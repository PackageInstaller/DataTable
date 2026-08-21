local var_0_0 = class("IslandAchievementType")

var_0_0.ISLAND_LV = 1
var_0_0.FINISH_TYPE_TASK = 2
var_0_0.FINISH_MAIN_TASK = 3
var_0_0.FINISH_ORDER = 4
var_0_0.SHIP_LV = 5
var_0_0.SHIP_SKILL_LV = 6
var_0_0.SHIP_ATTR_LV_1 = 7
var_0_0.SHIP_ATTR_LV_2 = 8
var_0_0.SHIP_ATTR_LV_3 = 9
var_0_0.SHIP_ATTR_LV_4 = 10
var_0_0.SHIP_ATTR_LV_5 = 11
var_0_0.SHIP_ATTR_LV_6 = 12
var_0_0.LOGIN_DAYS = 13
var_0_0.SHIP_SKIN = 14
var_0_0.SHIP_DRESS_TYPE = 15
var_0_0.COMMANDER_DRESS_TYPE = 16
var_0_0.SHOP_COST_ITEM = 17
var_0_0.SHOP_BUY_ITEM = 18
var_0_0.PRODUCE_ITEM = 19
var_0_0.BUILDING_DELEGATE = 20
var_0_0.BUILDING_HAND = 21
var_0_0.OBTAIN_ITEM = 22
var_0_0.GIVE_GIFT = 23
var_0_0.SHIP_DISPATCH = 24
var_0_0.SEASON_RANK = 25
var_0_0.SEASON_NUM = 26
var_0_0.FINISH_TECH = 27
var_0_0.FINISH_TYPE_TECH = 28
var_0_0.RESTAURANT_SELL = 29
var_0_0.RESTAURANT_SALES = 30
var_0_0.RESTAURANT_OPEN = 31
var_0_0.NPC_INTERACT = 32
var_0_0.FURNITURE = 33
var_0_0.BUILDING_DELEGATE_PLUS = 34
var_0_0.SHIP_DISPATCH_PLUS = 35
var_0_0.ACTION = 36
var_0_0.TAKE_PHOTO = 37
var_0_0.DRAW_AWARD = 38

function var_0_0.GetAttrTypes()
	return {
		var_0_0.SHIP_ATTR_LV_1,
		var_0_0.SHIP_ATTR_LV_2,
		var_0_0.SHIP_ATTR_LV_3,
		var_0_0.SHIP_ATTR_LV_4,
		var_0_0.SHIP_ATTR_LV_5,
		var_0_0.SHIP_ATTR_LV_6
	}
end

function var_0_0.GetRuntimeTypes()
	return {
		var_0_0.ISLAND_LV,
		var_0_0.FINISH_MAIN_TASK,
		var_0_0.SHIP_LV,
		var_0_0.SHIP_SKILL_LV,
		var_0_0.SHIP_ATTR_LV_1,
		var_0_0.SHIP_ATTR_LV_2,
		var_0_0.SHIP_ATTR_LV_3,
		var_0_0.SHIP_ATTR_LV_4,
		var_0_0.SHIP_ATTR_LV_5,
		var_0_0.SHIP_ATTR_LV_6,
		var_0_0.SHIP_SKIN,
		var_0_0.SHIP_DRESS_TYPE,
		var_0_0.COMMANDER_DRESS_TYPE,
		var_0_0.SEASON_RANK,
		var_0_0.SEASON_NUM,
		var_0_0.FINISH_TECH,
		var_0_0.FINISH_TYPE_TECH,
		var_0_0.RESTAURANT_SALES,
		var_0_0.FURNITURE,
		var_0_0.ACTION
	}
end

function var_0_0.GetClientTypes()
	return {
		var_0_0.TAKE_PHOTO
	}
end

return var_0_0
