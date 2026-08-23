local var_0_0 = {}

var_0_0.TOP_BAR_ID = 324
var_0_0.GAME_STAGE = {
	FINAL = 3,
	APPLY = 1,
	RESULT = 4,
	LADDER = 2,
	NONE = 0
}
var_0_0.SWITCH_INTERVAL = 0.8
var_0_0.APPLY_STATE = {
	APPLY_ABLE = 0,
	APPLY_END = 2,
	APPLIED = 1
}
var_0_0.LADDER_STAGE = {
	RISE = 2,
	ELIMINATE = 3,
	IN_LADDER = 0,
	COMPUTE = 1
}
var_0_0.MY_FINAL_STATE = {
	SEMI = 1,
	GRAND = 2,
	ELIMINATE = 0
}
var_0_0.POOL_ID = {
	ALL = 103,
	GRAND = 202,
	SEMI = 201,
	CROSS = 102
}
var_0_0.POOL_TYPE = {
	ALL = 2,
	GRAND = 4,
	SEMI = 3,
	CROSS = 1
}
var_0_0.POOL_ID_INDEX = {
	202,
	201,
	103,
	102
}
var_0_0.POOL_INDEX = {
	ALL = 3,
	GRAND = 1,
	SEMI = 2,
	CROSS = 4
}
var_0_0.POOL_STATE = {
	ALL_END = 3,
	ALL_NOT_START = 0,
	CUR_NOT_START = 1,
	CUR_START = 2
}
var_0_0.ROOM_ID = {
	2000001,
	2000002,
	2000003,
	2000004,
	3000001
}
var_0_0.POOL_LIST_MIN_INDEX = 1
var_0_0.POOL_LIST_MAX_INDEX = 4
var_0_0.POOL_LIST_SIZE = 6
var_0_0.UPGRADE_TYPE = {
	PERMILLAGE = 1,
	POOL_SCORE = 3,
	TOTAL_SCORE = 2
}
var_0_0.UPGRADE_STATE = {
	UPGRADE = 1,
	CURRENT = 0,
	NEED_UPGRADE = 2
}
var_0_0.EDITOR_TYPE = {
	BARRIER = 0,
	SMALL = 2,
	BIG = 4,
	MIDDLE = 3,
	REBORN = 1
}
var_0_0.OUTPUT_TYPE = {
	SCORE = 1,
	HP = 2
}
var_0_0.REWARD_TYPE = {
	CROSS = 96,
	ALL_SERVER = 95
}
var_0_0.TOP_TYPE = {
	REWARD = 1,
	RANK = 0
}
var_0_0.RANK_SHOW_SIZE = {
	CROSS = 200,
	ALL_SERVER = 200
}
var_0_0.RANK_TYPE = {
	CROSS = 1,
	ALL_SERVER = 0
}
var_0_0.TASK_TYPE = {
	"pool_id",
	"daily_match_max_score",
	"max_season_score",
	"challenge_num",
	"win_challenge_num",
	"",
	"join_turn_num",
	"occupy_chibi_num",
	"occupy_medium_num",
	"occupy_component_num"
}
var_0_0.TASK_SHOW_SPECIAL_DESC_TYPE = 1
var_0_0.TASK_REFRESH_TYPE = {
	DAY = 1,
	SEASON = 2
}
var_0_0.COMPONENT_NUM = 20
var_0_0.MIN_ROBOT_GEN_NUM = 0
var_0_0.TOP_TIP_DELAY = 5
var_0_0.CD_COLOR = 120
var_0_0.RANK_REQUEST_INTERVAL = 5
var_0_0.ROBOT_GEN_INTERVAL = 0.7
var_0_0.MIN_RANK_LENGTH = 5
var_0_0.MOVE_UPDATE_COUNT = 16
var_0_0.MAP_DEBUG_TILED = false
var_0_0.MOVE_SPEED = 0.2
var_0_0.ROBOT_MOVE_SPEED = 0.05
var_0_0.COUNT_DOWN_TYPE = {
	DEAD = 1,
	COOL = 2,
	PROTECT = 3,
	NONE = 0
}
var_0_0.RECORD_TYPE = {
	DEFEND_LOSE = 2,
	ATK_WIN = 0,
	ATK_NONE = 3,
	ATK_LOSE = 1
}
var_0_0.HP_COLOR = {
	GREEN = 0,
	YELLOW = 1,
	RED = 2
}
var_0_0.HP_THRESHOLD = {
	GREEN = 80,
	YELLOW = 60
}
var_0_0.BATTLE_RESULT = {
	LOSE = 2,
	WIN = 1
}
var_0_0.CHECK_STATUS = {
	CLIENT = 1,
	LOSE = 3,
	NOT_OCCUPY = 4,
	SERVER = 2
}
var_0_0.OCCUPY_CHANGE_TYPE = {
	DIRECT_OCCUPY = 3,
	ATK_OCCUPY = 1,
	DISCARD = 2
}
var_0_0.NOT_BARRIER_ID = {
	[102] = true,
	[100] = true,
	[106] = true,
	[108] = true,
	[109] = true,
	[107] = true
}
var_0_0.ZORDER_TAG = 99999

return var_0_0
