local var_0_0 = {
	WALL_ORI_ID = 951013,
	gridLen = 250,
	CANTEEN_ID = 4,
	DORM_VISIT_ROOM_MIN = 1000,
	POS_PRECISION = 1000,
	ORDER_FOOD_AUTO_NUM = 1,
	DISPATCH_REFRESH_TIME = 1,
	DORM_CURRENCY_ID = 39,
	PRIVATE_CHARACTER_MAX_NUM = 1,
	DORM_HOME_UNLOCK_ROOM_CURRENCY = 41701,
	LOBBY_ORI_WALL_ID = 961002,
	LOBBY_ORI_BACKHGROUND_ID = 961004,
	BACK_GROUND_ORI_ID = 951027,
	WALL_TYPE_NUM = 21,
	FLOOR_ORI_ID = 951014,
	DORM_FUR_TYPE_END = 28,
	CATEEN_ORDER_FOOD_LIST_NUM = 3,
	DORM_FUR_TYPE_START = 20,
	DORM_HERO_TAG_MAX = 20,
	DORM_FLOOR_ROOM_NUM = 11,
	FLOOR_TYPE_NUM = 20,
	DORM_FURTYPE_OFFSET = -9,
	LOAD_HIGH_NUM = 0.8,
	DORM_SPECIAL_FURNITURE_NUM = 3,
	LOAD_WARING_NUM = 0.9,
	DORM_PRIVATE_FIRST_ID = 6,
	BACK_GROUND_TYPE = 27,
	DORM_POS_ID_OFFSET = 101,
	IDOL_TRAINEE_PROPERTY_COUNT = 5,
	DORM_VISIT_LOBBY = 1001,
	DORM_VISIT_PRIVATE = 1002,
	LOBBY_ORI_FLOOR_ID = 961001,
	COOK_CURSOR_FRAME = 30,
	CANTEEN_TRUST_CHARACTER_NUM = 3,
	DORM_FIRST_FLOOR_ROOM_NUM = 7,
	PUBLIC_DORM_ID = 5,
	CANTEEN_FOOD_MATERIAL_PATH = "TextureConfig/EmptyDream/canteen/material/",
	ORDER_FOOD_NUM = 2,
	DORM_SUIT_TYPE = 28,
	CANTEEN_FOOD_PATH = "TextureConfig/EmptyDream/canteen/food/",
	CHARACTER_INTERACT_CAMERA_MOVE_TIME = 0.5,
	TILE_TYPE = {
		CEIL = 1,
		FLOOR = 0,
		WALL_FRONT = 2,
		WALL_RIGHT = 5,
		WALL_BEHIND = 3,
		WALL_LEFT = 4
	},
	DORM_HERO_SKILL_SUB_TYPE = {
		ADD_EANRNINGS_IN_ARCHITECTURE = 101,
		ADD_EANRNINGS_WITH_HERO_IN_ARCHITECTURE = 103,
		REDUCE_MOODE_IN_ARCHITECTURE = 202,
		REDUCE_MOOD_MYSELF_IN_ARCHITECTURE = 201,
		ADD_GOODS_EARNINGS = 102
	},
	DORM_HERO_MAX_MOOD = GameSetting.dorm_hero_mood_max.value[1],
	DORM_RESTAURANT_SET_JOB_TYPE = {
		"RestaurantCook",
		"RestaurantWaiter",
		"RestaurantCashier"
	},
	BACKHOME_TYPE = {
		IdolTraineeCamp = 6,
		VISITPRIVATEDORM = 5,
		PrivateDorm = 3,
		VISITPUBLICDORM = 4,
		PublicDorm = 2,
		Canteen = 1
	},
	BACKHOME_SYSTEM_TYPE = {
		Dorm = 0,
		AutoPlay = 2,
		Canteen = 1
	},
	BACKHOME_FUR_GIVE_TYPE = {
		GIFT = 1,
		NO_GIFT = 0,
		SPECIFY = 3
	},
	DORM_TEMPLATE_NUM_MAX = GameSetting.dorm_template_max.value[1],
	DORM_TEMPLATE_PRIVATE_NUM_MAX = GameSetting.dorm_template_max.value[1],
	DORM_FLOOR_MAX = GameDisplayCfg.dorm_area_layer_num.value[1],
	DORM_AUDIO_EFFECT = {
		ChangeFloor = "ui_dorm_position",
		UpCharacter = "ui_dorm_up",
		InteractCam = "ui_dorm_character",
		PlaceFur = "ui_dorm_furniture",
		DownCharacter = "ui_dorm_down"
	},
	DORM_FUR_EDITVIEW_TYPE = {
		HadPlace = "HadPlace",
		CanPlace = "CanPlace",
		OtherHadPlace = "OtherHadPlac",
		NotPresented = "NotPresented"
	},
	DORM_RHYTHM_BUTTON_TYPE = {
		fail = 3,
		left = 1,
		right = 2
	},
	DORM_RHYTHMGAME_RANK = {
		"D",
		"C",
		"B",
		"A",
		"S"
	},
	DORM_CHANGESKIN_TYPE = {
		view = 1,
		furniture = 2
	},
	DORM_CHARACTER_TYPE = {
		NPC = 2,
		HERO = 1
	},
	DORM_QUICK_JUMP_TYPE = {
		DORM = 3,
		CANTEEN = 2,
		LOBBY = 4,
		VISIT = 1
	}
}

var_0_0.PROTOCOL_TILE_TYPE = {
	var_0_0.TILE_TYPE.WALL_LEFT,
	var_0_0.TILE_TYPE.WALL_RIGHT,
	var_0_0.TILE_TYPE.WALL_FRONT,
	var_0_0.TILE_TYPE.WALL_BEHIND,
	var_0_0.TILE_TYPE.FLOOR
}
var_0_0.PROTOCOL_TILE_TYPE_INDEX = {
	RIGHT = 2,
	BEHIND = 4,
	FLOOR = 5,
	FORNT = 3,
	LEFT = 1
}
var_0_0.LOCK_HERO_FOR_FEATURE = {
	LOCK_FOR_IDOL_TRAINING = 1,
	NONE = 0
}

return var_0_0
