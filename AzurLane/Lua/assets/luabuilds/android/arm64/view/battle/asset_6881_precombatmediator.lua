class = var_0_10000

local var_0_0 = "PreCombatMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_START = "PreCombatMediator:ON_START"
var_0_1.ON_CHANGE_FLEET = "PreCombatMediator:ON_CHANGE_FLEET"
var_0_1.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
var_0_1.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
var_0_1.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
var_0_1.REMOVE_SHIP = "PreCombatMediator:REMOVE_SHIP"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.CHANGE_FLEET_SHIP = "PreCombatMediator:CHANGE_FLEET_SHIP"
var_0_1.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_1.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
var_0_1.ON_AUTO = "PreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "PreCombatMediator:ON_SUB_AUTO"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bindEvent(var_1_0)

	getProxy = var_1
	BayProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0.ships = var_1.getRawData(var_1_1)

	local var_1_2 = arg_1_0.viewComponent

	var_2.SetShips(var_1_2, arg_1_0.ships)

	local var_1_3 = arg_1_0.contextData.system

	getProxy = var_1_0
	FleetProxy = var_5

	local var_1_4 = var_1_0(var_5)
	local var_1_5 = var_3.getData(var_1_4)

	if var_3.EdittingFleet ~= nil then
		var_1_5[var_3.EdittingFleet.id] = var_3.EdittingFleet
	end

	arg_1_0.fleets = var_1_5

	local var_1_6 = arg_1_0.viewComponent

	var_5.SetFleets(var_1_6, var_1_5)

	getProxy = var_5
	PlayerProxy = var_1_6

	local var_1_7 = var_5(var_1_6)
	local var_1_8 = var_5.getData(var_1_7)
	local var_1_9 = arg_1_0.viewComponent

	var_7.SetPlayerInfo(var_1_9, var_1_8)

	SYSTEM_DUEL = var_1_11

	local var_1_11

	if var_1_3 == var_1_11 then
		local var_1_10 = arg_1_0.viewComponent

		var_1_11 = var_1_11.SetCurrentFleet
		FleetProxy = var_10

		var_1_11(var_1_10, var_10.PVP_FLEET_ID)
	else
		SYSTEM_SUB_ROUTINE = var_1_11

		if var_1_3 == var_1_11 then
			local var_1_12 = arg_1_0.viewComponent

			var_7.SetStageID(var_1_12, arg_1_0.contextData.stageId)

			local var_1_13 = arg_1_0.viewComponent

			var_7.SetCurrentFleet(var_1_13, arg_1_0.contextData.subFleetId)
		else
			local var_1_14 = arg_1_0.viewComponent

			var_7.SetStageID(var_1_14, arg_1_0.contextData.stageId)

			local var_1_15 = arg_1_0.viewComponent

			var_7.SetCurrentFleet(var_1_15, var_5.combatFleetId)
		end
	end

	return
end

