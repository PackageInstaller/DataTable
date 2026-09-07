local IslandAchievementType = class("IslandAchievementType")

IslandAchievementType.ISLAND_LV = 1
IslandAchievementType.FINISH_TYPE_TASK = 2
IslandAchievementType.FINISH_MAIN_TASK = 3
IslandAchievementType.FINISH_ORDER = 4
IslandAchievementType.SHIP_LV = 5
IslandAchievementType.SHIP_SKILL_LV = 6
IslandAchievementType.SHIP_ATTR_LV_1 = 7
IslandAchievementType.SHIP_ATTR_LV_2 = 8
IslandAchievementType.SHIP_ATTR_LV_3 = 9
IslandAchievementType.SHIP_ATTR_LV_4 = 10
IslandAchievementType.SHIP_ATTR_LV_5 = 11
IslandAchievementType.SHIP_ATTR_LV_6 = 12
IslandAchievementType.LOGIN_DAYS = 13
IslandAchievementType.SHIP_SKIN = 14
IslandAchievementType.SHIP_DRESS_TYPE = 15
IslandAchievementType.COMMANDER_DRESS_TYPE = 16
IslandAchievementType.SHOP_COST_ITEM = 17
IslandAchievementType.SHOP_BUY_ITEM = 18
IslandAchievementType.PRODUCE_ITEM = 19
IslandAchievementType.BUILDING_DELEGATE = 20
IslandAchievementType.BUILDING_HAND = 21
IslandAchievementType.OBTAIN_ITEM = 22
IslandAchievementType.GIVE_GIFT = 23
IslandAchievementType.SHIP_DISPATCH = 24
IslandAchievementType.SEASON_RANK = 25
IslandAchievementType.SEASON_NUM = 26
IslandAchievementType.FINISH_TECH = 27
IslandAchievementType.FINISH_TYPE_TECH = 28
IslandAchievementType.RESTAURANT_SELL = 29
IslandAchievementType.RESTAURANT_SALES = 30
IslandAchievementType.RESTAURANT_OPEN = 31
IslandAchievementType.NPC_INTERACT = 32
IslandAchievementType.FURNITURE = 33
IslandAchievementType.BUILDING_DELEGATE_PLUS = 34
IslandAchievementType.SHIP_DISPATCH_PLUS = 35
IslandAchievementType.ACTION = 36
IslandAchievementType.TAKE_PHOTO = 37
IslandAchievementType.DRAW_AWARD = 38

function IslandAchievementType.GetAttrTypes()
	return {
		IslandAchievementType.SHIP_ATTR_LV_1,
		IslandAchievementType.SHIP_ATTR_LV_2,
		IslandAchievementType.SHIP_ATTR_LV_3,
		IslandAchievementType.SHIP_ATTR_LV_4,
		IslandAchievementType.SHIP_ATTR_LV_5,
		IslandAchievementType.SHIP_ATTR_LV_6
	}
end

function IslandAchievementType.GetRuntimeTypes()
	return {
		IslandAchievementType.ISLAND_LV,
		IslandAchievementType.FINISH_MAIN_TASK,
		IslandAchievementType.SHIP_LV,
		IslandAchievementType.SHIP_SKILL_LV,
		IslandAchievementType.SHIP_ATTR_LV_1,
		IslandAchievementType.SHIP_ATTR_LV_2,
		IslandAchievementType.SHIP_ATTR_LV_3,
		IslandAchievementType.SHIP_ATTR_LV_4,
		IslandAchievementType.SHIP_ATTR_LV_5,
		IslandAchievementType.SHIP_ATTR_LV_6,
		IslandAchievementType.SHIP_SKIN,
		IslandAchievementType.SHIP_DRESS_TYPE,
		IslandAchievementType.COMMANDER_DRESS_TYPE,
		IslandAchievementType.SEASON_RANK,
		IslandAchievementType.SEASON_NUM,
		IslandAchievementType.FINISH_TECH,
		IslandAchievementType.FINISH_TYPE_TECH,
		IslandAchievementType.RESTAURANT_SALES,
		IslandAchievementType.FURNITURE,
		IslandAchievementType.ACTION
	}
end

function IslandAchievementType.GetClientTypes()
	return {
		IslandAchievementType.TAKE_PHOTO
	}
end

return IslandAchievementType
