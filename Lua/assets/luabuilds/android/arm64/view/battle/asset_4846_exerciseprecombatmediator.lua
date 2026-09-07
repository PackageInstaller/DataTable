local ExercisePreCombatMediator = class("ExercisePreCombatMediator", import("..base.ContextMediator"))

ExercisePreCombatMediator.ON_START = "ExercisePreCombatMediator:ON_START"
ExercisePreCombatMediator.ON_CHANGE_FLEET = "ExercisePreCombatMediator:ON_CHANGE_FLEET"
ExercisePreCombatMediator.ON_COMMIT_EDIT = "ExercisePreCombatMediator:ON_COMMIT_EDIT"
ExercisePreCombatMediator.OPEN_SHIP_INFO = "ExercisePreCombatMediator:OPEN_SHIP_INFO"
ExercisePreCombatMediator.REMOVE_SHIP = "ExercisePreCombatMediator:REMOVE_SHIP"
ExercisePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "ExercisePreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
ExercisePreCombatMediator.CHANGE_FLEET_SHIP = "ExercisePreCombatMediator:CHANGE_FLEET_SHIP"
ExercisePreCombatMediator.ON_AUTO = "ExercisePreCombatMediator:ON_AUTO"
ExercisePreCombatMediator.ON_SUB_AUTO = "ExercisePreCombatMediator:ON_SUB_AUTO"

function ExercisePreCombatMediator:register()
	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	local var_1_0 = self.contextData.system
	local var_1_1 = getProxy(FleetProxy)
	local var_1_2 = var_1_1:getData()

	if self.contextData.EdittingFleet then
		var_1_1.EdittingFleet = self.contextData.EdittingFleet
		self.contextData.EdittingFleet = nil
	end

	if var_1_1.EdittingFleet ~= nil then
		var_1_2[var_1_1.EdittingFleet.id] = var_1_1.EdittingFleet
	end

	self.viewComponent:SetFleets(var_1_2)
	self.viewComponent:SetPlayerInfo((getProxy(PlayerProxy):getData()))
	self.viewComponent:SetCurrentFleet(FleetProxy.PVP_FLEET_ID)
	self:bind(ExercisePreCombatMediator.ON_CHANGE_FLEET, function(arg_2_0, arg_2_1)
		self:changeFleet(arg_2_1)

		return
	end)
	self:bind(ExercisePreCombatMediator.ON_AUTO, function(arg_3_0, arg_3_1)
		self:onAutoBtn(arg_3_1)

		return
	end)
	self:bind(ExercisePreCombatMediator.ON_SUB_AUTO, function(arg_4_0, arg_4_1)
		self:onAutoSubBtn(arg_4_1)

		return
	end)
	self:bind(ExercisePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_5_0, arg_5_1)
		self:refreshEdit(arg_5_1)

		return
	end)
	self:bind(ExercisePreCombatMediator.REMOVE_SHIP, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_2:removeShip(arg_6_1)

		getProxy(FleetProxy).EdittingFleet = arg_6_2

		self:refreshEdit(arg_6_2)

		return
	end)
	self:bind(ExercisePreCombatMediator.OPEN_SHIP_INFO, function(arg_7_0, arg_7_1, arg_7_2)
		self.contextData.form = ExercisePreCombatLayer.FORM_EDIT

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
	self:bind(ExercisePreCombatMediator.CHANGE_FLEET_SHIP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		assert(arg_8_2.id == FleetProxy.PVP_FLEET_ID, "fleet type error")

		self.contextData.form = ExercisePreCombatLayer.FORM_EDIT

		FormationMediator.saveEdit()

		local var_8_0

		if var_1_0 == SYSTEM_DUEL then
			var_8_0 = ShipStatus.TAG_HIDE_PVP or ShipStatus.TAG_HIDE_NORMAL

			local var_8_1

			if var_1_0 == SYSTEM_DUEL then
				var_8_1 = ShipStatus.TAG_BLOCK_PVP or nil
			end
		end

		local var_8_2, var_8_3, var_8_4 = self:getDockCallbackFuncsForExercise(arg_8_1, arg_8_2, arg_8_3)
		local var_8_5 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2.ships) do
			if not arg_8_1 or iter_8_1 ~= arg_8_1.id then
				table.insert(var_8_5, iter_8_1)
			end
		end

		local var_8_6 = GAME.GO_SCENE
		local var_8_7 = SCENE.DOCKYARD
		local var_8_8 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true
		}

		var_8_8.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})
		var_8_8.leastLimitMsg = i18n("battle_preCombatMediator_leastLimit")
		var_8_8.quitTeam = arg_8_1 ~= nil
		var_8_8.teamFilter = arg_8_3
		var_8_8.onShip = var_8_2
		var_8_8.confirmSelect = var_8_3
		var_8_8.onSelected = var_8_4
		var_8_8.hideTagFlags = var_8_0
		var_8_8.blockTagFlags = var_8_1
		var_8_8.otherSelectedIds = var_8_5

		self:sendNotification(var_8_6, var_8_7, var_8_8)

		return
	end)
	self:bind(ExercisePreCombatMediator.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		self:commitEdit(arg_9_1)

		return
	end)
	self:bind(ExercisePreCombatMediator.ON_START, function(arg_10_0, arg_10_1)
		local var_10_0 = self.contextData.rivalId and self.contextData.rivalId or self.contextData.stageId

		seriesAsync({
			function(arg_11_0)
				if self.contextData.OnConfirm then
					self.contextData.OnConfirm(arg_11_0)
				else
					arg_11_0()
				end

				return
			end,
			function()
				self:sendNotification(GAME.BEGIN_STAGE, {
					stageId = var_10_0,
					mainFleetId = arg_10_1,
					system = self.contextData.system,
					actId = self.contextData.actId,
					rivalId = self.contextData.rivalId
				})

				return
			end
		})

		return
	end)

	return
