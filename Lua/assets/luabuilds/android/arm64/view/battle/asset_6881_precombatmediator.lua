local PreCombatMediator = class("PreCombatMediator", import("..base.ContextMediator"))

PreCombatMediator.ON_START = "PreCombatMediator:ON_START"
PreCombatMediator.ON_CHANGE_FLEET = "PreCombatMediator:ON_CHANGE_FLEET"
PreCombatMediator.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
PreCombatMediator.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
PreCombatMediator.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
PreCombatMediator.REMOVE_SHIP = "PreCombatMediator:REMOVE_SHIP"
PreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
PreCombatMediator.CHANGE_FLEET_SHIP = "PreCombatMediator:CHANGE_FLEET_SHIP"
PreCombatMediator.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
PreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
PreCombatMediator.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
PreCombatMediator.ON_AUTO = "PreCombatMediator:ON_AUTO"
PreCombatMediator.ON_SUB_AUTO = "PreCombatMediator:ON_SUB_AUTO"

function PreCombatMediator:register()
	self:bindEvent()

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	local var_1_0 = getProxy(FleetProxy)
	local var_1_1 = var_1_0:getData()

	if var_1_0.EdittingFleet ~= nil then
		var_1_1[var_1_0.EdittingFleet.id] = var_1_0.EdittingFleet
	end

	self.fleets = var_1_1

	self.viewComponent:SetFleets(var_1_1)

	local var_1_2 = getProxy(PlayerProxy)

	self.viewComponent:SetPlayerInfo((var_1_2:getData()))

	if self.contextData.system == SYSTEM_DUEL then
		self.viewComponent:SetCurrentFleet(FleetProxy.PVP_FLEET_ID)
	elseif self.contextData.system == SYSTEM_SUB_ROUTINE then
		self.viewComponent:SetStageID(self.contextData.stageId)
		self.viewComponent:SetCurrentFleet(self.contextData.subFleetId)
	else
		self.viewComponent:SetStageID(self.contextData.stageId)
		self.viewComponent:SetCurrentFleet(var_1_2.combatFleetId)
	end

	return
end

