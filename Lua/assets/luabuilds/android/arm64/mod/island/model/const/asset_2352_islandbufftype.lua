local IslandBuffType = class("IslandBuffType")

IslandBuffType.SHIP_ATTR = 1
IslandBuffType.SHIP_POWER_RECOVER = 2
IslandBuffType.SHIP_PRODUCT_EXTRA = 101
IslandBuffType.SHIP_PRODUCT_RATIO = 102
IslandBuffType.SHIP_PRODUCT_POWER_COST = 103
IslandBuffType.SHIP_MANAGE_SELL_PRICE = 601
IslandBuffType.SHIP_MANAGE_SELL_NUM = 602
IslandBuffType.GLOBAL_MANAGE_SELL_PRICE = 603
IslandBuffType.GLOBAL_MANAGE_SELL_NUM = 604
IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING = 701
IslandBuffType.SHIP_AWARD_BY_GREETING = 702

function IslandBuffType.GetGlobalTypes()
	return {
		IslandBuffType.GLOBAL_MANAGE_SELL_PRICE,
		IslandBuffType.GLOBAL_MANAGE_SELL_NUM
	}
end

function IslandBuffType:IsGlobalType()
	return table.contains(IslandBuffType.GetGlobalTypes(), self)
end

function IslandBuffType.GetLimitPlaceTypes()
	return {
		IslandBuffType.SHIP_PRODUCT_EXTRA,
		IslandBuffType.SHIP_PRODUCT_RATIO,
		IslandBuffType.SHIP_PRODUCT_POWER_COST
	}
end

function IslandBuffType:IsLimitPlaceType()
	return table.contains(IslandBuffType.GetLimitPlaceTypes(), self)
end

function IslandBuffType.GetLimitRestaurantTypes()
	return {
		IslandBuffType.SHIP_MANAGE_SELL_PRICE,
		IslandBuffType.SHIP_MANAGE_SELL_NUM,
		IslandBuffType.GLOBAL_MANAGE_SELL_PRICE,
		IslandBuffType.GLOBAL_MANAGE_SELL_NUM
	}
end

function IslandBuffType:IsLimitRestaurantType()
	return table.contains(IslandBuffType.GetLimitRestaurantTypes(), self)
end

function IslandBuffType.GetGreetingTypes()
	return {
		IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING,
		IslandBuffType.SHIP_AWARD_BY_GREETING
	}
end

function IslandBuffType:IsGreetingType()
	return table.contains(IslandBuffType.GetGreetingTypes(), self)
end

return IslandBuffType
