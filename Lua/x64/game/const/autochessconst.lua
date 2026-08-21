local var_0_0 = {}

var_0_0.BRAHMA_BOSS_ID = 17
var_0_0.TEACH_STAGE = {
	401
}
var_0_0.TEACH_ROUND_NUM = 2
var_0_0.USER_INFO_KEY = {
	BATTLE_UID = 10,
	SUNGLASS_FLAG = 11,
	HP = 1,
	CUR_ROUND_COUNT = 4,
	STAGE_ID = 5,
	VICTORY_ROUND_COUNT = 2,
	BRAHMA_BOSS_FLAG = 6
}
var_0_0.CHESS_ATTRI_KEY = {
	EXPERIENCE = 3,
	HP = 2,
	ATK = 1
}
var_0_0.ATTR_KEY = {
	CHESS_GOOD_COUNT = 6,
	REWARD_GOOD_COUNT = 8,
	BATTLE_CELL_COUNT = 5,
	MONEY_INCRISE_CEIL = 3,
	PROP_GOOD_COUNT = 7,
	NOW_MONEY = 1,
	SHOP_LEVEL_UP_ROUND = 9,
	SHOP_CHESS_BASE_EXP = 12,
	RESTART_MONEY = 2,
	SHOP_STAR_NUM = 11,
	SHOP_FREE_PROP_COUNT = 17,
	PREPARE_CELL_COUNT = 4,
	SHOP_FREE_CHESS_COUNT = 18,
	REFRESH_SHOP_COST = 10,
	SHOP_FREE_REFRESH_COUNT = 16
}
var_0_0.CHESS_TYPE = {
	CALL_CHESS = 2,
	NORMAL_CHESS = 0,
	OP_PLAYER_CHESS = 3,
	PLAYER_CHESS = 1
}
var_0_0.ITEM_TARGET_TYPE = {
	SHOP = 7,
	PLAYER = 2,
	TEAM_SHOP = 8,
	WITHOUT_PLAYER = 15,
	SELF_CHESS = 112,
	CHESS = 6,
	RANDOM_SHOP_ONE = 10
}
var_0_0.TARGET_PROP_TYPE = {
	var_0_0.ITEM_TARGET_TYPE.CHESS,
	var_0_0.ITEM_TARGET_TYPE.WITHOUT_PLAYER,
	var_0_0.ITEM_TARGET_TYPE.SHOP,
	var_0_0.ITEM_TARGET_TYPE.TEAM_SHOP
}
var_0_0.BUFF_KEYWORD_TYPE = {
	RAGE = 4,
	DEATH_WHISPE = 2,
	VENOMOUS = 5,
	GROW = 3,
	SHIELD = 1,
	NONE = 0
}
var_0_0.BUFF_TARGET_TYPE = {
	PLAYER = 1,
	CHESS = 0,
	GAME = 2
}
var_0_0.SHOP_TYPE = {
	PROP = 1,
	REWARD = 2,
	NORMAL = 0
}
var_0_0.SHOP_UPDATE_TYPE = {
	NORMAL = 0,
	REFRESH = 1
}
var_0_0.GAME_TYPE = {
	PVP = 1,
	PVP_5_0 = 3,
	PVE = 0,
	ONLINE = 2
}
var_0_0.CHESS_UPGRADE_TYPE = {
	NORMAL = 0,
	BRAHMA = 1
}
var_0_0.BATTLE_STATUS = {
	PLAYING = 1,
	END = 3,
	IDLE = 0,
	PAUSE = 2
}
var_0_0.GAME_STATUS = {
	TOTAL_SETTLE_LOSE = 5,
	ROUND_SETTLE = 3,
	REPLAY = 6,
	PREPARE = 1,
	TOTAL_SETTLE_WIN = 4,
	PREPARE_END = 2,
	NONE = 0
}
var_0_0.PLAYER_TYPE = {
	SELF = 0,
	OPPONENT = 1
}
var_0_0.BATTLE_ROUND_RESULT = {
	LOSE = 2,
	DRAW = 0,
	WIN = 1
}
var_0_0.BUFF_OTHER_PARAM = {
	Get_BUFF_ROUND = 3,
	OTHER_PARAM_ATK = 1,
	OTHER_PARAM_HP = 2
}
var_0_0.ACTION_TYPE = {
	FIGHT = 2,
	DEAD = 5,
	GLOBAL_ATTR = 9,
	REFRESH_BUFF = 10,
	MERGE = 0,
	REMOVE_BUFF = 7,
	EFFECT = 3,
	SHOP_REFRESH = 8,
	REFRESH = 6,
	MOVE = 1
}
var_0_0.GLOBAL_ACTION_TYPE = {
	SHOP_LEVEL_UP = 6,
	LESS_EXP = 12,
	SHOP_REWARD = 20
}
var_0_0.ACTION_EFFECT_TYPE = {
	REFRESH_SHOP = 15,
	TRANSFER_FORMATION = 17,
	GLOBAL_ATTR_BUFF = 6,
	IMMUNE = 7,
	ADD_ATTR_BUFF = 5,
	ADD_ATTR = 1,
	SUMMON = 3,
	UPGRADE_CHESS_STAR = 16,
	ADD_EXPERIENCE = 10,
	SUMMON_CHESS = 30,
	DAMAGE = 2,
	ADD_BUFF = 4,
	REMOVE_SHOP = 9
}
var_0_0.SPECIAL_BUFF_TYPE = {
	ADD_ATTR_WITH_ATK_COUNT = 41,
	UPGRADE_CHESS_WITH_SAME_ATTR = 16,
	ADD_BODY_WITH_USED_PROP_COUNT = 36,
	ADD_NUM_WITH_ROUND = 38,
	REMOVE_CHESS_BUFF_ACTION_TYPE = 17
}
var_0_0.ACTION_NODE_STATUS = {
	FINISH = 2,
	NEW = 0,
	RUNNING = 1
}
var_0_0.HIDE_BOTTOM_BUTTON_INFO = {
	{
		101,
		1
	},
	{
		303,
		1
	},
	{
		401,
		1
	}
}
var_0_0.ACTION_CONFIG = {
	[var_0_0.ACTION_TYPE.MOVE] = {
		rendererClassName = "AutoChessActionMoveRenderer",
		dataClassName = "AutoChessActionMoveDataTemplate",
		nodeClassName = "AutoChessMoveNode"
	},
	[var_0_0.ACTION_TYPE.FIGHT] = {
		rendererClassName = "AutoChessActionFightRenderer",
		dataClassName = "AutoChessActionFightDataTemplate",
		nodeClassName = "AutoChessFightNode"
	},
	[var_0_0.ACTION_TYPE.DEAD] = {
		rendererClassName = "AutoChessActionDeadRenderer",
		dataClassName = "AutoChessActionDeadDataTemplate",
		nodeClassName = "AutoChessDeadNode"
	},
	[var_0_0.ACTION_TYPE.REFRESH] = {
		rendererClassName = "AutoChessActionRefreshRenderer",
		dataClassName = "AutoChessActionRefreshDataTemplate",
		nodeClassName = "AutoChessRefreshNode"
	},
	[var_0_0.ACTION_TYPE.REMOVE_BUFF] = {
		rendererClassName = "AutoChessRemoveBuffRenderer",
		dataClassName = "AutoChessActionRemoveBuffDataTemplate",
		nodeClassName = "AutoChessRemoveBuffNode"
	},
	[var_0_0.ACTION_TYPE.SHOP_REFRESH] = {
		rendererClassName = "AutoChessActionShopRefreshRender",
		dataClassName = "AutoChessActionShopRefreshDataTemplate",
		nodeClassName = "AutoChessShopRefreshNode"
	},
	[var_0_0.ACTION_TYPE.GLOBAL_ATTR] = {
		rendererClassName = "AutoChessActionBaseRenderer",
		dataClassName = "AutoChessActionGlobalAttrDataTemplate",
		nodeClassName = "AutoChessGlobalAttrNode"
	},
	[var_0_0.ACTION_TYPE.REFRESH_BUFF] = {
		rendererClassName = "AutoChessActionBaseRenderer",
		dataClassName = "AutoChessActionRefreshBuffDataTemplate",
		nodeClassName = "AutoChessRefreshBuffNode"
	}
}
var_0_0.ACTION_EFFECT_CONFIG = {
	[var_0_0.ACTION_EFFECT_TYPE.ADD_ATTR] = {
		rendererClassName = "AutoChessAddAttrRenderer",
		dataClassName = "AutoChessEffectAddAttrDataTemplate",
		nodeClassName = "AutoChessAddAttrNode"
	},
	[var_0_0.ACTION_EFFECT_TYPE.DAMAGE] = {
		rendererClassName = "AutoChessDamageRenderer",
		dataClassName = "AutoChessEffectDamageDataTemplate",
		nodeClassName = "AutoChessDamageNode"
	},
	[var_0_0.ACTION_EFFECT_TYPE.SUMMON] = {
		rendererClassName = "AutoChessEffectSummonRenderer",
		dataClassName = "AutoChessEffectSummonDataTemplate",
		nodeClassName = "AutoChessEffectSummonNode"
	},
	[var_0_0.ACTION_EFFECT_TYPE.ADD_BUFF] = {
		rendererClassName = "AutoChessAddBuffRenderer",
		dataClassName = "AutoChessEffectAddBuffDataTemplate",
		nodeClassName = "AutoChessAddBuffNode"
	},
	[var_0_0.ACTION_EFFECT_TYPE.ADD_ATTR_BUFF] = {
		rendererClassName = "AutoChessAddBuffRenderer",
		dataClassName = "AutoChessEffectAddBuffDataTemplate",
		nodeClassName = "AutoChessAddBuffNode"
	},
	[var_0_0.ACTION_EFFECT_TYPE.REMOVE_SHOP] = {
		rendererClassName = "AutoChessEffectBaseRenderer",
		dataClassName = "AutoChessEffectRemoveShopDataTemplate",
		nodeClassName = "AutoChessRemoveShopNode"
	}
}
var_0_0.ACTION_RENDERER_STATUS = {
	PAUSED = 2,
	FINISHED = 3,
	IDLE = 0,
	RUNNING = 1
}
var_0_0.ACTION_RENDER_CONTROLLER_TYPE = {
	TIME_LINE = 1,
	NODE = 0,
	LEAN_TWEEN = 3,
	ANIMATOR = 2
}
var_0_0.ACTION_RENDER_CONTROLLER_CONFIG = {
	[var_0_0.ACTION_RENDER_CONTROLLER_TYPE.TIME_LINE] = {
		controllerClassName = "AutoChessTimelineRenderController"
	},
	[var_0_0.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR] = {
		controllerClassName = "AutoChessAnimatorRenderController"
	},
	[var_0_0.ACTION_RENDER_CONTROLLER_TYPE.LEAN_TWEEN] = {
		controllerClassName = "AutoChessLeanTweenRenderController"
	}
}
var_0_0.ACTION_RENDER_CONTROLLER_STATUS = {
	PAUSED = 2,
	FINISHED = 3,
	IDLE = 0,
	RUNNING = 1
}
var_0_0.TROPHY_STATUS = {
	ALREADY = "already",
	NEW = "new",
	NORMAL = "normal"
}
var_0_0.HP_STATUS = {
	NORMAL = "normal",
	HURTED = "hurted",
	HURTING = "hurting"
}
var_0_0.STAGE_STATE = {
	COMPLETED = 2,
	LOCK = 0,
	UNLOCK = 1
}
var_0_0.RECORD_TYPE = {
	PVP = 0,
	PVP_4_8 = 2,
	GLORY = 1,
	PVP_4_8_ONLINE = 3
}
var_0_0.ILLUSTRATE_TYPE = {
	PROP_SHOP = 2,
	ADMIN_SKILL = 3,
	CHESS_SHOP = 1
}
var_0_0.ADMIN_ILLUSTRATE_UNLOCK_STAGE = 203
var_0_0.ADMIN_CHESS_ID = {
	[4041301] = 2,
	[4143001] = 2,
	[3740601] = 1
}
var_0_0.GAME_PAUSE_TYPE = {
	PAUSE = 1,
	RESUME = 2
}
var_0_0.COMPLETE_PLAY_ANIM = {
	"ChessItemDeadAnim",
	"ChessItem_Ani_bianshen_right",
	"ChessItem_Ani_bianshen_left",
	"ChessItem_Ani_bianshen_normal"
}
var_0_0.BACKGROUND_ID = {
	10001,
	20001,
	30001,
	40001,
	50001,
	60001,
	70001,
	80001
}
var_0_0.SUNGLASS_FLAG = {
	DISABLE = 2,
	UNLOCK = 1
}
var_0_0.POP_TYPE = {
	PVP_ASYNC = 3,
	PVE_FALLBACK = 4,
	REMAIN_MONEY = 2,
	TEACHING = 9,
	PVP_SYNC_RECONNECT = 6,
	PREVIOUS_ADVICE = 7,
	PVP_SYNC = 5,
	PVE = 1,
	SKIP_TEACHING = 8
}

return var_0_0
