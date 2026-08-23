return {
	MATCHING_TIME_LONG = 30,
	RANK_SHOW_SIZE = 200,
	RANK_REWARD_TYPE = 104,
	MATCHING_TIME_OUT = 120,
	LEFT_TIME_TYPE = 94,
	MINIMAP_RANGE_POINTS = 30,
	MAIN_TOP_BAR_ID = 360,
	GAME_STATE = {
		FINAL = 2,
		SHOW = 3,
		NOT_OPEN = 4,
		REGULAR = 1
	},
	MATCH_STATE = {
		NOT_START = 0,
		IN_GAME = 1
	},
	RANK_TYPE = g.core.network.proto.PUBG_USER_SCORE_CROSS,
	RECORD_TYPE = {
		DEFEND_LOSE = 3,
		ATK_WIN = 2,
		DEFEND_WIN = 4,
		ATK_LOSE = 1
	},
	TASK_TYPE = {
		DAILY = 2,
		SEASON = 1
	},
	TASK_STATE = {
		REWARD = 2,
		FINISH = 1,
		NOT_FINISH = 0
	},
	Params = {
		GAME_TIME = 16,
		START_INVINCIBLE_TIME = 29,
		MOVE_ACTION_TIME = 25,
		INIT_HP = 14,
		INVINCIBLE_TIME = 19,
		FGO_VIEW = 3,
		AIRDROP_TIP_TIME = 30,
		MAP_START_DELAY = 15,
		LEVEL_CHANGE_PREVIEW = 21,
		ATTACK_CD = 22,
		ATTACK_RANGE = 4,
		MOVE_DELAY_TIME = 24,
		AIRDROP_MINIMAP_MOVE_TIME = 31
	},
	map = {
		MAP_BORDER_NUM = 2,
		MAX_SHOW_ATTACK_NUM = 3,
		MAP_TILE_WIDTH = 140,
		MAP_MOVE_SPEED = 500,
		MAP_DRAG_RADIO = 1,
		MAP_DRAG_SENSITIVE = 1,
		MAP_DRAG_CHECK_NUM = 1,
		MAP_DRAG_ACCELERATE = 0,
		MAP_TILE_HEIGHT = 70,
		MAP_DEBUG_GRID = false,
		TOP_TIP_DELAY = 4,
		MAP_DRAG_INERTIA_CLOSE = true,
		MAP_DEBUG_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
		MAP_DEBUG_COLORB = cc.c4b(30, 230, 230, 255),
		itemType = {
			knight = 2,
			airDrop = 4,
			buff = 1,
			monster = 3,
			none = 0
		},
		GRID_TYPE = {
			OBSTACLE = 10,
			GRASS = 4
		},
		BUFF_TYPE = {
			HIDE = 5,
			RECEIVE_HP = 4,
			MOVE_SPEED = 1,
			FIGHT_VALUE_VALUE = 6,
			REVIVE = 3,
			ATTACK_RANGE = 2,
			MUST_WIN = 7,
			FIGHT_VALUE_RATE = 8
		},
		BUFF_LIMIT_TYPE = {
			USE_NUM = 2,
			TIME = 1
		},
		USER_UPDATE_TYPE = {
			HP = 1,
			LEVEL = 2,
			SCORE = 4,
			FIGHT_VALUE = 5,
			EXP = 3,
			RECOVER_TIME = 6,
			INVINCIBLE_TIME = 7
		}
	},
	entity = {
		obstacle_point = 5,
		user = 2,
		obstacle = 1,
		base = 0,
		obstacle_triangle = 6,
		buff = 3,
		monster = 4
	},
	fsm = {
		State = {
			dead = 3,
			attack = 4,
			idle = 2,
			null = 0,
			moving = 1
		},
		Tran = {
			null = 0,
			attack = 4,
			idle = 2,
			death = 3,
			moving = 1
		},
		test = {
			onProtoGetTick = 50,
			myId = 1,
			minTick = 100,
			moveSpeed = 240,
			jumpDeltaTime = 500,
			moveDistance = 25
		},
		Time = {
			averageDuration = 0,
			deltaT = 0,
			lowDuration = 0,
			updateCurPosConsumeMax = 0,
			lastT = 0,
			serverDeltaT = 0,
			lastSendDelayT = 0,
			updateCurPosConsume = 0,
			curT = 0,
			startTime = 0
		}
	}
}