end

function ExercisePreCombatMediator:changeFleet(arg_13_1)
	if self.contextData.system == SYSTEM_SUB_ROUTINE then
		self.contextData.subFleetId = arg_13_1
	else
		getProxy(PlayerProxy).combatFleetId = arg_13_1
	end

	self.viewComponent:SetCurrentFleet(arg_13_1)
	self.viewComponent:UpdateFleetView(true)

	return
end

function ExercisePreCombatMediator:refreshEdit(arg_14_1)
	local var_14_0 = getProxy(FleetProxy)

	var_14_0.EdittingFleet = arg_14_1

	if self.contextData.system ~= SYSTEM_SUB_ROUTINE then
		local var_14_1 = var_14_0:getData()

		var_14_1[arg_14_1.id] = arg_14_1

		self.viewComponent:SetFleets(var_14_1)
	end

	self.viewComponent:UpdateFleetView(false)

	return
end

function ExercisePreCombatMediator:commitEdit(arg_15_1)
	local var_15_0 = getProxy(FleetProxy)
	local var_15_1 = var_15_0.EdittingFleet

	if var_15_0.EdittingFleet == nil or var_15_0.EdittingFleet:isFirstFleet() or var_15_0.EdittingFleet:isLegalToFight() == true then
		var_15_0:commitEdittingFleet(arg_15_1)
	elseif #var_15_0.EdittingFleet.ships == 0 then
		var_15_0:commitEdittingFleet(arg_15_1)

		if self.contextData.system == SYSTEM_SUB_ROUTINE then
			-- block empty
		end
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_formationMediaror_trash_warning", var_15_0.EdittingFleet.defaultName),
			onYes = function()
				local var_16_0 = getProxy(BayProxy):getRawData()

				for iter_16_0 = #var_15_1.ships, 1, -1 do
					var_15_1:removeShip(var_16_0[var_15_1.ships[iter_16_0]])
				end

				if var_15_1.id == FleetProxy.PVP_FLEET_ID then
					var_15_0:commitEdittingFleet()
					self:changeFleet(FleetProxy.PVP_FLEET_ID)
				else
					var_15_0:commitEdittingFleet(arg_15_1)
				end

				return
			end
		})
	end

	return
end

function ExercisePreCombatMediator:onAutoBtn(arg_17_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_17_1.isOn,
		toggle = arg_17_1.toggle
	})

	return
end

function ExercisePreCombatMediator:onAutoSubBtn(arg_18_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_18_1.isOn,
		toggle = arg_18_1.toggle
	})

	return
end

function ExercisePreCombatMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO
	}
end

function ExercisePreCombatMediator:handleNotification(arg_20_1)
	local var_20_0 = arg_20_1:getName()
	local var_20_1 = arg_20_1:getBody()

	if var_20_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_20_1)
	elseif var_20_0 == PlayerProxy.UPDATED then
		self.viewComponent:SetPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_20_0 == GAME.BEGIN_STAGE_ERRO and var_20_1 == 3 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("battle_preCombatMediator_timeout"),
			onYes = function()
				self.viewComponent:emit(BaseUI.ON_CLOSE)

				return
			end
		})
	end

	return
end

function ExercisePreCombatMediator:getDockCallbackFuncsForExercise(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = getProxy(FleetProxy)
	local var_22_1 = getProxy(BayProxy)

	return function(arg_23_0, arg_23_1)
		local var_23_0, var_23_1 = ShipStatus.ShipStatusCheck("inFleet", arg_23_0, arg_23_1)

		if not var_23_0 then
			return var_23_0, var_23_1
		end

		local var_23_2, var_23_3 = FormationMediator.checkChangeShip(arg_22_2, arg_22_1, arg_23_0)

		if not var_23_2 then
			return false, var_23_3
		end

		return true
	end, function(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1()

		return
	end, function(arg_25_0)
		local var_25_0 = var_22_1:getShipById(arg_25_0[1])
		local var_25_1 = arg_22_2:getShipPos(arg_22_1) or -1

		if var_25_1 > 0 then
			arg_22_2:removeShip(arg_22_1)
		end

		local var_25_2 = arg_22_2:getShipPos(var_25_0) or -1

		if var_25_2 > 0 then
			arg_22_2:removeShip(var_25_0)
		end

		local var_25_3 = {}

		if arg_22_1 and var_25_2 > 0 then
			table.insert(var_25_3, {
				var_25_2,
				arg_22_1
			})
		end

		if var_25_0 then
			table.insert(var_25_3, {
				var_25_1,
				var_25_0
			})
		end

		table.sort(var_25_3, function(arg_26_0, arg_26_1)
			return arg_26_0[1] < arg_26_1[1]
		end)

		for iter_25_0, iter_25_1 in ipairs(var_25_3) do
			arg_22_2:insertShip(iter_25_1[2], (iter_25_1[1] > 0 or nil) and (iter_25_1[1] or nil), arg_22_3)
		end

		var_22_0.EdittingFleet = arg_22_2

		return
	end
end

return ExercisePreCombatMediator