function var_0_1.bindEvent(arg_2_0)
	local var_2_0 = arg_2_0.contextData.system

	arg_2_0:bind(var_0_1.ON_ABORT_EDIT, function(arg_3_0)
		getProxy = var_2_10001
		FleetProxy = var_2_10003

		local var_3_0 = var_2_10001(var_2_10003)

		var_1.abortEditting(var_3_0)
		var_1:syncFleet()

		return
	end)
	arg_2_0:bind(var_0_1.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.changeFleet(var_4_0, arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_AUTO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onAutoBtn(var_5_0, arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.onAutoSubBtn(var_6_0, arg_6_1)

		return
	end)
	arg_2_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.refreshEdit(var_7_0, arg_7_1)

		return
	end)
	arg_2_0:bind(var_0_1.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		FormationMediator = var_2_10003

		var_2_10003.removeShipFromFleet(arg_8_2, arg_8_1)

		local var_8_0 = arg_2_0

		var_3.refreshEdit(var_8_0, arg_8_2)

		return
	end)
	arg_2_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_2_0.contextData

		PreCombatLayer = var_2_10004
		var_9_0.form = var_2_10004.FORM_EDIT

		local var_9_1 = {}

		ipairs = var_4

		for iter_9_0, iter_9_1 in var_4(arg_9_2:getShipIds()) do
			table = var_2_10009

			var_2_10009.insert(var_9_1, arg_2_0.ships[iter_9_1])
		end

		local var_9_2 = arg_2_0
		local var_9_3 = var_4.sendNotification

		GAME = iter_9_0

		local var_9_4 = iter_9_0.GO_SCENE

		SCENE = iter_9_1

		var_9_3(var_9_2, var_9_4, iter_9_1.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = var_9_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		assert = var_2_10004

		local var_10_0 = arg_10_2.id

		FleetProxy = var_2_10007

		var_2_10004(var_10_0 ~= var_2_10007.PVP_FLEET_ID, "fleet type error")

		local var_10_1 = arg_2_0.contextData

		PreCombatLayer = var_2_10005
		var_10_1.form = var_2_10005.FORM_EDIT
		FormationMediator = var_10_1

		var_10_1.saveEdit()

		local var_10_2 = var_2_0

		SYSTEM_DUEL = var_10_3

		if var_10_2 == var_10_3 then
			ShipStatus = var_10_3

			local var_10_3

			if not var_10_3.TAG_HIDE_PVP then
				ShipStatus = var_10_3
				var_10_3 = var_10_3.TAG_HIDE_NORMAL
			end

			if var_4 then
				ShipStatus = var_6

				local var_10_4

				if not var_6.TAG_BLOCK_PVP then
					var_10_4 = nil
				end

				FormationMediator = var_7

				local var_10_5, var_10_6, var_10_7 = var_7.getDockCallbackFuncs(arg_2_0, arg_10_1, arg_10_2, arg_10_3)
				local var_10_8 = {}

				ipairs = var_11

				for iter_10_0, iter_10_1 in var_11(arg_10_2.ships) do
					if not arg_10_1 or iter_10_1 ~= arg_10_1.id then
						table = var_2_10016

						var_2_10016.insert(var_10_8, iter_10_1)
					end
				end

				local var_10_9 = arg_2_0
				local var_10_10 = var_11.sendNotification

				GAME = iter_10_0

				local var_10_11 = iter_10_0.GO_SCENE

				SCENE = iter_10_1

				local var_10_12 = iter_10_1.DOCKYARD
				local var_10_13 = {
					selectedMin = 0,
					useBlackBlock = true,
					selectedMax = 1,
					energyDisplay = true
				}

				i18n = var_2_10017
				var_10_13.leastLimitMsg = var_2_10017("battle_preCombatMediator_leastLimit")
				var_10_13.quitTeam = arg_10_1 ~= nil
				var_10_13.teamFilter = arg_10_3
				var_10_13.onShip = var_10_5
				var_10_13.confirmSelect = var_10_6
				var_10_13.onSelected = var_10_7
				var_10_13.hideTagFlags = var_10_3
				var_10_13.blockTagFlags = var_10_4
				var_10_13.otherSelectedIds = var_10_8

				var_10_10(var_10_9, var_10_11, var_10_12, var_10_13)

				return
			end
		end
	end)
	arg_2_0:bind(var_0_1.ON_COMMIT_EDIT, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_2_0

		var_2.commitEdit(var_11_0, arg_11_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_START, function(arg_12_0, arg_12_1, arg_12_2)
		seriesAsync = var_2_10003

		var_2_10003({
			function(arg_13_0)
				pg = var_3_10001

				if var_3_10001.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_13_0()

					return
				end

				local var_13_0
				local var_13_1

				getProxy = var_3_10004
				FleetProxy = var_3_10006

				local var_13_2 = var_3_10004(var_3_10006)
				local var_13_3 = var_4.getFleetById(var_13_2, arg_12_1)
				local var_13_4 = {}

				ipairs = var_3_10005

				for iter_13_0, iter_13_1 in var_3_10005(var_13_3.ships) do
					table = var_3_10010
					var_3_10010 = var_3_10010.insert

					local var_13_5 = var_13_4

					getProxy = var_3_10013
					BayProxy = var_3_10015
					var_3_10015 = var_3_10013(var_3_10015)

					var_3_10010(var_13_5, var_3_10013.getShipById(var_3_10015, iter_13_1))
				end

				local var_13_6 = var_13_3:GetName()

				Fleet = var_6

				var_6.EnergyCheck(var_13_4, var_13_6, function(arg_14_0)
					if arg_14_0 then
						arg_13_0()
					end

					return
				end, nil, var_13_1)

				return
			end,
			function(arg_15_0)
				if arg_2_0.contextData.OnConfirm then
					arg_2_0.contextData.OnConfirm(arg_15_0)
				else
					arg_15_0()
				end

				return
			end,
			function()
				local var_16_0 = arg_2_0.viewComponent

				var_0.emit(var_16_0, var_0_1.BEGIN_STAGE_PROXY, {
					curFleetId = arg_12_1,
					continuousBattleTimes = arg_12_2
				})

				return
			end
		})

		return
	end)

	local function var_2_1()
		local var_17_0 = 0

		ipairs = var_2_10001

		for iter_17_0, iter_17_1 in var_2_10001(arg_2_0.contextData.fleets) do
			local var_17_1 = iter_17_1:GetCostSum().oil
			local var_17_2 = iter_17_0 == 1
			local var_17_3 = arg_2_0.contextData.costLimit[var_17_2 and 1 or 2]

			if 0 < var_17_3 then
				math = var_9
				var_17_1 = var_9.min(var_17_1, var_17_3)
			end

			var_17_0 = var_17_0 + var_17_1
		end

		return var_17_0
	end

	arg_2_0:bind(var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_2_0
		local var_18_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_18_2 = var_2_10005.New
		local var_18_3 = {}

		ContinuousOperationWindowMediator = var_2_10008
		var_18_3.mediator = var_2_10008
		ContinuousOperationWindow = var_2_10008
		var_18_3.viewComponent = var_2_10008
		var_18_3.data = {
			mainFleetId = arg_18_1,
			stageId = arg_2_0.contextData.stageId,
			system = arg_2_0.contextData.system,
			oilCost = var_2_1()
		}

		var_18_1(var_18_0, var_18_2(var_18_3))

		return
	end)
	arg_2_0:bind(var_0_1.BEGIN_STAGE_PROXY, function(arg_19_0, arg_19_1)
		local var_19_0

		if arg_2_0.contextData.rivalId then
			var_19_0 = arg_2_0.contextData.rivalId
		else
			var_19_0 = arg_2_0.contextData.stageId
		end

		local var_19_1 = arg_2_0
		local var_19_2 = var_3.sendNotification

		GAME = var_2_10006

		var_19_2(var_19_1, var_2_10006.BEGIN_STAGE, {
			stageId = var_19_0,
			mainFleetId = arg_19_1.curFleetId,
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			rivalId = arg_2_0.contextData.rivalId,
			continuousBattleTimes = arg_19_1.continuousBattleTimes,
			totalBattleTimes = arg_19_1.continuousBattleTimes
		})

		return
	end)

	return
end

function var_0_1.changeFleet(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.contextData.system

	SYSTEM_SUB_ROUTINE = var_1_10003

	if var_20_0 == var_1_10003 then
		var_20_0 = arg_20_0.contextData
		var_20_0.subFleetId = arg_20_1
	else
		getProxy = var_20_0
		PlayerProxy = var_1_10004
		var_20_0(var_1_10004).combatFleetId = arg_20_1
	end

	local var_20_1 = arg_20_0.viewComponent

	var_2.SetCurrentFleet(var_20_1, arg_20_1)

	local var_20_2 = arg_20_0.viewComponent

	var_2.UpdateFleetView(var_20_2, true)

	local var_20_3 = arg_20_0.viewComponent

	var_2.SetFleetStepper(var_20_3)

	return
end

function var_0_1.refreshEdit(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_21_0 = var_1_10002(var_1_10004)

	var_21_0.EdittingFleet = arg_21_1

	local var_21_1 = arg_21_0.contextData.system

	SYSTEM_SUB_ROUTINE = var_1_10004

	if var_21_1 ~= var_1_10004 then
		local var_21_2 = var_21_0:getData()

		var_21_2[arg_21_1.id] = arg_21_1

		local var_21_3 = arg_21_0.viewComponent

		var_4.SetFleets(var_21_3, var_21_2)
	end

	local var_21_4 = arg_21_0.viewComponent

	var_3.UpdateFleetView(var_21_4, false)

	return
end

function var_0_1.commitEdit(arg_22_0, arg_22_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	if var_1_10002(var_1_10004).EdittingFleet == nil or var_3:isFirstFleet() or var_3:isLegalToFight() == true then
		var_2:commitEdittingFleet(arg_22_1)
	else
		local var_22_0

		if #var_3.ships == 0 then
			var_2:commitEdittingFleet(arg_22_1)

			var_22_0 = arg_22_0.contextData.system
			SYSTEM_SUB_ROUTINE = var_1_10005

			if var_22_0 == var_1_10005 then
				arg_22_0:changeFleet()
			else
				arg_22_0:changeFleet(1)
			end
		else
			pg = var_22_0

			local var_22_1 = var_22_0.MsgboxMgr.GetInstance()
			local var_22_2 = var_4.ShowMsgBox
			local var_22_3 = {}

			i18n = var_1_10008
			var_22_3.content = var_1_10008("ship_formationMediaror_trash_warning", var_3.defaultName)

			function var_22_3.onYes()
				getProxy = var_2_10000
				BayProxy = var_2_10002

				local var_23_0 = var_2_10000(var_2_10002)
				local var_23_1 = var_0.getRawData(var_23_0)

				for iter_23_0 = #var_0.ships, 1, -1 do
					local var_23_2 = var_0

					var_7.removeShip(var_23_2, var_23_1[var_2[iter_23_0]])
				end

				local var_23_3 = var_0.id

				FleetProxy = var_4

				if var_23_3 == var_4.PVP_FLEET_ID then
					local var_23_4 = var_0

					var_3.commitEdittingFleet(var_23_4)

					local var_23_5 = arg_22_0
					local var_23_6 = var_3.changeFleet

					FleetProxy = iter_23_0

					var_23_6(var_23_5, iter_23_0.PVP_FLEET_ID)
				else
					local var_23_7 = var_0

					var_3.commitEdittingFleet(var_23_7, arg_22_1)

					local var_23_8 = arg_22_0

					var_3.changeFleet(var_23_8, 1)
				end

				return
			end

			var_22_2(var_22_1, var_22_3)
		end
	end

	return
end

function var_0_1.onAutoBtn(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.isOn
	local var_24_1 = arg_24_1.toggle
	local var_24_2 = arg_24_0
	local var_24_3 = arg_24_0.sendNotification

	GAME = var_1_10007

	var_24_3(var_24_2, var_1_10007.AUTO_BOT, {
		isActiveBot = var_24_0,
		toggle = var_24_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.isOn
	local var_25_1 = arg_25_1.toggle
	local var_25_2 = arg_25_0
	local var_25_3 = arg_25_0.sendNotification

	GAME = var_1_10007

	var_25_3(var_25_2, var_1_10007.AUTO_SUB, {
		isActiveSub = var_25_0,
		toggle = var_25_1
	})

	return
end

function var_0_1.listNotificationInterests(arg_26_0)
	local var_26_0 = {}

	GAME = var_1_10002
	var_26_0[1] = var_1_10002.BEGIN_STAGE_DONE
	PlayerProxy = var_2
	var_26_0[2] = var_2.UPDATED
	GAME = var_2
	var_26_0[3] = var_2.BEGIN_STAGE_ERRO
	PreCombatMediator = var_2
	var_26_0[4] = var_2.BEGIN_STAGE_PROXY
	var_26_0[5] = var_0_1.CONTINUOUS_OPERATION

	return var_26_0
end

function var_0_1.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1
	local var_27_1 = arg_27_1.getName(var_27_0)
	local var_27_2 = arg_27_1:getBody()

	GAME = var_27_0

	local var_27_4

	if var_27_1 == var_27_0.BEGIN_STAGE_DONE then
		local var_27_3 = arg_27_0

		var_27_4 = arg_27_0.sendNotification
		GAME = var_1_10007
		var_1_10007 = var_1_10007.GO_SCENE
		SCENE = var_1_10008

		var_27_4(var_27_3, var_1_10007, var_1_10008.COMBATLOAD, var_27_2)
	else
		PlayerProxy = var_27_4

		local var_27_6

		if var_27_1 == var_27_4.UPDATED then
			local var_27_5 = arg_27_0.viewComponent

			var_27_6 = var_27_6.SetPlayerInfo
			getProxy = var_1_10007
			PlayerProxy = var_1_10009

			local var_27_7 = var_1_10007(var_1_10009)

			var_27_6(var_27_5, var_1_10007.getData(var_27_7))
		else
			GAME = var_27_6

			local var_27_9

			if var_27_1 == var_27_6.BEGIN_STAGE_ERRO then
				if var_27_2 == 3 then
					pg = var_27_9

					local var_27_8 = var_27_9.MsgboxMgr.GetInstance()

					var_27_9 = var_27_9.ShowMsgBox
					var_1_10007 = {
						hideNo = true
					}
					i18n = var_1_10008
					var_1_10007.content = var_1_10008("battle_preCombatMediator_timeout")

					function var_1_10007.onYes()
						local var_28_0 = arg_27_0.viewComponent
						local var_28_1 = var_0.emit

						BaseUI = var_2_10003

						var_28_1(var_28_0, var_2_10003.ON_CLOSE)

						return
					end

					var_27_9(var_27_8, var_1_10007)
				end
			else
				PreCombatMediator = var_27_9

				if var_27_1 == var_27_9.BEGIN_STAGE_PROXY then
					local var_27_10 = arg_27_0.viewComponent
					local var_27_11 = var_4.emit

					PreCombatMediator = var_1_10007

					var_27_11(var_27_10, var_1_10007.BEGIN_STAGE_PROXY, var_27_2)
				elseif var_27_1 == var_0_1.CONTINUOUS_OPERATION then
					local var_27_12 = arg_27_0.viewComponent
					local var_27_13 = var_4.emit

					PreCombatMediator = var_1_10007

					var_27_13(var_27_12, var_1_10007.ON_START, var_27_2.mainFleetId, var_27_2.battleTimes)
				end
			end
		end
	end

	return
end

return var_0_1
