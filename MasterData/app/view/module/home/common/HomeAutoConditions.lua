local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User

return {
	AUTO_POPUP_COND = {
		[g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_SIGNIN] = {
			cond = function()
				return var_0_1.SignInData:isCanActivityDailySignIn()
			end,
			module = g.view.entrance.SIGNIN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN] = {
			cond = function()
				return var_0_1.sevenDaysSignInData:is7DaysSignInAutoPop()
			end,
			module = g.view.entrance.SEVEN_DAYS_SIGN_IN
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.HALLOWEEN_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.HALLOWEEN_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.HALLOWEEN_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LINDELL_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LINDELL_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.LINDELL_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.PUSH_GIFT] = {
			cond = function()
				return var_0_1.pushGiftData:getHasNew()
			end,
			module = g.view.entrance.PUSH_GIFT
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.OPEN_SCREEN_AD] = {
			cond = function()
				var_0_1.openScreenData:reloadBaseInfo()

				return var_0_1.openScreenData:hasData()
			end,
			module = g.view.entrance.OPEN_SCREEN_AD
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_REPORT] = {
			cond = function()
				return var_0_1.dailyReportData:isShowOpen() and var_0_1.dailyReportData:isToDayPop()
			end,
			module = g.view.entrance.DAILY_REPORT
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SUMMON_OLD_PLAYER] = {
			cond = function()
				return var_0_1.summonOldPlayerData:isShowDoor() and not g.core.model.User.dayNotifyTool:isTodayHasRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_OLD_PLAYER_SUMMON_TIP) and var_0_1.summonOldPlayerData:getInheritServerId() == 0
			end,
			module = g.view.entrance.SUMMON_OLD_PLAYER
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SIGN_CUSTOM_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.SIGN_CUSTOM_ACTIVITY)
			end,
			module = g.view.entrance.SIGN_CUSTOM_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CHRISTMAS_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.CHRISTMAS_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.CHRISTMAS_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LEVIA_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LEVIA_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.LEVIA_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LEVIA_SIGN_ACTIVITY_EU] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LEVIA_SIGN_ACTIVITY_EU)
			end,
			module = g.view.entrance.LEVIA_SIGN_ACTIVITY_EU
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.VALENTINE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.VALENTINE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SAKURA_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.SAKURA_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.SAKURA_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.RAIN_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.RAIN_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.RAIN_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LOVE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LOVE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.LOVE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.WHITEDANCE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.WHITEDANCE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.WHITEDANCE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.GM_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.GM_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.GM_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.BEAUTY_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.BEAUTY_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.BEAUTY_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LISTEN_SWEAR_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LISTEN_SWEAR_ACTIVITY)
			end,
			module = g.view.entrance.SIGN_616
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.BEACH_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.BEACH_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.BEACH_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.MAGPIE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.MAGPIE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.MAGPIE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.MIDAUTUMN_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.MIDAUTUMN_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.MIDAUTUMN_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.POTPOURRI_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.POTPOURRI_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.POTPOURRI_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.HERA_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.HERA_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.HERA_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CHRIS_GIFT_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.CHRIS_GIFT_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.CHRIS_GIFT_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LINK_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LINK_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.LINK_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.LOVER_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.LOVER_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.LOVER_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.ROSE_NIGHT_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.ROSE_NIGHT_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.ROSE_NIGHT_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CHILDRENDAY_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.CHILDRENDAY_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.CHILDRENDAY_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.PUREWHITE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.PUREWHITE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.PUREWHITE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CROWNBLUE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.CROWNBLUE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.CROWNBLUE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SILENT_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.SILENT_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.SILENT_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.FLOWLIGHT_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.FLOWLIGHT_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.FLOWLIGHT_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.BUILD_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.BUILD_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.BUILD_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.TEASOUND_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.TEASOUND_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.TEASOUND_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.FANTASYDREAM_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.FANTASYDREAM_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.FANTASYDREAM_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.GRANDCURTAIN_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.GRANDCURTAIN_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.GRANDCURTAIN_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.NURTURING_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.NURTURING_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.NURTURING_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SERGEANT_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.SERGEANT_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.SERGEANT_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.DOCTORVOLENCE_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.DOCTORVOLENCE_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.DOCTORVOLENCE_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.SEATRAVEL_SIGN_ACTIVITY] = {
			cond = function()
				return var_0_1.signActivityData:isCanGetSignAward(var_0_0.SEATRAVEL_SIGN_ACTIVITY)
			end,
			module = g.view.entrance.SEATRAVEL_SIGN_ACTIVITY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.NEW_YEAR_WISH] = {
			cond = function()
				return var_0_1.newYearWishData:isDrawEnable()
			end,
			module = g.view.entrance.NEW_YEAR_WISH
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.USER_BACK] = {
			cond = function()
				return var_0_1.userBackData:showOpenScreen()
			end,
			module = g.view.entrance.USER_BACK
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.HALF_ANNIVERSARY] = {
			cond = function()
				return var_0_1.halfAnniversaryData:isActivityOpen()
			end,
			module = g.view.entrance.HALF_ANNIVERSARY
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_PVP] = {
			cond = function()
				return var_0_1.teamPvpData:isActivityInExpire() and not var_0_1.teamPvpData:isToDayPop()
			end,
			module = g.view.entrance.TEAM_PVP_ACTIVE_RESULT_POP
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY] = {
			cond = function()
				return var_0_1.cultivateDataMgr:getCultivateData(1):isInActivityShowTime()
			end,
			module = g.view.entrance.CULTIVATE_MAIN
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN] = {
			cond = function()
				return var_0_1.activityCelebrationLoginData:isShowPopup(var_0_0.CELEBRATION_LOGIN)
			end,
			params = {
				function_id = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN
			},
			module = g.view.entrance.CELEBRATION_LOGIN_POP
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH] = {
			cond = function()
				return var_0_1.activityCelebrationLoginData:isShowPopup(var_0_0.CELEBRATION_WITCH)
			end,
			params = {
				function_id = g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH
			},
			module = g.view.entrance.CELEBRATION_LOGIN_POP
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.ABVERT_AWARD_1] = {
			cond = function()
				return var_0_1.abvertPageAwardData:isCanGetAward()
			end,
			params = {
				function_id = g.core.const.ConstMgr.FUNCTION_TYPE.ABVERT_AWARD_1
			},
			module = g.view.entrance.ABVERT_AWARD_1
		},
		[g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE] = {
			cond = function()
				return var_0_1.teamBattleData:isActivityResultStage()
			end,
			module = g.view.entrance.TEAM_BATTLE_RESULT_POP
		}
	}
}