function PreCombatMediator:bindEvent()
	local var_2_0 = self.contextData.system

	self:bind(PreCombatMediator.ON_ABORT_EDIT, function(arg_3_0)
		local var_3_0 = getProxy(FleetProxy)

		var_3_0:abortEditting()
		var_3_0:syncFleet()

		return
	end)
	self:bind(PreCombatMediator.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		self:changeFleet(arg_4_1)

		return
	end)
	self:bind(PreCombatMediator.ON_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoBtn(arg_5_1)

		return
	end)
	self:bind(PreCombatMediator.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		self:onAutoSubBtn(arg_6_1)

		return
	end)
	self:bind(PreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		self:refreshEdit(arg_7_1)

		return
	end)
	self:bind(PreCombatMediator.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		FormationMediator.removeShipFromFleet(arg_8_2, arg_8_1)
		self:refreshEdit(arg_8_2)

		return
	end)
	self:bind(PreCombatMediator.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		self.contextData.form = PreCombatLayer.FORM_EDIT

		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_2:getShipIds()) do
			table.insert(var_9_0, self.ships[iter_9_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = var_9_0
		})

		return
	end)
	self:bind(PreCombatMediator.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		assert(arg_10_2.id ~= FleetProxy.PVP_FLEET_ID, "fleet type error")

		self.contextData.form = PreCombatLayer.FORM_EDIT

		FormationMediator.saveEdit()

		local var_10_0

		if var_2_0 == SYSTEM_DUEL then
			var_10_0 = ShipStatus.TAG_HIDE_PVP or ShipStatus.TAG_HIDE_NORMAL

			local var_10_1

			if var_2_0 == SYSTEM_DUEL then
				var_10_1 = ShipStatus.TAG_BLOCK_PVP or nil
			end
		end

		local var_10_2, var_10_3, var_10_4 = FormationMediator.getDockCallbackFuncs(self, arg_10_1, arg_10_2, arg_10_3)
		local var_10_5 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_2.ships) do
			if not arg_10_1 or iter_10_1 ~= arg_10_1.id then
				table.insert(var_10_5, iter_10_1)
			end
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			leastLimitMsg = i18n("battle_preCombatMediator_leastLimit"),
			quitTeam = arg_10_1 ~= nil,
			teamFilter = arg_10_3,
			onShip = var_10_2,
			confirmSelect = var_10_3,
			onSelected = var_10_4,
			hideTagFlags = var_10_0,
			blockTagFlags = var_10_1,
			otherSelectedIds = var_10_5
		})

		return
	end)
	self:bind(PreCombatMediator.ON_COMMIT_EDIT, function(arg_11_0, arg_11_1)
		self:commitEdit(arg_11_1)

		return
	end)
	self:bind(PreCombatMediator.ON_START, function(arg_12_0, arg_12_1, arg_12_2)
		seriesAsync({
			function(arg_13_0)
				if pg.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_13_0()

					return
				end

				local var_13_1 = {}

				for iter_13_0, iter_13_1 in ipairs((nil).ships) do
					table.insert(var_13_1, getProxy(BayProxy):getShipById(iter_13_1))
				end

				Fleet.EnergyCheck(var_13_1, getProxy(FleetProxy):getFleetById(arg_12_1):GetName(), function(arg_14_0)
					if arg_14_0 then
						arg_13_0()
					end

					return
				end, nil, nil)

				return
			end,
			function(arg_15_0)
				if self.contextData.OnConfirm then
					self.contextData.OnConfirm(arg_15_0)
				else
					arg_15_0()
				end

				return
			end,
			function()
				self.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, {
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

		for iter_17_0, iter_17_1 in ipairs(self.contextData.fleets) do
			local var_17_1 = iter_17_1:GetCostSum().oil

			if self.contextData.costLimit[iter_17_0 == 1 and 1 or 2] > 0 then
				var_17_1 = math.min(var_17_1, self.contextData.costLimit[iter_17_0 == 1 and 1 or 2])
			end

			var_17_0 = var_17_0 + var_17_1
		end

		return var_17_0
	end

	self:bind(PreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_18_0, arg_18_1)
		self:addSubLayers(Context.New({
			mediator = ContinuousOperationWindowMediator,
			viewComponent = ContinuousOperationWindow,
			data = {
				mainFleetId = arg_18_1,
				stageId = self.contextData.stageId,
				system = self.contextData.system,
				oilCost = var_2_1()
			}
		}))

		return
	end)
	self:bind(PreCombatMediator.BEGIN_STAGE_PROXY, function(arg_19_0, arg_19_1)
		local var_19_0 = self.contextData.rivalId and self.contextData.rivalId or self.contextData.stageId

		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = var_19_0,
			mainFleetId = arg_19_1.curFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			rivalId = self.contextData.rivalId,
			continuousBattleTimes = arg_19_1.continuousBattleTimes,
			totalBattleTimes = arg_19_1.continuousBattleTimes
		})

		return
	end)

	return
end

function PreCombatMediator:changeFleet(arg_20_1)
	if self.contextData.system == SYSTEM_SUB_ROUTINE then
		self.contextData.subFleetId = arg_20_1
	else
		getProxy(PlayerProxy).combatFleetId = arg_20_1
	end

	self.viewComponent:SetCurrentFleet(arg_20_1)
	self.viewComponent:UpdateFleetView(true)
	self.viewComponent:SetFleetStepper()

	return
end

function PreCombatMediator:refreshEdit(arg_21_1)
	local var_21_0 = getProxy(FleetProxy)

	var_21_0.EdittingFleet = arg_21_1

	if self.contextData.system ~= SYSTEM_SUB_ROUTINE then
		local var_21_1 = var_21_0:getData()

		var_21_1[arg_21_1.id] = arg_21_1

		self.viewComponent:SetFleets(var_21_1)
	end

	self.viewComponent:UpdateFleetView(false)

	return
end

function PreCombatMediator:commitEdit(arg_22_1)
	local var_22_0 = getProxy(FleetProxy)
	local var_22_1 = var_22_0.EdittingFleet

	if var_22_0.EdittingFleet == nil or var_22_0.EdittingFleet:isFirstFleet() or var_22_0.EdittingFleet:isLegalToFight() == true then
		var_22_0:commitEdittingFleet(arg_22_1)
	elseif #var_22_0.EdittingFleet.ships == 0 then
		var_22_0:commitEdittingFleet(arg_22_1)

		if self.contextData.system == SYSTEM_SUB_ROUTINE then
			self:changeFleet()
		else
			self:changeFleet(1)
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
					self:changeFleet(FleetProxy.PVP_FLEET_ID)
				else
					var_22_0:commitEdittingFleet(arg_22_1)
					self:changeFleet(1)
				end

				return
			end
		})
	end

	return
end

function PreCombatMediator:onAutoBtn(arg_24_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_24_1.isOn,
		toggle = arg_24_1.toggle
	})

	return
end

function PreCombatMediator:onAutoSubBtn(arg_25_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_25_1.isOn,
		toggle = arg_25_1.toggle
	})

	return
end

function PreCombatMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		PreCombatMediator.CONTINUOUS_OPERATION
	}
end

function PreCombatMediator:handleNotification(arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_27_1)
	elseif var_27_0 == PlayerProxy.UPDATED then
		self.viewComponent:SetPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_27_0 == GAME.BEGIN_STAGE_ERRO then
		if var_27_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_27_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		self.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_27_1)
	elseif var_27_0 == PreCombatMediator.CONTINUOUS_OPERATION then
		self.viewComponent:emit(PreCombatMediator.ON_START, var_27_1.mainFleetId, var_27_1.battleTimes)
	end

	return
end

return PreCombatMediator
