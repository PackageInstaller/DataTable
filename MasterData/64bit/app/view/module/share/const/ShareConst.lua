local var_0_0 = {
	TEAM_BATTLE_USE_INVITE_ID = 44,
	SHARE_AWARD_ID = 7004,
	SHARE_TYPE = {
		TYPE_ID_25 = 25,
		TYPE_ID_24 = 24,
		TYPE_ID_23 = 23,
		TYPE_ID_22 = 22,
		TYPE_ID_ACCOUNT_LINK = 3001,
		TYPE_ID_21 = 21,
		TYPE_ID_20 = 20,
		TYPE_ID_19 = 19,
		TYPE_ID_18 = 18,
		TYPE_ID_17 = 17,
		TYPE_ID_16 = 16,
		TYPE_ID_15 = 15,
		TYPE_ID_14 = 14,
		TYPE_ID_13 = 13,
		TYPE_ID_12 = 12,
		TYPE_ID_11 = 11,
		TYPE_ID_10 = 10,
		TYPE_ID_9 = 9,
		TYPE_ID_8 = 8,
		TYPE_ID_7 = 7,
		TYPE_ID_6 = 6,
		TYPE_ID_5 = 5,
		TYPE_ID_4 = 4,
		TYPE_ID_3 = 3,
		TYPE_ID_2 = 2,
		TYPE_ID_1 = 1,
		TYPE_ID_26 = 26
	},
	SHARE_ACTIVITY_TYPE = {
		[1] = "ShareNewYearWishShotComp",
		[3] = "ShareHalfYearAnniversaryWishShotComp"
	},
	SPECIAL_SHARE_TYPE = {
		SHARE_ID1 = 10
	},
	SHARE_RESET_TYPE = {
		LIFELONG_RESET = 3,
		WEEKLY_RESET = 2,
		DAILY_RESET = 1
	},
	SHARE_PLATFORM = {
		QQ_SPACE = "6",
		KAKAO_TALK = "9",
		QQ_FRIEND = "5",
		KAKAO_STORY = "10",
		WECHAT_KEEP = "4",
		LINE = "11",
		WECHAT_QUAN = "3",
		TWITTER = "12",
		WECHAT_FRIEND = "2",
		VKontakte = "13",
		SINA_BLOG = "1",
		TIKTOK = "14",
		INSTAGRAM = "8",
		FACEBOOK = "7"
	},
	SHARE_PLATFORM_CFG = {
		["1"] = {
			icon = "ui://share/btn_weibo"
		},
		["2"] = {
			icon = "ui://share/btn_weixin"
		},
		["3"] = {
			icon = "ui://share/btn_pyq"
		},
		["5"] = {
			icon = "ui://share/btn_qq"
		},
		["6"] = {
			icon = "ui://share/btn_qqkj"
		},
		["7"] = {
			icon = "ui://share/btn_facebook"
		},
		["11"] = {
			icon = "ui://share/btn_line"
		},
		["12"] = {
			icon = "ui://share/btn_twitter"
		}
	},
	INVITE_FRIEND_SHARE_PLATFORM_CFG = {
		["1"] = {
			icon = "ui://activity/btn_weibo"
		},
		["2"] = {
			icon = "ui://activity/btn_weixin"
		},
		["3"] = {
			icon = "ui://activity/btn_pyq"
		},
		["5"] = {
			icon = "ui://activity/btn_qq"
		},
		["6"] = {
			icon = "ui://activity/btn_qqkj"
		},
		["7"] = {
			icon = "ui://share/btn_facebook"
		},
		["11"] = {
			icon = "ui://activity/btn_line"
		},
		["12"] = {
			icon = "ui://activity/btn_twitter"
		}
	}
}
local var_0_1 = {}

var_0_1[1] = device.isAndroid() and {
	"1",
	"5",
	"6"
} or {
	"2",
	"3",
	"5",
	"6"
}
var_0_1[2] = {
	"7",
	"11"
}
var_0_1[3] = {
	"7"
}
var_0_1[4] = {
	"7"
}
var_0_1[5] = {
	"7"
}
var_0_1[6] = {
	"7"
}
var_0_0.SHARE_REGION_CFG = var_0_1
var_0_0.SHOW_BIND_PHONE_OPID_LIST = {
	PC = 1,
	IOS_APP = 2107,
	UUZU_ANDROID = 2106
}

return var_0_0
