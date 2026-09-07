local BossSinglePreCombatMediator = class("BossSinglePreCombatMediator", import("view.base.ContextMediator"))

BossSinglePreCombatMediator.ON_START = "PreCombatMediator:ON_START"
BossSinglePreCombatMediator.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
BossSinglePreCombatMediator.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
BossSinglePreCombatMediator.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
BossSinglePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
BossSinglePreCombatMediator.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
BossSinglePreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
BossSinglePreCombatMediator.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
BossSinglePreCombatMediator.ON_AUTO = "BossSinglePreCombatMediator:ON_AUTO"
BossSinglePreCombatMediator.ON_SUB_AUTO = "BossSinglePreCombatMediator:ON_SUB_AUTO"

function BossSinglePreCombatMediator:register()
	self:bindEvent()

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	self.fleets = self.contextData.fleets

	self.viewComponent:SetFleets(self.contextData.fleets)
	self.viewComponent:SetPlayerInfo((getProxy(PlayerProxy):getData()))
	self.viewComponent:SetCurrentFleet(self.contextData.fleets[1].id)

	for iter_1_0, iter_1_1 in ipairs(self.contextData.fleets) do
		if iter_1_1:isSubmarineFleet() and iter_1_1:isLegalToFight() == true then
			self.viewComponent:SetSubFlag(true)

			break
		end
	end

	return
end

function BossSinglePreCombatMediator:bindEvent()
	local var_2_0 = self.contextData.system

	local function var_2_1()
		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs(self.contextData.fleets) do
			local var_3_1 = iter_3_1:GetCostSum().oil

			if self.contextData.costLimit[iter_3_0 == 1 and 1 or 2] > 0 then
				var_3_1 = math.min(var_3_1, self.contextData.costLimit[iter_3_0 == 1 and 1 or 2])
			end

			var_3_0 = var_3_0 + var_3_1
		end

		return var_3_0
	end

	self:bind(BossSinglePreCombatMediator.ON_ABORT_EDIT, function(arg_4_0)
		return
	end)
	self:bind(BossSinglePreCombatMediator.ON_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoBtn(arg_5_1)

		return
	end)
	self:bind(BossSinglePreCombatMediator.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		self:onAutoSubBtn(arg_6_1)

		return
	end)
	self:bind(BossSinglePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		self:refreshEdit(arg_7_1)

		return
	end)
	self:bind(BossSinglePreCombatMediator.OPEN_SHIP_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		self.contextData.form = PreCombatLayer.FORM_EDIT

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2:getShipIds()) do
			table.insert(var_8_0, self.ships[iter_8_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_8_1,
			shipVOs = var_8_0
		})

		return
	end)
	self:bind(BossSinglePreCombatMediator.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		self:commitEdit(arg_9_1)

		return
	end)
	self:bind(BossSinglePreCombatMediator.ON_START, function(arg_10_0, arg_10_1, arg_10_2)
		if var_2_1() > getProxy(PlayerProxy):getRawData().oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		seriesAsync({
			function(arg_11_0)
				if pg.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_11_0()

					return
				end

				local var_11_1 = {}

				for iter_11_0, iter_11_1 in ipairs(self.fleets[1].ships) do
					table.insert(var_11_1, getProxy(BayProxy):getShipById(iter_11_1))
				end

				Fleet.EnergyCheck(var_11_1, self.fleets[1]:GetName(), function(arg_12_0)
					if arg_12_0 then
						arg_11_0()
					end

					return
				end, nil, "ship_energy_low_warn_no_exp")

				return
			end,
			function(arg_13_0)
				if self.contextData.OnConfirm then
					self.contextData.OnConfirm(arg_13_0)
				else
					arg_13_0()
				end

				return
			end,
			function()
				self.viewComponent:emit(BossSinglePreCombatMediator.BEGIN_STAGE_PROXY, {
					curFleetId = arg_10_1,
					continuousBattleTimes = arg_10_2
				})

				return
			end
		})

		return
	end)
	self:bind(BossSinglePreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_15_0, arg_15_1)
		self:addSubLayers(Context.New({
			mediator = BossSingleContinuousOperationWindowMediator,
			viewComponent = BossSingleContinuousOperationWindow,
			data = {
				mainFleetId = arg_15_1,
				stageId = self.contextData.stageId,
				system = self.contextData.system,
				oilCost = var_2_1()
			}
		}))

		return
	end)
	self:bind(BossSinglePreCombatMediator.BEGIN_STAGE_PROXY, function(arg_16_0, arg_16_1)
		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = self.contextData.stageId,
			mainFleetId = arg_16_1.curFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			variableBuffList = self.contextData.buffList,
			continuousBattleTimes = arg_16_1.continuousBattleTimes,
			totalBattleTimes = arg_16_1.continuousBattleTimes,
			useVariableTicket = self.contextData.useTicket and 1 or 0
		})

		return
	end)

	return
end

function BossSinglePreCombatMediator:refreshEdit(arg_17_1)
	local var_17_0 = getProxy(FleetProxy)

	var_17_0:updateActivityFleet(self.contextData.actId, arg_17_1.id, arg_17_1)
	self.viewComponent:SetFleets(var_17_0:getActivityFleets()[self.contextData.actId])
	self.viewComponent:UpdateFleetView(false)

	return
end

function BossSinglePreCombatMediator:commitEdit(arg_18_1)
	getProxy(FleetProxy):commitActivityFleet(self.contextData.actId)
	arg_18_1()

	return
end

function BossSinglePreCombatMediator:onAutoBtn(arg_19_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_19_1.isOn,
		toggle = arg_19_1.toggle
	})

	return
end

function BossSinglePreCombatMediator:onAutoSubBtn(arg_20_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_20_1.isOn,
		toggle = arg_20_1.toggle
	})

	return
end

function BossSinglePreCombatMediator:removeShipFromFleet(arg_21_1, arg_21_2)
	arg_21_1:removeShip(arg_21_2)

	return true
end

function BossSinglePreCombatMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		BossSinglePreCombatMediator.CONTINUOUS_OPERATION
	}
end

function BossSinglePreCombatMediator:handleNotification(arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_23_1)
	elseif var_23_0 == GAME.BEGIN_STAGE_ERRO then
		if var_23_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:closeView()

					return
				end
			})
		end
	elseif var_23_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		self.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_23_1)
	elseif var_23_0 == BossSinglePreCombatMediator.CONTINUOUS_OPERATION then
		self.viewComponent:emit(PreCombatMediator.ON_START, var_23_1.mainFleetId, var_23_1.battleTimes)
	end

	return
end

return BossSinglePreCombatMediator
