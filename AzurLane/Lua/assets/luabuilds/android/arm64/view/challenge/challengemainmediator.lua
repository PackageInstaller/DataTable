class = var_0_10000

local var_0_0 = "ChallengeMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_COMMIT_FLEET = "ChallengeMainMediator:ON_COMMIT_FLEET"
var_0_1.ON_FLEET_SHIPINFO = "ChallengeMainMediator:ON_FLEET_SHIPINFO"
var_0_1.ON_PRECOMBAT = "ChallengeMainMediator:ON_PRECOMBAT"
var_0_1.ON_SELECT_ELITE_COMMANDER = "ChallengeMainMediator:ON_SELECT_ELITE_COMMANDER"
var_0_1.ON_OPEN_RANK = "ChallengeMainMediator:ON_OPEN_RANK"
var_0_1.COMMANDER_FORMATION_OP = "ChallengeMainMediator:COMMANDER_FORMATION_OP"
var_0_1.ON_COMMANDER_SKILL = "ChallengeMainMediator:ON_COMMANDER_SKILL"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_1_1 = var_1_10002(var_1_10004)

	getProxy = var_1_10003
	ChallengeProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_1_1
	local var_1_4 = var_1_1.getActivityByType

	ActivityConst = var_1_10007

	local var_1_5 = var_1_4(var_1_3, var_1_10007.ACTIVITY_TYPE_CHALLENGE)

	arg_1_0:bind(var_0_1.ON_OPEN_RANK, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.BILLBOARD
		local var_2_4 = {}

		PowerRank = var_2_10006
		var_2_4.page = var_2_10006.TYPE_CHALLENGE

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	ChallengeConst = var_8

	var_1_7(var_1_6, var_8.CLICK_GET_AWARD_BTN, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1)

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	ChallengeConst = var_8

	var_1_9(var_1_8, var_8.RESET_DATA_EVENT, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.CHALLENGE2_RESET, {
			mode = arg_4_1,
			isInfiniteSeasonClear = arg_4_2
		})

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	ActivityFleetPanel = var_8

	var_1_11(var_1_10, var_8.ON_OPEN_DOCK, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1.shipType
		local var_5_1 = arg_5_1.fleetIndex
		local var_5_2 = arg_5_1.shipVO
		local var_5_3 = arg_5_1.fleet
		local var_5_4 = arg_5_1.teamType

		getProxy = var_2_10007
		BayProxy = var_2_10009

		local var_5_5 = var_2_10007(var_2_10009)
		local var_5_6 = var_7.getRawData(var_5_5)

		arg_1_0.contextData.editFleet = true

		local var_5_7 = arg_1_0
		local var_5_8, var_5_9, var_5_10 = var_9.getDockCallbackFuncs(var_5_7, var_5_3, var_5_2, var_5_1, var_5_4)
		local var_5_11 = arg_1_0
		local var_5_12 = var_12.sendNotification

		GAME = var_15

		local var_5_13 = var_15.GO_SCENE

		SCENE = var_2_10016

		local var_5_14 = var_2_10016.DOCKYARD
		local var_5_15 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1
		}

		i18n = var_2_10018
		var_5_15.leastLimitMsg = var_2_10018("ship_formationMediator_leastLimit")
		var_5_15.quitTeam = var_5_2 ~= nil
		var_5_15.teamFilter = var_5_4
		i18n = var_18
		var_5_15.leftTopInfo = var_18("word_formation")
		var_5_15.onShip = var_5_8
		var_5_15.confirmSelect = var_5_9
		var_5_15.onSelected = var_5_10
		setmetatable = var_18

		local var_5_16 = {
			inActivity = var_1_5.id
		}
		local var_5_17 = {}

		ShipStatus = var_2_10022
		var_5_17.__index = var_2_10022.TAG_HIDE_CHALLENGE
		var_5_15.hideTagFlags = var_18(var_5_16, var_5_17)
		var_5_15.otherSelectedIds = var_5_3
		pg = var_18

		local var_5_18 = var_18.ShipFlagMgr.GetInstance()

		var_5_15.ignoredIds = var_18.FilterShips(var_5_18, {
			isActivityNpc = true
		})

		var_5_12(var_5_11, var_5_13, var_5_14, var_5_15)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMIT_FLEET, function()
		local var_6_0 = var_1_0

		var_0.commitActivityFleet(var_6_0, var_1_5.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_FLEET_SHIPINFO, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_7_1(var_7_0, var_7_2, var_2_10006.SHIPINFO, {
			shipId = arg_7_1.shipId,
			shipVOs = arg_7_1.shipVOs
		})

		arg_1_0.contextData.editFleet = true

		return
	end)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.bind

	ActivityFleetPanel = var_8

	var_1_13(var_1_12, var_8.ON_FLEET_RECOMMEND, function(arg_8_0, arg_8_1)
		local var_8_0 = var_1_0

		var_2.recommendActivityFleet(var_8_0, var_1_5.id, arg_8_1)

		local var_8_1 = var_1_0
		local var_8_2 = var_2.getActivityFleets(var_8_1)[var_1_5.id]
		local var_8_3 = arg_1_0.viewComponent

		var_4.setFleet(var_8_3, var_8_2)

		local var_8_4 = arg_1_0.viewComponent

		var_4.updateEditPanel(var_8_4)

		return
	end)

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.bind

	ActivityFleetPanel = var_8

	var_1_15(var_1_14, var_8.ON_FLEET_CLEAR, function(arg_9_0, arg_9_1)
		local var_9_0 = var_1_0
		local var_9_1 = var_2.getActivityFleets(var_9_0)[var_1_5.id][arg_9_1]

		var_3.clearFleet(var_9_1)

		local var_9_2 = var_1_0

		var_4.updateActivityFleet(var_9_2, var_1_5.id, arg_9_1, var_3)

		local var_9_3 = arg_1_0.viewComponent

		var_4.setFleet(var_9_3, var_2)

		local var_9_4 = arg_1_0.viewComponent

		var_4.updateEditPanel(var_9_4)

		return
	end)
	arg_1_0:bind(var_0_1.COMMANDER_FORMATION_OP, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.COMMANDER_FORMATION_OP, {
			data = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMANDER_SKILL, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_11_2 = var_2_10005.New
		local var_11_3 = {}

		CommanderSkillMediator = var_2_10008
		var_11_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_11_3.viewComponent = var_2_10008
		var_11_3.data = {
			skill = arg_11_1
		}

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_ELITE_COMMANDER, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = var_1_0
		local var_12_1 = var_3.getActivityFleets(var_12_0)[var_1_5.id][arg_12_1]
		local var_12_2 = var_4.getCommanders(var_12_1)
		local var_12_3 = arg_1_0
		local var_12_4 = var_6.sendNotification

		GAME = var_2_10009

		local var_12_5 = var_2_10009.GO_SCENE

		SCENE = var_2_10010

		local var_12_6 = var_2_10010.COMMANDERCAT
		local var_12_7 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10012
		var_12_7.mode = var_2_10012.MODE_SELECT
		var_12_7.activeCommander = var_12_2[arg_12_2]
		var_12_7.ignoredIds = {}
		CommanderCatScene = var_12
		var_12_7.fleetType = var_12.FLEET_TYPE_CHALLENGE

		function var_12_7.onCommander(arg_13_0)
			return true
		end

		function var_12_7.onSelected(arg_14_0, arg_14_1)
			local var_14_0 = arg_14_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10005

			local var_14_1 = var_3_10003(var_3_10005)
			local var_14_2 = var_3.getCommanderById(var_14_1, var_14_0)

			pairs = var_3_10005

			for iter_14_0, iter_14_1 in var_3_10005(var_0) do
				if iter_14_0 == arg_12_1 then
					pairs = var_10

					for iter_14_2, iter_14_3 in var_10(var_12_2) do
						if iter_14_3.groupId == var_14_2.groupId and iter_14_2 ~= arg_12_2 then
							pg = var_15

							local var_14_3 = var_15.TipsMgr.GetInstance()
							local var_14_4 = var_15.ShowTips

							i18n = var_3_10018

							var_14_4(var_14_3, var_3_10018("commander_can_not_select_same_group"))

							return
						end
					end
				else
					local var_14_5 = iter_14_1:getCommanders()

					pairs = var_3_10011

					for iter_14_4, iter_14_5 in var_3_10011(var_14_5) do
						if var_14_0 == iter_14_5.id then
							pg = var_16
							var_3_10018 = var_16.TipsMgr.GetInstance()

							local var_14_6 = var_16.ShowTips

							i18n = var_3_10019

							var_14_6(var_3_10018, var_3_10019("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			local var_14_7 = var_0

			var_5.updateCommanderByPos(var_14_7, arg_12_2, var_14_2)

			local var_14_8 = var_1_0

			var_5.updateActivityFleet(var_14_8, var_1_5.id, arg_12_1, var_0)
			arg_14_1()

			return
		end

		function var_12_7.onQuit(arg_15_0)
			local var_15_0 = var_0

			var_1.updateCommanderByPos(var_15_0, arg_12_2, nil)

			local var_15_1 = var_1_0

			var_1.updateActivityFleet(var_15_1, var_1_5.id, arg_12_1, var_0)
			arg_15_0()

			return
		end

		var_12_4(var_12_3, var_12_5, var_12_6, var_12_7)

		arg_1_0.contextData.editFleet = true

		return
	end)
	arg_1_0:bind(var_0_1.ON_PRECOMBAT, function(arg_16_0, arg_16_1)
		local var_16_0 = var_1_0

		if var_2.checkActivityFleet(var_16_0, var_1_5.id) ~= true then
			pg = var_2

			local var_16_1 = var_2.TipsMgr.GetInstance()
			local var_16_2 = var_2.ShowTips

			i18n = var_5

			var_16_2(var_16_1, var_5("elite_disable_no_fleet"))

			return
		end

		local var_16_3 = var_1_0
		local var_16_4 = var_2.getActivityFleets(var_16_3)[var_1_5.id][arg_16_1 + 1]
		local var_16_5 = var_4.isLegalToFight(var_16_4)

		TeamType = var_2_10006

		local var_16_7

		if var_16_5 == var_2_10006.Vanguard then
			pg = var_16_7

			local var_16_6 = var_16_7.TipsMgr.GetInstance()

			var_16_7 = var_16_7.ShowTips
			i18n = var_2_10009

			var_16_7(var_16_6, var_2_10009("ship_vo_vanguardFleet_must_hasShip"))

			return
		else
			TeamType = var_16_7

			if var_16_5 == var_16_7.Main then
				pg = var_6

				local var_16_8 = var_6.TipsMgr.GetInstance()
				local var_16_9 = var_6.ShowTips

				i18n = var_2_10009

				var_16_9(var_16_8, var_2_10009("ship_vo_mainFleet_must_hasShip"))

				return
			end
		end

		local var_16_10 = arg_1_0.viewComponent

		var_6.hideFleetEdit(var_16_10)

		local var_16_11 = var_1_2

		if not var_6.getUserChallengeInfo(var_16_11, arg_16_1) then
			local var_16_12 = arg_1_0
			local var_16_13 = var_7.sendNotification

			GAME = var_2_10010

			var_16_13(var_16_12, var_2_10010.CHALLENGE2_INITIAL, {
				mode = arg_16_1
			})

			return
		end

		local var_16_14 = arg_1_0
		local var_16_15 = var_7.addSubLayers

		Context = var_2_10010

		local var_16_16 = var_2_10010.New
		local var_16_17 = {}

		ChallengePreCombatMediator = var_2_10013
		var_16_17.mediator = var_2_10013
		ChallengePreCombatLayer = var_2_10013
		var_16_17.viewComponent = var_2_10013

		local var_16_18 = {}

		SYSTEM_CHALLENGE = var_2_10014
		var_16_18.system = var_2_10014
		var_16_18.actId = var_1_5.id
		var_16_18.mode = arg_16_1

		function var_16_18.func()
			local var_17_0 = arg_1_0

			var_0.tryBattle(var_17_0)

			return
		end

		var_16_17.data = var_16_18

		var_16_15(var_16_14, var_16_16(var_16_17))

		return
	end)

	local var_1_16 = var_1_0:getActivityFleets()[var_1_5.id]
	local var_1_17 = arg_1_0.viewComponent

	var_7.setFleet(var_1_17, var_1_16)

	getProxy = var_7
	CommanderProxy = var_1_17

	local var_1_18 = var_7(var_1_17)
	local var_1_19 = var_7.getPrefabFleet(var_1_18)
	local var_1_20 = arg_1_0.viewComponent

	var_8.setCommanderPrefabs(var_1_20, var_1_19)

	return
end

function var_0_1.listNotificationInterests(arg_18_0)
	local var_18_0 = {}

	GAME = var_1_10002
	var_18_0[1] = var_1_10002.CHALLENGE2_INITIAL_DONE
	GAME = var_2
	var_18_0[2] = var_2.CHALLENGE2_RESET_DONE
	GAME = var_2
	var_18_0[3] = var_2.CHALLENGE2_INFO_DONE
	GAME = var_2
	var_18_0[4] = var_2.SUBMIT_TASK_DONE
	CommanderProxy = var_2
	var_18_0[5] = var_2.PREFAB_FLEET_UPDATE
	GAME = var_2
	var_18_0[6] = var_2.COMMANDER_ACTIVITY_FORMATION_OP_DONE

	return var_18_0
end

function var_0_1.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.getName(var_19_0)
	local var_19_2 = arg_19_1
	local var_19_3 = arg_19_1.getBody(var_19_2)

	getProxy = var_19_0
	ChallengeProxy = var_1_10006

	local var_19_4 = var_19_0(var_1_10006)

	getProxy = var_19_2
	ActivityProxy = var_1_10007

	local var_19_5 = var_19_2(var_1_10007)

	getProxy = var_1_10006
	FleetProxy = var_1_10008

	local var_19_6 = var_1_10006(var_1_10008)

	GAME = var_1_10007

	local var_19_7

	if var_19_1 == var_1_10007.CHALLENGE2_INITIAL_DONE then
		var_19_7 = var_19_3.mode
		var_1_10010 = var_19_4
		var_1_10008 = var_19_4.getUserChallengeInfo(var_1_10010, var_19_7)

		local var_19_8 = var_19_5

		var_1_10009 = var_19_5.getActivityByType
		ActivityConst = var_1_10012
		var_1_10009 = var_1_10009(var_19_8, var_1_10012.ACTIVITY_TYPE_CHALLENGE)

		local var_19_9 = arg_19_0

		var_1_10010 = arg_19_0.addSubLayers
		Context = var_1_10013

		local var_19_10 = var_1_10013.New
		local var_19_11 = {}

		ChallengePreCombatMediator = var_1_10016
		var_19_11.mediator = var_1_10016
		ChallengePreCombatLayer = var_1_10016
		var_19_11.viewComponent = var_1_10016

		local var_19_12 = {}

		SYSTEM_CHALLENGE = var_1_10017
		var_19_12.system = var_1_10017
		var_19_12.actId = var_1_10009.id
		var_19_12.mode = var_19_7

		function var_19_12.func()
			local var_20_0 = arg_19_0

			var_0.tryBattle(var_20_0)

			return
		end

		var_19_11.data = var_19_12

		var_1_10010(var_19_9, var_19_10(var_19_11))

		local var_19_13 = arg_19_0.viewComponent

		var_1_10010.updateData(var_19_13)

		local var_19_14 = arg_19_0.viewComponent

		var_1_10010.updatePaintingList(var_19_14)

		local var_19_15 = arg_19_0.viewComponent

		var_1_10010.updateRoundText(var_19_15)

		local var_19_16 = arg_19_0.viewComponent

		var_1_10010.updateSlider(var_19_16)

		local var_19_17 = arg_19_0.viewComponent

		var_1_10010.updateFuncBtns(var_19_17)
	else
		GAME = var_19_7

		local var_19_18

		if var_19_1 == var_19_7.CHALLENGE2_RESET_DONE then
			var_19_18 = arg_19_0.viewComponent.curMode
			ChallengeProxy = var_1_10008

			if var_19_18 == var_1_10008.MODE_INFINITE then
				var_1_10009 = arg_19_0.viewComponent

				if not var_19_18.isFinishedCasualMode(var_1_10009) then
					var_1_10009 = var_19_4
					var_19_18 = var_19_4.setCurMode
					ChallengeProxy = var_1_10010

					var_19_18(var_1_10009, var_1_10010.MODE_CASUAL)
				end
			end

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updateData(var_1_10009)

			var_1_10009 = arg_19_0.viewComponent
			var_19_18 = var_19_18.updateGrade

			local var_19_19 = var_19_4:getChallengeInfo()

			var_19_18(var_1_10009, var_1_10010.getGradeList(var_19_19))

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updateSwitchModBtn(var_1_10009)

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updatePaintingList(var_1_10009)

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updateRoundText(var_1_10009)

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updateSlider(var_1_10009)

			var_1_10009 = arg_19_0.viewComponent

			var_19_18.updateFuncBtns(var_1_10009)
		else
			GAME = var_19_18

			local var_19_20

			if var_19_1 == var_19_18.CHALLENGE2_INFO_DONE then
				var_19_20 = arg_19_0.viewComponent.curMode
				ChallengeProxy = var_1_10008

				if var_19_20 == var_1_10008.MODE_INFINITE then
					var_1_10009 = arg_19_0.viewComponent

					if not var_19_20.isFinishedCasualMode(var_1_10009) then
						var_1_10009 = var_19_4
						var_19_20 = var_19_4.setCurMode
						ChallengeProxy = var_1_10010

						var_19_20(var_1_10009, var_1_10010.MODE_CASUAL)
					end
				end

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateData(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent
				var_19_20 = var_19_20.updateGrade

				local var_19_21 = var_19_4:getChallengeInfo()

				var_19_20(var_1_10009, var_1_10010.getGradeList(var_19_21))

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateTimePanel(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateSwitchModBtn(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updatePaintingList(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateRoundText(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateSlider(var_1_10009)

				var_1_10009 = arg_19_0.viewComponent

				var_19_20.updateFuncBtns(var_1_10009)
			else
				GAME = var_19_20

				local var_19_22

				if var_19_1 == var_19_20.SUBMIT_TASK_DONE then
					var_1_10009 = arg_19_0.viewComponent
					var_19_22 = var_19_22.emit
					BaseUI = var_1_10010

					var_19_22(var_1_10009, var_1_10010.ON_ACHIEVE, var_19_3, function()
						local var_21_0 = arg_19_0.viewComponent

						var_0.updateAwardPanel(var_21_0)

						return
					end)
				else
					CommanderProxy = var_19_22

					local var_19_24

					if var_19_1 == var_19_22.PREFAB_FLEET_UPDATE then
						getProxy = var_19_24
						CommanderProxy = var_1_10009

						local var_19_23 = var_19_24(var_1_10009)

						var_19_24 = var_19_24.getPrefabFleet(var_19_23)

						local var_19_25 = arg_19_0.viewComponent

						var_8.setCommanderPrefabs(var_19_25, var_19_24)

						local var_19_26 = arg_19_0.viewComponent

						var_8.updateCommanderPrefab(var_19_26)
					else
						GAME = var_19_24

						if var_19_1 == var_19_24.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
							local var_19_27 = var_19_6:getActivityFleets()[var_19_3.actId]
							local var_19_28 = arg_19_0.viewComponent

							var_8.setFleet(var_19_28, var_19_27)

							local var_19_29 = arg_19_0.viewComponent

							var_8.updateEditPanel(var_19_29)

							local var_19_30 = arg_19_0.viewComponent

							var_8.updateCommanderFleet(var_19_30, var_19_27[var_19_3.fleetId])
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.getDockCallbackFuncs(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_22_0 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	FleetProxy = var_1_10008

	local var_22_1 = var_1_10006(var_1_10008)

	getProxy = var_1_10007
	ActivityProxy = var_1_10009

	local var_22_2 = var_1_10007(var_1_10009)
	local var_22_3 = var_7.getActivityByType

	ActivityConst = var_1_10011

	local var_22_4 = var_22_3(var_22_2, var_1_10011.ACTIVITY_TYPE_CHALLENGE)

	local function var_22_5(arg_23_0, arg_23_1)
		ShipStatus = var_2_10002

		local var_23_0, var_23_1 = var_2_10002.ShipStatusCheck("inActivity", arg_23_0, arg_23_1, {
			inActivity = var_22_4.id
		})

		if not var_23_0 then
			return var_23_0, var_23_1
		end

		ipairs = var_4

		for iter_23_0, iter_23_1 in var_4(arg_22_1) do
			local var_23_2 = arg_23_0
			local var_23_3 = arg_23_0.isSameKind
			local var_23_4 = var_22_0

			if var_23_3(var_23_2, var_12.getShipById(var_23_4, iter_23_1)) then
				local var_23_5 = false

				i18n = var_2_10010
				var_2_10010 = var_2_10010("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_22_6(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1()

		return
	end

	local function var_22_7(arg_25_0)
		local var_25_0 = var_0
		local var_25_1 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_25_2 = var_25_1(var_25_0, var_2_10004.ACTIVITY_TYPE_CHALLENGE)
		local var_25_3 = var_22_1
		local var_25_4 = var_2.getActivityFleets(var_25_3)[var_25_2.id][arg_22_3]

		if arg_22_2 then
			var_25_4:removeShip(arg_22_2)
		end

		if #arg_25_0 > 0 then
			local var_25_5 = var_25_4
			local var_25_6 = var_25_4.insertShip
			local var_25_7 = var_22_0

			var_25_6(var_25_5, var_8.getShipById(var_25_7, arg_25_0[1]), nil, arg_22_4)
		end

		local var_25_8 = var_22_1

		var_5.updateActivityFleet(var_25_8, var_25_2.id, arg_22_3, var_25_4)

		return
	end

	return var_22_5, var_22_6, var_22_7
end

return var_0_1
