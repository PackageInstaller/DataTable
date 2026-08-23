local var_0_0 = {
	CTRL_BTN_UNLOCK = 0,
	CTRL_BTN_LOCK = 1,
	CTRL_BANNER_DOT_SHOW = 1,
	CTRL_BANNER_DOT_HIDE = 0,
	MAX_ACTIVITY_BTN_NUM = 5,
	GM_UNPUT_INFO_LIST = {
		knight_info = {
			is_display = 0,
			put = 0
		},
		artifact_info = {
			put = 0
		},
		pet_info = {
			put = 0
		},
		unite_token_info = {
			put = 0
		},
		skin_info = {
			put = 0
		},
		item_info = {
			if_show = 0
		},
		avata_info = {
			put = 0
		},
		avatar_frame_info = {
			put = 0
		},
		furniture_info = {
			put = 0
		},
		ksoul_book_chapter_info = {
			put = 0
		},
		role_skin_info = {
			put = 0
		},
		succuba_info = {
			put = 0
		}
	},
	GM_SORT_TYPE = {
		NORMAL = 0,
		KSOUL_CHAPTER = 1
	},
	THEME_ACTIVITY = {
		value = 1,
		route_id = 200072,
		type = 27
	},
	INFO_REMIND_TYPE = {
		TIMES = 2,
		REWARD = 1,
		OTHERS = 3
	},
	VOICE_PREFERENCE = {
		PLAYER_BIRTH = 4,
		COMMON_HOLIDAY = 2,
		KNIGHT_BIRTH = 3,
		NONE = 1
	},
	TYPE_TO_VOICE_PREFERENCE = {
		"COMMON_HOLIDAY",
		"COMMON_HOLIDAY",
		"KNIGHT_BIRTH",
		"PLAYER_BIRTH"
	},
	LAND_PART_POS_OFF = {
		[0] = cc.p(0, 100),
		[5000001] = cc.p(0, -200)
	}
}

var_0_0.ASSISTANT_TOUCH_BG_ALPHA = 0
var_0_0.OTHER_BTN = {
	TYPE_CULTIVATE = 3,
	TYPE_COMMANDER_WORLD = 1,
	TYPE_DOUBLE_ELEVEN = 2,
	TYPE_WITCH = 4
}

return var_0_0
