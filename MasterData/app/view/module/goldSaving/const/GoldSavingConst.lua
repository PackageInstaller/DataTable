local var_0_0 = {}

var_0_0.DEFAULT_TYPE = 0
var_0_0.DIAMOND_TYPE = 1
var_0_0.MONEY_TYPE = 2
var_0_0.FREE_TYPE = 3
var_0_0.RECHARGE_DIAMOND = 4
var_0_0.GAME_TYPE = {
	RED_PACKAGE = 2,
	TURN_TABLE = 3,
	DAILY_BOX_TURN_TABLE = 4,
	CART = 1
}
var_0_0.TURN_GAME_CONST = {
	BASE_TIME = 0.007374375,
	PER_NUM = 13,
	BIG_AWARD_NUM = 100,
	PER_ADD_TIME = 0.1,
	SHOW_AWARD_DELAY = 1,
	ALL_NUM = 14
}
var_0_0.DAILY_BOX_BIG_AWARD = {
	[g.core.common.Goods.TYPE_ITEM] = {
		[2576] = 1,
		[23] = 3
	}
}

return var_0_0
