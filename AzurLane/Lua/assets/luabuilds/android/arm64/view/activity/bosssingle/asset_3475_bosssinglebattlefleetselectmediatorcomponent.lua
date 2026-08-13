class = var_0_10000

local var_0_0 = var_0_10000("BossSingleBattleFleetSelectMediatorComponent")

function var_0_0.AttachFleetSelect(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.New(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_0.DetachFleetSelect(arg_2_0)
	if arg_2_0._IFleetSelect == nil then
		return
	end

	local var_2_0 = arg_2_0._IFleetSelect

	var_1._Destory_(var_2_0)

	arg_2_0._IFleetSelect = nil

	return
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._target_ = arg_3_1
	arg_3_0._actType = arg_3_2
	arg_3_0._systemType = arg_3_3
	arg_3_0._subFleetOffset = arg_3_4 or 10

	arg_3_0:_Init_()

	return
end

function var_0_0._Init_(arg_4_0)
	arg_4_0._target_.class.GO_SCENE = arg_4_0._target_.__cname .. ":GO_SCENE"
	arg_4_0._target_.class.GO_SUBLAYER = arg_4_0._target_.__cname .. ":GO_SUBLAYER"
	arg_4_0._target_.class.ON_PRECOMBAT = arg_4_0._target_.__cname .. ":ON_PRECOMBAT"
	arg_4_0._target_.class.ON_COMMIT_FLEET = arg_4_0._target_.__cname .. ":ON_COMMIT_FLEET"
	arg_4_0._target_.class.ON_FLEET_RECOMMEND = arg_4_0._target_.__cname .. ":ON_FLEET_RECOMMEND"
	arg_4_0._target_.class.ON_FLEET_CLEAR = arg_4_0._target_.__cname .. ":ON_FLEET_CLEAR"
	arg_4_0._target_.class.ON_OPEN_DOCK = arg_4_0._target_.__cname .. ":ON_OPEN_DOCK"
	arg_4_0._target_.class.ON_FLEET_SHIPINFO = arg_4_0._target_.__cname .. ":ON_FLEET_SHIPINFO"
	arg_4_0._target_.class.ON_SELECT_COMMANDER = arg_4_0._target_.__cname .. ":ON_SELECT_COMMANDER"
	arg_4_0._target_.class.COMMANDER_FORMATION_OP = arg_4_0._target_.__cname .. ":COMMANDER_FORMATION_OP"
	arg_4_0._target_.class.ON_COMMANDER_SKILL = arg_4_0._target_.__cname .. ":ON_COMMANDER_SKILL"
	arg_4_0._target_.class.ON_PERFORM_COMBAT = arg_4_0._target_.__cname .. ":ON_PERFORM_COMBAT"

	arg_4_0:bindBattleEvents()

	arg_4_0._target_._IFleetSelect = arg_4_0

	return
end

function var_0_0._Destory_(arg_5_0)
	arg_5_0._target_ = nil

	return
end

function var_0_0.bindBattleEvents(arg_6_0)
	local var_6_0 = arg_6_0._target_.contextData

	var_6_0.mediatorClass = arg_6_0._target_.class
	getProxy = var_6_0
	FleetProxy = var_1_10003

	local var_6_1 = var_6_0(var_1_10003)

	getProxy = var_2
	ActivityProxy = var_1_10004

	local var_6_2 = var_2(var_1_10004)

	if not var_2.getActivityByType(var_6_2, arg_6_0._actType) then
		return
	end

	arg_6_0._target_.contextData.bossActivity = var_2
	arg_6_0._target_.contextData.activityID = var_2.id
	arg_6_0._target_.contextData.stageIDs = var_2:GetStageIDs()

	local var_6_3 = arg_6_0._target_.contextData

	var_6_3.useOilLimit = var_2:GetOilLimits()
	getProxy = var_6_3
	FleetProxy = var_5

	local var_6_4 = var_6_3(var_5)
	local var_6_5

	var_6_5.actFleets, var_6_5 = var_3.getActivityFleets(var_6_4)[arg_6_0._target_.contextData.activityID], arg_6_0._target_.contextData
	getProxy = var_6_5
	CommanderProxy = var_1_10007

	local var_6_6 = var_6_5(var_1_10007)
	local var_6_7 = var_5.getPrefabFleet(var_6_6)
	local var_6_8 = arg_6_0._target_.viewComponent

	var_6.setCommanderPrefabs(var_6_8, var_6_7)

	pg = var_6

	local var_6_9 = var_6.GuildMsgBoxMgr.GetInstance()

	var_6.NotificationForBattle(var_6_9)

	local var_6_10 = arg_6_0._target_

	var_6.bind(var_6_10, arg_6_0._target_.GO_SCENE, function(arg_7_0, arg_7_1, ...)
		local var_7_0 = arg_6_0._target_
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.GO_SCENE, arg_7_1, ...)

		return
	end)

	local var_6_11 = arg_6_0._target_

	var_6.bind(var_6_11, arg_6_0._target_.GO_SUBLAYER, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0._target_

		var_3.addSubLayers(var_8_0, arg_8_1, nil, arg_8_2)

		return
	end)

	local var_6_12 = arg_6_0._target_
	local var_6_13 = var_6.bind

	ActivityMediator = var_9

	var_6_13(var_6_12, var_9.EVENT_PT_OPERATION, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_6_0._target_
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.ACT_NEW_PT, arg_9_1)

		return
	end)

	local var_6_14 = arg_6_0._target_

	var_6.bind(var_6_14, arg_6_0._target_.ON_PRECOMBAT, function(arg_10_0, arg_10_1)
		local var_10_0 = var_6_1

		if not var_2.getActivityFleets(var_10_0)[arg_6_0._target_.contextData.activityID] then
			pg = var_3

			local var_10_1 = var_3.TipsMgr.GetInstance()
			local var_10_2 = var_3.ShowTips

			i18n = var_2_10006

			var_10_2(var_10_1, var_2_10006("elite_disable_no_fleet"))

			return
		end

		local var_10_3 = var_2[arg_10_1]

		var_3.RemoveUnusedItems(var_10_3)

		local var_10_4 = var_2[arg_10_1]

		if var_3.isLegalToFight(var_10_4) ~= true then
			pg = var_3

			local var_10_5 = var_3.TipsMgr.GetInstance()
			local var_10_6 = var_3.ShowTips

			i18n = var_2_10006

			var_10_6(var_10_5, var_2_10006("elite_disable_formation_unsatisfied"))

			return
		end

		local var_10_7 = var_2[arg_10_1 + arg_6_0._subFleetOffset]

		var_3.RemoveUnusedItems(var_10_7)

		local var_10_8 = {
			var_2[arg_10_1],
			var_2[arg_10_1 + arg_6_0._subFleetOffset]
		}
		local var_10_9 = arg_6_0._target_.contextData.activityID

		_ = var_10_7

		if var_10_7.any(var_10_8, function(arg_11_0)
			local var_11_0 = arg_11_0
			local var_11_1, var_11_2 = arg_11_0.HaveShipsInEvent(var_11_0)

			if var_11_1 then
				pg = var_11_0

				local var_11_3 = var_11_0.TipsMgr.GetInstance()

				var_11_0.ShowTips(var_11_3, var_11_2)

				return true
			end

			_ = var_11_0

			return var_11_0.any(arg_11_0:getShipIds(), function(arg_12_0)
				getProxy = var_4_10001
				BayProxy = var_4_10003

				local var_12_0 = var_4_10001(var_4_10003)

				if not var_1.RawGetShipById(var_12_0, arg_12_0) then
					return
				end

				ShipStatus = var_4_10002

				local var_12_1, var_12_2 = var_4_10002.ShipStatusCheck("inActivity", var_1, nil, {
					inActivity = var_10_9
				})

				if not var_12_1 then
					pg = var_4

					local var_12_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_12_3, var_12_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		local var_10_10
		local var_10_11
		local var_10_12 = arg_6_0._systemType
		local var_10_13 = arg_6_0._target_.contextData.stageIDs[arg_10_1]
		local var_10_14 = arg_6_0._target_.contextData.useOilLimit[arg_10_1]
		local var_10_15 = arg_6_0._target_
		local var_10_16 = var_8.sendNotification

		GAME = var_2_10011

		local var_10_17 = var_2_10011.GO_SCENE

		SCENE = var_2_10012

		var_10_16(var_10_15, var_10_17, var_2_10012.BOSS_SINGLE_PRECOMBAT, {
			system = var_10_12,
			stageId = var_10_13,
			actId = arg_6_0._target_.contextData.activityID,
			fleets = var_10_8,
			costLimit = var_10_14,
			buffList = arg_6_0._target_.contextData.selectedBuffList,
			useTicket = arg_6_0._target_.contextData.useTicket
		})

		return
	end)

	local var_6_15 = arg_6_0._target_

	var_6.bind(var_6_15, arg_6_0._target_.ON_COMMIT_FLEET, function()
		local var_13_0 = var_6_1

		var_0.commitActivityFleet(var_13_0, arg_6_0._target_.contextData.activityID)

		return
	end)

	local var_6_16 = arg_6_0._target_

	var_6.bind(var_6_16, arg_6_0._target_.ON_FLEET_RECOMMEND, function(arg_14_0, arg_14_1)
		local var_14_0 = var_6_1

		var_2.recommendActivityFleet(var_14_0, arg_6_0._target_.contextData.activityID, arg_14_1)

		local var_14_1 = var_6_1
		local var_14_2 = var_2.getActivityFleets(var_14_1)[arg_6_0._target_.contextData.activityID]

		arg_6_0._target_.contextData.actFleets = var_14_2

		local var_14_3 = arg_6_0._target_.viewComponent

		var_4.updateEditPanel(var_14_3)

		return
	end)

	local var_6_17 = arg_6_0._target_

	var_6.bind(var_6_17, arg_6_0._target_.ON_FLEET_CLEAR, function(arg_15_0, arg_15_1)
		local var_15_0 = var_6_1
		local var_15_1 = var_2.getActivityFleets(var_15_0)[arg_6_0._target_.contextData.activityID][arg_15_1]

		var_3.clearFleet(var_15_1)

		local var_15_2 = var_6_1

		var_4.updateActivityFleet(var_15_2, arg_6_0._target_.contextData.activityID, arg_15_1, var_3)

		arg_6_0._target_.contextData.actFleets = var_2

		local var_15_3 = arg_6_0._target_.viewComponent

		var_4.updateEditPanel(var_15_3)

		return
	end)

	local var_6_18 = arg_6_0._target_

	var_6.bind(var_6_18, arg_6_0._target_.ON_OPEN_DOCK, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1.fleetIndex
		local var_16_1 = arg_16_1.shipVO
		local var_16_2 = arg_16_1.fleet
		local var_16_3 = arg_16_1.teamType
		local var_16_4 = arg_6_0._target_.contextData.activityID
		local var_16_5, var_16_6, var_16_7 = var_0_0.getDockCallbackFuncs4ActicityFleet(arg_6_0._actType, var_16_1, var_16_0, var_16_3)
		local var_16_8 = arg_6_0._target_
		local var_16_9 = var_10.sendNotification

		GAME = var_2_10013

		local var_16_10 = var_2_10013.GO_SCENE

		SCENE = var_2_10014

		local var_16_11 = var_2_10014.DOCKYARD
		local var_16_12 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1
		}

		i18n = var_2_10016
		var_16_12.leastLimitMsg = var_2_10016("ship_formationMediator_leastLimit")
		var_16_12.quitTeam = var_16_1 ~= nil
		var_16_12.teamFilter = var_16_3
		i18n = var_16
		var_16_12.leftTopInfo = var_16("word_formation")
		var_16_12.onShip = var_16_5
		var_16_12.confirmSelect = var_16_6
		var_16_12.onSelected = var_16_7
		setmetatable = var_16

		local var_16_13 = {
			inActivity = var_16_4
		}
		local var_16_14 = {}

		ShipStatus = var_2_10020
		var_16_14.__index = var_2_10020.TAG_HIDE_ACTIVITY_BOSS
		var_16_12.hideTagFlags = var_16(var_16_13, var_16_14)
		var_16_12.otherSelectedIds = var_16_2
		pg = var_16

		local var_16_15 = var_16.ShipFlagMgr.GetInstance()

		var_16_12.ignoredIds = var_16.FilterShips(var_16_15, {
			isActivityNpc = true
		})

		var_16_9(var_16_8, var_16_10, var_16_11, var_16_12)

		return
	end)

	local var_6_19 = arg_6_0._target_

	var_6.bind(var_6_19, arg_6_0._target_.ON_FLEET_SHIPINFO, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_6_0._target_
		local var_17_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_17_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_17_1(var_17_0, var_17_2, var_2_10006.SHIPINFO, {
			shipId = arg_17_1.shipId,
			shipVOs = arg_17_1.shipVOs
		})

		return
	end)

	local var_6_20 = arg_6_0._target_

	var_6.bind(var_6_20, arg_6_0._target_.COMMANDER_FORMATION_OP, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_6_0._target_
		local var_18_1 = var_2.sendNotification

		GAME = var_2_10005

		var_18_1(var_18_0, var_2_10005.COMMANDER_FORMATION_OP, {
			data = arg_18_1
		})

		return
	end)

	local var_6_21 = arg_6_0._target_

	var_6.bind(var_6_21, arg_6_0._target_.ON_COMMANDER_SKILL, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_6_0._target_
		local var_19_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_19_2 = var_2_10005.New
		local var_19_3 = {}

		CommanderSkillMediator = var_2_10008
		var_19_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_19_3.viewComponent = var_2_10008
		var_19_3.data = {
			skill = arg_19_1
		}

		var_19_1(var_19_0, var_19_2(var_19_3))

		return
	end)

	local var_6_22 = arg_6_0._target_

	var_6.bind(var_6_22, arg_6_0._target_.ON_SELECT_COMMANDER, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_6_1
		local var_20_1 = var_3.getActivityFleets(var_20_0)[arg_6_0._target_.contextData.activityID][arg_20_1]
		local var_20_2 = var_4.getCommanders(var_20_1)
		local var_20_3 = arg_6_0._target_
		local var_20_4 = var_6.sendNotification

		GAME = var_2_10009

		local var_20_5 = var_2_10009.GO_SCENE

		SCENE = var_2_10010

		local var_20_6 = var_2_10010.COMMANDERCAT
		local var_20_7 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10012
		var_20_7.mode = var_2_10012.MODE_SELECT
		var_20_7.activeCommander = var_20_2[arg_20_2]
		CommanderCatScene = var_12
		var_20_7.fleetType = var_12.FLEET_TYPE_BOSSSINGLE_VARIABLE
		var_20_7.ignoredIds = {}

		function var_20_7.onCommander(arg_21_0)
			return true
		end

		function var_20_7.onSelected(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10005

			local var_22_1 = var_3_10003(var_3_10005)
			local var_22_2 = var_3.getCommanderById(var_22_1, var_22_0)

			pairs = var_3_10005

			for iter_22_0, iter_22_1 in var_3_10005(var_0) do
				if iter_22_0 == arg_20_1 then
					pairs = var_10

					for iter_22_2, iter_22_3 in var_10(var_20_2) do
						if iter_22_3.groupId == var_22_2.groupId and iter_22_2 ~= arg_20_2 then
							pg = var_15

							local var_22_3 = var_15.TipsMgr.GetInstance()
							local var_22_4 = var_15.ShowTips

							i18n = var_3_10018

							var_22_4(var_22_3, var_3_10018("commander_can_not_select_same_group"))

							return
						end
					end
				elseif iter_22_0 == var_0_0.GetPairedFleetIndex(arg_20_1, arg_6_0._subFleetOffset) then
					local var_22_5 = iter_22_1:getCommanders()

					pairs = var_3_10011

					for iter_22_4, iter_22_5 in var_3_10011(var_22_5) do
						if var_22_0 == iter_22_5.id then
							pg = var_16
							var_3_10018 = var_16.TipsMgr.GetInstance()

							local var_22_6 = var_16.ShowTips

							i18n = var_3_10019

							var_22_6(var_3_10018, var_3_10019("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			local var_22_7 = var_0

			var_5.updateCommanderByPos(var_22_7, arg_20_2, var_22_2)

			local var_22_8 = var_6_1

			var_5.updateActivityFleet(var_22_8, arg_6_0._target_.contextData.activityID, arg_20_1, var_0)
			arg_22_1()

			return
		end

		function var_20_7.onQuit(arg_23_0)
			local var_23_0 = var_0

			var_1.updateCommanderByPos(var_23_0, arg_20_2, nil)

			local var_23_1 = var_6_1

			var_1.updateActivityFleet(var_23_1, arg_6_0._target_.contextData.activityID, arg_20_1, var_0)
			arg_23_0()

			return
		end

		var_20_4(var_20_3, var_20_5, var_20_6, var_20_7)

		return
	end)

	local var_6_23 = arg_6_0._target_
	local var_6_24 = var_6.bind

	PreCombatMediator = var_9

	var_6_24(var_6_23, var_9.BEGIN_STAGE_PROXY, function(arg_24_0, arg_24_1)
		local var_24_0 = arg_6_0._target_
		local var_24_1 = var_2.sendNotification

		PreCombatMediator = var_2_10005

		var_24_1(var_24_0, var_2_10005.BEGIN_STAGE_PROXY, {
			curFleetId = arg_24_1
		})

		return
	end)

	local var_6_25 = arg_6_0._target_

	var_6.bind(var_6_25, arg_6_0._target_.ON_PERFORM_COMBAT, function(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = arg_6_0._target_
		local var_25_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_25_2 = var_2_10006.BEGIN_STAGE
		local var_25_3 = {}

		SYSTEM_PERFORM = var_2_10008
		var_25_3.system = var_2_10008
		var_25_3.stageId = arg_25_1
		var_25_3.exitCallback = arg_25_2

		var_25_1(var_25_0, var_25_2, var_25_3)

		return
	end)

	return
end

function var_0_0.GetPairedFleetIndex(arg_26_0, arg_26_1)
	Fleet = var_1_10002

	if arg_26_0 < var_1_10002.SUBMARINE_FLEET_ID then
		return arg_26_0 + arg_26_1
	else
		return arg_26_0 - arg_26_1
	end

	return
end

function var_0_0.getDockCallbackFuncs4ActicityFleet(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_27_0 = var_1_10004(var_1_10006)

	getProxy = var_1_10005
	FleetProxy = var_1_10007

	local var_27_1 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_27_2 = var_1_10006(var_1_10008)
	local var_27_3 = var_6.getActivityByType(var_27_2, arg_27_0)
	local var_27_4 = var_27_1:getActivityFleets()[var_27_3.id][arg_27_2]

	local function var_27_5(arg_28_0, arg_28_1)
		ShipStatus = var_2_10002

		local var_28_0, var_28_1 = var_2_10002.ShipStatusCheck("inActivity", arg_28_0, arg_28_1, {
			inActivity = var_27_3.id
		})

		if not var_28_0 then
			return var_28_0, var_28_1
		end

		if arg_27_1 then
			local var_28_2 = arg_27_1

			if var_4.isSameKind(var_28_2, arg_28_0) then
				return true
			end
		end

		ipairs = var_4

		local var_28_3

		if not var_27_4.ships then
			var_28_3 = {}
		end

		for iter_28_0, iter_28_1 in var_4(var_28_3) do
			local var_28_4 = arg_28_0
			local var_28_5 = arg_28_0.isSameKind
			local var_28_6 = var_27_0

			if var_28_5(var_28_4, var_12.getShipById(var_28_6, iter_28_1)) then
				local var_28_7 = false

				i18n = var_2_10010
				var_2_10010 = var_2_10010("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_27_6(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1()

		return
	end

	local function var_27_7(arg_30_0)
		if arg_27_1 then
			local var_30_0 = var_27_4

			var_1.removeShip(var_30_0, arg_27_1)
		end

		if #arg_30_0 > 0 then
			local var_30_1 = var_27_0
			local var_30_2 = var_1.getShipById(var_30_1, arg_30_0[1])
			local var_30_3 = var_27_4

			if not var_2.containShip(var_30_3, var_30_2) then
				local var_30_4 = var_27_4

				var_2.insertShip(var_30_4, var_30_2, nil, arg_27_3)
			elseif arg_27_1 then
				local var_30_5 = var_27_4

				var_2.insertShip(var_30_5, arg_27_1, nil, arg_27_3)
			end

			local var_30_6 = var_27_4

			var_2.RemoveUnusedItems(var_30_6)
		end

		local var_30_7 = var_27_1

		var_1.updateActivityFleet(var_30_7, var_27_3.id, arg_27_2, var_27_4)

		return
	end

	return var_27_5, var_27_6, var_27_7
end

return var_0_0
