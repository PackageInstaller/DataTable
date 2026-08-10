return {
	MAIN_QUEST_STATUS = {
		UNTAKE = 2,
		LOCKED = 0,
		FINISH = 9,
		IN_PROGRESS = 3,
		UNLOCK = 1
	},
	QUEST_STATUS = {
		SKIPPED = -101,
		IN_PROGRESS = 0,
		NOT_START = -100,
		FINISH = 1
	},
	QUEST_TASK_TYPE = {
		SIDE = 2,
		MAIN = 1,
		TREASURE = 4,
		EXPLORE = 3,
		NONE = 0
	},
	SDK_QUEST_TRACK_TYPE = {
		AUTO_TRACK = 3,
		TRACK = 1,
		UNTRACK = 2
	},
	QUEST_EVENT = {
		ON_ENTER_ZONE = "on_enter_zone",
		ON_ACCOMPLISHED = "on_accomplished",
		ON_NOT_START = "on_not_start",
		ON_MINIGAME_FINISH = "on_minigame_finish",
		ON_BUBBLE_CLICK = "on_bubble_click",
		ON_MINIGAME_FAIL = "on_minigame_fail",
		ON_BACK_MAIN_HOME = "on_back_main_home",
		ON_UNMEET = "on_unmeet",
		ON_RECEIVE_EVENT = "on_receive_event",
		ON_EXIT_ZONE = "on_exit_zone",
		ON_PROG_UPDATE = "on_progress_update",
		ON_FINISH = "on_finish"
	},
	LISTENING_EVENT = {
		EVENT_QUANZHOU_PHASE_CLOSE_3 = "EVENT_QUANZHOU_PHASE_CLOSE_3",
		EVENT_QUANZHOU_PHASE_CLOSE_1 = "EVENT_QUANZHOU_PHASE_CLOSE_1",
		EVENT_QUANZHOU_PHASE_CLOSE_2 = "EVENT_QUANZHOU_PHASE_CLOSE_2"
	},
	TASK_BLUEPRINT_TAG = {
		LIFETIME_GRAPH = 0,
		NO_GRAPH = 2,
		ALWAYS_RUN_GRAPH = 1
	},
	GRAPH_PREDEFINE_VAR = {
		QUEST_LOCAL_PROGRESS = -1
	}
}
