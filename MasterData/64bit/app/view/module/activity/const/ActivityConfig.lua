local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User

return {
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ONLINE_GIFT] = {
		tabRedPointId = 134,
		compName = "ActivityOnlineGiftMainComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_richangbuji_1.png",
			shadowIcon = "icon/activity/icon_hd_richangbuji_3.png",
			icon = "icon/activity/icon_hd_richangbuji_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ONLINE_GIFT
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LEVEL_UP_GIFT] = {
		tabRedPointId = 114,
		compName = "ActivityLevelUpComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_kuozhanxieyi_1.png",
			shadowIcon = "icon/activity/icon_hd_kuozhanxieyi_3.png",
			icon = "icon/activity/icon_hd_kuozhanxieyi_2.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityLevelUpData:isExistUnfinishedTask(...)
		end,
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.LEVEL_UP_AWARD
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.GET_STAMINA] = {
		tabRedPointId = 115,
		compName = "ActivityGetStaminaComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_richangbuji_1.png",
			shadowIcon = "icon/activity/icon_hd_richangbuji_3.png",
			icon = "icon/activity/icon_hd_richangbuji_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_STAMINA
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DAILY_RECHARGE] = {
		tabRedPointId = 173,
		compName = "ActivityDailyBoxGiftComp",
		topBarId = 267,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_meiritehui_1.png",
			shadowIcon = "icon/activity/icon_meiritehui_3.png",
			icon = "icon/activity/icon_meiritehui_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_BOX
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUBSCRIPTION] = {
		tabRedPointId = 237,
		compName = "ActivitySubscriptionComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_meiritehui_1.png",
			shadowIcon = "icon/activity/icon_meiritehui_3.png",
			icon = "icon/activity/icon_meiritehui_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE_SUBSCRIPTION
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LEVEL_FUND] = {
		tabRedPointId = 252,
		compName = "ActivityFundComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_quanxianjijin_1.png",
			shadowIcon = "icon/activity/icon_hd_quanxianjijin_3.png",
			icon = "icon/activity/icon_hd_quanxianjijin_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.GROWTH_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DUNGEON_FUND] = {
		tabRedPointId = 253,
		compName = "ActivityFundComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_zhanqujijin_1.png",
			shadowIcon = "icon/activity/icon_hd_zhanqujijin_3.png",
			icon = "icon/activity/icon_hd_zhanqujijin_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.WUSH_FUND] = {
		tabRedPointId = 254,
		compName = "ActivityFundComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_heiyuanjijin_1.png",
			shadowIcon = "icon/activity/icon_hd_heiyuanjijin_3.png",
			icon = "icon/activity/icon_hd_heiyuanjijin_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MYSTERY_FUND] = {
		tabRedPointId = 1091,
		compName = "ActivityFundComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_huajingjijin_1.png",
			shadowIcon = "icon/activity/icon_hd_huajingjijin_3.png",
			icon = "icon/activity/icon_hd_huajingjijin_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.MYSTERY_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.INVITE_FRIEND] = {
		tabRedPointId = 335,
		compName = "ActivityInviteFriendComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_haoyouyaoqing_1.png",
			shadowIcon = "icon/activity/icon_hd_haoyouyaoqing_3.png",
			icon = "icon/activity/icon_hd_haoyouyaoqing_2.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityInviteFriendData:isShowInviteEntrance(...)
		end,
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.INVITE_FRIEND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MONTH_GACHA] = {
		tabRedPointId = 399,
		compName = "ActivityGachaComp",
		bg = "bg/activity/bg_ljs_liujinshangbg2.jpg",
		topBarId = 223,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_liujinshang_1.png",
			shadowIcon = "icon/activity/icon_hd_liujinshang_3.png",
			icon = "icon/activity/icon_hd_liujinshang_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.MONTH_GACHA
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.PERMANENT_RECHARGE] = {
		tabRedPointId = 411,
		compName = "ActivityPermanentRechargeComp",
		bg = "bg/activity/bg_yongjiuleichong.jpg",
		topBarId = 235,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_chongjian_1.png",
			shadowIcon = "icon/activity/icon_hd_chongjian_3.png",
			icon = "icon/activity/icon_hd_chongjian_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.PERMANENT_RECHARGE,
		additionalOpenFunc = function()
			return var_0_1.activityPermanentRechargeData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DAILY_WISH] = {
		tabRedPointId = 444,
		compName = "ActivityWishpoolComp",
		bg = "",
		topBarId = 263,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_wish_1.png",
			shadowIcon = "icon/activity/icon_hd_wish_3.png",
			icon = "icon/activity/icon_hd_wish_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_WISH
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIFE_TIME_CARD] = {
		bg = "bg/activity/bg_hd_zhongshengka.jpg",
		compName = "ActivityLifeTimeCard",
		tabRedPointId = 456,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_dingyue_1.png",
			shadowIcon = "icon/activity/icon_hd_dingyue_3.png",
			icon = "icon/activity/icon_hd_dingyue_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.TIME_LIFE_CARD
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.HY_REBATE] = {
		bg = "bg/activity/bg_hd_czfl.jpg",
		compName = "ActivityHYUserRebateComp",
		tabRedPointId = 877,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_chongzhifanli_1.png",
			shadowIcon = "icon/activity/icon_hd_chongzhifanli_3.png",
			icon = "icon/activity/icon_hd_chongzhifanli_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.HY_REBATE,
		additionalOpenFunc = function()
			return var_0_1.activityOtherReturnPayData:isShow()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RECHARGE_TEST_REBATE] = {
		bg = "bg/activity/bg_hd_czfl.jpg",
		compName = "ActivityReturnPayComp",
		tabRedPointId = 458,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_chongzhifanli_1.png",
			shadowIcon = "icon/activity/icon_hd_chongzhifanli_3.png",
			icon = "icon/activity/icon_hd_chongzhifanli_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE_TEST_REBATE,
		additionalOpenFunc = function()
			return var_0_1.rechargeData:isShowReturnPay()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.TAP_WELFARE] = {
		bg = "bg/activity/bg_hd_taptap2024.11_lingqu.jpg",
		compName = "ActivityTapWelfareComp",
		tabRedPointId = 716,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_taptap_1.png",
			shadowIcon = "icon/activity/icon_hd_taptap_3.png",
			icon = "icon/activity/icon_hd_taptap_2.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityTapWelfareData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.BLACK_FIVE] = {
		bg = "bg/activity/bg_hd_taptap2024_lingqu.jpg",
		compName = "ActivityBlackFiveComp",
		tabRedPointId = 2000,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_heiwu_1.png",
			shadowIcon = "icon/activity/icon_hd_heiwu_3.png",
			icon = "icon/activity/icon_hd_heiwu_2.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityBlackFiveData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RESOURCE_BACK] = {
		tabRedPointId = 717,
		compName = "ActivityResourceBackComp",
		topBarId = 312,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_wuzibuling_1.png",
			shadowIcon = "icon/activity/icon_hd_wuzibuling_3.png",
			icon = "icon/activity/icon_hd_wuzibuling_2.png"
		}
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CELEBRATION_LOGIN] = {
		bg = "bg/activity/bg_hd_znqqdbg.jpg",
		compName = "ActivityCelebrationLoginComp",
		tabRedPointId = 816,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_znqqd_1.png",
			shadowIcon = "icon/activity/icon_hd_znqqd_3.png",
			icon = "icon/activity/icon_hd_znqqd_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN,
		additionalOpenFunc = function()
			return var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_LOGIN)
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CELEBRATION_WITCH] = {
		bg = "bg/activity/bg_hd_znqqdbg.jpg",
		compName = "ActivityCelebrationLoginComp",
		tabRedPointId = 902,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_znqqd_4.png",
			shadowIcon = "icon/activity/icon_hd_znqqd_6.png",
			icon = "icon/activity/icon_hd_znqqd_5.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH,
		additionalOpenFunc = function()
			return var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_WITCH)
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ABVERT_PAGE_AWARD] = {
		tabRedPointId = 905,
		compName = "ActivityAbvertPageComp",
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_znzl_1.png",
			shadowIcon = "icon/activity/icon_hd_znzl_3.png",
			icon = "icon/activity/icon_hd_znzl_2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ABVERT_AWARD_1,
		additionalOpenFunc = function()
			return var_0_1.abvertPageAwardData:isActivityInShow(var_0_1.abvertPageAwardData:getCurActId())
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.USER_BACK] = {
		bg = "bg/activity/bg_xinxingguila.jpg",
		compName = "ActivityUserBackComp",
		tabRedPointId = 911,
		tabIconConfig = {
			selectedIcon = "icon/activity/icon_hd_xxgl1.png",
			shadowIcon = "icon/activity/icon_hd_xxgl3.png",
			icon = "icon/activity/icon_hd_xxgl2.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.USER_BACK,
		additionalOpenFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.USER_BACK) and var_0_1.userBackData:showEntrance()
		end
	}
}
