return {
	MINIMAP_RANGE_POINTS = 30,
	RANK_REWARD_TYPE = 104,
	MATCHING_TIME_OUT = 120,
	MATCHING_TIME_LONG = 30,
	LEFT_TIME_TYPE = 94,
	MAIN_TOP_BAR_ID = 360,
	RANK_SHOW_SIZE = 200,
	GAME_STATE = {
		SHOW = 3,
		FINAL = 2,
		REGULAR = 1,
		NOT_OPEN = 4
	},
	MATCH_STATE = {
		IN_GAME = 1,
		NOT_START = 0
	},
	RANK_TYPE = g.core.network.proto.PUBG_USER_SCORE_CROSS,
	RECORD_TYPE = {
		ATK_LOSE = 1,
		DEFEND_WIN = 4,
		DEFEND_LOSE = 3,
		ATK_WIN = 2
	},
	TASK_TYPE = {
		DAILY = 2,
		SEASON = 1
	},
	TASK_STATE = {
		NOT_FINISH = 0,
		REWARD = 2,
		FINISH = 1
	},
	Params = {
		GAME_TIME = 16,
		MAP_START_DELAY = 15,
		INIT_HP = 14,
		ATTACK_RANGE = 4,
		FGO_VIEW = 3,
		AIRDROP_MINIMAP_MOVE_TIME = 31,
		AIRDROP_TIP_TIME = 30,
		START_INVINCIBLE_TIME = 29,
		MOVE_ACTION_TIME = 25,
		MOVE_DELAY_TIME = 24,
		ATTACK_CD = 22,
		LEVEL_CHANGE_PREVIEW = 21,
		INVINCIBLE_TIME = 19
	},
	map = {
		MAP_TILE_WIDTH = 140,
		MAP_DEBUG_GRID = false,
		MAX_SHOW_ATTACK_NUM = 3,
		TOP_TIP_DELAY = 4,
		MAP_DRAG_CHECK_NUM = 1,
		MAP_BORDER_NUM = 2,
		MAP_MOVE_SPEED = 500,
		MAP_DRAG_ACCELERATE = 0,
		MAP_DRAG_SENSITIVE = 1,
		MAP_DRAG_RADIO = 1,
		MAP_DRAG_INERTIA_CLOSE = true,
		MAP_TILE_HEIGHT = 70,
		MAP_DEBUG_COLORF = cc.c4f(0.15, 0.9, 0.9, 1),
		MAP_DEBUG_COLORB = cc.c4b(30, 230, 230, 255),
		itemType = {
			airDrop = 4,
			monster = 3,
			knight = 2,
			buff = 1,
			none = 0
		},
		GRID_TYPE = {
			GRASS = 4,
			OBSTACLE = 10
		},
		BUFF_TYPE = {
			REVIVE = 3,
			HIDE = 5,
			RECEIVE_HP = 4,
			ATTACK_RANGE = 2,
			MOVE_SPEED = 1,
			FIGHT_VALUE_VALUE = 6,
			MUST_WIN = 7,
			FIGHT_VALUE_RATE = 8
		},
		BUFF_LIMIT_TYPE = {
			TIME = 1,
			USE_NUM = 2
		},
		USER_UPDATE_TYPE = {
			RECOVER_TIME = 6,
			FIGHT_VALUE = 5,
			SCORE = 4,
			EXP = 3,
			LEVEL = 2,
			HP = 1,
			INVINCIBLE_TIME = 7
		}
	},
	entity = {
		base = 0,
		obstacle_triangle = 6,
		obstacle_point = 5,
		user = 2,
		obstacle = 1,
		buff = 3,
		monster = 4
	},
	fsm = {
		State = {
			attack = 4,
			dead = 3,
			idle = 2,
			moving = 1,
			null = 0
		},
		Tran = {
			death = 3,
			attack = 4,
			idle = 2,
			moving = 1,
			null = 0
		},
		test = {
			moveDistance = 25,
			jumpDeltaTime = 500,
			myId = 1,
			onProtoGetTick = 50,
			minTick = 100,
			moveSpeed = 240
		},
		Time = {
			updateCurPosConsumeMax = 0,
			updateCurPosConsume = 0,
			lastSendDelayT = 0,
			serverDeltaT = 0,
			startTime = 0,
			deltaT = 0,
			curT = 0,
			lastT = 0,
			lowDuration = 0,
			averageDuration = 0
		}
	}
}
