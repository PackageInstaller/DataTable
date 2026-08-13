class = var_0_10000

local var_0_0 = "LevelMediator2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_TRACKING = "LevelMediator2:ON_TRACKING"
var_0_1.ON_ELITE_TRACKING = "LevelMediator2:ON_ELITE_TRACKING"
var_0_1.ON_RETRACKING = "LevelMediator2:ON_RETRACKING"
var_0_1.ON_UPDATE_CUSTOM_FLEET = "LevelMediator2:ON_UPDATE_CUSTOM_FLEET"
var_0_1.ON_OP = "LevelMediator2:ON_OP"
var_0_1.ON_RESUME_SUBSTATE = "LevelMediator2:ON_RESUME_SUBSTATE"
var_0_1.ON_STAGE = "LevelMediator2:ON_STAGE"
var_0_1.ON_GO_TO_TASK_SCENE = "LevelMediator2:ON_GO_TO_TASK_SCENE"
var_0_1.ON_OPEN_EVENT_SCENE = "LevelMediator2:ON_OPEN_EVENT_SCENE"
var_0_1.ON_DAILY_LEVEL = "LevelMediator2:ON_DAILY_LEVEL"
var_0_1.ON_OPEN_MILITARYEXERCISE = "LevelMediator2:ON_OPEN_MILLITARYEXERCISE"
var_0_1.ON_OVERRIDE_CHAPTER = "LevelMediator2:ON_OVERRIDE_CHAPTER"
var_0_1.ON_TIME_UP = "LevelMediator2:ON_TIME_UP"
var_0_1.UPDATE_EVENT_LIST = "LevelMediator2:UPDATE_EVENT_LIST"
var_0_1.ON_START = "ON_START"
var_0_1.ON_ENTER_MAINLEVEL = "LevelMediator2:ON_ENTER_MAINLEVEL"
var_0_1.ON_DIDENTER = "LevelMediator2:ON_DIDENTER"
var_0_1.ON_PERFORM_COMBAT = "LevelMediator2.ON_PERFORM_COMBAT"
var_0_1.ON_SUPPORT_SUBMARINE = "LevelMediator2.ON_SUPPORT_SUBMARINE"
var_0_1.ON_ELITE_OEPN_DECK = "LevelMediator2:ON_ELITE_OEPN_DECK"
var_0_1.ON_ELITE_CLEAR = "LevelMediator2:ON_ELITE_CLEAR"
var_0_1.ON_ELITE_RECOMMEND = "LevelMediator2:ON_ELITE_RECOMMEND"
var_0_1.ON_ELITE_ADJUSTMENT = "LevelMediator2:ON_ELITE_ADJUSTMENT"
var_0_1.ON_SUPPORT_OPEN_DECK = "LevelMediator2:ON_SUPPORT_OPEN_DECK"
var_0_1.ON_ACTIVITY_MAP = "LevelMediator2:ON_ACTIVITY_MAP"
var_0_1.GO_ACT_SHOP = "LevelMediator2:GO_ACT_SHOP"
var_0_1.ON_SWITCH_NORMAL_MAP = "LevelMediator2:ON_SWITCH_NORMAL_MAP"
var_0_1.NOTICE_AUTOBOT_ENABLED = "LevelMediator2:NOTICE_AUTOBOT_ENABLED"
var_0_1.ON_EXTRA_RANK = "LevelMediator2:ON_EXTRA_RANK"
var_0_1.ON_STRATEGYING_CHAPTER = "LevelMediator2:ON_STRATEGYING_CHAPTER"
var_0_1.ON_SELECT_COMMANDER = "LevelMediator2:ON_SELECT_COMMANDER"
var_0_1.ON_SELECT_ELITE_COMMANDER = "LevelMediator2:ON_SELECT_ELITE_COMMANDER"
var_0_1.ON_COMMANDER_SKILL = "LevelMediator2:ON_COMMANDER_SKILL"
var_0_1.ON_SHIP_DETAIL = "LevelMediator2:ON_SHIP_DETAIL"
var_0_1.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN = "LevelMediator2:ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN"
var_0_1.GET_REMASTER_TICKETS_DONE = "LevelMediator2:GET_REMASTER_TICKETS_DONE"
var_0_1.ON_FLEET_SHIPINFO = "LevelMediator2:ON_FLEET_SHIPINFO"
var_0_1.ON_STAGE_SHIPINFO = "LevelMediator2:ON_STAGE_SHIPINFO"
var_0_1.ON_SUPPORT_SHIPINFO = "LevelMediator2:ON_SUPPORT_SHIPINFO"
var_0_1.ON_COMMANDER_OP = "LevelMediator2:ON_COMMANDER_OP"
var_0_1.CLICK_CHALLENGE_BTN = "LevelMediator2:CLICK_CHALLENGE_BTN"
var_0_1.ON_SUBMIT_TASK = "LevelMediator2:ON_SUBMIT_TASK"
var_0_1.ON_VOTE_BOOK = "LevelMediator2:ON_VOTE_BOOK"
var_0_1.GET_CHAPTER_DROP_SHIP_LIST = "LevelMediator2:GET_CHAPTER_DROP_SHIP_LIST"
var_0_1.ON_CHAPTER_REMASTER_AWARD = "LevelMediator2:ON_CHAPTER_REMASTER_AWARD"
var_0_1.ON_BOSSRUSH_REMASTER_ACTIVITY = "LevelMediator2:ON_BOSSRUSH_REMASTER_ACTIVITY"
var_0_1.ENTER_WORLD = "LevelMediator2:ENTER_WORLD"
var_0_1.ON_OPEN_ACT_BOSS_BATTLE = "LevelMediator2:ON_OPEN_ACT_BOSS_BATTLE"
var_0_1.ON_BOSSRUSH_MAP = "LevelMediator2:ON_BOSSRUSH_MAP"
var_0_1.SHOW_ATELIER_BUFF = "LevelMediator2:SHOW_ATELIER_BUFF"
var_0_1.ON_SPITEM_CHANGED = "LevelMediator2:ON_SPITEM_CHANGED"
var_0_1.ON_BOSSSINGLE_MAP = "LevelMediator2:ON_BOSSSINGLE_MAP"
var_0_1.ON_CLUE_MAP = "LevelMediator2:ON_CLUE_MAP"
var_0_1.ON_COLLAB_BOSSRUSH_MAP = "LevelMediator2:ON_COLLAB_BOSSRUSH_MAP"
var_0_1.ON_UPDATE_LOWPRIORITY_TASK = "LevelMediator2:ON_UPDATE_LOWPRIORITY_TASK"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_VOTE_BOOK, function(arg_3_0, arg_3_1)
		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMANDER_OP, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.contextData.commanderOPChapter = arg_4_2

		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.COMMANDER_FORMATION_OP, {
			data = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		FormationMediator = var_2_10004

		var_2_10004.onSelectCommander(arg_5_1, arg_5_2)

		arg_1_0.contextData.selectedChapterVO = arg_5_3

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_ELITE_COMMANDER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		getProxy = var_2_10004
		ChapterProxy = var_2_10006

		local var_6_0 = var_2_10004(var_2_10006)
		local var_6_1 = arg_6_3.id

		arg_1_0.contextData.editEliteChapter = var_6_1

		local var_6_2

		if not arg_6_3:getEliteFleetCommanders()[arg_6_1] then
			var_6_2 = {}
		end

		local var_6_3

		if var_6_2[arg_6_2] then
			getProxy = var_8
			CommanderProxy = var_2_10010
			var_2_10011 = var_8(var_2_10010)
			var_6_3 = var_8.getCommanderById(var_2_10011, var_6_2[arg_6_2])
		end

		local var_6_4 = arg_1_0
		local var_6_5 = var_8.sendNotification

		GAME = var_2_10011

		local var_6_6 = var_2_10011.GO_SCENE

		SCENE = var_2_10012

		local var_6_7 = var_2_10012.COMMANDERCAT
		local var_6_8 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10014
		var_6_8.mode = var_2_10014.MODE_SELECT
		var_6_8.activeCommander = var_6_3
		var_6_8.ignoredIds = {}
		CommanderCatScene = var_14
		var_6_8.fleetType = var_14.FLEET_TYPE_HARD_CHAPTER
		var_6_8.chapterId = var_6_1

		function var_6_8.onCommander(arg_7_0)
			return true
		end

		function var_6_8.onSelected(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_0[1]
			local var_8_1 = arg_1_0
			local var_8_2 = var_3.sendNotification

			GAME = var_3_10006

			var_8_2(var_8_1, var_3_10006.SELECT_ELIT_CHAPTER_COMMANDER, {
				chapterId = var_6_1,
				index = arg_6_1,
				pos = arg_6_2,
				commanderId = var_8_0,
				callback = function()
					arg_8_1()

					return
				end
			})

			return
		end

		function var_6_8.onQuit(arg_10_0)
			local var_10_0 = arg_1_0
			local var_10_1 = var_1.sendNotification

			GAME = var_3_10004

			var_10_1(var_10_0, var_3_10004.SELECT_ELIT_CHAPTER_COMMANDER, {
				commanderId = 0,
				chapterId = var_6_1,
				index = arg_6_1,
				pos = arg_6_2,
				callback = function()
					arg_10_0()

					return
				end
			})

			return
		end

		var_6_5(var_6_4, var_6_6, var_6_7, var_6_8)

		return
	end)
	arg_1_0:RegisterTrackEvent()
	arg_1_0:bind(var_0_1.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10005

		var_12_1(var_12_0, var_2_10005.UPDATE_CUSTOM_FLEET, {
			chapterId = arg_12_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_OP, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0
		local var_13_1 = var_2.sendNotification

		GAME = var_2_10005

		var_13_1(var_13_0, var_2_10005.CHAPTER_OP, arg_13_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_NORMAL_MAP, function(arg_14_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_14_0 = var_2_10001(var_2_10003)

		if var_1.GetLastNormalMap(var_14_0) then
			local var_14_1 = arg_1_0.viewComponent

			var_2.setMap(var_14_1, var_1)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_RESUME_SUBSTATE, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0

		var_2.loadSubState(var_15_0, arg_15_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_STAGE, function(arg_16_0)
		local var_16_0 = arg_1_0
		local var_16_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_16_2 = var_2_10004.New
		local var_16_3 = {}

		ChapterPreCombatMediator = var_2_10007
		var_16_3.mediator = var_2_10007
		ChapterPreCombatLayer = var_2_10007
		var_16_3.viewComponent = var_2_10007

		var_16_1(var_16_0, var_16_2(var_16_3), false)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_MILITARYEXERCISE, function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_17_0 = var_2_10000(var_2_10002)

		if var_0.getMilitaryExerciseActivity(var_17_0) then
			local var_17_1 = arg_1_0

			var_2_10002 = var_2_10002.sendNotification
			GAME = var_2_10005
			var_2_10005 = var_2_10005.GO_SCENE
			SCENE = var_2_10006

			var_2_10002(var_17_1, var_2_10005, var_2_10006.MILITARYEXERCISE)
		else
			pg = var_2_10002

			local var_17_2 = var_2_10002.TipsMgr.GetInstance()
			local var_17_3 = var_2.ShowTips

			i18n = var_2_10005

			var_17_3(var_17_2, var_2_10005("common_activity_notStartOrEnd"))
		end

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_CHALLENGE_BTN, function(arg_18_0)
		LOCK_LIMIT_CHALLENGE = var_2_10001

		if var_2_10001 then
			local var_18_0 = arg_1_0
			local var_18_1 = var_1.sendNotification

			GAME = var_2_10004
			var_2_10004 = var_2_10004.GO_SCENE
			SCENE = var_2_10005

			var_18_1(var_18_0, var_2_10004, var_2_10005.CHALLENGE_MAIN_SCENE)
		else
			local var_18_2 = arg_1_0
			local var_18_3 = var_1.sendNotification

			GAME = var_2_10004

			local var_18_4 = var_2_10004.GO_SCENE

			SCENE = var_2_10005

			var_18_3(var_18_2, var_18_4, var_2_10005.LIMIT_CHALLENGE)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_DAILY_LEVEL, function(arg_19_0)
		local var_19_0 = arg_1_0
		local var_19_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_19_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_19_1(var_19_0, var_19_2, var_2_10005.DAILYLEVEL)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GO_TO_TASK_SCENE, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_1_0
		local var_20_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_20_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_20_1(var_20_0, var_20_2, var_2_10006.TASK, arg_20_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_EVENT_SCENE, function()
		local var_21_0 = arg_1_0
		local var_21_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_21_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_21_1(var_21_0, var_21_2, var_2_10004.EVENT)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OVERRIDE_CHAPTER, function()
		local var_22_0 = arg_1_0.contextData.chapterVO

		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_22_1 = var_2_10001(var_2_10003)

		var_1.updateChapter(var_22_1, var_22_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TIME_UP, function()
		local var_23_0 = arg_1_0

		var_0.onTimeUp(var_23_0)

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_EVENT_LIST, function()
		local var_24_0 = arg_1_0.viewComponent

		var_0.addbubbleMsgBox(var_24_0, function(arg_25_0)
			local var_25_0 = arg_1_0

			var_1.OnEventUpdate(var_25_0, arg_25_0)

			return
		end)

		getProxy = var_0
		ChapterProxy = var_24_0

		local var_24_1 = var_0(var_24_0)

		if var_0.getActiveChapter(var_24_1, true) and var_0:IsAutoFight() then
			pg = var_1

			local var_24_2 = var_1.GuildMsgBoxMgr.GetInstance()

			if var_1.GetShouldShowBattleTip(var_24_2) then
				getProxy = var_2
				GuildProxy = var_24_2

				local var_24_3 = var_2(var_24_2)

				if var_2.getRawData(var_24_3) and var_2:getWeeklyTask() and var_3.id ~= 0 then
					getProxy = var_4
					ChapterProxy = var_2_10006

					local var_24_4 = var_4(var_2_10006)

					var_4.AddExtendChapterDataTable(var_24_4, var_0.id, "ListGuildEventNotify", var_3:GetPresonTaskId(), var_3:GetPrivateTaskName())

					pg = var_4

					local var_24_5 = var_4.GuildMsgBoxMgr.GetInstance()

					var_4.CancelShouldShowBattleTip(var_24_5)
				end

				var_1:SubmitTask(function(arg_26_0, arg_26_1, arg_26_2)
					if arg_26_0 then
						pg = var_3_10003

						local var_26_0 = var_3_10003.task_data_template[arg_26_2].desc

						getProxy = var_3_10004
						ChapterProxy = var_3_10006

						local var_26_1 = var_3_10004(var_3_10006)

						var_4.AddExtendChapterDataTable(var_26_1, var_0.id, "ListGuildEventAutoReceiveNotify", arg_26_2, var_26_0)
					end

					return
				end)
			end
		else
			local var_24_6 = arg_1_0.viewComponent

			var_1.addbubbleMsgBox(var_24_6, function(arg_27_0)
				pg = var_3_10001

				local var_27_0 = var_3_10001.GuildMsgBoxMgr.GetInstance()

				var_1.NotificationForBattle(var_27_0, arg_27_0)

				return
			end)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_CLEAR, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_1.index
		local var_28_1 = arg_28_1.chapterVO

		var_3.clearEliterFleetByIndex(var_28_1, var_28_0)

		getProxy = var_4
		ChapterProxy = var_28_1

		local var_28_2 = var_4(var_28_1)

		var_4.updateChapter(var_28_2, var_3)
		var_4:duplicateEliteFleet(var_3)

		local var_28_3 = arg_1_0.viewComponent

		var_5.RefreshFleetSelectView(var_28_3, var_3)

		return
	end)
	arg_1_0:bind(var_0_1.NOTICE_AUTOBOT_ENABLED, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_1_0
		local var_29_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_29_2 = var_2_10005.COMMON_FLAG
		local var_29_3 = {}

		BATTLE_AUTO_ENABLED = var_2_10007
		var_29_3.flagID = var_2_10007

		var_29_1(var_29_0, var_29_2, var_29_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_RECOMMEND, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_1.index
		local var_30_1 = arg_30_1.chapterVO

		getProxy = var_2_10004
		ChapterProxy = var_2_10006

		local var_30_2 = var_2_10004(var_2_10006)

		var_4.eliteFleetRecommend(var_30_2, var_30_1, var_30_0)
		var_4:updateChapter(var_30_1)
		var_4:duplicateEliteFleet(var_30_1)

		local var_30_3 = arg_1_0.viewComponent

		var_5.RefreshFleetSelectView(var_30_3, var_30_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_ADJUSTMENT, function(arg_31_0, arg_31_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10004

		local var_31_0 = var_2_10002(var_2_10004)

		var_2.updateChapter(var_31_0, arg_31_1)
		var_2:duplicateEliteFleet(arg_31_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_OEPN_DECK, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_1.shipType
		local var_32_1 = arg_32_1.fleetIndex
		local var_32_2 = arg_32_1.shipVO
		local var_32_3 = arg_32_1.fleet
		local var_32_4 = arg_32_1.chapter
		local var_32_5 = arg_32_1.teamType

		getProxy = var_2_10008
		BayProxy = var_2_10010

		local var_32_6 = var_2_10008(var_2_10010)
		local var_32_7 = var_8.getRawData(var_32_6)
		local var_32_8 = {}

		pairs = var_32_6

		for iter_32_0, iter_32_1 in var_32_6(var_32_7) do
			ShipType = var_2_10016
			var_2_10016 = var_2_10016.ContainInLimitBundle

			local var_32_9 = var_32_0

			var_2_10021 = iter_32_1

			if not var_2_10016(var_32_9, iter_32_1.getShipType(var_2_10021)) then
				table = var_2_10016

				var_2_10016.insert(var_32_8, iter_32_0)
			end
		end

		arg_1_0.contextData.editEliteChapter = var_32_4.id

		local var_32_10 = {}

		pairs = var_12

		for iter_32_2, iter_32_3 in var_12(var_32_3) do
			table = var_2_10017

			var_2_10017.insert(var_32_10, iter_32_2.id)
		end

		local var_32_11 = arg_1_0
		local var_32_12, var_32_13, var_32_14 = var_12.getDockCallbackFuncs(var_32_11, var_32_3, var_32_2, var_32_4, var_32_1)
		local var_32_15 = arg_1_0
		local var_32_16 = var_15.sendNotification

		GAME = var_18

		local var_32_17 = var_18.GO_SCENE

		SCENE = var_2_10019

		local var_32_18 = var_2_10019.DOCKYARD
		local var_32_19 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			ignoredIds = var_32_8
		}

		i18n = var_2_10021
		var_32_19.leastLimitMsg = var_2_10021("ship_formationMediator_leastLimit")
		var_32_19.quitTeam = var_32_2 ~= nil
		var_32_19.teamFilter = var_32_5
		i18n = var_21
		var_32_19.leftTopInfo = var_21("word_formation")
		var_32_19.onShip = var_32_12
		var_32_19.confirmSelect = var_32_13
		var_32_19.onSelected = var_32_14
		setmetatable = var_21

		local var_32_20 = {
			inElite = var_32_4:getConfig("formation")
		}
		local var_32_21 = {}

		ShipStatus = var_2_10025
		var_32_21.__index = var_2_10025.TAG_HIDE_LEVEL
		var_32_19.hideTagFlags = var_21(var_32_20, var_32_21)
		var_32_19.otherSelectedIds = var_32_10

		var_32_16(var_32_15, var_32_17, var_32_18, var_32_19)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUPPORT_OPEN_DECK, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_1.shipType
		local var_33_1 = arg_33_1.shipVO
		local var_33_2 = arg_33_1.fleet
		local var_33_3 = arg_33_1.chapter
		local var_33_4 = arg_33_1.teamType

		getProxy = var_2_10007
		BayProxy = var_2_10009

		local var_33_5 = var_2_10007(var_2_10009)
		local var_33_6 = var_7.getRawData(var_33_5)
		local var_33_7 = {}

		pairs = var_33_5

		for iter_33_0, iter_33_1 in var_33_5(var_33_6) do
			ShipType = var_2_10015
			var_2_10015 = var_2_10015.ContainInLimitBundle
			var_2_10017 = var_33_0
			var_2_10020 = iter_33_1

			if not var_2_10015(var_2_10017, iter_33_1.getShipType(var_2_10020)) then
				table = var_2_10015

				var_2_10015.insert(var_33_7, iter_33_0)
			end
		end

		local var_33_8 = {}

		pairs = var_11

		for iter_33_2, iter_33_3 in var_11(var_33_2) do
			table = var_2_10016

			var_2_10016.insert(var_33_8, iter_33_2.id)
		end

		local var_33_9 = arg_1_0
		local var_33_10, var_33_11, var_33_12 = var_11.getSupportDockCallbackFuncs(var_33_9, var_33_2, var_33_1, var_33_3)
		local var_33_13 = arg_1_0
		local var_33_14 = var_14.sendNotification

		GAME = var_2_10017

		local var_33_15 = var_2_10017.GO_SCENE

		SCENE = var_2_10018

		local var_33_16 = var_2_10018.DOCKYARD
		local var_33_17 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			ignoredIds = var_33_7
		}

		i18n = var_2_10020
		var_33_17.leastLimitMsg = var_2_10020("ship_formationMediator_leastLimit")
		var_33_17.quitTeam = var_33_1 ~= nil
		var_33_17.teamFilter = var_33_4
		i18n = var_20
		var_33_17.leftTopInfo = var_20("word_formation")
		var_33_17.onShip = var_33_10
		var_33_17.confirmSelect = var_33_11
		var_33_17.onSelected = var_33_12
		setmetatable = var_20

		local var_33_18 = {
			inSupport = var_33_3:getConfig("formation")
		}
		local var_33_19 = {}

		ShipStatus = var_2_10024
		var_33_19.__index = var_2_10024.TAG_HIDE_SUPPORT
		var_33_17.hideTagFlags = var_20(var_33_18, var_33_19)
		var_33_17.otherSelectedIds = var_33_8

		var_33_14(var_33_13, var_33_15, var_33_16, var_33_17)

		arg_1_0.contextData.selectedChapterVO = var_33_3

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVITY_MAP, function(arg_34_0, arg_34_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10004

		local var_34_0 = var_2_10002(var_2_10004)
		local var_34_1, var_34_2 = var_2.getLastMapForActivity(var_34_0, arg_34_1)

		if var_34_1 then
			local var_34_3 = var_2:getMapById(var_34_1)

			if not var_34_0.isUnlock(var_34_3) then
				pg = var_34_0

				local var_34_4 = var_34_0.TipsMgr.GetInstance()
				local var_34_5 = var_5.ShowTips

				i18n = var_2_10008

				var_34_5(var_34_4, var_2_10008("common_activity_end"))

				return
			end

			local var_34_6 = arg_1_0.viewComponent

			var_5.ShowSelectedMap(var_34_6, var_34_1, function()
				if var_34_2 then
					local var_35_0 = var_0
					local var_35_1 = var_0.getChapterById(var_35_0, var_34_2)
					local var_35_2 = arg_1_0.viewComponent

					var_1.switchToChapter(var_35_2, var_35_1)
				end

				return
			end)

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_BOSSRUSH_MAP, function()
		local var_36_0 = arg_1_0
		local var_36_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_36_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_36_1(var_36_0, var_36_2, var_2_10004.BOSSRUSH_MAIN)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BOSSSINGLE_MAP, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_1_0
		local var_37_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_37_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_37_1(var_37_0, var_37_2, var_2_10006.OTHERWORLD_MAP, arg_37_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLUE_MAP, function()
		local var_38_0 = arg_1_0
		local var_38_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_38_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_38_1(var_38_0, var_38_2, var_2_10004.CLUE_MAP)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COLLAB_BOSSRUSH_MAP, function()
		local var_39_0 = arg_1_0
		local var_39_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_39_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_39_1(var_39_0, var_39_2, var_2_10004.BOSSRUSH_DAL_COLLAB)

		return
	end)
	arg_1_0:bind(var_0_1.GO_ACT_SHOP, function()
		if arg_1_0.contextData.map then
			local var_40_0 = arg_1_0.contextData.map
			local var_40_1

			if not var_0.getConfig(var_40_0, "on_activity") then
				var_40_1 = nil
			end

			if var_40_1 then
				::label_40_0::

				if var_40_1 ~= 0 then
					getProxy = var_2_10001
					ActivityProxy = var_2_10003
					var_2_10003 = var_2_10001(var_2_10003)
					var_2_10001 = var_2_10001.getActivityById(var_2_10003, var_40_1)
				else
					var_2_10001 = false
				end

				if false then
					var_2_10001 = true
				end
			end

			local var_40_2

			if var_2_10001 then
				::label_40_1::

				var_2_10004 = var_2_10001

				if not var_2_10001.isEnd(var_2_10004) then
					var_2_10004 = var_2_10001
					var_40_2 = var_2_10001.GetConfigClientSetting(var_2_10004, "PTID")
				else
					var_40_2 = false
				end

				if false then
					var_40_2 = true
				end
			end

			getProxy = var_2_10003
			ActivityProxy = var_2_10005

			local var_40_3 = var_2_10003(var_2_10005)
			local var_40_4 = var_3.getActivityByType

			ActivityConst = var_2_10006

			local var_40_5

			if var_40_4(var_40_3, var_2_10006.ACTIVITY_TYPE_LOTTERY) then
				var_40_5 = var_3

				if var_3.getConfig(var_40_5, "config_client").resId == var_40_2 then
					var_40_5 = var_3

					if not var_3.isEnd(var_40_5) then
						var_40_5 = arg_1_0
						var_2_10004 = var_2_10004.addSubLayers
						Context = var_7

						local var_40_6 = var_7.New

						var_2_10009 = {}
						LotteryMediator = var_2_10010
						var_2_10009.mediator = var_2_10010
						LotteryLayer = var_2_10010
						var_2_10009.viewComponent = var_2_10010
						var_2_10009.data = {
							activityId = var_3.id
						}

						var_2_10004(var_40_5, var_40_6(var_2_10009), false)

						goto label_40_2
					end
				end
			end

			_ = var_2_10004

			do
				local var_40_7 = var_2_10004.detect

				getProxy = var_40_5
				ActivityProxy = var_2_10008

				local var_40_8 = var_40_5(var_2_10008)
				local var_40_9 = var_6.getActivitiesByType

				ActivityConst = var_2_10009

				local var_40_10 = var_40_7(var_40_9(var_40_8, var_2_10009.ACTIVITY_TYPE_SHOP), function(arg_41_0)
					return arg_41_0:getConfig("config_client").pt_id == var_40_2
				end) and var_4.id
				local var_40_11 = arg_1_0
				local var_40_12 = var_6.sendNotification

				GAME = var_9

				local var_40_13 = var_9.GO_SCENE

				SCENE = var_2_10010

				local var_40_14 = var_2_10010.SHOP
				local var_40_15 = {}

				NewShopsScene = var_2_10012
				var_40_15.warp = var_2_10012.TYPE_ACTIVITY
				var_40_15.actId = var_40_10

				var_40_12(var_40_11, var_40_13, var_40_14, var_40_15)
			end

			::label_40_2::

			return
		end
	end)
	arg_1_0:bind(var_0_1.SHOW_ATELIER_BUFF, function(arg_42_0, arg_42_1)
		if arg_42_1 then
			local var_42_0 = arg_1_0
			local var_42_1 = var_2.addSubLayers

			Context = var_2_10005
			var_2_10005 = var_2_10005.New

			local var_42_2 = {}

			AterialYumiaCoreBuffMediator = var_2_10008
			var_42_2.mediator = var_2_10008
			AterialYumiaCoreBuffLayer = var_2_10008
			var_42_2.viewComponent = var_2_10008

			var_42_1(var_42_0, var_2_10005(var_42_2))
		else
			local var_42_3 = arg_1_0
			local var_42_4 = var_2.addSubLayers

			Context = var_2_10005

			local var_42_5 = var_2_10005.New
			local var_42_6 = {}

			AtelierBuffMediator = var_2_10008
			var_42_6.mediator = var_2_10008
			AtelierBuffLayer = var_2_10008
			var_42_6.viewComponent = var_2_10008

			var_42_4(var_42_3, var_42_5(var_42_6))
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHIP_DETAIL, function(arg_43_0, arg_43_1)
		arg_1_0.contextData.selectedChapterVO = arg_43_1.chapter

		local var_43_0 = arg_1_0
		local var_43_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_43_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_43_1(var_43_0, var_43_2, var_2_10006.SHIPINFO, {
			shipId = arg_43_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FLEET_SHIPINFO, function(arg_44_0, arg_44_1)
		local var_44_0 = arg_1_0
		local var_44_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_44_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_44_1(var_44_0, var_44_2, var_2_10006.SHIPINFO, {
			shipId = arg_44_1.shipId,
			shipVOs = arg_44_1.shipVOs
		})

		arg_1_0.contextData.editEliteChapter = arg_44_1.chapter.id

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUPPORT_SHIPINFO, function(arg_45_0, arg_45_1)
		local var_45_0 = arg_1_0
		local var_45_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_45_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_45_1(var_45_0, var_45_2, var_2_10006.SHIPINFO, {
			shipId = arg_45_1.shipId,
			shipVOs = arg_45_1.shipVOs
		})

		arg_1_0.contextData.selectedChapterVO = arg_45_1.chapter

		return
	end)
	arg_1_0:bind(var_0_1.ON_STAGE_SHIPINFO, function(arg_46_0, arg_46_1)
		local var_46_0 = arg_1_0
		local var_46_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_46_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_46_1(var_46_0, var_46_2, var_2_10006.SHIPINFO, {
			shipId = arg_46_1.shipId,
			shipVOs = arg_46_1.shipVOs
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTRA_RANK, function(arg_47_0)
		local var_47_0 = arg_1_0
		local var_47_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_47_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_47_3 = var_2_10005.BILLBOARD
		local var_47_4 = {}

		PowerRank = var_2_10007
		var_47_4.page = var_2_10007.TYPE_EXTRA_CHAPTER

		var_47_1(var_47_0, var_47_2, var_47_3, var_47_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_STRATEGYING_CHAPTER, function(arg_48_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_48_0 = var_2_10001(var_2_10003)
		local var_48_1 = var_1.getActiveChapter(var_48_0)

		assert = var_2_10003

		var_2_10003(var_48_1)

		local var_48_2 = var_1
		local var_48_3 = var_1.getMapById
		local var_48_4 = var_48_1
		local var_48_5 = var_48_3(var_48_2, var_48_1.getConfig(var_48_4, "map"))

		pg = var_48_0

		local var_48_6 = var_48_0.MsgboxMgr.GetInstance()
		local var_48_7 = var_4.ShowMsgBox
		local var_48_8 = {
			yesText = "text_forward"
		}

		i18n = var_48_4

		local var_48_9 = "levelScene_chapter_is_activation"

		string = var_2_10011
		var_48_8.content = var_48_4(var_48_9, var_2_10011.split(var_48_5:getConfig("name"), "|")[1] .. ":" .. var_48_1:getConfig("chapter_name"))

		function var_48_8.onYes()
			local var_49_0 = arg_1_0.viewComponent

			var_0.switchToChapter(var_49_0, var_48_1)

			return
		end

		function var_48_8.onNo()
			arg_1_0.contextData.chapterVO = var_48_1

			local var_50_0 = arg_1_0.viewComponent
			local var_50_1 = var_0.emit

			LevelMediator2 = var_3_10003

			local var_50_2 = var_3_10003.ON_OP
			local var_50_3 = {}

			ChapterConst = var_3_10005
			var_50_3.type = var_3_10005.OpRetreat
			ChapterConst = var_5
			var_50_3.exittype = var_5.ExitFromMap

			var_50_1(var_50_0, var_50_2, var_50_3)

			return
		end

		function var_48_8.onClose()
			return
		end

		pg = var_8
		var_48_8.noBtnType = var_8.MsgboxMgr.BUTTON_RETREAT

		var_48_7(var_48_6, var_48_8)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMANDER_SKILL, function(arg_52_0, arg_52_1)
		local var_52_0 = arg_1_0
		local var_52_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_52_2 = var_2_10005.New
		local var_52_3 = {}

		CommanderSkillMediator = var_2_10008
		var_52_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_52_3.viewComponent = var_2_10008
		var_52_3.data = {
			skill = arg_52_1
		}

		var_52_1(var_52_0, var_52_2(var_52_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
		local var_53_0 = arg_1_0
		local var_53_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_53_2 = var_2_10007.BEGIN_STAGE
		local var_53_3 = {}

		SYSTEM_PERFORM = var_2_10009
		var_53_3.system = var_2_10009
		var_53_3.stageId = arg_53_1
		var_53_3.exitCallback = arg_53_2
		var_53_3.memory = arg_53_3

		var_53_1(var_53_0, var_53_2, var_53_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUPPORT_SUBMARINE, function(arg_54_0)
		local var_54_0 = arg_1_0
		local var_54_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_54_2 = var_2_10004.BEGIN_STAGE
		local var_54_3 = {}

		SYSTEM_SCENARIO_SUB_STRIKE = var_2_10006
		var_54_3.system = var_2_10006

		var_54_1(var_54_0, var_54_2, var_54_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN, function(arg_55_0)
		local var_55_0 = arg_1_0
		local var_55_1 = var_1.sendNotification

		GAME = var_2_10004

		var_55_1(var_55_0, var_2_10004.GET_REMASTER_TICKETS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BOSSRUSH_REMASTER_ACTIVITY, function(arg_56_0, arg_56_1)
		arg_1_0.bossRushRemasterActivityId = arg_56_1

		local var_56_0 = arg_1_0
		local var_56_1 = var_2.sendNotification

		GAME = var_2_10005

		var_56_1(var_56_0, var_2_10005.ACTIVITY_PERMANENT_START, {
			activity_id = arg_56_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_TASK, function(arg_57_0, arg_57_1)
		local var_57_0 = arg_1_0
		local var_57_1 = var_2.sendNotification

		GAME = var_2_10005

		var_57_1(var_57_0, var_2_10005.SUBMIT_TASK, arg_57_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_58_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_58_0 = var_2_10001(var_2_10003)
		local var_58_1 = var_1.getActiveChapter(var_58_0)

		assert = var_2_10002

		var_2_10002(var_58_1)

		local var_58_2 = var_58_1.fleet
		local var_58_3 = var_58_1:getStageId(var_58_2.line.row, var_58_2.line.column)

		seriesAsync = var_4

		var_4({
			function(arg_59_0)
				local var_59_0 = {}

				pairs = var_3_10002

				for iter_59_0, iter_59_1 in var_3_10002(var_58_2.ships) do
					table = var_3_10007

					var_3_10007.insert(var_59_0, iter_59_1)
				end

				Fleet = var_2

				var_2.EnergyCheck(var_59_0, var_58_2.name, function(arg_60_0)
					if arg_60_0 then
						arg_59_0()
					end

					return
				end, function(arg_61_0)
					if not arg_61_0 then
						getProxy = var_4_10001
						ChapterProxy = var_4_10003

						local var_61_0 = var_4_10001(var_4_10003)
						local var_61_1 = var_1.StopAutoFight

						ChapterConst = var_4_10004

						var_61_1(var_61_0, var_4_10004.AUTOFIGHT_STOP_REASON.SHIP_ENERGY_LOW)
					end

					return
				end)

				return
			end,
			function(arg_62_0)
				getProxy = var_3_10001
				PlayerProxy = var_3_10003

				local var_62_0 = var_3_10001(var_3_10003)
				local var_62_1 = var_1.getRawData(var_62_0)

				if var_1.GoldMax(var_62_1, 1) then
					i18n = var_2

					local var_62_2 = var_2("gold_max_tip_title")

					i18n = var_62_0

					local var_62_3 = var_62_2 .. var_62_0("resource_max_tip_battle")

					getProxy = var_3
					ChapterProxy = var_5

					local var_62_4 = var_3(var_5)
					local var_62_5 = var_3.StopAutoFight

					ChapterConst = var_3_10006

					var_62_5(var_62_4, var_3_10006.AUTOFIGHT_STOP_REASON.GOLD_MAX)

					pg = var_62_5

					local var_62_6 = var_62_5.MsgboxMgr.GetInstance()

					var_3.ShowMsgBox(var_62_6, {
						content = var_62_3,
						onYes = arg_62_0
					})
				else
					arg_62_0()
				end

				return
			end,
			function(arg_63_0)
				local var_63_0 = arg_1_0
				local var_63_1 = var_1.sendNotification

				GAME = var_3_10004

				local var_63_2 = var_3_10004.BEGIN_STAGE
				local var_63_3 = {}

				SYSTEM_SCENARIO = var_3_10006
				var_63_3.system = var_3_10006
				var_63_3.stageId = var_58_3

				var_63_1(var_63_0, var_63_2, var_63_3)

				return
			end
		})

		return
	end)
	arg_1_0:bind(arg_1_0.ON_ENTER_MAINLEVEL, function(arg_64_0, arg_64_1)
		local var_64_0 = arg_1_0

		var_2.DidEnterLevelMainUI(var_64_0, arg_64_1)

		return
	end)
	arg_1_0:bind(arg_1_0.ON_DIDENTER, function(arg_65_0)
		local var_65_0 = arg_1_0.viewComponent
		local var_65_1 = var_1.emit

		LevelMediator2 = var_2_10004

		var_65_1(var_65_0, var_2_10004.UPDATE_EVENT_LIST)

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_WORLD, function(arg_66_0)
		local var_66_0 = arg_1_0
		local var_66_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_66_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_66_1(var_66_0, var_66_2, var_2_10005.WORLD)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHAPTER_REMASTER_AWARD, function(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
		local var_67_0 = arg_1_0
		local var_67_1 = var_4.sendNotification

		GAME = var_2_10007

		var_67_1(var_67_0, var_2_10007.CHAPTER_REMASTER_AWARD_RECEIVE, {
			chapterId = arg_67_1,
			pos = arg_67_2,
			actId = arg_67_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_ACT_BOSS_BATTLE, function(arg_68_0)
		local var_68_0 = arg_1_0
		local var_68_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_68_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_68_1(var_68_0, var_68_2, var_2_10005.ACT_BOSS_BATTLE, {
			showAni = true
		})

		return
	end)

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.bind

	LevelUIConst = var_5

	var_1_2(var_1_1, var_5.OPEN_NORMAL_CONTINUOUS_WINDOW, function(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
		_ = var_2_10005

		local var_69_0 = var_2_10005.map(arg_69_2, function(arg_70_0)
			getProxy = var_3_10001
			FleetProxy = var_3_10003

			local var_70_0 = var_3_10001(var_3_10003)

			if var_1.getFleetById(var_70_0, arg_70_0) then
				local var_70_1 = var_1:getFleetType()

				FleetType = var_70_0

				if var_70_1 == var_70_0.Submarine then
					return
				end

				return var_1
			end
		end)
		local var_69_1 = arg_1_0

		var_6.DisplayContinuousWindow(var_69_1, arg_69_1, var_69_0, arg_69_3, arg_69_4)

		return
	end)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bind

	LevelUIConst = var_5

	var_1_4(var_1_3, var_5.OPEN_ELITE_CONTINUOUS_WINDOW, function(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
		local var_71_0 = arg_71_1
		local var_71_1 = arg_71_1.getEliteFleetList(var_71_0)

		getProxy = var_2_10005
		BayProxy = var_2_10007

		local var_71_2 = var_2_10005(var_2_10007)
		local var_71_3 = var_5.getRawData(var_71_2)

		_ = var_71_0

		local var_71_4 = var_71_0.map(var_71_1, function(arg_72_0)
			if #arg_72_0 ~= 0 then
				_ = var_1

				if var_1.any(arg_72_0, function(arg_73_0)
					if var_71_3[arg_73_0] then
						::label_73_0::

						var_4_10002 = var_1:getTeamType()
						TeamType = var_4_10003
						var_4_10002 = var_4_10002 == var_4_10003.Submarine
					end

					return var_4_10002
				end) then
					return
				end

				TypedFleet = var_1

				local var_72_0 = var_1.New
				local var_72_1 = {}

				FleetType = var_3_10004
				var_72_1.fleetType = var_3_10004.Normal
				var_72_1.ship_list = arg_72_0

				return var_72_0(var_72_1)
			end
		end)
		local var_71_5 = arg_1_0

		var_7.DisplayContinuousWindow(var_71_5, arg_71_1, var_71_4, arg_71_2, arg_71_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_LOWPRIORITY_TASK, function(arg_74_0, arg_74_1, arg_74_2)
		local var_74_0 = arg_1_0
		local var_74_1 = var_3.sendNotification

		GAME = var_2_10006

		var_74_1(var_74_0, var_2_10006.UPDATE_LOW_PRIORITY_TASK_PROGRESS, {
			taskId = arg_74_1
		})

		return
	end)

	arg_1_0.player = var_1_0:getData()

	local var_1_5 = arg_1_0.viewComponent

	var_2.updateRes(var_1_5, arg_1_0.player)

	getProxy = var_2
	EventProxy = var_1_5

	local var_1_6 = var_2(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_3.updateEvent(var_1_7, var_1_6)

	getProxy = var_3
	FleetProxy = var_1_7

	local var_1_8 = var_3(var_1_7)
	local var_1_9 = var_3.GetRegularFleets(var_1_8)
	local var_1_10 = arg_1_0.viewComponent

	var_5.updateFleet(var_1_10, var_1_9)

	getProxy = var_5
	BayProxy = var_1_10

	local var_1_11 = var_5(var_1_10)
	local var_1_12 = arg_1_0.viewComponent

	var_6.setShips(var_1_12, var_1_11:getRawData())

	getProxy = var_6
	ActivityProxy = var_1_12

	local var_1_13 = var_6(var_1_12)
	local var_1_14 = arg_1_0.viewComponent

	var_7.updateVoteBookBtn(var_1_14)

	getProxy = var_7
	CommanderProxy = var_1_14

	local var_1_15 = var_7(var_1_14)
	local var_1_16 = var_7.getPrefabFleet(var_1_15)
	local var_1_17 = arg_1_0.viewComponent

	var_8.setCommanderPrefabs(var_1_17, var_1_16)

	getProxy = var_8
	DailyLevelProxy = var_1_17

	local var_1_18 = var_8(var_1_17)
	local var_1_19 = arg_1_0.viewComponent
	local var_1_20 = var_9.setEliteQuota
	local var_1_21 = var_1_18.eliteCount

	pg = var_1_10013

	var_1_20(var_1_19, var_1_21, var_1_10013.gameset.elite_quota.key_value)

	getProxy = var_1_20
	ChapterProxy = var_1_19

	local var_1_22 = var_1_20(var_1_19)

	var_9.updateActiveChapterShips(var_1_22)

	getProxy = var_10
	BagProxy = var_1_22

	local var_1_23 = var_10(var_1_22)
	local var_1_24 = var_10.getItemsByType

	Item = var_1_10014

	local var_1_25 = var_1_24(var_1_23, var_1_10014.SPECIAL_OPERATION_TICKET)
	local var_1_26 = arg_1_0.viewComponent

	var_12.setSpecialOperationTickets(var_1_26, var_1_25)

	return
end

function var_0_1.DidEnterLevelMainUI(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.viewComponent

	var_2.setMap(var_75_0, arg_75_1)

	local var_75_2

	if arg_75_0.contextData.openChapterId then
		local var_75_1 = arg_75_0.contextData.openChapterId

		var_75_2 = arg_75_0.viewComponent.mapBuilder

		var_3.ActionInvoke(var_75_2, "TryOpenChapter", var_75_1)

		arg_75_0.contextData.openChapterId = nil
	end

	if arg_75_0.contextData.chapterVO and var_2.active then
		var_75_2 = arg_75_0.viewComponent

		var_3.switchToChapter(var_75_2, var_2)
	else
		var_75_2 = arg_75_0.contextData.map

		if var_3.isSkirmish(var_75_2) then
			var_75_2 = arg_75_0.viewComponent

			var_3.ShowCurtains(var_75_2, true)

			var_75_2 = arg_75_0.viewComponent

			var_3.doPlayAnim(var_75_2, "TV01", function(arg_76_0)
				go = var_2_10001

				local var_76_0 = var_2_10001(arg_76_0)

				var_1.SetActive(var_76_0, false)

				local var_76_1 = arg_75_0.viewComponent

				var_1.ShowCurtains(var_76_1, false)

				return
			end)
		end
	end

	if arg_75_0.contextData.preparedTaskList and #arg_75_0.contextData.preparedTaskList > 0 then
		ipairs = var_3

		for iter_75_0, iter_75_1 in var_3(arg_75_0.contextData.preparedTaskList) do
			local var_75_3 = arg_75_0
			local var_75_4 = arg_75_0.sendNotification

			GAME = var_1_10011

			var_75_4(var_75_3, var_1_10011.SUBMIT_TASK, iter_75_1)
		end

		table = var_3

		var_3.clean(arg_75_0.contextData.preparedTaskList)
	end

	if arg_75_0.contextData.StopAutoFightFlag then
		getProxy = var_3
		ChapterProxy = var_75_2

		local var_75_5 = var_3(var_75_2)

		if var_3.getActiveChapter(var_75_5) then
			local var_75_6 = var_3

			var_3.SetChapterAutoFlag(var_75_6, var_4.id, false)

			bit = var_5

			local var_75_7 = var_5.bor

			ChapterConst = var_75_6

			local var_75_8 = var_75_6.DirtyAttachment

			ChapterConst = var_8

			local var_75_9 = var_75_7(var_75_8, var_8.DirtyStrategy)
			local var_75_10 = arg_75_0.viewComponent

			var_6.updateChapterVO(var_75_10, var_4, var_75_9)
		end

		arg_75_0.contextData.StopAutoFightFlag = nil
	end

	arg_75_0:TryEnterPendingChapter()

	return
end

function var_0_1.TryEnterPendingChapter(arg_77_0)
	if not arg_77_0.contextData.pendingEnterChapterId then
		return
	end

	if not arg_77_0.contextData.map or not arg_77_0.viewComponent.mapBuilder then
		return
	end

	local var_77_0

	if arg_77_0.contextData.chapterVO and arg_77_0.contextData.chapterVO.id == var_1 then
		var_77_0 = arg_77_0.contextData
		var_77_0.pendingEnterChapterId = nil

		return
	end

	getProxy = var_77_0
	ChapterProxy = var_1_10004

	local var_77_1 = var_77_0(var_1_10004)

	if not var_2.getChapterById(var_77_1, var_1) or not var_2.active then
		return
	end

	arg_77_0.contextData.pendingEnterChapterId = nil
	arg_77_0.waitingTracking = nil

	local var_77_2 = arg_77_0.viewComponent

	var_3.resetLevelGrid(var_77_2)

	arg_77_0.viewComponent.FirstEnterChapter = var_2.id

	local var_77_3 = arg_77_0.viewComponent

	var_3.switchToChapter(var_77_3, var_2)

	return
end

function var_0_1.RegisterTrackEvent(arg_78_0)
	arg_78_0:bind(var_0_1.ON_TRACKING, function(arg_79_0, arg_79_1, arg_79_2, arg_79_3, arg_79_4, arg_79_5)
		getProxy = var_2_10006
		ChapterProxy = var_2_10008

		local var_79_0 = var_2_10006(var_2_10008)
		local var_79_1 = var_6.getChapterById(var_79_0, arg_79_1, true)

		getProxy = var_2_10007
		ChapterProxy = var_9

		local var_79_2 = var_2_10007(var_9)
		local var_79_3 = var_7.GetLastFleetIndex(var_79_2)
		local var_79_4 = arg_78_0
		local var_79_5 = var_8.sendNotification

		GAME = var_2_10011

		var_79_5(var_79_4, var_2_10011.TRACKING, {
			chapterId = arg_79_1,
			fleetIds = var_79_3,
			loopFlag = arg_79_2,
			operationItem = arg_79_3,
			duties = arg_79_4,
			autoFightFlag = arg_79_5
		})

		return
	end)
	arg_78_0:bind(var_0_1.ON_ELITE_TRACKING, function(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
		local var_80_0 = arg_78_0
		local var_80_1 = var_6.sendNotification

		GAME = var_2_10009

		var_80_1(var_80_0, var_2_10009.TRACKING, {
			chapterId = arg_80_1,
			loopFlag = arg_80_2,
			operationItem = arg_80_3,
			duties = arg_80_4,
			autoFightFlag = arg_80_5
		})

		return
	end)
	arg_78_0:bind(var_0_1.ON_RETRACKING, function(arg_81_0, arg_81_1, arg_81_2)
		local var_81_0 = arg_81_1.duties
		local var_81_1 = arg_81_1:getConfig("type")

		Chapter = var_2_10005

		local var_81_2 = var_81_1 == var_2_10005.CustomFleet
		local var_81_3 = arg_81_1:GetActiveSPItemID()

		if var_81_2 then
			local var_81_4 = arg_78_0.viewComponent
			local var_81_5 = var_6.emit

			LevelMediator2 = var_2_10009

			var_81_5(var_81_4, var_2_10009.ON_ELITE_TRACKING, arg_81_1.id, arg_81_1.loopFlag, var_81_3, var_81_0, arg_81_2)
		else
			local var_81_6 = arg_78_0.viewComponent
			local var_81_7 = var_6.emit

			LevelMediator2 = var_2_10009

			var_81_7(var_81_6, var_2_10009.ON_TRACKING, arg_81_1.id, arg_81_1.loopFlag, var_81_3, var_81_0, arg_81_2)
		end

		return
	end)

	return
end

function var_0_1.NoticeVoteBook(arg_82_0, arg_82_1)
	arg_82_1()

	return
end

function var_0_1.TryPlaySubGuide(arg_83_0)
	local var_83_0 = arg_83_0.viewComponent

	var_1.tryPlaySubGuide(var_83_0)

	return
end

function var_0_1.listNotificationInterests(arg_84_0)
	local var_84_0 = {}

	ChapterProxy = var_1_10002
	var_84_0[1] = var_1_10002.CHAPTER_UPDATED
	ChapterProxy = var_2
	var_84_0[2] = var_2.CHAPTER_TIMESUP
	PlayerProxy = var_2
	var_84_0[3] = var_2.UPDATED
	DailyLevelProxy = var_2
	var_84_0[4] = var_2.ELITE_QUOTA_UPDATE
	var_84_0[5] = var_0_1.ON_TRACKING
	var_84_0[6] = var_0_1.ON_ELITE_TRACKING
	var_84_0[7] = var_0_1.ON_RETRACKING
	GAME = var_2
	var_84_0[8] = var_2.TRACKING_DONE
	GAME = var_2
	var_84_0[9] = var_2.TRACKING_ERROR
	GAME = var_2
	var_84_0[10] = var_2.CHAPTER_OP_DONE
	GAME = var_2
	var_84_0[11] = var_2.EVENT_LIST_UPDATE
	GAME = var_2
	var_84_0[12] = var_2.BEGIN_STAGE_DONE
	ActivityProxy = var_2
	var_84_0[13] = var_2.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_84_0[14] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_84_0[15] = var_2.SUB_CHAPTER_REFRESH_DONE
	GAME = var_2
	var_84_0[16] = var_2.SUB_CHAPTER_FETCH_DONE
	CommanderProxy = var_2
	var_84_0[17] = var_2.PREFAB_FLEET_UPDATE
	GAME = var_2
	var_84_0[18] = var_2.COOMMANDER_EQUIP_TO_FLEET_DONE
	GAME = var_2
	var_84_0[19] = var_2.COMMANDER_ELIT_FORMATION_OP_DONE
	GAME = var_2
	var_84_0[20] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_84_0[21] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	LevelUIConst = var_2
	var_84_0[22] = var_2.CONTINUOUS_OPERATION
	var_84_0[23] = var_0_1.ON_SPITEM_CHANGED
	GAME = var_2
	var_84_0[24] = var_2.GET_REMASTER_TICKETS_DONE
	GAME = var_2
	var_84_0[25] = var_2.ACTIVITY_PERMANENT_START_DONE
	VoteProxy = var_2
	var_84_0[26] = var_2.VOTE_ORDER_BOOK_DELETE
	VoteProxy = var_2
	var_84_0[27] = var_2.VOTE_ORDER_BOOK_UPDATE
	GAME = var_2
	var_84_0[28] = var_2.VOTE_BOOK_BE_UPDATED_DONE
	BagProxy = var_2
	var_84_0[29] = var_2.ITEM_UPDATED
	ChapterProxy = var_2
	var_84_0[30] = var_2.CHAPTER_AUTO_FIGHT_FLAG_UPDATED
	ChapterProxy = var_2
	var_84_0[31] = var_2.CHAPTER_SKIP_PRECOMBAT_UPDATED
	ChapterProxy = var_2
	var_84_0[32] = var_2.CHAPTER_REMASTER_INFO_UPDATED
	GAME = var_2
	var_84_0[33] = var_2.CHAPTER_REMASTER_INFO_REQUEST_DONE
	GAME = var_2
	var_84_0[34] = var_2.CHAPTER_REMASTER_AWARD_RECEIVE_DONE
	GAME = var_2
	var_84_0[35] = var_2.STORY_UPDATE_DONE
	GAME = var_2
	var_84_0[36] = var_2.STORY_END

	return var_84_0
end

function var_0_1.handleNotification(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_1
	local var_85_1 = arg_85_1.getName(var_85_0)
	local var_85_2 = arg_85_1
	local var_85_3 = arg_85_1.getBody(var_85_2)

	GAME = var_85_0

	local var_85_4

	if var_85_1 == var_85_0.BEGIN_STAGE_DONE then
		var_1_10006 = arg_85_0
		var_85_4 = arg_85_0.sendNotification
		GAME = var_1_10007
		var_1_10007 = var_1_10007.GO_SCENE
		SCENE = iter_85_0

		var_85_4(var_1_10006, var_1_10007, iter_85_0.COMBATLOAD, var_85_3)

		goto label_85_0
	end

	VoteProxy = var_85_4

	if var_85_1 ~= var_85_4.VOTE_ORDER_BOOK_DELETE then
		VoteProxy = var_4

		if var_4.VOTE_ORDER_BOOK_UPDATE == var_85_1 then
			var_1_10006 = arg_85_0.viewComponent

			var_4.updateVoteBookBtn(var_1_10006)

			goto label_85_0
		end

		PlayerProxy = var_4

		if var_85_1 == var_4.UPDATED then
			var_1_10006 = arg_85_0.viewComponent

			var_4.updateRes(var_1_10006, var_85_3)

			goto label_85_0
		end

		local var_85_5

		if var_85_1 == var_0_1.ON_TRACKING or var_85_1 == var_0_1.ON_ELITE_TRACKING or var_85_1 == var_0_1.ON_RETRACKING then
			var_1_10006 = arg_85_0.viewComponent
			var_85_5 = var_85_5.emit
			var_1_10007 = var_85_1
			unpackEx = iter_85_0

			var_85_5(var_1_10006, var_1_10007, iter_85_0(var_85_3))

			goto label_85_0
		end

		GAME = var_85_5

		local var_85_6

		if var_85_1 == var_85_5.TRACKING_DONE then
			arg_85_0.waitingTracking = nil

			if arg_85_0.contextData.pendingEnterChapterId == var_85_3.id then
				var_85_6 = arg_85_0.contextData
				var_85_6.pendingEnterChapterId = nil
			end

			var_1_10006 = arg_85_0.viewComponent

			var_85_6.resetLevelGrid(var_1_10006)

			var_85_6 = arg_85_0.viewComponent
			var_85_6.FirstEnterChapter = var_85_3.id
			var_1_10006 = arg_85_0.viewComponent

			var_85_6.switchToChapter(var_1_10006, var_85_3)

			goto label_85_0
		end

		ChapterProxy = var_85_6

		if var_85_1 == var_85_6.CHAPTER_UPDATED then
			var_1_10006 = arg_85_0.viewComponent

			var_4.updateChapterVO(var_1_10006, var_85_3.chapter, var_85_3.dirty)

			goto label_85_0
		end

		GAME = var_4

		local var_85_7

		if var_85_1 == var_4.COMMANDER_ELIT_FORMATION_OP_DONE then
			if arg_85_0.contextData.commanderOPChapter then
				getProxy = var_85_7
				ChapterProxy = var_1_10006
				var_1_10006 = var_85_7(var_1_10006)
				var_85_7 = var_85_7.getChapterById(var_1_10006, var_85_3.chapterId)
				pairs = var_85_2
				iter_85_1 = var_85_7

				for iter_85_0, iter_85_1 in var_85_2(var_85_7.getEliteFleetCommanders(iter_85_1)) do
					local var_85_8 = arg_85_0.contextData.commanderOPChapter

					var_1_10010 = var_1_10010.setEliteFleetByIndex

					local var_85_9 = iter_85_0
					local var_85_10 = {}
					local var_85_11 = {}

					TeamType = var_1_10016
					var_85_11[1] = var_1_10016.FormCommander
					var_85_11[2] = {
						pos = 1,
						id = iter_85_1[1]
					}
					var_85_10[1] = var_85_11

					local var_85_12 = {}

					TeamType = var_1_10016
					var_85_12[1] = var_1_10016.FormCommander
					var_85_12[2] = {
						pos = 2,
						id = iter_85_1[2]
					}
					var_85_10[2] = var_85_12

					var_1_10010(var_85_8, var_85_9, var_85_10)
				end

				var_1_10007 = arg_85_0.viewComponent

				var_5.RefreshFleetSelectView(var_1_10007, arg_85_0.contextData.commanderOPChapter)
			end

			goto label_85_0
		end

		GAME = var_85_7

		local var_85_13

		if var_85_1 == var_85_7.CHAPTER_OP_DONE then
			var_85_13 = nil

			local function var_85_14()
				if var_85_13 then
					coroutine = var_0

					if var_0.status(var_85_13) == "suspended" then
						coroutine = var_0

						local var_86_0, var_86_1 = var_0.resume(var_85_13)

						assert = var_2

						local var_86_2 = var_86_0

						debug = var_2_10005

						var_2(var_86_2, var_2_10005.traceback(var_85_13, var_86_1))
					end
				end

				return
			end

			coroutine = var_1_10006
			var_85_13 = var_1_10006.create(function()
				local var_87_0 = var_85_3.type
				local var_87_1 = arg_85_0.contextData.chapterVO
				local var_87_2 = var_87_3.IsAutoFight(var_87_1)

				ChapterConst = var_2_10003

				local var_87_3

				if var_87_0 == var_2_10003.OpRetreat and not var_85_3.id then
					var_87_3 = var_85_3.finalChapterLevelData

					if var_85_3.exittype then
						local var_87_4 = var_85_3.exittype

						ChapterConst = var_87_1

						if var_87_4 == var_87_1.ExitFromMap then
							var_2_10005 = arg_85_0.viewComponent

							var_3.setChapter(var_2_10005, nil)

							var_2_10005 = arg_85_0.viewComponent.mapBuilder

							var_3.UpdateChapterTF(var_2_10005, var_87_3.id)

							var_2_10005 = arg_85_0

							var_3.OnExitChapter(var_2_10005, var_87_3, var_85_3.win, var_85_3.extendData)

							return
						end
					end

					var_2_10005 = var_87_3

					if var_87_3.existOni(var_2_10005) then
						var_2_10005 = var_87_3

						if var_87_3.checkOniState(var_2_10005) then
							var_2_10006 = arg_85_0.viewComponent

							var_4.displaySpResult(var_2_10006, var_3, var_85_14)

							coroutine = var_4

							var_4.yield()
						end
					end

					var_2_10005 = var_87_3

					if var_87_3.isPlayingWithBombEnemy(var_2_10005) then
						var_2_10005 = arg_85_0.viewComponent

						var_3.displayBombResult(var_2_10005, var_85_14)

						coroutine = var_3

						var_3.yield()
					end
				end

				local var_87_5 = var_85_3.items
				local var_87_6

				if var_87_5 then
					var_2_10005 = #var_87_5

					if 0 < var_2_10005 then
						ChapterConst = var_2_10005

						if var_87_0 == var_2_10005.OpBox then
							var_2_10005 = var_87_3.fleet.line
							var_2_10008 = var_87_3
							var_2_10006 = var_87_3.getChapterCell(var_2_10008, var_2_10005.row, var_2_10005.column)
							pg = var_2_10007
							var_2_10008 = var_2_10007.box_data_template[var_2_10006.attachmentId].type
							ChapterConst = var_2_10009

							if var_2_10008 == var_2_10009.BoxDrop then
								ChapterConst = var_2_10008

								if var_2_10008.IsAtelierMap(arg_85_0.contextData.map) then
									_ = var_2_10008
									var_2_10009 = #var_2_10008.filter(var_87_5, function(arg_88_0)
										local var_88_0 = arg_88_0.type

										DROP_TYPE_RYZA_DROP = var_3_10002

										return var_88_0 == var_3_10002
									end)

									if 0 < var_2_10009 then
										AwardInfoLayer = var_2_10009
										var_87_6 = var_2_10009.TITLE.RYZA
										math = var_2_10009
										var_2_10009 = var_2_10009.random(#var_2_10008)
										AtelierMaterial = var_2_10010
										var_2_10013 = var_2_10010.New({
											configId = var_2_10008[var_2_10009].id
										})

										if var_2_10010.GetVoices(var_2_10013) then
											local var_87_7 = #var_11

											if 0 < var_87_7 then
												math = var_87_7

												local var_87_8 = var_11[var_87_7.random(#var_11)]

												ShipWordHelper = var_2_10013
												var_2_10013 = var_2_10013.GetWordAndCV

												local var_87_9 = var_87_8[1]
												local var_87_10 = var_87_8[2]
												local var_87_11

												PLATFORM_CODE = var_2_10018
												PLATFORM_US = var_2_10019

												local var_87_12, var_87_13

												var_2_10013, var_87_12, var_87_13 = var_2_10013(var_87_9, var_87_10, var_87_11, var_2_10018 ~= var_2_10019)

												local var_87_14 = arg_85_0.viewComponent
												local var_87_15 = var_16.emit

												LevelUIConst = var_2_10019

												local var_87_16 = var_2_10019.ADD_TOAST_QUEUE
												local var_87_17 = {
													iconScale = 0.75
												}

												LevelStageAtelierMaterialToast = var_2_10021
												var_87_17.Class = var_2_10021
												i18n = var_2_10021
												var_87_17.title = var_2_10021("ryza_tip_toast_item_got")
												var_87_17.desc = var_87_13
												var_87_17.voice = var_87_12
												var_87_17.icon = var_87_8[3]

												var_87_15(var_87_14, var_87_16, var_87_17)
											end
										end
									end
								end
							end
						end

						seriesAsync = var_2_10005

						var_2_10005({
							function(arg_89_0)
								getProxy = var_3_10001
								ChapterProxy = var_3_10003

								local var_89_0 = var_3_10001(var_3_10003)
								local var_89_1 = var_1.AddExtendChapterDataArray
								local var_89_2 = var_87_3.id
								local var_89_3 = "TotalDrops"

								_ = var_3_10006

								var_89_1(var_89_0, var_89_2, var_89_3, var_3_10006.filter(var_87_5, function(arg_90_0)
									local var_90_0 = arg_90_0.type

									DROP_TYPE_STRATEGY = var_4_10002

									return var_90_0 ~= var_4_10002
								end))

								local var_89_4 = arg_85_0.viewComponent
								local var_89_5 = var_1.emit

								BaseUI = var_89_2

								var_89_5(var_89_4, var_89_2.ON_WORLD_ACHIEVE, {
									items = var_87_5,
									title = var_87_6,
									closeOnCompleted = var_87_2,
									removeFunc = arg_89_0
								})

								return
							end,
							function(arg_91_0)
								local var_91_0 = var_87_0

								ChapterConst = var_3_10002

								if var_91_0 == var_3_10002.OpBox then
									_ = var_91_0

									if var_91_0.any(var_87_5, function(arg_92_0)
										local var_92_0 = arg_92_0.type

										DROP_TYPE_VITEM = var_4_10002

										if var_92_0 ~= var_4_10002 then
											return false
										end

										return arg_92_0:getConfig("virtual_type") == 1
									end) then
										(function()
											getProxy = var_4_10000
											ActivityProxy = var_4_10002

											local var_93_0 = var_4_10000(var_4_10002)
											local var_93_1 = var_0.getActivityByType

											ActivityConst = var_4_10003

											if not var_93_1(var_93_0, var_4_10003.ACTIVITY_TYPE_PUZZLA) then
												return
											end

											pg = var_4_10001

											if not var_4_10001.activity_event_picturepuzzle[var_0.id] then
												return
											end

											table = var_2

											if #var_2.mergeArray(var_0.data1_list, var_0.data2_list, true) < #var_1.pickup_picturepuzzle + #var_1.drop_picturepuzzle then
												return
											end

											local var_93_2 = var_0:getConfig("config_client").comStory

											pg = var_4

											local var_93_3 = var_4.NewStoryMgr.GetInstance()

											var_4.Play(var_93_3, var_93_2, arg_91_0)

											return
										end)()
									end
								end

								_ = var_91_0

								if var_91_0.any(var_87_5, function(arg_94_0)
									local var_94_0 = arg_94_0.type

									DROP_TYPE_STRATEGY = var_4_10002

									if var_94_0 ~= var_4_10002 then
										return false
									end

									pg = var_94_0

									local var_94_1 = var_94_0.strategy_data_template[arg_94_0.id].type

									ChapterConst = var_4_10003

									return var_94_1 == var_4_10003.StgTypeConsume
								end) then
									local var_91_1 = arg_85_0.viewComponent.levelStageView

									var_1.popStageStrategy(var_91_1)
								end

								arg_91_0()

								return
							end
						}, var_85_14)

						coroutine = var_2_10005

						var_2_10005.yield()
					end
				end

				assert = var_2_10005

				var_2_10005(var_87_3)

				ChapterConst = var_2_10005

				if var_87_0 ~= var_2_10005.OpSkipBattle then
					ChapterConst = var_5

					local var_87_18

					if var_87_0 == var_5.OpPreClear then
						var_87_18 = arg_85_0.viewComponent.levelStageView

						var_5.tryAutoAction(var_87_18, function()
							if not arg_85_0.viewComponent.levelStageView then
								return
							end

							local var_95_0 = arg_85_0.viewComponent.levelStageView

							var_0.tryAutoTrigger(var_95_0)

							return
						end)
					else
						ChapterConst = var_5

						local var_87_19

						if var_87_0 == var_5.OpRetreat then
							getProxy = var_87_19
							ContextProxy = var_87_18
							var_87_18 = var_87_19(var_87_18)
							var_87_19 = var_87_19.getContextByMediator
							LevelMediator2 = var_2_10008

							if var_87_19(var_87_18, var_2_10008) then
								var_2_10006 = {}
								var_2_10009 = var_87_19
								var_87_18 = var_87_19.getContextByMediator
								ChapterPreCombatMediator = var_2_10010

								if var_87_18(var_2_10009, var_2_10010) then
									table = var_2_10008

									var_2_10008.insert(var_2_10006, var_87_18)
								end

								_ = var_2_10008

								var_2_10008.each(var_2_10006, function(arg_96_0)
									local var_96_0 = arg_85_0
									local var_96_1 = var_1.sendNotification

									GAME = var_3_10004

									var_96_1(var_96_0, var_3_10004.REMOVE_LAYERS, {
										context = arg_96_0
									})

									return
								end)
							end

							if var_85_3.id then
								return
							end

							getProxy = var_2_10006
							ActivityProxy = var_2_10008
							var_2_10009 = var_2_10006(var_2_10008)
							var_87_18 = var_2_10006.getActivityByType
							ActivityConst = var_2_10010

							if var_87_18(var_2_10009, var_2_10010.ACTIVITY_TYPE_PROGRESSLOGIN) and not var_87_18.autoActionForbidden and not var_87_18.achieved and var_87_18.data1 == 7 and var_87_3.id == 204 and var_87_3:isClear() then
								pg = var_8

								local var_87_20 = var_8.MsgboxMgr.GetInstance()

								var_8.ShowMsgBox(var_87_20, {
									modal = true,
									hideNo = true,
									content = "有新的签到奖励可以领取，点击确定前往",
									onYes = function()
										local var_97_0 = arg_85_0
										local var_97_1 = var_0.sendNotification

										GAME = var_3_10003

										local var_97_2 = var_3_10003.GO_SCENE

										SCENE = var_3_10004

										var_97_1(var_97_0, var_97_2, var_3_10004.ACTIVITY)

										return
									end,
									onNo = function()
										local var_98_0 = arg_85_0
										local var_98_1 = var_0.sendNotification

										GAME = var_3_10003

										local var_98_2 = var_3_10003.GO_SCENE

										SCENE = var_3_10004

										var_98_1(var_98_0, var_98_2, var_3_10004.ACTIVITY)

										return
									end
								})

								return
							end

							local var_87_21 = arg_85_0

							var_8.OnExitChapter(var_87_21, var_87_3, var_85_3.win, var_85_3.extendData)
						else
							ChapterConst = var_87_19

							if var_87_0 == var_87_19.OpMove then
								seriesAsync = var_5

								var_5({
									function(arg_99_0)
										var_87_3 = arg_85_0.contextData.chapterVO

										local var_99_0 = var_85_3.fullpath[#var_85_3.fullpath]
										local var_99_1 = var_87_3.fleet

										var_2.SetLine(var_99_1, var_99_0)

										getProxy = var_2
										ChapterProxy = var_99_1

										local var_99_2 = var_2(var_99_1)

										var_2.updateChapter(var_99_2, var_87_3)

										local var_99_3 = arg_85_0.viewComponent.grid

										var_2.moveFleet(var_99_3, var_85_3.path, var_85_3.fullpath, var_85_3.oldLine, arg_99_0)

										return
									end,
									function(arg_100_0)
										if not var_85_3.teleportPaths then
											arg_100_0()

											return
										end

										local var_100_0 = var_85_3.teleportPaths[1]
										local var_100_1 = var_85_3.teleportPaths[2]

										if not var_100_0 or not var_100_1 then
											arg_100_0()

											return
										end

										var_87_3 = arg_85_0.contextData.chapterVO

										local var_100_2 = var_87_3
										local var_100_3 = var_3.getFleet

										FleetType = var_3_10006

										if not var_100_3(var_100_2, var_3_10006.Normal, var_100_0.row, var_100_0.column) then
											arg_100_0()

											return
										end

										Clone = var_3_10004
										var_3.line = var_3_10004(var_85_3.teleportPaths[2])
										getProxy = var_4
										ChapterProxy = var_6

										local var_100_4 = var_4(var_6)

										var_4.updateChapter(var_100_4, var_87_3)

										local var_100_5 = arg_85_0
										local var_100_6 = var_4.getViewComponent(var_100_5).grid
										local var_100_7 = var_4.GetCellFleet(var_100_6, var_3.id)
										local var_100_8 = arg_85_0
										local var_100_9 = var_5.getViewComponent(var_100_8).grid

										var_5.TeleportCellByPortalWithCameraMove(var_100_9, var_3, var_100_7, var_85_3.teleportPaths, arg_100_0)

										return
									end,
									function(arg_101_0)
										local var_101_0 = arg_85_0

										var_1.playAIActions(var_101_0, var_85_3.aiActs, var_85_3.extraFlag, arg_101_0)

										return
									end
								}, function()
									var_87_3 = arg_85_0.contextData.chapterVO

									local var_102_0 = var_87_3.fleet
									local var_102_1 = var_0.getStrategies(var_102_0)

									_ = var_3_10001

									if var_3_10001.any(var_102_1, function(arg_103_0)
										local var_103_0 = arg_103_0.id

										ChapterConst = var_4_10002

										return var_103_0 == var_4_10002.StrategyExchange and arg_103_0.count > 0
									end) then
										local var_102_2 = arg_85_0.viewComponent.levelStageView

										var_1.popStageStrategy(var_102_2)
									end

									local var_102_3 = arg_85_0.viewComponent.grid
									local var_102_4 = var_1.updateQuadCells

									ChapterConst = var_4

									var_102_4(var_102_3, var_4.QuadStateNormal)

									local var_102_5 = arg_85_0.viewComponent.levelStageView

									var_1.updateAmbushRate(var_102_5, var_87_3.fleet.line, true)

									local var_102_6 = arg_85_0.viewComponent.levelStageView

									var_1.updateStageStrategy(var_102_6)

									local var_102_7 = arg_85_0.viewComponent.levelStageView

									var_1.updateFleetBuff(var_102_7)

									local var_102_8 = arg_85_0.viewComponent.levelStageView

									var_1.updateBombPanel(var_102_8)

									local var_102_9 = arg_85_0.viewComponent.levelStageView

									var_1.tryAutoTrigger(var_102_9)

									return
								end)
							else
								ChapterConst = var_5

								if var_87_0 == var_5.OpAmbush then
									var_87_18 = arg_85_0.viewComponent.levelStageView

									var_5.tryAutoTrigger(var_87_18)
								else
									ChapterConst = var_5

									if var_87_0 == var_5.OpBox then
										var_87_18 = arg_85_0

										var_5.playAIActions(var_87_18, var_85_3.aiActs, var_85_3.extraFlag, function()
											if not arg_85_0.viewComponent.levelStageView then
												return
											end

											local var_104_0 = arg_85_0.viewComponent.levelStageView

											var_0.tryAutoTrigger(var_104_0)

											return
										end)
									else
										ChapterConst = var_5

										if var_87_0 == var_5.OpStory then
											var_87_18 = arg_85_0.viewComponent.levelStageView

											var_5.tryAutoTrigger(var_87_18)
										else
											ChapterConst = var_5

											if var_87_0 == var_5.OpSwitch then
												var_87_18 = arg_85_0.viewComponent.grid

												var_5.adjustCameraFocus(var_87_18)
											else
												ChapterConst = var_5

												if var_87_0 == var_5.OpEnemyRound then
													var_87_18 = arg_85_0

													var_5.playAIActions(var_87_18, var_85_3.aiActs, var_85_3.extraFlag, function()
														local var_105_0 = arg_85_0.viewComponent.levelStageView

														var_0.updateBombPanel(var_105_0, true)

														local var_105_1 = var_87_3.fleet
														local var_105_2 = var_0.getStrategies(var_105_1)

														_ = var_3_10001

														if var_3_10001.any(var_105_2, function(arg_106_0)
															local var_106_0 = arg_106_0.id

															ChapterConst = var_4_10002

															return var_106_0 == var_4_10002.StrategyExchange and arg_106_0.count > 0
														end) then
															local var_105_3 = arg_85_0.viewComponent.levelStageView

															var_1.updateStageStrategy(var_105_3)

															local var_105_4 = arg_85_0.viewComponent.levelStageView

															var_1.popStageStrategy(var_105_4)
														end

														local var_105_5 = arg_85_0.viewComponent.levelStageView

														var_1.tryAutoTrigger(var_105_5)

														local var_105_6 = arg_85_0.viewComponent

														var_1.updatePoisonAreaTip(var_105_6)

														return
													end)
												else
													ChapterConst = var_5

													if var_87_0 == var_5.OpSubState then
														var_87_18 = arg_85_0

														var_5.saveSubState(var_87_18, var_87_3.subAutoAttack)

														var_87_18 = arg_85_0.viewComponent.grid

														var_5.OnChangeSubAutoAttack(var_87_18)
													else
														ChapterConst = var_5

														local var_87_22

														if var_87_0 == var_5.OpStrategy then
															var_87_22 = var_85_3.arg1
															ChapterConst = var_2_10006

															if var_87_22 == var_2_10006.StrategyExchange then
																local var_87_23 = var_87_3.fleet
																local var_87_24 = var_6.findSkills

																FleetSkill = var_2_10009

																local var_87_25 = var_87_24(var_87_23, var_2_10009.TypeStrategy)

																ipairs = var_87_18

																for iter_87_0, iter_87_1 in var_87_18(var_87_25) do
																	local var_87_26 = iter_87_1:GetType()

																	FleetSkill = var_2_10013

																	if var_87_26 == var_2_10013.TypeStrategy then
																		local var_87_27 = iter_87_1:GetArgs()[1]

																		ChapterConst = var_2_10013

																		if var_87_27 == var_2_10013.StrategyExchange then
																			local var_87_28 = var_87_3.fleet
																			local var_87_29 = var_12.findCommanderBySkillId(var_87_28, iter_87_1.id)
																			local var_87_30 = arg_85_0.viewComponent

																			var_2_10013.doPlayCommander(var_87_30, var_87_29)

																			break
																		end
																	end
																end
															end

															local var_87_31 = arg_85_0

															var_6.playAIActions(var_87_31, var_85_3.aiActs, var_85_3.extraFlag, function()
																local var_107_0 = arg_85_0.viewComponent.grid
																local var_107_1 = var_0.updateQuadCells

																ChapterConst = var_3_10003

																var_107_1(var_107_0, var_3_10003.QuadStateNormal)

																return
															end)
														else
															ChapterConst = var_87_22

															if var_87_0 == var_87_22.OpSupply then
																local var_87_32 = arg_85_0.viewComponent.levelStageView

																var_5.tryAutoTrigger(var_87_32)
															else
																ChapterConst = var_5

																if var_87_0 == var_5.OpBarrier then
																	local var_87_33 = arg_85_0.viewComponent.levelStageView

																	var_5.tryAutoTrigger(var_87_33)
																else
																	ChapterConst = var_5

																	if var_87_0 == var_5.OpSubTeleport then
																		seriesAsync = var_5

																		var_5({
																			function(arg_108_0)
																				_ = var_3_10001

																				local var_108_0 = var_3_10001.detect(var_87_3.fleets, function(arg_109_0)
																					return arg_109_0.id == var_85_3.id
																				end)

																				var_108_0.line = {
																					row = var_85_3.arg1,
																					column = var_85_3.arg2
																				}
																				var_108_0.startPos = {
																					row = var_85_3.arg1,
																					column = var_85_3.arg2
																				}

																				local var_108_1 = var_85_3.fullpath[1]
																				local var_108_2 = var_85_3.fullpath[#var_85_3.fullpath]
																				local var_108_3 = var_87_3
																				local var_108_4 = var_4.findPath(var_108_3, nil, var_108_1, var_108_2)

																				pg = var_3_10005

																				local var_108_5 = var_3_10005.strategy_data_template

																				ChapterConst = var_108_3

																				local var_108_6 = var_108_5[var_108_3.StrategySubTeleport].arg[2]

																				math = var_6

																				local var_108_7 = var_6.ceil(var_108_6 * #var_108_0:getShips(false) * var_108_4 - 1e-05)

																				getProxy = var_7
																				PlayerProxy = var_9

																				local var_108_8 = var_7(var_9)
																				local var_108_9 = var_7.getData(var_108_8)

																				var_8.consume(var_108_9, {
																					oil = var_108_7
																				})

																				local var_108_10 = arg_85_0.viewComponent

																				var_9.updateRes(var_108_10, var_8)
																				var_7:updatePlayer(var_8)

																				local var_108_11 = arg_85_0.viewComponent.grid
																				local var_108_12 = var_9.moveSub

																				table = var_12

																				var_108_12(var_108_11, var_12.indexof(var_87_3.fleets, var_108_0), var_85_3.fullpath, nil, function()
																					bit = var_4_10000

																					local var_110_0 = var_4_10000.bor

																					ChapterConst = var_4_10002

																					local var_110_1 = var_4_10002.DirtyFleet

																					ChapterConst = var_4_10003

																					local var_110_2 = var_4_10003.DirtyAttachment

																					ChapterConst = var_4_10004

																					local var_110_3 = var_110_0(var_110_1, var_110_2, var_4_10004.DirtyChampionPosition)

																					getProxy = var_4_10001
																					ChapterProxy = var_110_2

																					local var_110_4 = var_4_10001(var_110_2)

																					var_1.updateChapter(var_110_4, var_87_3, var_110_3)

																					var_87_3 = arg_85_0.contextData.chapterVO

																					arg_108_0()

																					return
																				end)

																				return
																			end,
																			function(arg_111_0)
																				if not var_85_3.teleportPaths then
																					arg_111_0()

																					return
																				end

																				local var_111_0 = var_85_3.teleportPaths[1]
																				local var_111_1 = var_85_3.teleportPaths[2]

																				if not var_111_0 or not var_111_1 then
																					arg_111_0()

																					return
																				end

																				_ = var_3_10003

																				local var_111_2 = var_3_10003.detect(var_87_3.fleets, function(arg_112_0)
																					return arg_112_0.id == var_85_3.id
																				end)

																				Clone = var_3_10004
																				var_111_2.startPos = var_3_10004(var_85_3.teleportPaths[2])
																				Clone = var_4
																				var_111_2.line = var_4(var_85_3.teleportPaths[2])

																				local var_111_3 = arg_85_0
																				local var_111_4 = var_4.getViewComponent(var_111_3).grid
																				local var_111_5 = var_4.GetCellFleet(var_111_4, var_111_2.id)
																				local var_111_6 = arg_85_0
																				local var_111_7 = var_5.getViewComponent(var_111_6).grid

																				var_5.TeleportFleetByPortal(var_111_7, var_111_5, var_85_3.teleportPaths, function()
																					bit = var_4_10000

																					local var_113_0 = var_4_10000.bor

																					ChapterConst = var_4_10002

																					local var_113_1 = var_4_10002.DirtyFleet

																					ChapterConst = var_4_10003

																					local var_113_2 = var_4_10003.DirtyAttachment

																					ChapterConst = var_4_10004

																					local var_113_3 = var_113_0(var_113_1, var_113_2, var_4_10004.DirtyChampionPosition)

																					getProxy = var_4_10001
																					ChapterProxy = var_113_2

																					local var_113_4 = var_4_10001(var_113_2)

																					var_1.updateChapter(var_113_4, var_87_3, var_113_3)

																					var_87_3 = arg_85_0.contextData.chapterVO

																					arg_111_0()

																					return
																				end)

																				return
																			end,
																			function(arg_114_0)
																				local var_114_0 = arg_85_0.viewComponent.levelStageView

																				var_1.SwitchBottomStagePanel(var_114_0, false)

																				local var_114_1 = arg_85_0.viewComponent.grid

																				var_1.TurnOffSubTeleport(var_114_1)

																				local var_114_2 = arg_85_0.viewComponent.grid
																				local var_114_3 = var_1.updateQuadCells

																				ChapterConst = var_4

																				var_114_3(var_114_2, var_4.QuadStateNormal)

																				return
																			end
																		})
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end

					return
				end
			end)

			var_85_14()

			goto label_85_0
		end

		ChapterProxy = var_85_13

		if var_85_1 == var_85_13.CHAPTER_TIMESUP then
			var_1_10006 = arg_85_0

			arg_85_0.onTimeUp(var_1_10006)

			goto label_85_0
		end

		GAME = var_4

		if var_85_1 == var_4.EVENT_LIST_UPDATE then
			var_1_10006 = arg_85_0.viewComponent

			var_4.addbubbleMsgBox(var_1_10006, function(arg_115_0)
				local var_115_0 = arg_85_0

				var_1.OnEventUpdate(var_115_0, arg_115_0)

				return
			end)

			goto label_85_0
		end

		GAME = var_4

		if var_85_1 == var_4.VOTE_BOOK_BE_UPDATED_DONE then
			var_1_10006 = arg_85_0.viewComponent

			var_4.addbubbleMsgBox(var_1_10006, function(arg_116_0)
				local var_116_0 = arg_85_0

				var_1.NoticeVoteBook(var_116_0, arg_116_0)

				return
			end)

			goto label_85_0
		end

		DailyLevelProxy = var_4

		local var_85_15

		if var_85_1 == var_4.ELITE_QUOTA_UPDATE then
			getProxy = var_85_15
			DailyLevelProxy = var_1_10006
			var_85_15 = var_85_15(var_1_10006)
			var_1_10007 = arg_85_0.viewComponent

			local var_85_16 = var_5.setEliteQuota

			iter_85_0 = var_85_15.eliteCount
			pg = iter_85_1

			var_85_16(var_1_10007, iter_85_0, iter_85_1.gameset.elite_quota.key_value)

			goto label_85_0
		end

		ActivityProxy = var_85_15

		if var_85_1 == var_85_15.ACTIVITY_OPERATION_DONE then
			var_1_10006 = arg_85_0.viewComponent.mapBuilder

			var_4.UpdateMapItems(var_1_10006)

			goto label_85_0
		end

		ActivityProxy = var_4

		if var_85_1 == var_4.ACTIVITY_UPDATED then
			if var_85_3 and arg_85_0.viewComponent.ptActivity and var_85_3.id == arg_85_0.viewComponent.ptActivity.id then
				var_1_10006 = arg_85_0.viewComponent

				var_4.updatePtActivity(var_1_10006, var_85_3)
			end

			goto label_85_0
		end

		GAME = var_4

		local var_85_17

		if var_85_1 == var_4.GET_REMASTER_TICKETS_DONE then
			var_1_10006 = arg_85_0.viewComponent
			var_85_17 = var_85_17.emit
			BaseUI = var_1_10007

			var_85_17(var_1_10006, var_1_10007.ON_ACHIEVE, var_85_3, function()
				local var_117_0 = arg_85_0.viewComponent

				var_0.updateRemasterTicket(var_117_0)

				return
			end)

			goto label_85_0
		end

		GAME = var_85_17

		local var_85_18

		if var_85_1 == var_85_17.ACTIVITY_PERMANENT_START_DONE then
			var_85_18 = var_85_3 and var_85_3.id

			if var_85_18 ~= arg_85_0.bossRushRemasterActivityId then
				return
			end

			getProxy = var_5
			ActivityPermanentProxy = var_1_10007
			var_1_10007 = var_5(var_1_10007)

			local var_85_19 = var_5.IsActivityIdByType

			iter_85_0 = var_85_18
			ActivityPermanentProxy = iter_85_1

			if not var_85_19(var_1_10007, iter_85_0, iter_85_1.TYPE_REMASTER_ACTIVITY) then
				return
			end

			arg_85_0.bossRushRemasterActivityId = nil
			var_1_10007 = arg_85_0

			local var_85_20 = arg_85_0.sendNotification

			GAME = iter_85_0
			iter_85_0 = iter_85_0.GO_SCENE
			SCENE = var_9

			var_85_20(var_1_10007, iter_85_0, var_9.BOSSRUSH_REMASTER, {
				id = var_85_18
			})

			goto label_85_0
		end

		CommanderProxy = var_85_18

		local var_85_21

		if var_85_1 == var_85_18.PREFAB_FLEET_UPDATE then
			getProxy = var_85_21
			CommanderProxy = var_1_10006
			var_1_10006 = var_85_21(var_1_10006)
			var_85_21 = var_85_21.getPrefabFleet(var_1_10006)
			var_1_10007 = arg_85_0.viewComponent

			var_5.setCommanderPrefabs(var_1_10007, var_85_21)

			var_1_10007 = arg_85_0.viewComponent

			var_5.updateCommanderPrefab(var_1_10007)

			goto label_85_0
		end

		GAME = var_85_21

		if var_85_1 == var_85_21.COOMMANDER_EQUIP_TO_FLEET_DONE then
			getProxy = var_4
			FleetProxy = var_1_10006
			var_1_10007 = var_4(var_1_10006)

			local var_85_22 = var_4.GetRegularFleets(var_1_10007)

			iter_85_0 = arg_85_0.viewComponent

			var_1_10006.updateFleet(iter_85_0, var_85_22)

			iter_85_0 = arg_85_0.viewComponent

			var_1_10006.RefreshFleetSelectView(iter_85_0)

			goto label_85_0
		end

		GAME = var_4

		local var_85_23

		if var_85_1 == var_4.SUBMIT_TASK_DONE then
			if arg_85_0.contextData.map then
				var_1_10006 = arg_85_0.contextData.map

				if var_85_23.isSkirmish(var_1_10006) then
					var_1_10006 = arg_85_0.viewComponent.mapBuilder

					var_85_23.UpdateMapItems(var_1_10006)
				end
			end

			var_1_10006 = arg_85_0.viewComponent
			var_85_23 = var_85_23.emit
			BaseUI = var_1_10007

			var_85_23(var_1_10006, var_1_10007.ON_ACHIEVE, var_85_3, function()
				if arg_85_0.contextData.map then
					local var_118_0 = arg_85_0.contextData.map

					if var_0.isSkirmish(var_118_0) and arg_85_0.contextData.TaskToSubmit then
						local var_118_1 = arg_85_0.contextData.TaskToSubmit

						arg_85_0.contextData.TaskToSubmit = nil

						local var_118_2 = arg_85_0
						local var_118_3 = var_1.sendNotification

						GAME = var_2_10004

						var_118_3(var_118_2, var_2_10004.SUBMIT_TASK, var_118_1)
					end
				end

				local var_118_4 = arg_85_0.viewComponent.mapBuilder

				var_0.OnSubmitTaskDone(var_118_4)

				return
			end)

			goto label_85_0
		end

		GAME = var_85_23

		local var_85_24

		if var_85_1 == var_85_23.SUBMIT_ACTIVITY_TASK_DONE then
			var_1_10006 = arg_85_0.viewComponent
			var_85_24 = var_85_24.emit
			BaseUI = var_1_10007

			var_85_24(var_1_10006, var_1_10007.ON_ACHIEVE, var_85_3.awards, function()
				local var_119_0 = arg_85_0.viewComponent.mapBuilder

				var_0.OnSubmitTaskDone(var_119_0)

				return
			end)

			goto label_85_0
		end

		BagProxy = var_85_24

		if var_85_1 == var_85_24.ITEM_UPDATED then
			getProxy = var_4
			BagProxy = var_1_10006
			var_1_10007 = var_4(var_1_10006)

			local var_85_25 = var_4.getItemsByType

			Item = iter_85_0

			local var_85_26 = var_85_25(var_1_10007, iter_85_0.SPECIAL_OPERATION_TICKET)

			iter_85_0 = arg_85_0.viewComponent

			var_6.setSpecialOperationTickets(iter_85_0, var_85_26)

			goto label_85_0
		end

		ChapterProxy = var_4

		if var_85_1 == var_4.CHAPTER_AUTO_FIGHT_FLAG_UPDATED then
			if not arg_85_0:getViewComponent().levelStageView then
				return
			end

			local var_85_27 = arg_85_0:getViewComponent().levelStageView

			var_4.ActionInvoke(var_85_27, "UpdateAutoFightMark")

			goto label_85_0
		end

		ChapterProxy = var_4

		if var_85_1 == var_4.CHAPTER_SKIP_PRECOMBAT_UPDATED then
			if not arg_85_0:getViewComponent().levelStageView then
				return
			end

			local var_85_28 = arg_85_0:getViewComponent().levelStageView

			var_4.ActionInvoke(var_85_28, "UpdateSkipPreCombatMark")

			goto label_85_0
		end

		ChapterProxy = var_4

		if var_85_1 ~= var_4.CHAPTER_REMASTER_INFO_UPDATED then
			GAME = var_4

			if var_85_1 == var_4.CHAPTER_REMASTER_INFO_REQUEST_DONE then
				local var_85_29 = arg_85_0.viewComponent

				var_4.updateRemasterInfo(var_85_29)

				local var_85_30 = arg_85_0.viewComponent

				var_4.updateRemasterBtnTip(var_85_30)
			else
				GAME = var_4

				local var_85_32

				if var_85_1 == var_4.CHAPTER_REMASTER_AWARD_RECEIVE_DONE then
					local var_85_31 = arg_85_0.viewComponent

					var_85_32 = var_85_32.emit
					BaseUI = var_1_10007

					var_85_32(var_85_31, var_1_10007.ON_ACHIEVE, var_85_3)
				else
					GAME = var_85_32

					if var_85_1 == var_85_32.STORY_UPDATE_DONE then
						arg_85_0.cachedStoryAwards = var_85_3

						local var_85_33 = arg_85_0.viewComponent.mapBuilder

						var_4.UpdateView(var_85_33)
					else
						GAME = var_4

						local var_85_35

						if var_85_1 == var_4.STORY_END then
							if arg_85_0.cachedStoryAwards then
								local var_85_34 = arg_85_0.viewComponent

								var_85_35 = var_85_35.emit
								BaseUI = var_1_10007

								var_85_35(var_85_34, var_1_10007.ON_ACHIEVE, arg_85_0.cachedStoryAwards.awards)

								arg_85_0.cachedStoryAwards = nil
							end
						else
							LevelUIConst = var_85_35

							local var_85_37

							if var_85_1 == var_85_35.CONTINUOUS_OPERATION then
								local var_85_36 = arg_85_0.viewComponent

								var_85_37 = var_85_37.emit
								LevelUIConst = var_1_10007

								var_85_37(var_85_36, var_1_10007.CONTINUOUS_OPERATION, var_85_3)
							else
								GAME = var_85_37

								if var_85_1 == var_85_37.TRACKING_ERROR then
									if arg_85_0.waitingTracking then
										local var_85_38 = arg_85_0
										local var_85_39 = arg_85_0.DisplayContinuousOperationResult
										local var_85_40 = var_85_3.chapter

										getProxy = iter_85_0
										ChapterProxy = var_1_10010

										local var_85_41 = iter_85_0(var_1_10010)
										local var_85_42 = var_8.PopContinuousData

										SYSTEM_SCENARIO = var_1_10011

										var_85_39(var_85_38, var_85_40, var_85_42(var_85_41, var_1_10011))
									end

									arg_85_0.waitingTracking = nil
								elseif var_85_1 == var_0_1.ON_SPITEM_CHANGED then
									local var_85_43 = arg_85_0.viewComponent

									var_4.emit(var_85_43, var_0_1.ON_SPITEM_CHANGED, var_85_3)
								end
							end
						end
					end
				end
			end

			::label_85_0::

			return
		end
	end
end

function var_0_1.OnExitChapter(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	assert = var_1_10004

	var_1_10004(arg_120_1)

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_121_0)
			if not arg_120_0.contextData.chapterVO then
				return arg_121_0()
			end

			local var_121_0 = arg_120_0.viewComponent

			var_1.switchToMap(var_121_0, arg_121_0)

			return
		end,
		function(arg_122_0)
			local var_122_0 = arg_120_0.viewComponent

			var_1.addbubbleMsgBox(var_122_0, function()
				local var_123_0 = arg_120_0.viewComponent

				var_0.CleanBubbleMsgbox(var_123_0)
				arg_122_0()

				return
			end)

			return
		end,
		function(arg_124_0)
			if not arg_120_2 then
				return arg_124_0()
			end

			getProxy = var_1
			PlayerProxy = var_2_10003

			local var_124_0 = var_1(var_2_10003)
			local var_124_1 = var_1.getData(var_124_0)

			if arg_120_1.id == 103 then
				local var_124_2 = var_124_1
				local var_124_3 = var_124_1.GetCommonFlag

				BATTLE_AUTO_ENABLED = var_2_10005

				if not var_124_3(var_124_2, var_2_10005) then
					local var_124_4 = arg_120_0.viewComponent
					local var_124_5 = var_2.HandleShowMsgBox
					local var_124_6 = {
						modal = true,
						hideNo = true
					}

					i18n = var_2_10006
					var_124_6.content = var_2_10006("battle_autobot_unlock")
					var_124_6.onYes = arg_124_0
					var_124_6.onNo = arg_124_0

					var_124_5(var_124_4, var_124_6)

					local var_124_7 = arg_120_0.viewComponent
					local var_124_8 = var_2.emit

					LevelMediator2 = var_124_6

					var_124_8(var_124_7, var_124_6.NOTICE_AUTOBOT_ENABLED, {})

					return
				end
			end

			arg_124_0()

			return
		end,
		function(arg_125_0)
			if not arg_120_2 then
				return arg_125_0()
			end

			getProxy = var_1
			ChapterProxy = var_2_10003

			local var_125_0 = var_1(var_2_10003)
			local var_125_1 = var_1.getMapById
			local var_125_2 = arg_120_1
			local var_125_3 = var_125_1(var_125_0, var_4.getConfig(var_125_2, "map"))

			if var_1.isSkirmish(var_125_3) then
				local var_125_4 = arg_120_1.id

				getProxy = var_125_0
				SkirmishProxy = var_2_10005

				local var_125_5 = var_125_0(var_2_10005)
				local var_125_6 = var_3.getRawData(var_125_5)

				_ = var_2_10005

				if not var_2_10005.detect(var_125_6, function(arg_126_0)
					tonumber = var_3_10001

					return var_3_10001(arg_126_0:getConfig("event")) == var_125_4
				end) then
					arg_125_0()

					return
				end

				getProxy = var_125_5
				TaskProxy = var_8

				local var_125_7 = var_125_5(var_8)
				local var_125_8 = var_5:getConfig("task_id")
				local var_125_9 = var_125_7

				if var_125_7.getTaskVO(var_125_9, var_125_8) and var_8:getTaskStatus() == 1 then
					local var_125_10 = arg_120_0
					local var_125_11 = var_9.sendNotification

					GAME = var_2_10012

					var_125_11(var_125_10, var_2_10012.SUBMIT_TASK, var_125_8)

					if var_5 == var_125_6[#var_125_6] then
						getProxy = var_9
						ActivityProxy = var_125_10

						local var_125_12 = var_9(var_125_10)

						ActivityConst = var_125_9

						local var_125_13 = var_125_9.ACTIVITY_ID_US_SKIRMISH_RE
						local var_125_14 = var_125_12:getActivityById(var_125_13)

						assert = var_12

						var_12(var_125_14, "Missing Skirmish Activity " .. (var_125_13 or "NIL"))

						local var_125_15 = var_12[#var_125_14:getConfig("config_data")][2]

						if var_125_7:getTaskVO(var_125_15) and var_14:getTaskStatus() < 2 then
							arg_120_0.contextData.TaskToSubmit = var_125_15
						end
					end
				end
			end

			arg_125_0()

			return
		end,
		function(arg_127_0)
			if not arg_120_2 then
				return arg_127_0()
			end

			getProxy = var_1
			ChapterProxy = var_2_10003

			local var_127_0 = var_1(var_2_10003)
			local var_127_1 = var_1.getMapById
			local var_127_2 = arg_120_1
			local var_127_3 = var_127_1(var_127_0, var_5.getConfig(var_127_2, "map"))

			if var_2.isRemaster(var_127_3) then
				local var_127_4 = var_2
				local var_127_5 = var_2.getRemaster(var_127_4)

				pg = var_127_0

				local var_127_6 = var_127_0.re_map_template[var_127_5]

				Map = var_127_4

				local var_127_7 = var_127_4.GetRearChaptersOfRemaster(var_127_5)

				assert = var_2_10006

				var_2_10006(var_127_7)

				_ = var_2_10006

				if var_2_10006.any(var_127_7, function(arg_128_0)
					return arg_128_0 == arg_120_1.id
				end) then
					local var_127_8 = var_127_6.memory_group

					BossRushChapterRemasterHelper = var_7

					if var_7.UnlockMemoryGroupStoriesAndShowMsgBox(var_127_8, arg_127_0) then
						return
					end
				end
			end

			arg_127_0()

			return
		end,
		function(arg_129_0)
			if arg_120_0.contextData.map then
				local var_129_0 = arg_120_0.contextData.map

				if not var_1.isUnlock(var_129_0) then
					local var_129_1 = arg_120_0.viewComponent

					var_1.emit(var_129_1, var_0_1.ON_SWITCH_NORMAL_MAP)

					return
				end
			end

			if not arg_120_3 then
				return arg_129_0()
			end

			local var_129_2

			if arg_120_3 then
				var_129_2 = arg_120_3.AutoFightFlag
			end

			local var_129_3 = {}

			if arg_120_3 and arg_120_3.ResultDrops then
				ipairs = var_3

				for iter_129_0, iter_129_2 in var_3(arg_120_3.ResultDrops) do
					table = iter_129_3
					var_129_3 = iter_129_3.mergeArray(var_129_3, iter_129_2)
				end
			end

			local var_129_4 = {}

			if arg_120_3 and arg_120_3.TotalDrops then
				ipairs = var_4

				for iter_129_2, iter_129_3 in var_4(arg_120_3.TotalDrops) do
					table = var_2_10009
					var_129_4 = var_2_10009.mergeArray(var_129_4, iter_129_3)
				end
			end

			DropResultIntegration = var_4

			var_4(var_129_4)

			getProxy = var_4
			ChapterProxy = var_6

			local var_129_5 = var_4(var_6)
			local var_129_6 = var_4.GetContinuousData

			SYSTEM_SCENARIO = iter_129_2

			if var_129_6(var_129_5, iter_129_2) then
				var_4:MergeDrops(var_129_4, var_129_3)
				var_4:MergeEvents(arg_120_3.ListEventNotify, arg_120_3.ListGuildEventNotify, arg_120_3.ListGuildEventAutoReceiveNotify)

				if arg_120_2 then
					var_4:ConsumeBattleTime()
				end

				local var_129_7 = var_4
				local var_129_8

				if var_4.IsActive(var_129_7) then
					var_129_7 = var_4

					if var_4.GetRestBattleTime(var_129_7) > 0 then
						var_129_8 = arg_120_0
						var_129_8.waitingTracking = true
						var_129_7 = arg_120_0.viewComponent

						var_129_8.emit(var_129_7, var_0_1.ON_RETRACKING, arg_120_1, var_129_2)

						return
					end
				end

				getProxy = var_129_8
				ChapterProxy = var_129_7

				local var_129_9 = var_129_8(var_129_7)
				local var_129_10 = var_5.PopContinuousData

				SYSTEM_SCENARIO = iter_129_3

				var_129_10(var_129_9, iter_129_3)

				local var_129_11 = arg_120_0

				var_5.DisplayContinuousOperationResult(var_129_11, arg_120_1, var_4)
				arg_129_0()

				return
			end

			if not (var_129_2 ~= nil) and not arg_120_3.ResultDrops then
				return arg_129_0()
			end

			local var_129_12
			local var_129_13

			if var_5 then
				i18n = iter_129_3
				var_129_12 = iter_129_3("autofight_rewards")
				i18n = iter_129_3
				var_129_13 = iter_129_3("total_rewards_subtitle")
			else
				i18n = iter_129_3
				var_129_12 = iter_129_3("settle_rewards_title")
				i18n = var_8
				var_129_13 = var_8("settle_rewards_subtitle")
			end

			local var_129_14 = arg_120_0
			local var_129_15 = var_8.addSubLayers

			Context = var_2_10011

			local var_129_16 = var_2_10011.New
			local var_129_17 = {}

			LevelStageTotalRewardPanel = var_2_10014
			var_129_17.viewComponent = var_2_10014
			LevelStageTotalRewardPanelMediator = var_2_10014
			var_129_17.mediator = var_2_10014
			var_129_17.data = {
				title = var_129_12,
				subTitle = var_129_13,
				chapter = arg_120_1,
				onClose = arg_129_0,
				rewards = var_129_4,
				resultRewards = var_129_3,
				events = arg_120_3.ListEventNotify,
				guildTasks = arg_120_3.ListGuildEventNotify,
				guildAutoReceives = arg_120_3.ListGuildEventAutoReceiveNotify,
				isAutoFight = var_129_2
			}

			var_129_15(var_129_14, var_129_16(var_129_17), true)

			return
		end,
		function(arg_130_0)
			Map = var_2_10001

			if var_2_10001.autoNextPage then
				Map = var_1
				var_1.autoNextPage = nil
				triggerButton = var_1

				var_1(arg_120_0.viewComponent.btnNext)
			end

			if arg_120_2 then
				local var_130_0 = arg_120_0.viewComponent

				var_1.RefreshMapBG(var_130_0)
			end

			local var_130_1 = arg_120_0

			var_1.TryPlaySubGuide(var_130_1)

			return
		end
	})

	return
end

function var_0_1.DisplayContinuousWindow(arg_131_0, arg_131_1, arg_131_2, arg_131_3, arg_131_4)
	local var_131_0 = arg_131_1:getConfig("oil")

	if arg_131_1:IsSupportSubmarineStage() and #arg_131_1:getSupportFleet() > 0 then
		getGameset = var_6
		var_131_0 = var_131_0 + var_6("submarine_support_oil_consume")[1]
	end

	local var_131_1 = arg_131_1:getPlayType()
	local var_131_2 = 0
	local var_131_3 = 0

	ChapterConst = var_1_10009

	if var_131_1 == var_1_10009.TypeMultiStageBoss then
		pg = var_9

		local var_131_4 = var_9.chapter_model_multistageboss[arg_131_1.id]

		_ = var_1_10010
		var_131_2 = var_1_10010.reduce(var_131_4.boss_refresh, 0, function(arg_132_0, arg_132_1)
			return arg_132_0 + arg_132_1
		end)
		var_131_3 = #var_131_4.boss_refresh
	else
		var_131_2, var_131_3 = arg_131_1:getConfig("boss_refresh"), 1
	end

	local var_131_5 = arg_131_1:getConfig("use_oil_limit")

	table = var_1_10010

	var_1_10010.Foreach(arg_131_2, function(arg_133_0, arg_133_1)
		local var_133_0 = arg_131_4[arg_133_0]

		ChapterFleet = var_2_10003

		if var_133_0 == var_2_10003.DUTY_IDLE then
			return
		end

		local var_133_1 = arg_133_1:GetCostSum().oil

		ChapterFleet = var_2_10004

		local var_133_2

		if var_133_0 == var_2_10004.DUTY_KILLALL then
			if not var_131_5[1] then
				var_133_2 = 0
			end

			local var_133_3 = var_133_1

			if 0 < var_133_2 then
				math = var_6
				var_133_3 = var_6.min(var_133_3, var_133_2)
			end

			local var_133_4

			if not var_131_5[2] then
				var_133_4 = 0
			end

			local var_133_5 = var_133_1

			if 0 < var_133_4 then
				math = var_8
				var_133_5 = var_8.min(var_133_5, var_133_4)
			end

			var_131_0 = var_131_0 + var_133_3 * var_131_2 + var_133_5 * var_131_3
		else
			ChapterFleet = var_133_2

			local var_133_6

			if var_133_0 == var_133_2.DUTY_CLEANPATH then
				if not var_131_5[1] then
					var_133_6 = 0
				end

				local var_133_7 = var_133_1

				if 0 < var_133_6 then
					math = var_6
					var_133_7 = var_6.min(var_133_7, var_133_6)
				end

				var_131_0 = var_131_0 + var_133_7 * var_131_2
			else
				ChapterFleet = var_133_6

				if var_133_0 == var_133_6.DUTY_KILLBOSS then
					local var_133_8

					if not var_131_5[2] then
						var_133_8 = 0
					end

					local var_133_9 = var_133_1

					if 0 < var_133_8 then
						math = var_6
						var_133_9 = var_6.min(var_133_9, var_133_8)
					end

					var_131_0 = var_131_0 + var_133_9 * var_131_3
				end
			end
		end

		return
	end)

	local var_131_6 = arg_131_1:GetMaxBattleCount()
	local var_131_7 = arg_131_3 and arg_131_3 > 0
	local var_131_8

	if not arg_131_1:GetSpItems()[1] or not var_12[1].count then
		var_131_8 = 0
	end

	local var_131_9

	if not var_12[1] or not var_12[1].id then
		var_131_9 = 0
	end

	local var_131_10 = arg_131_1:GetRestDailyBonus()
	local var_131_11 = arg_131_0
	local var_131_12 = arg_131_0.addSubLayers

	Context = var_1_10019

	local var_131_13 = var_1_10019.New
	local var_131_14 = {}

	LevelContinuousOperationWindowMediator = var_1_10022
	var_131_14.mediator = var_1_10022
	LevelContinuousOperationWindow = var_1_10022
	var_131_14.viewComponent = var_1_10022
	var_131_14.data = {
		maxCount = var_131_6,
		oilCost = var_131_0,
		chapter = arg_131_1,
		extraRate = {
			rate = 2,
			enabled = var_131_7,
			extraCount = var_131_8,
			spItemId = var_131_9,
			freeBonus = var_131_10
		}
	}

	var_131_12(var_131_11, var_131_13(var_131_14))

	return
end

function var_0_1.DisplayContinuousOperationResult(arg_134_0, arg_134_1, arg_134_2)
	i18n = var_1_10003

	local var_134_0 = var_1_10003("autofight_rewards")

	i18n = var_1_10004

	local var_134_1 = var_1_10004("total_rewards_subtitle")
	local var_134_2 = arg_134_0
	local var_134_3 = arg_134_0.addSubLayers

	Context = var_1_10008

	local var_134_4 = var_1_10008.New
	local var_134_5 = {}

	LevelContinuousOperationTotalRewardPanel = var_1_10011
	var_134_5.viewComponent = var_1_10011
	LevelStageTotalRewardPanelMediator = var_1_10011
	var_134_5.mediator = var_1_10011
	var_134_5.data = {
		title = var_134_0,
		subTitle = var_134_1,
		chapter = arg_134_1,
		rewards = arg_134_2:GetDrops(),
		resultRewards = arg_134_2:GetSettlementDrops(),
		continuousData = arg_134_2,
		events = arg_134_2:GetEvents(1),
		guildTasks = arg_134_2:GetEvents(2),
		guildAutoReceives = arg_134_2:GetEvents(3)
	}

	var_134_3(var_134_2, var_134_4(var_134_5), true)

	return
end

function var_0_1.OnEventUpdate(arg_135_0, arg_135_1)
	getProxy = var_1_10002
	EventProxy = var_1_10004

	local var_135_0 = var_1_10002(var_1_10004)
	local var_135_1 = arg_135_0.viewComponent

	var_3.updateEvent(var_135_1, var_135_0)

	pg = var_3

	local var_135_2 = var_3.SystemOpenMgr.GetInstance()

	if var_3.isOpenSystem(var_135_2, arg_135_0.player.level, "EventMediator") and var_135_0.eventForMsg then
		if not var_135_0.eventForMsg.id then
			var_1_10004 = 0
		end

		getProxy = var_135_2
		ChapterProxy = var_7

		local var_135_3 = var_135_2(var_7)

		if var_5.getActiveChapter(var_135_3, true) then
			local var_135_4 = var_5

			if var_5.IsAutoFight(var_135_4) then
				getProxy = var_6
				ChapterProxy = var_135_4

				local var_135_5 = var_6(var_135_4)

				var_6.AddExtendChapterDataArray(var_135_5, var_5.id, "ListEventNotify", var_1_10004)

				existCall = var_6

				var_6(arg_135_1)

				goto label_135_0
			end
		end

		pg = var_6

		if var_6.collection_template[var_1_10004] then
			pg = var_6

			do
				local var_135_6

				if not var_6.collection_template[var_1_10004].title then
					var_135_6 = ""
				end

				pg = var_135_3

				local var_135_7 = var_135_3.MsgboxMgr.GetInstance()
				local var_135_8 = var_7.ShowMsgBox
				local var_135_9 = {
					modal = false,
					hideNo = true
				}

				i18n = var_1_10011
				var_135_9.content = var_1_10011("event_special_update", var_135_6)
				var_135_9.onYes = arg_135_1
				var_135_9.onNo = arg_135_1

				var_135_8(var_135_7, var_135_9)
			end

			::label_135_0::

			var_135_0.eventForMsg = nil

			if false then
				existCall = var_1_10004

				var_1_10004(arg_135_1)
			end

			return
		end
	end
end

function var_0_1.onTimeUp(arg_136_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_136_0 = var_1_10001(var_1_10003)

	if var_1.getActiveChapter(var_136_0) and not var_2:inWartime() then
		local function var_136_1()
			local var_137_0 = arg_136_0
			local var_137_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_137_2 = var_2_10003.CHAPTER_OP
			local var_137_3 = {}

			ChapterConst = var_2_10005
			var_137_3.type = var_2_10005.OpRetreat

			var_137_1(var_137_0, var_137_2, var_137_3)

			return
		end

		if arg_136_0.contextData.chapterVO then
			pg = var_4

			local var_136_2 = var_4.MsgboxMgr.GetInstance()
			local var_136_3 = var_4.ShowMsgBox

			var_1_10007 = {
				modal = true,
				hideNo = true
			}
			i18n = var_1_10008
			var_1_10007.content = var_1_10008("battle_preCombatMediator_timeout")
			var_1_10007.onYes = var_136_1
			var_1_10007.onNo = var_136_1

			var_136_3(var_136_2, var_1_10007)
		else
			var_136_1()

			pg = var_4

			local var_136_4 = var_4.TipsMgr.GetInstance()
			local var_136_5 = var_4.ShowTips

			i18n = var_1_10007

			var_136_5(var_136_4, var_1_10007("levelScene_chapter_timeout"))
		end
	end

	return
end

function var_0_1.getDockCallbackFuncs(arg_138_0, arg_138_1, arg_138_2, arg_138_3, arg_138_4)
	getProxy = var_1_10005
	ChapterProxy = var_1_10007

	local var_138_0 = var_1_10005(var_1_10007)

	local function var_138_1(arg_139_0, arg_139_1)
		ShipStatus = var_2_10002

		local var_139_0 = var_2_10002.ShipStatusCheck
		local var_139_1 = "inElite"
		local var_139_2 = arg_139_0
		local var_139_3 = arg_139_1
		local var_139_4 = {}
		local var_139_5 = arg_138_3

		var_139_4.inElite = var_8.getConfig(var_139_5, "formation")

		local var_139_6, var_139_7 = var_139_0(var_139_1, var_139_2, var_139_3, var_139_4)

		if not var_139_6 then
			return var_139_6, var_139_7
		end

		pairs = var_139_1

		for iter_139_0, iter_139_1 in var_139_1(arg_138_1) do
			if arg_139_0:isSameKind(iter_139_0) then
				local var_139_8 = false

				i18n = var_139_5
				var_139_5 = var_139_5("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_138_2(arg_140_0, arg_140_1, arg_140_2)
		arg_140_1()

		return
	end

	local function var_138_3(arg_141_0)
		local var_141_0 = arg_138_3
		local var_141_1 = var_1.getEliteFleetList(var_141_0)[arg_138_4]
		local var_141_2

		if arg_138_2 then
			table = var_141_2
			var_141_2 = var_141_2.indexof(var_141_1, arg_138_2.id)
			assert = var_141_0

			var_141_0(var_141_2)

			if arg_141_0[1] then
				var_141_1[var_141_2] = arg_141_0[1]
			else
				table = var_3

				var_3.remove(var_141_1, var_141_2)
			end
		else
			table = var_141_2

			var_141_2.insert(var_141_1, arg_141_0[1])
		end

		local var_141_3 = arg_138_3
		local var_141_4 = var_2.setEliteFleetByIndex
		local var_141_5 = arg_138_4
		local var_141_6 = {}
		local var_141_7 = {}

		TeamType = var_2_10008
		var_141_7[1] = var_2_10008.FormShips
		var_141_7[2] = var_141_1
		var_141_6[1] = var_141_7

		var_141_4(var_141_3, var_141_5, var_141_6)

		local var_141_8 = var_138_0

		var_2.updateChapter(var_141_8, arg_138_3)

		local var_141_9 = var_138_0

		var_2.duplicateEliteFleet(var_141_9, arg_138_3)

		return
	end

	return var_138_1, var_138_2, var_138_3
end

function var_0_1.getSupportDockCallbackFuncs(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
	getProxy = var_1_10004
	ChapterProxy = var_1_10006

	local var_142_0 = var_1_10004(var_1_10006)

	local function var_142_1(arg_143_0, arg_143_1)
		ShipStatus = var_2_10002

		local var_143_0, var_143_1 = var_2_10002.ShipStatusCheck("inSupport", arg_143_0, arg_143_1)

		if not var_143_0 then
			return var_143_0, var_143_1
		end

		pairs = var_4

		for iter_143_0, iter_143_1 in var_4(arg_142_1) do
			if arg_143_0:isSameKind(iter_143_0) then
				local var_143_2 = false

				i18n = var_2_10010
				var_2_10010 = var_2_10010("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_142_2(arg_144_0, arg_144_1, arg_144_2)
		arg_144_1()

		return
	end

	local function var_142_3(arg_145_0)
		local var_145_0 = arg_142_3
		local var_145_1 = var_1.getSupportFleet(var_145_0)
		local var_145_2

		if arg_142_2 then
			table = var_145_2
			var_145_2 = var_145_2.indexof(var_145_1, arg_142_2.id)
			assert = var_145_0

			var_145_0(var_145_2)

			if arg_145_0[1] then
				var_145_1[var_145_2] = arg_145_0[1]
			else
				table = var_3

				var_3.remove(var_145_1, var_145_2)
			end
		else
			table = var_145_2

			var_145_2.insert(var_145_1, arg_145_0[1])
		end

		local var_145_3 = arg_142_3
		local var_145_4 = var_2.setEliteFleetByIndex
		local var_145_5 = 4
		local var_145_6 = {}
		local var_145_7 = {}

		TeamType = var_2_10008
		var_145_7[1] = var_2_10008.FormShips
		var_145_7[2] = var_145_1
		var_145_6[1] = var_145_7

		var_145_4(var_145_3, var_145_5, var_145_6)

		local var_145_8 = var_142_0

		var_2.updateChapter(var_145_8, arg_142_3)

		local var_145_9 = var_142_0

		var_2.duplicateEliteFleet(var_145_9, arg_142_3)

		return
	end

	return var_142_1, var_142_2, var_142_3
end

function var_0_1.playAIActions(arg_146_0, arg_146_1, arg_146_2, arg_146_3)
	if not arg_146_0.viewComponent.grid then
		arg_146_3()

		return
	end

	getProxy = var_4
	ChapterProxy = var_1_10006

	local var_146_0 = var_4(var_1_10006)
	local var_146_1

	local function var_146_2()
		if var_146_1 then
			coroutine = var_0

			if var_0.status(var_146_1) == "suspended" then
				coroutine = var_0

				local var_147_0, var_147_1 = var_0.resume(var_146_1)

				assert = var_2

				local var_147_2 = var_147_0

				debug = var_2_10005

				var_2(var_147_2, var_2_10005.traceback(var_146_1, var_147_1))

				if not var_147_0 then
					local var_147_3 = arg_146_0.viewComponent

					var_2.unfrozen(var_147_3, -1)

					local var_147_4 = arg_146_0
					local var_147_5 = var_2.sendNotification

					GAME = var_5

					local var_147_6 = var_5.CHAPTER_OP
					local var_147_7 = {}

					ChapterConst = var_7
					var_147_7.type = var_7.OpRequest

					var_147_5(var_147_4, var_147_6, var_147_7)
				end
			end
		end

		return
	end

	coroutine = var_1_10007
	var_146_1 = var_1_10007.create(function()
		local var_148_0 = arg_146_0.viewComponent

		var_0.frozen(var_148_0)

		local var_148_1 = {}
		local var_148_2

		if not arg_146_2 then
			var_148_2 = 0
		end

		ipairs = var_148_0

		for iter_148_0, iter_148_1 in var_148_0(arg_146_1) do
			local var_148_3 = arg_146_0.contextData.chapterVO
			local var_148_4 = iter_148_1
			local var_148_5

			var_2_10008, var_148_5 = iter_148_1.applyTo(var_148_4, var_148_3, true)
			assert = var_148_4

			var_148_4(var_2_10008, var_148_5)
			iter_148_1:PlayAIAction(arg_146_0.contextData.chapterVO, arg_146_0, function()
				local var_149_0 = iter_148_1
				local var_149_1, var_149_2, var_149_3 = var_0.applyTo(var_149_0, var_148_3, false)

				if var_149_1 then
					local var_149_4 = var_146_0

					var_3.updateChapter(var_149_4, var_148_3, var_149_2)

					bit = var_3
					var_148_2 = var_3.bor(var_148_2, var_149_3 or 0)
				end

				onNextTick = var_3

				var_3(var_146_2)

				return
			end)

			coroutine = var_10

			var_10.yield()

			isa = var_10

			local var_148_6 = iter_148_1

			FleetAIAction = var_13

			if var_10(var_148_6, var_13) then
				local var_148_7 = iter_148_1.actType

				ChapterConst = var_11

				if var_148_7 == var_11.ActType_Poison then
					local var_148_8 = var_148_3
					local var_148_9 = var_148_3.existFleet

					FleetType = var_13

					if var_148_9(var_148_8, var_13.Normal, iter_148_1.line.row, iter_148_1.line.column) then
						local var_148_10 = var_148_3
						local var_148_11 = var_148_3.getFleetIndex

						FleetType = var_13

						local var_148_12 = var_148_11(var_148_10, var_13.Normal, iter_148_1.line.row, iter_148_1.line.column)

						table = var_11

						var_11.insert(var_148_1, var_148_12)
					end
				end
			end
		end

		bit = var_2

		local var_148_13 = var_2.band
		local var_148_14 = var_148_2

		ChapterConst = iter_148_0

		local var_148_15 = var_148_13(var_148_14, iter_148_0.DirtyAutoAction)

		bit = var_3

		local var_148_16 = var_3.band
		local var_148_17 = var_148_2

		bit = iter_148_1

		local var_148_18 = iter_148_1.bnot

		ChapterConst = var_2_10008

		local var_148_19

		if var_148_16(var_148_17, var_148_18(var_2_10008.DirtyAutoAction)) ~= 0 then
			var_148_19 = arg_146_0.contextData.chapterVO

			local var_148_20 = var_146_0

			var_4.updateChapter(var_148_20, var_148_19, var_148_2)
		end

		seriesAsync = var_148_19

		var_148_19({
			function(arg_150_0)
				if var_148_15 ~= 0 then
					local var_150_0 = arg_146_0.viewComponent.levelStageView

					var_1.tryAutoAction(var_150_0, arg_150_0)
				else
					arg_150_0()
				end

				return
			end,
			function(arg_151_0)
				table = var_3_10001

				var_3_10001.ParallelIpairsAsync(var_148_1, function(arg_152_0, arg_152_1, arg_152_2)
					local var_152_0 = arg_146_0.viewComponent.grid

					var_3.showFleetPoisonDamage(var_152_0, arg_152_1, arg_152_2)

					return
				end, arg_151_0)

				return
			end,
			function(arg_153_0)
				arg_146_3()

				local var_153_0 = arg_146_0.viewComponent

				var_1.unfrozen(var_153_0)

				return
			end
		})

		return
	end)

	var_146_2()

	return
end

function var_0_1.saveSubState(arg_154_0, arg_154_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_154_0 = var_1_10002(var_1_10004)
	local var_154_1 = var_2.getRawData(var_154_0).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("chapter_submarine_ai_type_" .. var_154_1, arg_154_1 + 1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.loadSubState(arg_155_0, arg_155_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_155_0 = var_1_10002(var_1_10004)
	local var_155_1 = var_2.getRawData(var_155_0).id

	PlayerPrefs = var_1_10003

	local var_155_2 = var_1_10003.GetInt("chapter_submarine_ai_type_" .. var_155_1, 1) - 1

	math = var_155_0

	if var_155_0.clamp(var_155_2, 0, 1) ~= arg_155_1 then
		local var_155_3 = arg_155_0.viewComponent
		local var_155_4 = var_4.emit

		LevelMediator2 = var_7

		local var_155_5 = var_7.ON_OP
		local var_155_6 = {}

		ChapterConst = var_1_10009
		var_155_6.type = var_1_10009.OpSubState
		var_155_6.arg1 = var_3

		var_155_4(var_155_3, var_155_5, var_155_6)
	end

	return
end

function var_0_1.remove(arg_156_0)
	local var_156_0 = arg_156_0
	local var_156_1 = arg_156_0.removeSubLayers

	LevelContinuousOperationWindowMediator = var_1_10004

	var_156_1(var_156_0, var_1_10004)
	var_0_1.super.remove(arg_156_0)

	return
end

return var_0_1
