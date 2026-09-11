local var_0_0 = {
	SHOP_ID = {
		REPURCHASE_SHOP = 17,
		CONSTANT_OBSERVATIONS = 24,
		SIX_SHOP = 34,
		DREAM_SHOP = 23,
		DIRECT_SHOP = 16,
		RE_COME_SHOP = 200,
		PASSPORT_SHOP = 11,
		DAILY_SHOP = 2,
		LIMIT_SUPPLY = 3,
		MIGRATION_OBSERVATIONS = 25,
		CONTRACT_BENEFITS = 37,
		SKIN_SHOP = 15,
		REPORT_SHOP = 12,
		GUIDE_SHOP = 13,
		DRAW_SHOP = 6,
		NEWBIE_SHOP = 5,
		SP_KALI_CHALLENGE_1 = 302,
		DAILY_SUPPLY = 4,
		NEW_DUO_WEI = 22,
		SP_HERO_CHALLENGE_1 = 216,
		NOOB_BP_RECHARGE = 1046,
		CORE_VERIFICATION = 41,
		DRAW_EXCHANGE_ASSET_SHOP = 10,
		NEW_SERVER_SHOP = 220,
		SUMMER_SHOP1 = 91,
		OLD_DUO_WEI = 21,
		BLACK_AREA = 20,
		SPRING_FESTIVAL_UP = 304,
		DORM_SHOP = 51,
		SUPPORT_SHOP = 100,
		OBSERVATION_SHOP = 36,
		SPRING_FESTIVAL_DOWN = 305,
		GODEARTER_SHOP_1 = 307,
		ADMIN_CAT_SHOP = 99,
		OATH_RING_SHIP = 42,
		FURNITURE_SHOP = 52,
		EQUIP_DEVELOP = 32,
		RECHARGE = 1043,
		EIGHT_SHOP = 35,
		COHOMOLOGY_TRACKS = 14,
		REGRESSION_SHOP = 308,
		CANTEEN_SHOP = 50,
		SKIN_TARGET = 18,
		DLC_SHOP = 15,
		SUPPORT_SHOP_2_8 = 103
	},
	SHOP_LIMIT_TEXT = {
		[0] = "LIMIT_ALL",
		"PURCHASE_LIMIT",
		"LIMIT_MONTH",
		"LIMIT_WEEK",
		"LIMIT_DAY",
		"LIMIT_ALL",
		"LIMIT_ALL",
		"PURCHASE_LIMIT"
	},
	SHOP_LIMIT = {
		BATTLE_PASS_LV = 2,
		PLAYER_LV = 1
	},
	COST_LEVEL = {
		CURRENCY_TYPE_SKIN = 4,
		RECHARGE_DIAMOND = 2,
		MATERIAL = 3,
		FREE_DIAMOND = 1
	},
	DISCOUNT = {
		TIME_DISCOUNT = 2,
		DISCOUNT = 3,
		NONE = 4
	},
	TAGS = {
		NEW = 2,
		SUPER_VALUE = 1
	},
	ITEM_TYPE_TO_LABEL = {
		[ItemConst.ITEM_TYPE.HERO_PIECE] = "SHOP_LABLE_4",
		[ItemConst.ITEM_TYPE.EQUIP] = "SHOP_LABLE_3",
		[ItemConst.ITEM_TYPE.WEAPON_SERVANT] = "SHOP_LABLE_2"
	},
	ADD_CURRENCY = {
		[2] = true,
		[1] = true
	},
	FILTER_SKIN_TYPE = {
		STATE_GOODS = 2,
		HERO = 1,
		STATE_BUY = 3
	},
	FILTER_HERO_TYPE = {
		ALL = 1,
		DLC = 3,
		SKIN = 2
	},
	FILTER_STATE_TYPE = {
		ALL = 1,
		CAN_BUY = 2,
		CANT_BUY = 3
	}
}

