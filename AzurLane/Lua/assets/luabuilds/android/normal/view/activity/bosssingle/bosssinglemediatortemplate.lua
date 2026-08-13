class = var_0_10000

local var_0_0 = "BossSingleMediatorTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_SCENE = "BossSingleMediatorTemplate.GO_SCENE"
var_0_1.GO_SUBLAYER = "BossSingleMediatorTemplate.GO_SUBLAYER"
var_0_1.ON_PRECOMBAT = "BossSingleMediatorTemplate:ON_PRECOMBAT"
var_0_1.ON_COMMIT_FLEET = "BossSingleMediatorTemplate:ON_COMMIT_FLEET"
var_0_1.ON_FLEET_RECOMMEND = "BossSingleMediatorTemplate:ON_FLEET_RECOMMEND"
var_0_1.ON_FLEET_CLEAR = "BossSingleMediatorTemplate:ON_FLEET_CLEAR"
var_0_1.ON_OPEN_DOCK = "BossSingleMediatorTemplate:ON_OPEN_DOCK"
var_0_1.ON_FLEET_SHIPINFO = "BossSingleMediatorTemplate:ON_FLEET_SHIPINFO"
var_0_1.ON_SELECT_COMMANDER = "BossSingleMediatorTemplate:ON_SELECT_COMMANDER"
var_0_1.COMMANDER_FORMATION_OP = "BossSingleMediatorTemplate:COMMANDER_FORMATION_OP"
var_0_1.ON_COMMANDER_SKILL = "BossSingleMediatorTemplate:ON_COMMANDER_SKILL"
var_0_1.ON_PERFORM_COMBAT = "BossSingleMediatorTemplate:ON_PERFORM_COMBAT"

function var_0_1.GetPairedFleetIndex(arg_1_0)
	Fleet = var_1_10001

	if arg_1_0 < var_1_10001.SUBMARINE_FLEET_ID then
		return arg_1_0 + 10
	else
		return arg_1_0 - 10
	end

	return
end

