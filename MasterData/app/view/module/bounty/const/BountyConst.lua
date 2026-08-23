local var_0_0 = {
	MONSTER_SUMMON_MAX_NUM = 10,
	ACTIVITY_STATE = {
		OPEN = 2,
		RESULT = 3,
		NOT_OPEN = 1
	},
	MONSTER_REWARD_TYPE = {
		EXTRA = 3,
		SHARE = 1,
		KILL = 2
	},
	MONSTER_REWARD_ID = {
		SHARE_MAX = 3,
		KILL_MIN = 4,
		KILL_MAX = 6,
		SHARE_MIN = 1
	},
	MONSTER_SUMMON_TYPE = {
		LOW = 1,
		HIGH = 2
	},
	SHARE_CD = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BOUNTY_SHARE_CD).parameter,
	TASK_FRESH_TYPE = {
		DAILY = 1,
		NEVER = 2
	},
	SHARE_RWD_GOOD = {
		VALUE = 104,
		TYPE = 1
	},
	SHARE_SEL_TYPE = {
		MINE = 0,
		GUILD = 1,
		CUR_SERVER = 2,
		CROSS_SERVER = 3
	},
	SHARE_CHANNEL = {
		g.core.const.ConstMgr.ChatConst.ARMY,
		g.core.const.ConstMgr.ChatConst.WORLD,
		g.core.const.ConstMgr.ChatConst.BOUNTY
	},
	SCORE_ITEM = {
		value = 104,
		type = 1
	},
	BATTLE_COST_ITEM = {
		value = 103,
		type = 3
	},
	ERROR_RET_CODE = {
		MONSTER_DEFEATED = 3534,
		MONSTER_NOT_EXIST = 3535,
		MONSTER_EXPIRED = 3533,
		MONSTER_SHARE_CHANGED = 3542,
		ACTIVITY_EXPIRED = 2005,
		SHARE_GUILD_CHANGED = 3545
	}
}

var_0_0.INVITE_ID = {
	[41] = var_0_0.SHARE_SEL_TYPE.CUR_SERVER,
	[42] = var_0_0.SHARE_SEL_TYPE.GUILD,
	[43] = var_0_0.SHARE_SEL_TYPE.CROSS_SERVER
}
var_0_0.SHOP_FIRST_TARGET = {
	[5] = 0,
	[2] = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BOUNTY_SHOP_NUM2).parameter,
	[3] = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BOUNTY_SHOP_NUM3).parameter,
	[4] = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BOUNTY_SHOP_NUM4).parameter
}

return var_0_0
