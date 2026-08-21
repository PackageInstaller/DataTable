local var_0_0 = class("IslandBuffType")

var_0_0.SHIP_ATTR = 1
var_0_0.SHIP_POWER_RECOVER = 2
var_0_0.SHIP_PRODUCT_EXTRA = 101
var_0_0.SHIP_PRODUCT_RATIO = 102
var_0_0.SHIP_PRODUCT_POWER_COST = 103
var_0_0.SHIP_MANAGE_SELL_PRICE = 601
var_0_0.SHIP_MANAGE_SELL_NUM = 602
var_0_0.GLOBAL_MANAGE_SELL_PRICE = 603
var_0_0.GLOBAL_MANAGE_SELL_NUM = 604
var_0_0.SHIP_POWER_RECOVER_BY_GREETING = 701
var_0_0.SHIP_AWARD_BY_GREETING = 702

function var_0_0.GetGlobalTypes()
	return {
		var_0_0.GLOBAL_MANAGE_SELL_PRICE,
		var_0_0.GLOBAL_MANAGE_SELL_NUM
	}
end

function var_0_0.IsGlobalType(arg_2_0)
	return table.contains(var_0_0.GetGlobalTypes(), arg_2_0)
end

function var_0_0.GetLimitPlaceTypes()
	return {
		var_0_0.SHIP_PRODUCT_EXTRA,
		var_0_0.SHIP_PRODUCT_RATIO,
		var_0_0.SHIP_PRODUCT_POWER_COST
	}
end

function var_0_0.IsLimitPlaceType(arg_4_0)
	return table.contains(var_0_0.GetLimitPlaceTypes(), arg_4_0)
end

function var_0_0.GetLimitRestaurantTypes()
	return {
		var_0_0.SHIP_MANAGE_SELL_PRICE,
		var_0_0.SHIP_MANAGE_SELL_NUM,
		var_0_0.GLOBAL_MANAGE_SELL_PRICE,
		var_0_0.GLOBAL_MANAGE_SELL_NUM
	}
end

function var_0_0.IsLimitRestaurantType(arg_6_0)
	return table.contains(var_0_0.GetLimitRestaurantTypes(), arg_6_0)
end

function var_0_0.GetGreetingTypes()
	return {
		var_0_0.SHIP_POWER_RECOVER_BY_GREETING,
		var_0_0.SHIP_AWARD_BY_GREETING
	}
end

function var_0_0.IsGreetingType(arg_8_0)
	return table.contains(var_0_0.GetGreetingTypes(), arg_8_0)
end

return var_0_0
