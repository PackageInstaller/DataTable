local var_0_0 = class("PreCombatMediator", import("..base.ContextMediator"))

var_0_0.ON_START = "PreCombatMediator:ON_START"
var_0_0.ON_CHANGE_FLEET = "PreCombatMediator:ON_CHANGE_FLEET"
var_0_0.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
var_0_0.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
var_0_0.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
var_0_0.REMOVE_SHIP = "PreCombatMediator:REMOVE_SHIP"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.CHANGE_FLEET_SHIP = "PreCombatMediator:CHANGE_FLEET_SHIP"
var_0_0.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_0.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
var_0_0.ON_AUTO = "PreCombatMediator:ON_AUTO"
var_0_0.ON_SUB_AUTO = "PreCombatMediator:ON_SUB_AUTO"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:SetShips(arg_1_0.ships)

	local var_1_0 = getProxy(FleetProxy)
	local var_1_1 = var_1_0:getData()

	if var_1_0.EdittingFleet ~= nil then
		var_1_1[var_1_0.EdittingFleet.id] = var_1_0.EdittingFleet
	end

	arg_1_0.fleets = var_1_1

	arg_1_0.viewComponent:SetFleets(var_1_1)

	local var_1_2 = getProxy(PlayerProxy)

	arg_1_0.viewComponent:SetPlayerInfo((var_1_2:getData()))

	if arg_1_0.contextData.system == SYSTEM_DUEL then
		arg_1_0.viewComponent:SetCurrentFleet(FleetProxy.PVP_FLEET_ID)
	elseif arg_1_0.contextData.system == SYSTEM_SUB_ROUTINE then
		arg_1_0.viewComponent:SetStageID(arg_1_0.contextData.stageId)
		arg_1_0.viewComponent:SetCurrentFleet(arg_1_0.contextData.subFleetId)
	else
		arg_1_0.viewComponent:SetStageID(arg_1_0.contextData.stageId)
		arg_1_0.viewComponent:SetCurrentFleet(var_1_2.combatFleetId)
	end

	return
end

