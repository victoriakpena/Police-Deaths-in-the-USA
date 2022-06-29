-- checking column names & data types
Select 
	*
From 
	INFORMATION_SCHEMA.COLUMNS
Where 
	Table_Name = N'police_deaths_in_america';

-- checking for null values
Select
	*
From
	police_deaths_in_america
Where
	'rank' is null OR
    name is null OR
    cause_of_death is null OR
    'date' is null OR
    'year' is null OR
    'Month' is null OR
    Day is null OR
    Department is null OR
    State is null OR
    K9_Unit is null;

-- checking for invalid data
Select
	*
From
	police_deaths_in_america
Where 
	day <> 'Monday' AND
    day <> 'Tuesday' AND
    day <> 'Wednesday' AND
    day <> 'Thursday' AND
    day <> 'Friday' AND
    day <> 'Saturday' AND
    day <> 'Sunday';

Select
	*
From
	police_deaths_in_america
Where 
	year <1791 AND 
    year >2022;

Select
	*
From
	police_deaths_in_america
Where 
	month <> 'January' AND
    month <> 'February' AND
    month <> 'March' AND
    month <> 'April' AND
    month <> 'May' AND
    month <> 'June' AND
    month <> 'July' AND
    month <> 'August' AND
    month <> 'September' AND
    month <> 'October' AND
    month <> 'November' AND
    month <> 'December';
    
Select
	*
From
	police_deaths_in_america
Where 
	K9_Unit < 0 OR
    K9_Unit > 1;

-- checking for distinct row names for state & cause of death
Select
	distinct state
From 
	police_deaths_in_america;

Select
	distinct Cause_of_Death 
From 
	police_deaths_in_america
Order by
	Cause_of_Death asc;

-- checking to see how many deaths were k9 dogs: 483!
Select
	count(`Rank`)
From
	police_deaths_in_america
Where
	`Rank` = 'k9';
    

-- checking the different causes of death for k9s ordered most to least
Select
	count(`Rank`), cause_of_death
From
	police_deaths_in_america
Where
	`Rank` = 'k9'
Group by
	Cause_of_death
Order by
	count(`Rank`) desc;
    
-- checking the different states for k9 deaths ordered most to least
Select
	count(`Rank`), state
From
	police_deaths_in_america
Where
	`Rank` = 'k9'
Group by
	state
Order by
	count(`Rank`) desc;

-- looking to see which days of the week have the most overall deaths
Select
	`day`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Group by
	`day`
Order by
	count(Cause_of_Death) desc;
    
Select
	`day`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths, cause_of_death
From
	police_deaths_in_america
Group by
	`day`, cause_of_death
Order by
	count(Cause_of_Death) desc;

-- looking to see which months have the most overall deaths
Select
	`month`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Group by
	`month`
Order by
	count(Cause_of_Death) desc;

Select
	`month`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths, cause_of_death
From
	police_deaths_in_america
Group by
	`month`, cause_of_death
Order by
	count(Cause_of_Death) desc;

-- looking to see which years have the most overall deaths. excluding 2022 because only have half year of data as of June.
Select
	`year`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Where
	year <> 2022
Group by
	`year`
Order by
	count(Cause_of_Death) desc;

Select
	`year`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths, cause_of_death
From
	police_deaths_in_america
Where
	year <> 2022
Group by
	`year`, Cause_of_Death
Order by
	count(Cause_of_Death) desc;
    
-- looking to see which years have the most overall deaths excluding 2022 & Covid related deaths.
Select
	`year`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Where
	year <> 2022 AND 
    Cause_of_Death <> 'covid19'
Group by
	`year`
Order by
	count(Cause_of_Death) desc;

-- Checking the states with the most overall deaths. Excluding United States as a state.
Select
	state, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Where
	state <> 'United States'
Group by
	state
Order by
	count(Cause_of_Death) desc;

-- checking most common ways for police deaths: gunfire 49.89%!
Select
	Cause_of_Death, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Group by
	Cause_of_Death
Order by
	count(Cause_of_Death) desc;

-- checking which rankings had the most gunfire deaths: deputy sherrif, patrolman, police officer are top 3. 
Select
	`rank`, Cause_of_Death, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Where
	Cause_of_Death = 'gunfire'
Group by
	Cause_of_Death, `rank`
Order by
	count(Cause_of_Death) desc;

-- checking how deaths are distributed across rankings
Select
	`rank`, count(cause_of_death) as deaths, round(count(cause_of_death) * 100.0 / (select count(cause_of_death) from police_deaths_in_america),2) as percentage_of_deaths
From
	police_deaths_in_america
Group by
	`rank`
Order by
	count(Cause_of_Death) desc;