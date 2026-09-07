local IslandTaskTargetType = class("IslandTaskTargetType")

IslandTaskTargetType.INTERACTION = 1
IslandTaskTargetType.APPROACH = 2
IslandTaskTargetType.ORDER = 3
IslandTaskTargetType.RECYCLE = 4
IslandTaskTargetType.OBTAIN = 5
IslandTaskTargetType.HAND_GATHER = 6
IslandTaskTargetType.PRODUCTION = 7
IslandTaskTargetType.TECHNOLOGY = 8
IslandTaskTargetType.ISLAND_LV = 9
IslandTaskTargetType.FRAGMENT = 10
IslandTaskTargetType.UNLOCK_SHIP = 11
IslandTaskTargetType.SHIP_ORDER = 12
IslandTaskTargetType.SIGN_IN = 13
IslandTaskTargetType.HAND_PROD = 14
IslandTaskTargetType.FURNITURE = 15
IslandTaskTargetType.COMMANDER_DRESS = 16
IslandTaskTargetType.SHIP_DRESS = 17
IslandTaskTargetType.SHIP_SKIN = 18
IslandTaskTargetType.SKIN_ALL_COLOR = 19
IslandTaskTargetType.SKIN_COLOR = 20
IslandTaskTargetType.ACHIEVEMENT = 21
IslandTaskTargetType.TASK = 22
IslandTaskTargetType.TASK_TYPE = 23
IslandTaskTargetType.TASK_TYPE_PLUS = 24
IslandTaskTargetType.GIVE_GIFT = 25
IslandTaskTargetType.PROD_ITEM = 26
IslandTaskTargetType.RESTAURANT_SHELVE = 27
IslandTaskTargetType.RESTAURANT_SELL = 28
IslandTaskTargetType.RESTAURANT_SALES = 29
IslandTaskTargetType.RESTAURANT_RANK = 30
IslandTaskTargetType.RESTAURANT_OPEN = 31
IslandTaskTargetType.SHIP_EXP_BOOK = 32
IslandTaskTargetType.SHIP_SKILL_UPGRADE = 33
IslandTaskTargetType.STORY = 34
IslandTaskTargetType.ACTION = 35
IslandTaskTargetType.ACTION_END = 36
IslandTaskTargetType.ACTION_HELLO = 37
IslandTaskTargetType.FOLLOW = 38
IslandTaskTargetType.ACTIVITY_ORDER = 39
IslandTaskTargetType.ACTIVIEY_GATHER = 40
IslandTaskTargetType.ACTIVIEY_FORMULA = 41
IslandTaskTargetType.START_DELEGATE = 42
IslandTaskTargetType.TAKE_PHOTO = 43
IslandTaskTargetType.COMMANDER_DRESS_ID = 44
IslandTaskTargetType.SHIP_DRESS_ID = 45
IslandTaskTargetType.ORDER_TYPE = 46
IslandTaskTargetType.ITEM_IN_PLACE = 47
IslandTaskTargetType.DELEGATE_IN_PLACE = 48
IslandTaskTargetType.HAND_IN_PLACE = 49
IslandTaskTargetType.DELEGATE_FORMULA_TYPE = 50
IslandTaskTargetType.HAND_FORMULA_TYPE = 51
IslandTaskTargetType.ITEM_TYPE_PRODU = 52
IslandTaskTargetType.ITEM_TYPE_ANY = 53
IslandTaskTargetType.ORDER_DAILY = 54
IslandTaskTargetType.ACTION_HELLO_DAILY = 55
IslandTaskTargetType.TASK_DAILY_IN_WEEK = 56
IslandTaskTargetType.START_FISHING = 57
IslandTaskTargetType.FISHING = 58
IslandTaskTargetType.GAME_MAX_SCORE = 1001
IslandTaskTargetType.GAME_CUR_SCORE = 1002

function IslandTaskTargetType.GetRuntimeTypes()
	return {
		IslandTaskTargetType.RECYCLE,
		IslandTaskTargetType.TECHNOLOGY,
		IslandTaskTargetType.ISLAND_LV,
		IslandTaskTargetType.FRAGMENT,
		IslandTaskTargetType.UNLOCK_SHIP,
		IslandTaskTargetType.FURNITURE,
		IslandTaskTargetType.COMMANDER_DRESS,
		IslandTaskTargetType.SHIP_DRESS,
		IslandTaskTargetType.SHIP_SKIN,
		IslandTaskTargetType.SKIN_ALL_COLOR,
		IslandTaskTargetType.SKIN_COLOR,
		IslandTaskTargetType.ACHIEVEMENT,
		IslandTaskTargetType.TASK,
		IslandTaskTargetType.TASK_TYPE_PLUS,
		IslandTaskTargetType.RESTAURANT_RANK,
		IslandTaskTargetType.STORY,
		IslandTaskTargetType.ACTION,
		IslandTaskTargetType.COMMANDER_DRESS_ID,
		IslandTaskTargetType.SHIP_DRESS_ID,
		IslandTaskTargetType.ACTIVITY_ORDER,
		IslandTaskTargetType.ORDER_DAILY,
		IslandTaskTargetType.ACTION_HELLO_DAILY,
		IslandTaskTargetType.TASK_DAILY_IN_WEEK,
		IslandTaskTargetType.GAME_MAX_SCORE,
		IslandTaskTargetType.GAME_CUR_SCORE
	}
end

function IslandTaskTargetType.GetClientTypes()
	return {
		IslandTaskTargetType.INTERACTION,
		IslandTaskTargetType.APPROACH,
		IslandTaskTargetType.ACTION_END,
		IslandTaskTargetType.TAKE_PHOTO
	}
end

function IslandTaskTargetType.GetObjectLinkTypes()
	return {
		IslandTaskTargetType.APPROACH
	}
end

return IslandTaskTargetType
