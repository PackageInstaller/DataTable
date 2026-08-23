local var_0_0 = g.core.common.Storage:load("furniture_spine_touch_debug.json", false) or {
	show = false
}

return {
	DEFAULT_FURNITURE_ID_KEY_FLOOR = 14001,
	FURNITURE_LIMIT_SWEEP_ID = 10133,
	FURNITURE_MOVE_W_GRID = 16,
	FURNITURE_MOVE_H_GRID = 16,
	FURNITURE_INIT_INDEX = 1,
	FLOOR_LAYER = 1,
	FURNITURE_KNIGHT_MAX = 5,
	FURNITURE_GRID_HEIGHT = 86,
	FURNITURE_GRID_WIDTH = 172,
	FURNITURE_WALL_H_GRID = 5,
	FURNITURE_GROUND_W_GRID = 20,
	FURNITURE_GROUND_H_GRID = 20,
	MOBILITY_RECOVER_FACTOR_ID = 14003,
	BATHING_ANI_PLAY_TIME = 5,
	FURNITURE_SWEEP_INFO_ID = 68,
	FURNITURE_NAMES_PREFIX = "furniture_",
	ROLE_SCALE_SIZE = 1.8,
	DEFAULT_SVR_FLOOR_NUM = 4,
	DEFAULT_FURNITURE_ID_KEY_BG = 14004,
	DEFAULT_FURNITURE_ID_KEY_WALL = 14002,
	DATA_EXPIRED_INTERVAL = 310,
	ROLE_VISIT_COMP_NAME = "roleVisitComp_",
	ROLE_COMP_PREFIX_NAME = "roleComp_",
	JSON_NAME = "furniture.json",
	DEBUG_GRID_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
	PlaneType = {
		RIGHT_WALL = 1,
		LEFT_WALL = 0,
		GROUND = 2
	},
	LEVEL_UP_COND_TYPE = {
		HL_TRAIN_ROOM_LEVEL = 1,
		NONE = 0
	},
	UNLOCK_COND_TYPE = {
		DORM_LEVEL = 2,
		NONE = 0,
		HL_TRAIN_ROOM_UNLOCKED = 1
	},
	SVR_DEFINITION_LEVEL = {
		FURNITURE_BACKGROUND = 8,
		WALL_DECORATION_RIGHT = 7,
		WALL_LAND_RIGHT = 6,
		WALL_DECORATION_LEFT = 5,
		WALL_LAND_LEFT = 4,
		FLOOR_FURNITURE = 3,
		FLOOR_DECORATION = 2,
		FLOOR_LAND = 1
	},
	FURNITURE_TYPE_NAME = {
		{
			name = 112512,
			type = 1
		},
		{
			name = 112513,
			type = 2
		},
		{
			name = 112554,
			type = 10
		},
		{
			name = 112514,
			type = 3
		},
		{
			name = 112515,
			type = 4
		},
		{
			name = 112516,
			type = 5
		},
		{
			name = 112517,
			type = 6
		},
		{
			name = 112518,
			type = 7
		},
		{
			name = 112519,
			type = 8
		},
		{
			name = 112520,
			type = 9
		}
	},
	ROLE_ACTION = {
		BATH = 5,
		REST = 4,
		SIT = 3,
		IDLE = 2,
		RUN = 1,
		EMPTY = 0
	},
	FURNITURE_BASAL_TYPE = {
		FURNITURE = 3,
		DECORATE = 2,
		FLOOR = 1
	},
	FURNITURE_TYPE = {
		GROUND_ADORNMENT = 4,
		WALL_DECORATION = 3,
		WALL = 1,
		FLOOR = 2,
		ROOM_BG = 10,
		FURNISHING_ARTICLE = 9,
		TABLE_CHAIR = 8,
		BATH_CROCK = 7,
		SOFA = 6,
		BED = 5
	},
	BATH_CROCK_STATE = {
		NOT_PLACED = 0,
		CD = 2,
		CAN_USE = 1
	},
	CAN_PLACE_CTRL_IDX = {
		NO = 0,
		YES = 1
	},
	PLACE_END_CTRL_IDX = {
		NO = 0,
		YES = 1
	},
	FURNITURE_SPINE_DEBUG_TOUCH = var_0_0,
	BUBBLE_TYPE = {
		CHARM = 2,
		LOOK = 1,
		CLEAN = 3
	}
}