function var_0_0.bindEvent(arg_2_0)
	local var_2_0 = arg_2_0.contextData.system

	arg_2_0:bind(var_0_0.ON_ABORT_EDIT, function(arg_3_0)
		local var_3_0 = getProxy(FleetProxy)

		var_3_0:abortEditting()
		var_3_0:syncFleet()

		return
	end)
	arg_2_0:bind(var_0_0.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		arg_2_0:changeFleet(arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_AUTO, function(arg_5_0, arg_5_1)
		arg_2_0:onAutoBtn(arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		arg_2_0:onAutoSubBtn(arg_6_1)

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		arg_2_0:refreshEdit(arg_7_1)

		return
	end)
	arg_2_0:bind(var_0_0.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		FormationMediator.removeShipFromFleet(arg_8_2, arg_8_1)
		arg_2_0:refreshEdit(arg_8_2)

		return
	end)
	arg_2_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		arg_2_0.contextData.form = PreCombatLayer.FORM_EDIT

		for iter_9_0, iter_9_1 in ipairs(arg_9_2:getShipIds()) do
			table.insert({}, arg_2_0.ships[iter_9_1])
		end

		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = {}
		})

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		assert(arg_10_2.id ~= FleetProxy.PVP_FLEET_ID, "fleet type error")

		arg_2_0.contextData.form = PreCombatLayer.FORM_EDIT

		FormationMediator.saveEdit()

		local var_10_0 = var_2_0 == SYSTEM_DUEL

		if var_2_0 == SYSTEM_DUEL then
			local var_10_1 = ShipStatus.TAG_HIDE_PVP or ShipStatus.TAG_HIDE_NORMAL

			if var_10_0 then
				local var_10_2 = ShipStatus.TAG_BLOCK_PVP or nil
				local var_10_3, var_10_4, var_10_5 = FormationMediator.getDockCallbackFuncs(arg_2_0, arg_10_1, arg_10_2, arg_10_3)
				local var_10_6 = {}

				for iter_10_0, iter_10_1 in ipairs(arg_10_2.ships) do
					if not arg_10_1 or iter_10_1 ~= arg_10_1.id then
						table.insert(var_10_6, iter_10_1)
					end
				end

				arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
					selectedMin = 0,
					useBlackBlock = true,
					selectedMax = 1,
					energyDisplay = true,
					leastLimitMsg = i18n("battle_preCombatMediator_leastLimit"),
					quitTeam = arg_10_1 ~= nil,
					teamFilter = arg_10_3,
					onShip = var_10_3,
					confirmSelect = var_10_4,
					onSelected = var_10_5,
					hideTagFlags = var_10_1,
					blockTagFlags = var_10_2,
					otherSelectedIds = var_10_6
				})

				return
			end
		end
	end)
	arg_2_0:bind(var_0_0.ON_COMMIT_EDIT, function(arg_11_0, arg_11_1)
		arg_2_0:commitEdit(arg_11_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_START, function(arg_12_0, arg_12_1, arg_12_2)
		seriesAsync({
			function(arg_13_0)
				if pg.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_13_0()

					return
				end

				for iter_13_0, iter_13_1 in ipairs((nil).ships) do
					local var_13_1 = getProxy(BayProxy)

					table.insert({}, var_13_1:getShipById(iter_13_1))
				end

				Fleet.EnergyCheck({}, getProxy(FleetProxy):getFleetById(arg_12_1):GetName(), function(arg_14_0)
					if arg_14_0 then
						arg_13_0()
					end

					return
				end, nil, nil)

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
				arg_2_0.viewComponent:emit(var_0_0.BEGIN_STAGE_PROXY, {
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

		for iter_17_0, iter_17_1 in ipairs(arg_2_0.contextData.fleets) do
			local var_17_1 = iter_17_1:GetCostSum().oil
			local var_17_2 = arg_2_0.contextData.costLimit[iter_17_0 == 1 and 1 or 2]

			if arg_2_0.contextData.costLimit[iter_17_0 == 1 and 1 or 2] > 0 then
				var_17_1 = math.min(var_17_1, var_17_2)
			end

			var_17_0 = var_17_0 + var_17_1
		end

		return var_17_0
	end

	arg_2_0:bind(var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_18_0, arg_18_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = ContinuousOperationWindowMediator,
			viewComponent = ContinuousOperationWindow,
			data = {
				mainFleetId = arg_18_1,
				stageId = arg_2_0.contextData.stageId,
				system = arg_2_0.contextData.system,
				oilCost = var_2_1()
			}
		}))

		return
	end)
	arg_2_0:bind(var_0_0.BEGIN_STAGE_PROXY, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_2_0.contextData.rivalId and arg_2_0.contextData.rivalId or arg_2_0.contextData.stageId

		arg_2_0:sendNotification(GAME.BEGIN_STAGE, {
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

function var_0_0.changeFleet(arg_20_0, arg_20_1)
	if arg_20_0.contextData.system == SYSTEM_SUB_ROUTINE then
		arg_20_0.contextData.subFleetId = arg_20_1
	else
		getProxy(PlayerProxy).combatFleetId = arg_20_1
	end

	arg_20_0.viewComponent:SetCurrentFleet(arg_20_1)
	arg_20_0.viewComponent:UpdateFleetView(true)
	arg_20_0.viewComponent:SetFleetStepper()

	return
end

function var_0_0.refreshEdit(arg_21_0, arg_21_1)
	local var_21_0 = getProxy(FleetProxy)

	var_21_0.EdittingFleet = arg_21_1

	if arg_21_0.contextData.system ~= SYSTEM_SUB_ROUTINE then
		local var_21_1 = var_21_0:getData()

		var_21_1[arg_21_1.id] = arg_21_1

		arg_21_0.viewComponent:SetFleets(var_21_1)
	end

	arg_21_0.viewComponent:UpdateFleetView(false)

	return
end

function var_0_0.commitEdit(arg_22_0, arg_22_1)
	local var_22_0 = getProxy(FleetProxy)
	local var_22_1 = var_22_0.EdittingFleet

	if var_22_0.EdittingFleet == nil or var_22_0.EdittingFleet:isFirstFleet() or var_22_0.EdittingFleet:isLegalToFight() == true then
		var_22_0:commitEdittingFleet(arg_22_1)
	elseif #var_22_0.EdittingFleet.ships == 0 then
		var_22_0:commitEdittingFleet(arg_22_1)

		if arg_22_0.contextData.system == SYSTEM_SUB_ROUTINE then
			arg_22_0:changeFleet()
		else
			arg_22_0:changeFleet(1)
		end
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_formationMediaror_trash_warning", var_22_0.EdittingFleet.defaultName),
			onYes = function()
				local var_23_0 = getProxy(BayProxy):getRawData()

				for iter_23_0 = #var_22_1.ships, 1, -1 do
					var_22_1:removeShip(var_23_0[var_22_1.ships[iter_23_0]])
				end

				if var_22_1.id == FleetProxy.PVP_FLEET_ID then
					var_22_0:commitEdittingFleet()
					arg_22_0:changeFleet(FleetProxy.PVP_FLEET_ID)
				else
					var_22_0:commitEdittingFleet(arg_22_1)
					arg_22_0:changeFleet(1)
				end

				return
			end
		})
	end

	return
end

function var_0_0.onAutoBtn(arg_24_0, arg_24_1)
	arg_24_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_24_1.isOn,
		toggle = arg_24_1.toggle
	})

	return
end

function var_0_0.onAutoSubBtn(arg_25_0, arg_25_1)
	arg_25_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_25_1.isOn,
		toggle = arg_25_1.toggle
	})

	return
end

function var_0_0.listNotificationInterests(arg_26_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		var_0_0.CONTINUOUS_OPERATION
	}
end

function var_0_0.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == GAME.BEGIN_STAGE_DONE then
		arg_27_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_27_1)
	elseif var_27_0 == PlayerProxy.UPDATED then
		arg_27_0.viewComponent:SetPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_27_0 == GAME.BEGIN_STAGE_ERRO then
		if var_27_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					arg_27_0.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_27_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		arg_27_0.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_27_1)
	elseif var_27_0 == var_0_0.CONTINUOUS_OPERATION then
		arg_27_0.viewComponent:emit(PreCombatMediator.ON_START, var_27_1.mainFleetId, var_27_1.battleTimes)
	end

	return
end

return var_0_0
