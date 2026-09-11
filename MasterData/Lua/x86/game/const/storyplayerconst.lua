return {
	PLAYER_STATUS = {
		IDLE = 1,
		HISTORY = 5,
		HIDE = 4,
		PLAYING = 2,
		PAUSED = 3
	},
	NODE_STATUS = {
		IDLE = 1,
		FINISHED = 5,
		HIDE = 4,
		PLAYING = 2,
		PAUSED = 3
	},
	ACTOR_TYPE = {
		Tpose = 3,
		Camera = 4,
		Background = 2,
		Sprite = 5,
		UI_Effect = 7,
		ActorSprite = 6,
		None = 1
	},
	ACTOR_DISPLAY_LAYER = {
		NORMAL = 1,
		TOP = 2
	},
	EASE_MOVE_TYPE = {
		MOVE_OUT = 2,
		MOVE_IN = 1
	},
	EASE_MOVE_DIRECTION = {
		RIGHT = 2,
		UP = 3,
		LEFT = 1,
		DOWN = 4
	},
	BACKGROUND_VIDEO_PLAY_MODE = {
		LOOP = 2,
		PART_LOOP = 3,
		ONCE = 1
	},
	BACKGROUND_VIDEO_STOP_MODE = {
		MOVIE_END = 2,
		NODE_END = 3,
		MANUAL = 1
	},
	TEXT_GROUP_NODE_TYPE = {
		CREATE_TEXT_GROUP = 1,
		DESTROY_ALL_TEXT_GROUP = 4,
		ADD_TEXT = 2,
		DESTROY_TEXT_GROUP = 3
	},
	TEXT_GROUP_BG_ACTION_TYPE = {
		ENABLE = 1,
		DISABLE = 2,
		CHANGE = 3
	},
	TEXT_GROUP_EFFECT_TYPE = {
		ALPHA = 2,
		TYPE_WRITER = 1
	},
	SHAKE_TARGET = {
		ACTOR_SPRITE = 6,
		TPOSE = 3,
		BACKGROUND = 2,
		DIALOG = 7,
		SPRITE = 5,
		DIALOG_HEAD = 8,
		CAMERA = 4,
		NONE = 1
	}
}
