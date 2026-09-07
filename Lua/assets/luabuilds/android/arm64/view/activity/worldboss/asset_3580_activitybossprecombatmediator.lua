local ActivityBossPreCombatMediator = class("ActivityBossPreCombatMediator", import("view.base.ContextMediator"))

ActivityBossPreCombatMediator.ON_START = "PreCombatMediator:ON_START"
ActivityBossPreCombatMediator.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
ActivityBossPreCombatMediator.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
ActivityBossPreCombatMediator.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
ActivityBossPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
ActivityBossPreCombatMediator.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
ActivityBossPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
ActivityBossPreCombatMediator.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
ActivityBossPreCombatMediator.ON_AUTO = "PreCombatMediator:ON_AUTO"
ActivityBossPreCombatMediator.ON_SUB_AUTO = "PreCombatMediator:ON_SUB_AUTO"

function ActivityBossPreCombatMediator:register()
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

	self.viewComponent:SetTicketItemID((getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetBossConfig():GetTicketID()))

	return
end

function ActivityBossPreCombatMediator:bindEvent()
	local var_2_0 = self.contextData.system

	self:bind(ActivityBossPreCombatMediator.ON_ABORT_EDIT, function(arg_3_0)
		return
	end)
	self:bind(ActivityBossPreCombatMediator.ON_AUTO, function(arg_4_0, arg_4_1)
		self:onAutoBtn(arg_4_1)

		return
	end)
	self:bind(ActivityBossPreCombatMediator.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoSubBtn(arg_5_1)

		return
	end)
	self:bind(ActivityBossPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_6_0, arg_6_1)
		self:refreshEdit(arg_6_1)

		return
	end)
	self:bind(ActivityBossPreCombatMediator.OPEN_SHIP_INFO, function(arg_7_0, arg_7_1, arg_7_2)
		self.contextData.form = PreCombatLayer.FORM_EDIT

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_2:getShipIds()) do
			table.insert(var_7_0, self.ships[iter_7_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_7_1,
			shipVOs = var_7_0
		})

		return
	end)
	self:bind(ActivityBossPreCombatMediator.ON_COMMIT_EDIT, function(arg_8_0, arg_8_1)
		self:commitEdit(arg_8_1)

		return
	end)
	self:bind(ActivityBossPreCombatMediator.ON_START, function(arg_9_0, arg_9_1, arg_9_2)
		seriesAsync({
			function(arg_10_0)
				if pg.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_10_0()

					return
				end

				local var_10_1 = {}

				for iter_10_0, iter_10_1 in ipairs(self.fleets[1].ships) do
					table.insert(var_10_1, getProxy(BayProxy):getShipById(iter_10_1))
				end

				Fleet.EnergyCheck(var_10_1, self.fleets[1]:GetName(), function(arg_11_0)
					if arg_11_0 then
						arg_10_0()
					end

					return
				end, nil, "ship_energy_low_warn_no_exp")

				return
			end,
			function(arg_12_0)
				if self.contextData.OnConfirm then
					self.contextData.OnConfirm(arg_12_0)
				else
					arg_12_0()
				end

				return
			end,
			function()
				self.viewComponent:emit(ActivityBossPreCombatMediator.BEGIN_STAGE_PROXY, {
					curFleetId = arg_9_1,
					continuousBattleTimes = arg_9_2
				})

				return
			end
		})

		return
	end)

	local function var_2_1()
		local var_14_0 = 0

		for iter_14_0, iter_14_1 in ipairs(self.contextData.fleets) do
			local var_14_1 = iter_14_1:GetCostSum().oil

			if self.contextData.costLimit[iter_14_0 == 1 and 1 or 2] > 0 then
				var_14_1 = math.min(var_14_1, self.contextData.costLimit[iter_14_0 == 1 and 1 or 2])
			end

			var_14_0 = var_14_0 + var_14_1
		end

		return var_14_0
	end

	self:bind(ActivityBossPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_15_0, arg_15_1)
		self:addSubLayers(Context.New({
			mediator = ContinuousOperationWindowMediator,
			viewComponent = ContinuousOperationWindow,
			data = {
				mainFleetId = arg_15_1,
				stageId = self.contextData.stageId,
				system = self.contextData.system,
				oilCost = var_2_1()
			}
		}))

		return
	end)
	self:bind(ActivityBossPreCombatMediator.BEGIN_STAGE_PROXY, function(arg_16_0, arg_16_1)
		local var_16_0 = self.contextData.rivalId and self.contextData.rivalId or self.contextData.stageId

		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = var_16_0,
			mainFleetId = arg_16_1.curFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			rivalId = self.contextData.rivalId,
			continuousBattleTimes = arg_16_1.continuousBattleTimes,
			totalBattleTimes = arg_16_1.continuousBattleTimes
		})

		return
	end)

	return
end

function ActivityBossPreCombatMediator:refreshEdit(arg_17_1)
	local var_17_0 = getProxy(FleetProxy)

	var_17_0:updateActivityFleet(self.contextData.actId, arg_17_1.id, arg_17_1)
	self.viewComponent:SetFleets(var_17_0:getActivityFleets()[self.contextData.actId])
	self.viewComponent:UpdateFleetView(false)

	return
end

function ActivityBossPreCombatMediator:commitEdit(arg_18_1)
	getProxy(FleetProxy):commitActivityFleet(self.contextData.actId)
	arg_18_1()

	return
end

function ActivityBossPreCombatMediator:onAutoBtn(arg_19_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_19_1.isOn,
		toggle = arg_19_1.toggle
	})

	return
end

function ActivityBossPreCombatMediator:onAutoSubBtn(arg_20_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_20_1.isOn,
		toggle = arg_20_1.toggle
	})

	return
end

function ActivityBossPreCombatMediator:removeShipFromFleet(arg_21_1, arg_21_2)
	arg_21_1:removeShip(arg_21_2)

	return true
end

function ActivityBossPreCombatMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		ActivityBossPreCombatMediator.CONTINUOUS_OPERATION
	}
end

function ActivityBossPreCombatMediator:handleNotification(arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_23_1)
	elseif var_23_0 == PlayerProxy.UPDATED then
		self.viewComponent:SetPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_23_0 == GAME.BEGIN_STAGE_ERRO then
		if var_23_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_23_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		self.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_23_1)
	elseif var_23_0 == ActivityBossPreCombatMediator.CONTINUOUS_OPERATION then
		self.viewComponent:emit(PreCombatMediator.ON_START, var_23_1.mainFleetId, var_23_1.battleTimes)
	end

	return
end

return ActivityBossPreCombatMediator
