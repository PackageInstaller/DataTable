class = var_0_10000

local var_0_0 = "BossSinglePreCombatLiteMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BossSinglePreCombatMediator"))

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

		GAME = iter_8_0

		local var_8_4 = iter_8_0.GO_SCENE

		SCENE = iter_8_1

		var_8_3(var_8_2, var_8_4, iter_8_1.SHIPINFO, {
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
		local var_10_0 = arg_2_0.viewComponent

		var_3.emit(var_10_0, var_0_1.BEGIN_STAGE_PROXY, {
			curFleetId = arg_10_1,
			continuousBattleTimes = arg_10_2
		})

		return
	end)
	arg_2_0:bind(var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_2_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_11_2 = var_2_10005.New
		local var_11_3 = {}

		BossSingleContinuousOperationWindowMediator = var_2_10008
		var_11_3.mediator = var_2_10008
		BossSingleContinuousOperationWindow = var_2_10008
		var_11_3.viewComponent = var_2_10008
		var_11_3.data = {
			mainFleetId = arg_11_1,
			stageId = arg_2_0.contextData.stageId,
			system = arg_2_0.contextData.system,
			oilCost = var_2_1()
		}

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)
	arg_2_0:bind(var_0_1.BEGIN_STAGE_PROXY, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_2_0.contextData.useTicket and 1 or 0
		local var_12_1 = arg_2_0
		local var_12_2 = var_3.sendNotification

		GAME = var_2_10006

		var_12_2(var_12_1, var_2_10006.BEGIN_STAGE, {
			stageId = arg_2_0.contextData.stageId,
			mainFleetId = arg_12_1.curFleetId,
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			variableBuffList = arg_2_0.contextData.buffList,
			continuousBattleTimes = arg_12_1.continuousBattleTimes,
			totalBattleTimes = arg_12_1.continuousBattleTimes,
			useVariableTicket = var_12_0
		})

		return
	end)

	return
end

function var_0_1.refreshEdit(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)
	local var_13_1 = arg_13_0.contextData.actId

	var_13_0:updateActivityFleet(var_13_1, arg_13_1.id, arg_13_1)

	local var_13_2 = var_13_0:getActivityFleets()[var_13_1]
	local var_13_3 = arg_13_0.viewComponent

	var_5.SetFleets(var_13_3, var_13_2)

	local var_13_4 = arg_13_0.viewComponent

	var_5.UpdateFleetView(var_13_4, false)

	return
end

function var_0_1.commitEdit(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_14_0 = var_1_10002(var_1_10004)

	var_2.commitActivityFleet(var_14_0, arg_14_0.contextData.actId)
	arg_14_1()

	return
end

function var_0_1.onAutoBtn(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.isOn
	local var_15_1 = arg_15_1.toggle
	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.sendNotification

	GAME = var_1_10007

	var_15_3(var_15_2, var_1_10007.AUTO_BOT, {
		isActiveBot = var_15_0,
		toggle = var_15_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.isOn
	local var_16_1 = arg_16_1.toggle
	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.sendNotification

	GAME = var_1_10007

	var_16_3(var_16_2, var_1_10007.AUTO_SUB, {
		isActiveSub = var_16_0,
		toggle = var_16_1
	})

	return
end

function var_0_1.removeShipFromFleet(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1:removeShip(arg_17_2)

	return true
end

function var_0_1.listNotificationInterests(arg_18_0)
	local var_18_0 = {}

	GAME = var_1_10002
	var_18_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_18_0[2] = var_2.BEGIN_STAGE_ERRO
	PreCombatMediator = var_2
	var_18_0[3] = var_2.BEGIN_STAGE_PROXY
	var_18_0[4] = var_0_1.CONTINUOUS_OPERATION

	return var_18_0
end

function var_0_1.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.getName(var_19_0)
	local var_19_2 = arg_19_1:getBody()

	GAME = var_19_0

	local var_19_4

	if var_19_1 == var_19_0.BEGIN_STAGE_DONE then
		local var_19_3 = arg_19_0

		var_19_4 = arg_19_0.sendNotification
		GAME = var_1_10007
		var_1_10007 = var_1_10007.GO_SCENE
		SCENE = var_1_10008

		var_19_4(var_19_3, var_1_10007, var_1_10008.COMBATLOAD, var_19_2)
	else
		GAME = var_19_4

		local var_19_6

		if var_19_1 == var_19_4.BEGIN_STAGE_ERRO then
			if var_19_2 == 3 then
				pg = var_19_6

				local var_19_5 = var_19_6.MsgboxMgr.GetInstance()

				var_19_6 = var_19_6.ShowMsgBox
				var_1_10007 = {
					hideNo = true
				}
				i18n = var_1_10008
				var_1_10007.content = var_1_10008("battle_preCombatMediator_timeout")

				function var_1_10007.onYes()
					local var_20_0 = arg_19_0.viewComponent

					var_0.closeView(var_20_0)

					return
				end

				var_19_6(var_19_5, var_1_10007)
			end
		else
			PreCombatMediator = var_19_6

			if var_19_1 == var_19_6.BEGIN_STAGE_PROXY then
				local var_19_7 = arg_19_0.viewComponent
				local var_19_8 = var_4.emit

				PreCombatMediator = var_1_10007

				var_19_8(var_19_7, var_1_10007.BEGIN_STAGE_PROXY, var_19_2)
			elseif var_19_1 == var_0_1.CONTINUOUS_OPERATION then
				local var_19_9 = arg_19_0.viewComponent
				local var_19_10 = var_4.emit

				PreCombatMediator = var_1_10007

				var_19_10(var_19_9, var_1_10007.ON_START, var_19_2.mainFleetId, var_19_2.battleTimes)
			end
		end
	end

	return
end

return var_0_1
