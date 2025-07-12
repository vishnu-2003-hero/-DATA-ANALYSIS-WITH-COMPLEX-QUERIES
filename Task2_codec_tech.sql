use sales_project;

select * FROM amazon limit 100;

# COMMON TABLE EXPRESSIONS:
WITH monthly_sales AS (
  SELECT 
    DATE_FORMAT('Order Date', '%Y-%m') AS month,
    SUM(sales) AS total_sales
  FROM amazon
  GROUP BY DATE_FORMAT('Order Date', '%Y-%m')
)
SELECT * FROM monthly_sales
ORDER BY month;

# Window Function:
SELECT 
  'Product Name',
  category,
  SUM(profit) AS total_profit,
  RANK() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rank_in_category
FROM amazon
GROUP BY 'Product Name', category
ORDER BY category, rank_in_category;

# Subquery:
SELECT geography, total_profit
FROM (
  SELECT geography, SUM(profit) AS total_profit
  FROM amazon
  GROUP BY geography
) AS regional_profit
ORDER BY total_profit DESC
LIMIT 1;


# Top-Selling Product list by Revenu
SELECT category, SUM(sales) AS total_sales
FROM amazon
GROUP BY category
ORDER BY total_sales DESC;
