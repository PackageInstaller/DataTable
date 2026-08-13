class = var_0_10000

local var_0_0 = "BossSinglePreCombatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_START = "PreCombatMediator:ON_START"
var_0_1.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
var_0_1.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
var_0_1.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_1.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
var_0_1.ON_AUTO = "BossSinglePreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "BossSinglePreCombatMediator:ON_SUB_AUTO"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bindEvent(var_1_0)

	getProxy = var_1
	BayProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0.ships = var_1.getRawData(var_1_1)

	local var_1_2 = arg_1_0.viewComponent

	var_2.SetShips(var_1_2, arg_1_0.ships)

	arg_1_0.fleets = arg_1_0.contextData.fleets

	local var_1_3 = arg_1_0.viewComponent

	var_3.SetFleets(var_1_3, var_2)

	getProxy = var_3
	PlayerProxy = var_1_3

	local var_1_4 = var_3(var_1_3)
	local var_1_5 = var_3.getData(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_5.SetPlayerInfo(var_1_6, var_1_5)

	local var_1_7 = var_2[1]
	local var_1_8 = arg_1_0.viewComponent

	var_6.SetCurrentFleet(var_1_8, var_1_7.id)

	ipairs = var_6

	for iter_1_0, iter_1_1 in var_6(var_2) do
		if iter_1_1:isSubmarineFleet() and iter_1_1:isLegalToFight() == true then
			local var_1_9 = arg_1_0.viewComponent

			var_11.SetSubFlag(var_1_9, true)

			break
		end
	end

	return
end

function var_0_1.bindEvent(arg_2_0)
	local var_2_0 = arg_2_0.contextData.system

	local function var_2_1()
		local var_3_0 = 0

		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_2_0.contextData.fleets) do
			local var_3_1 = iter_3_1:GetCostSum().oil
			local var_3_2 = iter_3_0 == 1
			local var_3_3 = arg_2_0.contextData.costLimit[var_3_2 and 1 or 2]

			if 0 < var_3_3 then
				math = var_9
				var_3_1 = var_9.min(var_3_1, var_3_3)
			end

			var_3_0 = var_3_0 + var_3_1
		end

		return var_3_0
	end

	arg_2_0:bind(var_0_1.ON_ABORT_EDIT, function(arg_4_0)
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
	arg_2_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_2_0.contextData

		PreCombatLayer = var_2_10004
		var_8_0.form = var_2_10004.FORM_EDIT

		local var_8_1 = {}

		ipairs = var_4

		for iter_8_0, iter_8_1 in var_4(arg_8_2:getShipIds()) do
			table = var_2_10009

			var_2_10009.insert(var_8_1, arg_2_0.ships[iter_8_1])
		end

		local var_8_2 = arg_2_0
		local var_8_3 = var_4.sendNotification

		GAME = var_6

		local var_8_4 = var_6.GO_SCENE

		SCENE = iter_8_0

		var_8_3(var_8_2, var_8_4, iter_8_0.SHIPINFO, {
			shipId = arg_8_1,
			shipVOs = var_8_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_2_0

		var_2.commitEdit(var_9_0, arg_9_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_START, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = var_2_1()

		getProxy = var_2_10004
		PlayerProxy = var_2_10005

		local var_10_1 = var_2_10004(var_2_10005)
		local var_10_3

		if var_4.getRawData(var_10_1).oil < var_10_0 then
			pg = var_10_3

			local var_10_2 = var_10_3.TipsMgr.GetInstance()

			var_10_3 = var_10_3.ShowTips
			i18n = var_2_10007

			var_10_3(var_10_2, var_2_10007("stage_beginStage_error_noResource"))

			return
		end

		seriesAsync = var_10_3

		var_10_3({
			function(arg_11_0)
				pg = var_3_10001

				if var_3_10001.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_11_0()

					return
				end

				local var_11_0
				local var_11_1
				local var_11_2 = arg_2_0.fleets[1]
				local var_11_3 = "ship_energy_low_warn_no_exp"
				local var_11_4 = {}

				ipairs = var_3_10005

				for iter_11_0, iter_11_1 in var_3_10005(var_11_2.ships) do
					table = var_3_10010
					var_3_10010 = var_3_10010.insert

					local var_11_5 = var_11_4

					getProxy = var_3_10012
					BayProxy = var_3_10013
					var_3_10013 = var_3_10012(var_3_10013)

					var_3_10010(var_11_5, var_3_10012.getShipById(var_3_10013, iter_11_1))
				end

				local var_11_6 = var_11_2
				local var_11_7 = var_11_2.GetName(var_11_6)

				Fleet = var_11_6

				var_11_6.EnergyCheck(var_11_4, var_11_7, function(arg_12_0)
					if arg_12_0 then
						arg_11_0()
					end

					return
				end, nil, var_11_3)

				return
			end,
			function(arg_13_0)
				if arg_2_0.contextData.OnConfirm then
					arg_2_0.contextData.OnConfirm(arg_13_0)
				else
					arg_13_0()
				end

				return
			end,
			function()
				local var_14_0 = arg_2_0.viewComponent

				var_0.emit(var_14_0, var_0_1.BEGIN_STAGE_PROXY, {
					curFleetId = arg_10_1,
					continuousBattleTimes = arg_10_2
				})

				return
			end
		})

		return
	end)
	arg_2_0:bind(var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_2_0
		local var_15_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		BossSingleContinuousOperationWindowMediator = var_2_10006
		var_15_3.mediator = var_2_10006
		BossSingleContinuousOperationWindow = var_2_10006
		var_15_3.viewComponent = var_2_10006
		var_15_3.data = {
			mainFleetId = arg_15_1,
			stageId = arg_2_0.contextData.stageId,
			system = arg_2_0.contextData.system,
			oilCost = var_2_1()
		}

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)
	arg_2_0:bind(var_0_1.BEGIN_STAGE_PROXY, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_2_0.contextData.useTicket and 1 or 0
		local var_16_1 = arg_2_0
		local var_16_2 = var_3.sendNotification

		GAME = var_2_10005

		var_16_2(var_16_1, var_2_10005.BEGIN_STAGE, {
			stageId = arg_2_0.contextData.stageId,
			mainFleetId = arg_16_1.curFleetId,
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			variableBuffList = arg_2_0.contextData.buffList,
			continuousBattleTimes = arg_16_1.continuousBattleTimes,
			totalBattleTimes = arg_16_1.continuousBattleTimes,
			useVariableTicket = var_16_0
		})

		return
	end)

	return
end

function var_0_1.refreshEdit(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_17_0 = var_1_10002(var_1_10003)
	local var_17_1 = arg_17_0.contextData.actId

	var_17_0:updateActivityFleet(var_17_1, arg_17_1.id, arg_17_1)

	local var_17_2 = var_17_0:getActivityFleets()[var_17_1]
	local var_17_3 = arg_17_0.viewComponent

	var_5.SetFleets(var_17_3, var_17_2)

	local var_17_4 = arg_17_0.viewComponent

	var_5.UpdateFleetView(var_17_4, false)

	return
end

function var_0_1.commitEdit(arg_18_0, arg_18_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_18_0 = var_1_10002(var_1_10003)

	var_2.commitActivityFleet(var_18_0, arg_18_0.contextData.actId)
	arg_18_1()

	return
end

function var_0_1.onAutoBtn(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.isOn
	local var_19_1 = arg_19_1.toggle
	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.sendNotification

	GAME = var_1_10006

	var_19_3(var_19_2, var_1_10006.AUTO_BOT, {
		isActiveBot = var_19_0,
		toggle = var_19_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.isOn
	local var_20_1 = arg_20_1.toggle
	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.sendNotification

	GAME = var_1_10006

	var_20_3(var_20_2, var_1_10006.AUTO_SUB, {
		isActiveSub = var_20_0,
		toggle = var_20_1
	})

	return
end

function var_0_1.removeShipFromFleet(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1:removeShip(arg_21_2)

	return true
end

function var_0_1.listNotificationInterests(arg_22_0)
	local var_22_0 = {}

	GAME = var_1_10002
	var_22_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_22_0[2] = var_2.BEGIN_STAGE_ERRO
	PreCombatMediator = var_2
	var_22_0[3] = var_2.BEGIN_STAGE_PROXY
	var_22_0[4] = var_0_1.CONTINUOUS_OPERATION

	return var_22_0
end

function var_0_1.handleNotification(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1
	local var_23_2 = arg_23_1.getBody(var_23_1)

	GAME = var_23_1

	local var_23_4

	if var_23_0 == var_23_1.BEGIN_STAGE_DONE then
		local var_23_3 = arg_23_0

		var_23_4 = arg_23_0.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		SCENE = var_1_10007

		var_23_4(var_23_3, var_1_10006, var_1_10007.COMBATLOAD, var_23_2)
	else
		GAME = var_23_4

		local var_23_6

		if var_23_0 == var_23_4.BEGIN_STAGE_ERRO then
			if var_23_2 == 3 then
				pg = var_23_6

				local var_23_5 = var_23_6.MsgboxMgr.GetInstance()

				var_23_6 = var_23_6.ShowMsgBox
				var_1_10006 = {
					hideNo = true
				}
				i18n = var_1_10007
				var_1_10006.content = var_1_10007("battle_preCombatMediator_timeout")

				function var_1_10006.onYes()
					local var_24_0 = arg_23_0.viewComponent

					var_0.closeView(var_24_0)

					return
				end

				var_23_6(var_23_5, var_1_10006)
			end
		else
			PreCombatMediator = var_23_6

			if var_23_0 == var_23_6.BEGIN_STAGE_PROXY then
				local var_23_7 = arg_23_0.viewComponent
				local var_23_8 = var_4.emit

				PreCombatMediator = var_1_10006

				var_23_8(var_23_7, var_1_10006.BEGIN_STAGE_PROXY, var_23_2)
			elseif var_23_0 == var_0_1.CONTINUOUS_OPERATION then
				local var_23_9 = arg_23_0.viewComponent
				local var_23_10 = var_4.emit

				PreCombatMediator = var_1_10006

				var_23_10(var_23_9, var_1_10006.ON_START, var_23_2.mainFleetId, var_23_2.battleTimes)
			end
		end
	end

	return
end

return var_0_1
