local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User

return {
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ONLINE_GIFT] = {
		compName = "ActivityOnlineGiftMainComp",
		tabRedPointId = 134,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_richangbuji_3.png",
			icon = "icon/activity/icon_hd_richangbuji_2.png",
			selectedIcon = "icon/activity/icon_hd_richangbuji_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ONLINE_GIFT
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LEVEL_UP_GIFT] = {
		compName = "ActivityLevelUpComp",
		tabRedPointId = 114,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_kuozhanxieyi_3.png",
			icon = "icon/activity/icon_hd_kuozhanxieyi_2.png",
			selectedIcon = "icon/activity/icon_hd_kuozhanxieyi_1.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityLevelUpData:isExistUnfinishedTask(...)
		end,
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.LEVEL_UP_AWARD
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.GET_STAMINA] = {
		compName = "ActivityGetStaminaComp",
		tabRedPointId = 115,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_richangbuji_3.png",
			icon = "icon/activity/icon_hd_richangbuji_2.png",
			selectedIcon = "icon/activity/icon_hd_richangbuji_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_STAMINA
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DAILY_RECHARGE] = {
		compName = "ActivityDailyBoxGiftComp",
		topBarId = 267,
		tabRedPointId = 173,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_meiritehui_3.png",
			icon = "icon/activity/icon_meiritehui_2.png",
			selectedIcon = "icon/activity/icon_meiritehui_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_BOX
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUBSCRIPTION] = {
		compName = "ActivitySubscriptionComp",
		tabRedPointId = 237,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_meiritehui_3.png",
			icon = "icon/activity/icon_meiritehui_2.png",
			selectedIcon = "icon/activity/icon_meiritehui_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE_SUBSCRIPTION
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LEVEL_FUND] = {
		compName = "ActivityFundComp",
		tabRedPointId = 252,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_quanxianjijin_3.png",
			icon = "icon/activity/icon_hd_quanxianjijin_2.png",
			selectedIcon = "icon/activity/icon_hd_quanxianjijin_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.GROWTH_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DUNGEON_FUND] = {
		compName = "ActivityFundComp",
		tabRedPointId = 253,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_zhanqujijin_3.png",
			icon = "icon/activity/icon_hd_zhanqujijin_2.png",
			selectedIcon = "icon/activity/icon_hd_zhanqujijin_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.WUSH_FUND] = {
		compName = "ActivityFundComp",
		tabRedPointId = 254,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_heiyuanjijin_3.png",
			icon = "icon/activity/icon_hd_heiyuanjijin_2.png",
			selectedIcon = "icon/activity/icon_hd_heiyuanjijin_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MYSTERY_FUND] = {
		compName = "ActivityFundComp",
		tabRedPointId = 1091,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_huajingjijin_3.png",
			icon = "icon/activity/icon_hd_huajingjijin_2.png",
			selectedIcon = "icon/activity/icon_hd_huajingjijin_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.MYSTERY_FUND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.INVITE_FRIEND] = {
		compName = "ActivityInviteFriendComp",
		tabRedPointId = 335,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_haoyouyaoqing_3.png",
			icon = "icon/activity/icon_hd_haoyouyaoqing_2.png",
			selectedIcon = "icon/activity/icon_hd_haoyouyaoqing_1.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityInviteFriendData:isShowInviteEntrance(...)
		end,
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.INVITE_FRIEND
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MONTH_GACHA] = {
		bg = "bg/activity/bg_ljs_liujinshangbg2.jpg",
		compName = "ActivityGachaComp",
		topBarId = 223,
		tabRedPointId = 399,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_liujinshang_3.png",
			icon = "icon/activity/icon_hd_liujinshang_2.png",
			selectedIcon = "icon/activity/icon_hd_liujinshang_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.MONTH_GACHA
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.PERMANENT_RECHARGE] = {
		bg = "bg/activity/bg_yongjiuleichong.jpg",
		topBarId = 235,
		tabRedPointId = 411,
		compName = "ActivityPermanentRechargeComp",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_chongjian_3.png",
			icon = "icon/activity/icon_hd_chongjian_2.png",
			selectedIcon = "icon/activity/icon_hd_chongjian_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.PERMANENT_RECHARGE,
		additionalOpenFunc = function()
			return var_0_1.activityPermanentRechargeData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DAILY_WISH] = {
		bg = "",
		compName = "ActivityWishpoolComp",
		topBarId = 263,
		tabRedPointId = 444,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_wish_3.png",
			icon = "icon/activity/icon_hd_wish_2.png",
			selectedIcon = "icon/activity/icon_hd_wish_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_WISH
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIFE_TIME_CARD] = {
		compName = "ActivityLifeTimeCard",
		tabRedPointId = 456,
		bg = "bg/activity/bg_hd_zhongshengka.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_dingyue_3.png",
			icon = "icon/activity/icon_hd_dingyue_2.png",
			selectedIcon = "icon/activity/icon_hd_dingyue_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.TIME_LIFE_CARD
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.HY_REBATE] = {
		compName = "ActivityHYUserRebateComp",
		tabRedPointId = 877,
		bg = "bg/activity/bg_hd_czfl.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_chongzhifanli_3.png",
			icon = "icon/activity/icon_hd_chongzhifanli_2.png",
			selectedIcon = "icon/activity/icon_hd_chongzhifanli_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.HY_REBATE,
		additionalOpenFunc = function()
			return var_0_1.activityOtherReturnPayData:isShow()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RECHARGE_TEST_REBATE] = {
		compName = "ActivityReturnPayComp",
		tabRedPointId = 458,
		bg = "bg/activity/bg_hd_czfl.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_chongzhifanli_3.png",
			icon = "icon/activity/icon_hd_chongzhifanli_2.png",
			selectedIcon = "icon/activity/icon_hd_chongzhifanli_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE_TEST_REBATE,
		additionalOpenFunc = function()
			return var_0_1.rechargeData:isShowReturnPay()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.TAP_WELFARE] = {
		tabRedPointId = 716,
		compName = "ActivityTapWelfareComp",
		bg = "bg/activity/bg_hd_taptap2024.11_lingqu.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_taptap_3.png",
			icon = "icon/activity/icon_hd_taptap_2.png",
			selectedIcon = "icon/activity/icon_hd_taptap_1.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityTapWelfareData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.BLACK_FIVE] = {
		tabRedPointId = 2000,
		compName = "ActivityBlackFiveComp",
		bg = "bg/activity/bg_hd_taptap2024_lingqu.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_heiwu_3.png",
			icon = "icon/activity/icon_hd_heiwu_2.png",
			selectedIcon = "icon/activity/icon_hd_heiwu_1.png"
		},
		additionalOpenFunc = function()
			return var_0_1.activityBlackFiveData:isShowEntrance()
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.RESOURCE_BACK] = {
		compName = "ActivityResourceBackComp",
		tabRedPointId = 717,
		topBarId = 312,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_wuzibuling_3.png",
			icon = "icon/activity/icon_hd_wuzibuling_2.png",
			selectedIcon = "icon/activity/icon_hd_wuzibuling_1.png"
		}
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CELEBRATION_LOGIN] = {
		compName = "ActivityCelebrationLoginComp",
		tabRedPointId = 816,
		bg = "bg/activity/bg_hd_znqqdbg.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_znqqd_3.png",
			icon = "icon/activity/icon_hd_znqqd_2.png",
			selectedIcon = "icon/activity/icon_hd_znqqd_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN,
		additionalOpenFunc = function()
			return var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_LOGIN)
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.CELEBRATION_WITCH] = {
		compName = "ActivityCelebrationLoginComp",
		tabRedPointId = 902,
		bg = "bg/activity/bg_hd_znqqdbg.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_znqqd_6.png",
			icon = "icon/activity/icon_hd_znqqd_5.png",
			selectedIcon = "icon/activity/icon_hd_znqqd_4.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH,
		additionalOpenFunc = function()
			return var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_WITCH)
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.ABVERT_PAGE_AWARD] = {
		compName = "ActivityAbvertPageComp",
		tabRedPointId = 905,
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_znzl_3.png",
			icon = "icon/activity/icon_hd_znzl_2.png",
			selectedIcon = "icon/activity/icon_hd_znzl_1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.ABVERT_AWARD_1,
		additionalOpenFunc = function()
			return var_0_1.abvertPageAwardData:isActivityInShow(var_0_1.abvertPageAwardData:getCurActId())
		end
	},
	[g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.USER_BACK] = {
		compName = "ActivityUserBackComp",
		tabRedPointId = 911,
		bg = "bg/activity/bg_xinxingguila.jpg",
		tabIconConfig = {
			shadowIcon = "icon/activity/icon_hd_xxgl3.png",
			icon = "icon/activity/icon_hd_xxgl2.png",
			selectedIcon = "icon/activity/icon_hd_xxgl1.png"
		},
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.USER_BACK,
		additionalOpenFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.USER_BACK) and var_0_1.userBackData:showEntrance()
		end
	}
}
