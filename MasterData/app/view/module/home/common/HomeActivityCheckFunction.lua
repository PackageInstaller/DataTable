local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User

return {
	[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN] = function()
		return g.core.model.User.sevenDaysSignInData:isShow7DaysSignIn(var_0_0.SEVEN_DAYS_SIGN_IN)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN_2] = function()
		return g.core.model.User.sevenDaysSignInData:isShow7DaysSignIn(var_0_0.SEVEN_DAYS_SIGN_IN_2)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HALLOWEEN_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HALLOWEEN_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.HALLOWEEN_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LINDELL_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LINDELL_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LINDELL_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PUSH_GIFT] = function()
		return g.core.model.User.pushGiftData:isShowPushGift()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PEAK_ARENA] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.PEAK_ARENA) and g.core.model.User.peakArenaData:isShowEntrance()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.MINE] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.MINE) and g.core.model.User.mineData:isInOpenTime()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SIGN_CUSTOM_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.SIGN_CUSTOM_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.SIGN_CUSTOM_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CHRISTMAS_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CHRISTMAS_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.CHRISTMAS_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LEVIA_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LEVIA_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LEVIA_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LEVIA_SIGN_ACTIVITY_EU] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LEVIA_SIGN_ACTIVITY_EU) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LEVIA_SIGN_ACTIVITY_EU)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.VALENTINE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.VALENTINE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SAKURA_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.SAKURA_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.SAKURA_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.RAIN_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.RAIN_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.RAIN_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.WHITEDANCE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.WHITEDANCE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.WHITEDANCE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BEAUTY_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.BEAUTY_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.BEAUTY_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LOVE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LOVE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LOVE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BEACH_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.BEACH_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.BEACH_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.MAGPIE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.MAGPIE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.MAGPIE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CHRIS_GIFT_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CHRIS_GIFT_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.CHRIS_GIFT_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LINK_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LINK_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LINK_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LOVER_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LOVER_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LOVER_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ROSE_NIGHT_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.ROSE_NIGHT_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.ROSE_NIGHT_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CHILDRENDAY_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CHILDRENDAY_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.CHILDRENDAY_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PUREWHITE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.PUREWHITE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.PUREWHITE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CROWNBLUE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CROWNBLUE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.CROWNBLUE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SILENT_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.SILENT_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.SILENT_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.FLOWLIGHT_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FLOWLIGHT_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.FLOWLIGHT_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BUILD_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.BUILD_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.BUILD_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.TEASOUND_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.TEASOUND_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.TEASOUND_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.FANTASYDREAM_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FANTASYDREAM_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.FANTASYDREAM_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GRANDCURTAIN_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.GRANDCURTAIN_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.GRANDCURTAIN_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.NURTURING_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.NURTURING_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.NURTURING_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SERGEANT_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.SERGEANT_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.SERGEANT_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.DOCTORVOLENCE_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.DOCTORVOLENCE_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.DOCTORVOLENCE_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SEATRAVEL_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.SEATRAVEL_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.SEATRAVEL_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.MIDAUTUMN_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.MIDAUTUMN_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.MIDAUTUMN_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.POTPOURRI_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.POTPOURRI_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.POTPOURRI_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HERA_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HERA_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.HERA_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GM_SIGN_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.GM_SIGN_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.GM_SIGN_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_WAR] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.GUILD_WAR) and g.core.model.User.guildWarData:isOpen()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.USER_BACK] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.USER_BACK) and g.core.model.User.userBackData:showEntrance()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GVE] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.GVE) and g.core.model.User.gveDataMgr:isOpen()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FOG_NIGHTMARE) and g.core.model.User.fogNightmareData:isShowEntrance()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINES_DAY_VOTE] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.VALENTINES_DAY_VOTE) and g.core.model.User.valentinesDayVoteData:isProcess()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HALF_ANNIVERSARY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HALF_ANNIVERSARY) and g.core.model.User.halfAnniversaryData:isActivityOpen()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.EXPLORATION] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.EXPLORATION) and g.core.model.User.explorationData:isActivityOpen()
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.LISTEN_SWEAR_ACTIVITY] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.LISTEN_SWEAR_ACTIVITY) and g.core.model.User.signActivityData:isOnShowTime(var_0_0.LISTEN_SWEAR_ACTIVITY)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CELEBRATION_LOGIN) and var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_LOGIN)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CELEBRATION_WITCH) and var_0_1.activityCelebrationLoginData:isShowEntrance(nil, var_0_0.CELEBRATION_WITCH)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.WAKE_LOGIN] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.WAKE_LOGIN) and var_0_1.activityCelebrationLoginData:isShowActivity(var_0_0.WAKE_LOGIN)
	end,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RECRUIT_SPRING] = function()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.ACTIVITY_RECRUIT_SPRING) and var_0_1.recruitData:isSpringOpen()
	end
}
