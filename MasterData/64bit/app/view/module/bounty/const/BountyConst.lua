local var_0_0 = {
	MONSTER_SUMMON_MAX_NUM = 10,
	ACTIVITY_STATE = {
		OPEN = 2,
		NOT_OPEN = 1,
		RESULT = 3
	},
	MONSTER_REWARD_TYPE = {
		KILL = 2,
		SHARE = 1,
		EXTRA = 3
	},
	MONSTER_REWARD_ID = {
		SHARE_MAX = 3,
		SHARE_MIN = 1,
		KILL_MAX = 6,
		KILL_MIN = 4
	},
	MONSTER_SUMMON_TYPE = {
		LOW = 1,
		HIGH = 2
	},
	SHARE_CD = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.BOUNTY_SHARE_CD).parameter,
	TASK_FRESH_TYPE = {
		NEVER = 2,
		DAILY = 1
	},
	SHARE_RWD_GOOD = {
		TYPE = 1,
		VALUE = 104
	},
	SHARE_SEL_TYPE = {
		GUILD = 1,
		MINE = 0,
		CROSS_SERVER = 3,
		CUR_SERVER = 2
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
		SHARE_GUILD_CHANGED = 3545,
		MONSTER_SHARE_CHANGED = 3542,
		MONSTER_NOT_EXIST = 3535,
		MONSTER_DEFEATED = 3534,
		MONSTER_EXPIRED = 3533,
		ACTIVITY_EXPIRED = 2005
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