function var_0_1.BindBattleEvents(arg_2_0)
	local var_2_0 = arg_2_0.contextData

	var_2_0.mediatorClass = arg_2_0.class
	getProxy = var_2_0
	FleetProxy = var_2

	local var_2_1 = var_2_0(var_2)

	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_2_2 = var_2(var_1_10003)
	local var_2_3 = var_2.getActivityByType

	ActivityConst = var_1_10004

	if not var_2_3(var_2_2, var_1_10004.ACTIVITY_TYPE_BOSSSINGLE) then
		return
	end

	arg_2_0.contextData.bossActivity = var_2
	arg_2_0.contextData.activityID = var_2.id
	arg_2_0.contextData.stageIDs = var_2:GetStageIDs()

	local var_2_4 = arg_2_0.contextData

	var_2_4.useOilLimit = var_2:GetOilLimits()
	getProxy = var_2_4
	FleetProxy = var_4

	local var_2_5 = var_2_4(var_4)
	local var_2_6

	var_2_6.actFleets, var_2_6 = var_3.getActivityFleets(var_2_5)[arg_2_0.contextData.activityID], arg_2_0.contextData
	getProxy = var_2_6
	CommanderProxy = var_1_10006

	local var_2_7 = var_2_6(var_1_10006)
	local var_2_8 = var_5.getPrefabFleet(var_2_7)
	local var_2_9 = arg_2_0.viewComponent

	var_6.setCommanderPrefabs(var_2_9, var_2_8)

	pg = var_6

	local var_2_10 = var_6.GuildMsgBoxMgr.GetInstance()

	var_6.NotificationForBattle(var_2_10)
	arg_2_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.bind

	ActivityMediator = var_8

	var_2_12(var_2_11, var_8.EVENT_PT_OPERATION, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.ACT_NEW_PT, arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_PRECOMBAT, function(arg_6_0, arg_6_1)
		local var_6_0 = var_2_1

		if not var_2.getActivityFleets(var_6_0)[arg_2_0.contextData.activityID] then
			pg = var_3

			local var_6_1 = var_3.TipsMgr.GetInstance()
			local var_6_2 = var_3.ShowTips

			i18n = var_2_10005

			var_6_2(var_6_1, var_2_10005("elite_disable_no_fleet"))

			return
		end

		local var_6_3 = var_2[arg_6_1]

		var_3.RemoveUnusedItems(var_6_3)

		local var_6_4 = var_2[arg_6_1]

		if var_3.isLegalToFight(var_6_4) ~= true then
			pg = var_3

			local var_6_5 = var_3.TipsMgr.GetInstance()
			local var_6_6 = var_3.ShowTips

			i18n = var_2_10005

			var_6_6(var_6_5, var_2_10005("elite_disable_formation_unsatisfied"))

			return
		end

		local var_6_7 = var_2[arg_6_1 + 10]

		var_3.RemoveUnusedItems(var_6_7)

		local var_6_8 = {
			var_2[arg_6_1],
			var_2[arg_6_1 + 10]
		}
		local var_6_9 = arg_2_0.contextData.activityID

		_ = var_2_10005

		if var_2_10005.any(var_6_8, function(arg_7_0)
			local var_7_0, var_7_1 = arg_7_0:HaveShipsInEvent()

			if var_7_0 then
				pg = var_3_10003

				local var_7_2 = var_3_10003.TipsMgr.GetInstance()

				var_3_10003.ShowTips(var_7_2, var_7_1)

				return true
			end

			_ = var_3_10003

			return var_3_10003.any(arg_7_0:getShipIds(), function(arg_8_0)
				getProxy = var_4_10001
				BayProxy = var_4_10002

				local var_8_0 = var_4_10001(var_4_10002)

				if not var_1.RawGetShipById(var_8_0, arg_8_0) then
					return
				end

				ShipStatus = var_8_0

				local var_8_1, var_8_2 = var_8_0.ShipStatusCheck("inActivity", var_1, nil, {
					inActivity = var_6_9
				})

				if not var_8_1 then
					pg = var_4

					local var_8_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_8_3, var_8_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		local var_6_10
		local var_6_11

		SYSTEM_BOSS_SINGLE = var_6_10

		local var_6_12 = arg_2_0.contextData.stageIDs[arg_6_1]
		local var_6_13 = arg_2_0.contextData.useOilLimit[arg_6_1]
		local var_6_14 = arg_2_0
		local var_6_15 = var_8.addSubLayers

		Context = var_2_10010

		local var_6_16 = var_2_10010.New
		local var_6_17 = {}

		BossSinglePreCombatMediator = var_2_10012
		var_6_17.mediator = var_2_10012
		BossSinglePreCombatLayer = var_2_10012
		var_6_17.viewComponent = var_2_10012
		var_6_17.data = {
			system = var_6_10,
			stageId = var_6_12,
			actId = arg_2_0.contextData.activityID,
			fleets = var_6_8,
			costLimit = var_6_13
		}

		function var_6_17.onRemoved()
			local var_9_0 = arg_2_0.viewComponent

			var_0.updateEditPanel(var_9_0)

			return
		end

		var_6_15(var_6_14, var_6_16(var_6_17))

		return
	end)
	arg_2_0:bind(var_0_1.ON_COMMIT_FLEET, function()
		local var_10_0 = var_2_1

		var_0.commitActivityFleet(var_10_0, arg_2_0.contextData.activityID)

		return
	end)
	arg_2_0:bind(var_0_1.ON_FLEET_RECOMMEND, function(arg_11_0, arg_11_1)
		local var_11_0 = var_2_1

		var_2.recommendActivityFleet(var_11_0, arg_2_0.contextData.activityID, arg_11_1)

		local var_11_1 = var_2_1
		local var_11_2 = var_2.getActivityFleets(var_11_1)[arg_2_0.contextData.activityID]

		arg_2_0.contextData.actFleets = var_11_2

		local var_11_3 = arg_2_0.viewComponent

		var_4.updateEditPanel(var_11_3)

		return
	end)
	arg_2_0:bind(var_0_1.ON_FLEET_CLEAR, function(arg_12_0, arg_12_1)
		local var_12_0 = var_2_1
		local var_12_1 = var_2.getActivityFleets(var_12_0)[arg_2_0.contextData.activityID][arg_12_1]

		var_3.clearFleet(var_12_1)

		local var_12_2 = var_2_1

		var_4.updateActivityFleet(var_12_2, arg_2_0.contextData.activityID, arg_12_1, var_3)

		arg_2_0.contextData.actFleets = var_2

		local var_12_3 = arg_2_0.viewComponent

		var_4.updateEditPanel(var_12_3)

		return
	end)
	arg_2_0:bind(var_0_1.ON_OPEN_DOCK, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1.fleetIndex
		local var_13_1 = arg_13_1.shipVO
		local var_13_2 = arg_13_1.fleet
		local var_13_3 = arg_13_1.teamType
		local var_13_4

		if not arg_2_0.contextData.activityID then
			var_13_4 = 5620
		end

		local var_13_5, var_13_6, var_13_7 = arg_2_0.getDockCallbackFuncs4ActicityFleet(var_13_1, var_13_0, var_13_3)
		local var_13_8 = arg_2_0
		local var_13_9 = var_10.sendNotification

		GAME = var_2_10012

		local var_13_10 = var_2_10012.GO_SCENE

		SCENE = var_2_10013

		local var_13_11 = var_2_10013.DOCKYARD
		local var_13_12 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1
		}

		i18n = var_2_10015
		var_13_12.leastLimitMsg = var_2_10015("ship_formationMediator_leastLimit")
		var_13_12.quitTeam = var_13_1 ~= nil
		var_13_12.teamFilter = var_13_3
		i18n = var_15
		var_13_12.leftTopInfo = var_15("word_formation")
		var_13_12.onShip = var_13_5
		var_13_12.confirmSelect = var_13_6
		var_13_12.onSelected = var_13_7
		setmetatable = var_15

		local var_13_13 = {
			inActivity = var_13_4
		}
		local var_13_14 = {}

		ShipStatus = var_2_10018
		var_13_14.__index = var_2_10018.TAG_HIDE_ACTIVITY_BOSS
		var_13_12.hideTagFlags = var_15(var_13_13, var_13_14)
		var_13_12.otherSelectedIds = var_13_2
		pg = var_15

		local var_13_15 = var_15.ShipFlagMgr.GetInstance()

		var_13_12.ignoredIds = var_15.FilterShips(var_13_15, {
			isActivityNpc = true
		})

		var_13_9(var_13_8, var_13_10, var_13_11, var_13_12)

		return
	end)
	arg_2_0:bind(var_0_1.ON_FLEET_SHIPINFO, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_2_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_14_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_14_1(var_14_0, var_14_2, var_2_10005.SHIPINFO, {
			shipId = arg_14_1.shipId,
			shipVOs = arg_14_1.shipVOs
		})

		return
	end)
	arg_2_0:bind(var_0_1.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_2_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10004

		var_15_1(var_15_0, var_2_10004.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_COMMANDER_SKILL, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_2_0
		local var_16_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_16_2 = var_2_10004.New
		local var_16_3 = {}

		CommanderSkillMediator = var_2_10006
		var_16_3.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_16_3.viewComponent = var_2_10006
		var_16_3.data = {
			skill = arg_16_1
		}

		var_16_1(var_16_0, var_16_2(var_16_3))

		return
	end)
	arg_2_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = var_2_1
		local var_17_1 = var_3.getActivityFleets(var_17_0)[arg_2_0.contextData.activityID][arg_17_1]
		local var_17_2 = var_4.getCommanders(var_17_1)
		local var_17_3 = arg_2_0
		local var_17_4 = var_6.sendNotification

		GAME = var_2_10008

		local var_17_5 = var_2_10008.GO_SCENE

		SCENE = var_2_10009

		local var_17_6 = var_2_10009.COMMANDERCAT
		local var_17_7 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10011
		var_17_7.mode = var_2_10011.MODE_SELECT
		var_17_7.activeCommander = var_17_2[arg_17_2]
		CommanderCatScene = var_11
		var_17_7.fleetType = var_11.FLEET_TYPE_BOSSSINGLE
		var_17_7.ignoredIds = {}

		function var_17_7.onCommander(arg_18_0)
			return true
		end

		function var_17_7.onSelected(arg_19_0, arg_19_1)
			local var_19_0 = arg_19_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10004

			local var_19_1 = var_3_10003(var_3_10004)
			local var_19_2 = var_3.getCommanderById(var_19_1, var_19_0)

			pairs = var_19_1

			for iter_19_0, iter_19_1 in var_19_1(var_0) do
				if iter_19_0 == arg_17_1 then
					pairs = var_10

					for iter_19_2, iter_19_3 in var_10(var_17_2) do
						if iter_19_3.groupId == var_19_2.groupId and iter_19_2 ~= arg_17_2 then
							pg = var_15

							local var_19_3 = var_15.TipsMgr.GetInstance()
							local var_19_4 = var_15.ShowTips

							i18n = var_3_10017

							var_19_4(var_19_3, var_3_10017("commander_can_not_select_same_group"))

							return
						end
					end
				elseif iter_19_0 == var_0_1.GetPairedFleetIndex(arg_17_1) then
					local var_19_5 = iter_19_1
					local var_19_6 = iter_19_1.getCommanders(var_19_5)

					pairs = var_19_5

					for iter_19_4, iter_19_5 in var_19_5(var_19_6) do
						if var_19_0 == iter_19_5.id then
							pg = var_16
							var_3_10017 = var_16.TipsMgr.GetInstance()

							local var_19_7 = var_16.ShowTips

							i18n = var_3_10018

							var_19_7(var_3_10017, var_3_10018("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			local var_19_8 = var_0

			var_5.updateCommanderByPos(var_19_8, arg_17_2, var_19_2)

			local var_19_9 = var_2_1

			var_5.updateActivityFleet(var_19_9, arg_2_0.contextData.activityID, arg_17_1, var_0)
			arg_19_1()

			return
		end

		function var_17_7.onQuit(arg_20_0)
			local var_20_0 = var_0

			var_1.updateCommanderByPos(var_20_0, arg_17_2, nil)

			local var_20_1 = var_2_1

			var_1.updateActivityFleet(var_20_1, arg_2_0.contextData.activityID, arg_17_1, var_0)
			arg_20_0()

			return
		end

		var_17_4(var_17_3, var_17_5, var_17_6, var_17_7)

		return
	end)

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.bind

	PreCombatMediator = var_8

	var_2_14(var_2_13, var_8.BEGIN_STAGE_PROXY, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_2_0
		local var_21_1 = var_2.sendNotification

		PreCombatMediator = var_2_10004

		var_21_1(var_21_0, var_2_10004.BEGIN_STAGE_PROXY, {
			curFleetId = arg_21_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_PERFORM_COMBAT, function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_2_0
		local var_22_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_22_2 = var_2_10005.BEGIN_STAGE
		local var_22_3 = {}

		SYSTEM_PERFORM = var_2_10007
		var_22_3.system = var_2_10007
		var_22_3.stageId = arg_22_1
		var_22_3.exitCallback = arg_22_2

		var_22_1(var_22_0, var_22_2, var_22_3)

		return
	end)

	return
end

function var_0_1.GetBattleHanldDic(arg_23_0)
	local var_23_0 = {}

	GAME = var_1_10002
	var_23_0[var_1_10002.BEGIN_STAGE_DONE] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_1:getBody()
		local var_24_1 = arg_24_0.contextData

		var_24_1.editFleet = nil
		getProxy = var_24_1
		ContextProxy = var_4

		local var_24_2 = var_24_1(var_4)
		local var_24_3 = var_3.getContextByMediator

		PreCombatMediator = var_2_10006

		if not var_24_3(var_24_2, var_2_10006) then
			local var_24_4 = arg_24_0
			local var_24_5 = arg_24_0.sendNotification

			GAME = var_2_10006

			local var_24_6 = var_2_10006.GO_SCENE

			SCENE = var_2_10007

			var_24_5(var_24_4, var_24_6, var_2_10007.COMBATLOAD, var_24_0)
		end

		return
	end
	GAME = var_2
	var_23_0[var_2.COMMANDER_ACTIVITY_FORMATION_OP_DONE] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_1
		local var_25_1 = arg_25_1.getBody(var_25_0)

		getProxy = var_25_0
		FleetProxy = var_2_10004

		local var_25_2 = var_25_0(var_2_10004)
		local var_25_3 = var_3.getActivityFleets(var_25_2)[var_25_1.actId]

		arg_25_0.contextData.actFleets = var_25_3

		local var_25_4 = arg_25_0.viewComponent

		var_4.updateEditPanel(var_25_4)

		local var_25_5 = arg_25_0.viewComponent

		var_4.updateCommanderFleet(var_25_5, var_25_3[var_25_1.fleetId])

		return
	end
	CommanderProxy = var_2
	var_23_0[var_2.PREFAB_FLEET_UPDATE] = function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_1
		local var_26_1 = arg_26_1.getBody(var_26_0)

		getProxy = var_26_0
		CommanderProxy = var_2_10004

		local var_26_2 = var_26_0(var_2_10004)
		local var_26_3 = var_3.getPrefabFleet(var_26_2)
		local var_26_4 = arg_26_0.viewComponent

		var_4.setCommanderPrefabs(var_26_4, var_26_3)

		local var_26_5 = arg_26_0.viewComponent

		var_4.updateCommanderPrefab(var_26_5)

		return
	end

	return var_23_0
end

function var_0_1.getDockCallbackFuncs4ActicityFleet(arg_27_0, arg_27_1, arg_27_2)
	getProxy = var_1_10003
	BayProxy = var_1_10004

	local var_27_0 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_27_1 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_27_2 = var_1_10005(var_1_10006)
	local var_27_3 = var_5.getActivityByType

	ActivityConst = var_1_10007

	local var_27_4 = var_27_3(var_27_2, var_1_10007.ACTIVITY_TYPE_BOSSSINGLE)
	local var_27_5 = var_27_1:getActivityFleets()[var_27_4.id][arg_27_1]

	local function var_27_6(arg_28_0, arg_28_1)
		ShipStatus = var_2_10002

		local var_28_0, var_28_1 = var_2_10002.ShipStatusCheck("inActivity", arg_28_0, arg_28_1, {
			inActivity = var_27_4.id
		})

		if not var_28_0 then
			return var_28_0, var_28_1
		end

		if arg_27_0 then
			local var_28_2 = arg_27_0

			if var_4.isSameKind(var_28_2, arg_28_0) then
				return true
			end
		end

		ipairs = var_4

		local var_28_3

		if not var_27_5.ships then
			var_28_3 = {}
		end

		for iter_28_0, iter_28_1 in var_4(var_28_3) do
			local var_28_4 = arg_28_0
			local var_28_5 = arg_28_0.isSameKind
			local var_28_6 = var_27_0

			if var_28_5(var_28_4, var_11.getShipById(var_28_6, iter_28_1)) then
				local var_28_7 = false

				i18n = var_28_4

				local var_28_8 = var_28_4("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_27_7(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1()

		return
	end

	local function var_27_8(arg_30_0)
		if arg_27_0 then
			local var_30_0 = var_27_5

			var_1.removeShip(var_30_0, arg_27_0)
		end

		if #arg_30_0 > 0 then
			local var_30_1 = var_27_0
			local var_30_2 = var_1.getShipById(var_30_1, arg_30_0[1])
			local var_30_3 = var_27_5

			if not var_2.containShip(var_30_3, var_30_2) then
				local var_30_4 = var_27_5

				var_2.insertShip(var_30_4, var_30_2, nil, arg_27_2)
			elseif arg_27_0 then
				local var_30_5 = var_27_5

				var_2.insertShip(var_30_5, arg_27_0, nil, arg_27_2)
			end

			local var_30_6 = var_27_5

			var_2.RemoveUnusedItems(var_30_6)
		end

		local var_30_7 = var_27_1

		var_1.updateActivityFleet(var_30_7, var_27_4.id, arg_27_1, var_27_5)

		return
	end

	return var_27_6, var_27_7, var_27_8
end

return var_0_1
