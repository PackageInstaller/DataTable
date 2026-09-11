return {
	GAME_STATUS = {
		OVER = 3,
		START = 1,
		RUNNING = 2
	},
	GAME_TIME_TIPS = {
		[GameSetting.activity_skadi_sea_be_out_start_tip.value[1]] = GameSetting.activity_skadi_sea_be_out_start_tip.value[2],
		[GameSetting.activity_skadi_sea_be_out_end_tip.value[1]] = GameSetting.activity_skadi_sea_be_out_end_tip.value[2]
	},
	GAME_COMMON_TIPS_INDEX = {
		SUCCESS = 1
	},
	EVENT_VIEW_ROUTE = {
		[0] = "sailGameOverEvent",
		"sailBattleEvent",
		"sailFishGameEvent",
		"sailLotteryEvent",
		"sailShopEvent",
		"sailGiftEvent",
		"sailDialogEvent"
	},
	EVENT_STATUS = {
		UN_READY = 0,
		OVER = 99,
		RUNNING = 1
	},
	EVENT_COMMON_OPERATE = {
		OVER = 99
	},
	EVENT_SHOP_STATUS = {
		NORMAL = 0,
		SOLD_OUT = 1
	},
	EVENT_LOTEERY_STATUS = {
		PLAY = 1,
		END = 5,
		WIN = 3,
		WAIT = 2,
		LOSE = 4,
		NONE = 0
	},
	LOTEERY_GAME_RESULT = {
		WIN = 2,
		LOSE = 1,
		NONE = 0
	},
	LOTTERY_OVER_TIPS_INDEX = {
		SUCCESS = 2,
		LOSE = 3,
		SUCCESS_FULLEST = 1
	},
	BUILDING_STATUS = {
		NOT_ENOUGH = 1,
		REWARD = 4,
		NORMAL = 3,
		CAN_BUILD = 2,
		MAX_LEVEL = 5,
		LOCK = 0
	},
	TASK_TYPE = {
		ISLAND_LEVEL = 1,
		BUILDING = 2
	}
}
