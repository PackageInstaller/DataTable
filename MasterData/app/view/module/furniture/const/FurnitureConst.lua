local var_0_0 = g.core.common.Storage:load("furniture_spine_touch_debug.json", false) or {
	show = false
}

return {
	FURNITURE_INIT_INDEX = 1,
	FURNITURE_WALL_H_GRID = 5,
	FURNITURE_MOVE_W_GRID = 16,
	FLOOR_LAYER = 1,
	ROLE_VISIT_COMP_NAME = "roleVisitComp_",
	FURNITURE_GRID_HEIGHT = 86,
	FURNITURE_MOVE_H_GRID = 16,
	JSON_NAME = "furniture.json",
	FURNITURE_GROUND_H_GRID = 20,
	DATA_EXPIRED_INTERVAL = 310,
	FURNITURE_SWEEP_INFO_ID = 68,
	DEFAULT_FURNITURE_ID_KEY_FLOOR = 14001,
	FURNITURE_GROUND_W_GRID = 20,
	ROLE_SCALE_SIZE = 1.8,
	FURNITURE_GRID_WIDTH = 172,
	FURNITURE_NAMES_PREFIX = "furniture_",
	DEFAULT_FURNITURE_ID_KEY_BG = 14004,
	BATHING_ANI_PLAY_TIME = 5,
	ROLE_COMP_PREFIX_NAME = "roleComp_",
	DEFAULT_FURNITURE_ID_KEY_WALL = 14002,
	FURNITURE_KNIGHT_MAX = 5,
	MOBILITY_RECOVER_FACTOR_ID = 14003,
	FURNITURE_LIMIT_SWEEP_ID = 10133,
	DEFAULT_SVR_FLOOR_NUM = 4,
	DEBUG_GRID_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
	PlaneType = {
		GROUND = 2,
		RIGHT_WALL = 1,
		LEFT_WALL = 0
	},
	LEVEL_UP_COND_TYPE = {
		HL_TRAIN_ROOM_LEVEL = 1,
		NONE = 0
	},
	UNLOCK_COND_TYPE = {
		DORM_LEVEL = 2,
		HL_TRAIN_ROOM_UNLOCKED = 1,
		NONE = 0
	},
	SVR_DEFINITION_LEVEL = {
		WALL_LAND_LEFT = 4,
		WALL_LAND_RIGHT = 6,
		FLOOR_LAND = 1,
		WALL_DECORATION_RIGHT = 7,
		FLOOR_FURNITURE = 3,
		WALL_DECORATION_LEFT = 5,
		FLOOR_DECORATION = 2,
		FURNITURE_BACKGROUND = 8
	},
	FURNITURE_TYPE_NAME = {
		{
			type = 1,
			name = 112512
		},
		{
			type = 2,
			name = 112513
		},
		{
			type = 10,
			name = 112554
		},
		{
			type = 3,
			name = 112514
		},
		{
			type = 4,
			name = 112515
		},
		{
			type = 5,
			name = 112516
		},
		{
			type = 6,
			name = 112517
		},
		{
			type = 7,
			name = 112518
		},
		{
			type = 8,
			name = 112519
		},
		{
			type = 9,
			name = 112520
		}
	},
	ROLE_ACTION = {
		EMPTY = 0,
		REST = 4,
		IDLE = 2,
		BATH = 5,
		SIT = 3,
		RUN = 1
	},
	FURNITURE_BASAL_TYPE = {
		FURNITURE = 3,
		FLOOR = 1,
		DECORATE = 2
	},
	FURNITURE_TYPE = {
		ROOM_BG = 10,
		FLOOR = 2,
		BATH_CROCK = 7,
		BED = 5,
		GROUND_ADORNMENT = 4,
		WALL = 1,
		TABLE_CHAIR = 8,
		WALL_DECORATION = 3,
		FURNISHING_ARTICLE = 9,
		SOFA = 6
	},
	BATH_CROCK_STATE = {
		CAN_USE = 1,
		CD = 2,
		NOT_PLACED = 0
	},
	CAN_PLACE_CTRL_IDX = {
		YES = 1,
		NO = 0
	},
	PLACE_END_CTRL_IDX = {
		YES = 1,
		NO = 0
	},
	FURNITURE_SPINE_DEBUG_TOUCH = var_0_0,
	BUBBLE_TYPE = {
		LOOK = 1,
		CLEAN = 3,
		CHARM = 2
	}
}