var_0_0.prefabList = {
	[var_0_0.SHOP_ID.LIMIT_SUPPLY] = "Widget/System/Recharge/pages/RechargeGiftPageUI",
	[var_0_0.SHOP_ID.DAILY_SUPPLY] = "Widget/System/Recharge/pages/RechargeGiftPageUI",
	[var_0_0.SHOP_ID.NEWBIE_SHOP] = "Widget/System/Recharge/pages/RechargeGiftPageUI",
	[var_0_0.SHOP_ID.DRAW_SHOP] = "Widget/System/Recharge/pages/RechargeVoucherPageUI",
	[var_0_0.SHOP_ID.SKIN_SHOP] = "Widget/System/Recharge/pages/RechargeSkinDlcPageUI_New",
	[var_0_0.SHOP_ID.DIRECT_SHOP] = "Widget/System/Recharge/pages/RechargeSkinPageUI_New",
	[var_0_0.SHOP_ID.REPURCHASE_SHOP] = "Widget/System/Recharge/pages/RechargeSkinDlcPageUI_New",
	[var_0_0.SHOP_ID.SKIN_TARGET] = "Widget/System/Recharge/pages/RechargeSkinTicketPageUI",
	[var_0_0.SHOP_ID.CONSTANT_OBSERVATIONS] = "Widget/System/Recharge/pages/RechargeMonthCardPageUI",
	[var_0_0.SHOP_ID.MIGRATION_OBSERVATIONS] = "Widget/System/Recharge/pages/RechargeRechargePageUI",
	[var_0_0.SHOP_ID.SIX_SHOP] = "Widget/System/Recharge/pages/RechargeFirstRechargePageUI",
	[var_0_0.SHOP_ID.EIGHT_SHOP] = "Widget/System/Recharge/pages/RechargeFirstRechargePageUI",
	[var_0_0.SHOP_ID.OBSERVATION_SHOP] = "Widget/System/Activitynewbie/NewbieMonthlyCardUI_old",
	[var_0_0.SHOP_ID.CONTRACT_BENEFITS] = "Widget/System/Activitynewbie/NewbieBpRechargeUI_old",
	[var_0_0.SHOP_ID.OATH_RING_SHIP] = "Widget/System/Recharge/pages/RechargeOathRingPageUI"
}
var_0_0.SIX_EIGHT = {
	[var_0_0.SHOP_ID.SIX_SHOP] = 1,
	[var_0_0.SHOP_ID.EIGHT_SHOP] = 2
}
var_0_0.SHOP_ID_TO_RED_CONST = {
	[var_0_0.SHOP_ID.LIMIT_SUPPLY] = "ACTIVITY_BONUS",
	[var_0_0.SHOP_ID.DAILY_SUPPLY] = "NORMAL_BONUS",
	[var_0_0.SHOP_ID.NEWBIE_SHOP] = "NEWBIE_BONUS",
	[var_0_0.SHOP_ID.REPORT_SHOP] = "HERO_PIECE_EXCHANGE",
	[var_0_0.SHOP_ID.CONSTANT_OBSERVATIONS] = "NOOB_MONTHLY_RECHARGE_SIGN",
	[var_0_0.SHOP_ID.MIGRATION_OBSERVATIONS] = 400,
	[var_0_0.SHOP_ID.SIX_SHOP] = "NOOB_FIRST_RECHARGE_1",
	[var_0_0.SHOP_ID.EIGHT_SHOP] = "NOOB_FIRST_RECHARGE_2",
	[var_0_0.SHOP_ID.OBSERVATION_SHOP] = "NOOB_MONTHLY_RECHARGE",
	[var_0_0.SHOP_ID.CONTRACT_BENEFITS] = "NOOB_BP_RECHARGE",
	[var_0_0.SHOP_ID.SKIN_SHOP] = "SKIN_DISCOUNT_GIFT",
	[var_0_0.SHOP_ID.OATH_RING_SHIP] = "OATH_RING_COUPON_WILL_EXPIRE"
}
var_0_0.PC_LOCK_SHOP = {
	[var_0_0.SHOP_ID.SKIN_TARGET] = true,
	[var_0_0.SHOP_ID.MIGRATION_OBSERVATIONS] = true
}
var_0_0.PC_LOCK_RECHARGE = {
	["2_3"] = true
}
var_0_0.NEED_HIDE_TIME = {
	[var_0_0.SHOP_ID.SP_HERO_CHALLENGE_1] = true,
	[var_0_0.SHOP_ID.CANTEEN_SHOP] = true
}
var_0_0.SKIN_SHOP_LIST = {
	[var_0_0.SHOP_ID.SKIN_SHOP] = true,
	[var_0_0.SHOP_ID.DIRECT_SHOP] = true,
	[var_0_0.SHOP_ID.REPURCHASE_SHOP] = true
}
var_0_0.SPECIAL_ID = {
	SKIN_LIST = -1
}
var_0_0.SPRCIAL_PREFAB = {
	[var_0_0.SPECIAL_ID.SKIN_LIST] = "Widget/System/Recharge/pages/RechargeSkinListPageUI_New"
}

return var_0_0
