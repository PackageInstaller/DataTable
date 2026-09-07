local FormationMediator = class("FormationMediator", import("..base.ContextMediator"))

FormationMediator.OPEN_SHIP_INFO = "FormationMediator:OPEN_SHIP_INFO"
FormationMediator.ON_CHANGE_FLEET = "FormationMediator:ON_CHANGE_FLEET"
FormationMediator.CHANGE_FLEET_NAME = "FormationMediator:CHANGE_FLEET_NAME"
FormationMediator.CHANGE_FLEET_SHIP = "FormationMediator:CHANGE_FLEET_SHIP"
FormationMediator.REMOVE_SHIP = "FormationMediator:REMOVE_SHIP"
FormationMediator.CHANGE_FLEET_FORMATION = "FormationMediator:CHANGE_FLEET_FORMATION"
FormationMediator.CHANGE_FLEET_SHIPS_ORDER = "FormationMediator:CHANGE_FLEET_SHIPS_ORDER"
FormationMediator.COMMIT_FLEET = "FormationMediator:COMMIT_FLEET"
FormationMediator.ON_SELECT_COMMANDER = "FormationMediator:ON_SELECT_COMMANDER"
FormationMediator.ON_CMD_SKILL = "FormationMediator:ON_CMD_SKILL"
FormationMediator.COMMANDER_FORMATION_OP = "FormationMediator:COMMANDER_FORMATION_OP"

function FormationMediator:register()
	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:setShips(self.ships)

	local var_1_0 = getProxy(FleetProxy)
	local var_1_1 = var_1_0:GetRegularFleets()

	if var_1_0.EdittingFleet ~= nil then
		var_1_1[var_1_0.EdittingFleet.id] = var_1_0.EdittingFleet
	end

	self.viewComponent:SetFleets(var_1_1)
	self.viewComponent:setCommanderPrefabFleet(getProxy(CommanderProxy):getPrefabFleet())
	self:bind(FormationMediator.ON_CMD_SKILL, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_2_1
			}
		}))

		return
	end)
	self:bind(FormationMediator.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		self.commitEdit(arg_3_1)

		return
	end)
	self:bind(FormationMediator.CHANGE_FLEET_NAME, function(arg_4_0, arg_4_1, arg_4_2)
		self.commitEdit(function()
			self:sendNotification(GAME.RENAME_FLEET, {
				id = arg_4_1,
				name = arg_4_2
			})

			return
		end)

		return
	end)
	self:bind(FormationMediator.OPEN_SHIP_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		self.commitEdit(function()
			self.contextData.number = arg_6_2.id
			self.contextData.toggle = arg_6_3

			local var_7_0 = {}

			for iter_7_0, iter_7_1 in ipairs(arg_6_2:getShipIds()) do
				table.insert(var_7_0, self.ships[iter_7_1])
			end

			self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
				shipId = arg_6_1,
				shipVOs = var_7_0
			})

			return
		end)

		return
	end)
	self:bind(FormationMediator.ON_CHANGE_FLEET, function(arg_8_0, arg_8_1)
		self.commitEdit(function()
			self.viewComponent:SetFleets(var_1_0:GetRegularFleets())
			self.viewComponent:SetCurrentFleetID(arg_8_1)
			self.viewComponent:UpdateFleetView(true)

			return
		end)

		return
	end)
	self:bind(FormationMediator.CHANGE_FLEET_FORMATION, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_2.formation = arg_10_1

		self:refreshEdit(arg_10_2)

		return
	end)
	self:bind(FormationMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_11_0, arg_11_1)
		self:refreshEdit(arg_11_1)

		return
	end)
	self:bind(FormationMediator.REMOVE_SHIP, function(arg_12_0, arg_12_1, arg_12_2)
		FormationMediator.removeShipFromFleet(arg_12_2, arg_12_1)
		self:refreshEdit(arg_12_2)

		return
	end)
	self:bind(FormationMediator.CHANGE_FLEET_SHIP, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		self.contextData.number = arg_13_2.id
		self.contextData.toggle = arg_13_3

		self.saveEdit()

		local var_13_0 = 0

		if arg_13_2.id == 1 and #arg_13_2.ships <= 1 and arg_13_1 ~= nil then
			var_13_0 = 1
		end

		local var_13_1 = {}

		for iter_13_0, iter_13_1 in ipairs(arg_13_2.ships) do
			if not arg_13_1 or iter_13_1 ~= arg_13_1.id then
				table.insert(var_13_1, iter_13_1)
			end
		end

		local var_13_2, var_13_3, var_13_4 = FormationMediator.getDockCallbackFuncs(self, arg_13_1, arg_13_2, arg_13_4)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			selectedMin = var_13_0,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = arg_13_1 ~= nil,
			teamFilter = arg_13_4,
			leftTopInfo = i18n("word_formation"),
			onShip = var_13_2,
			confirmSelect = var_13_3,
			onSelected = var_13_4,
			onQuickHome = self.commitEdit,
			hideTagFlags = ShipStatus.TAG_HIDE_FORMATION,
			otherSelectedIds = var_13_1,
			preView = self.viewComponent.__cname
		})

		return
	end)
	self:bind(FormationMediator.ON_SELECT_COMMANDER, function(arg_14_0, arg_14_1, arg_14_2)
		self.contextData.toggle = FormationUI.TOGGLE_FORMATION
		self.contextData.number = arg_14_2

		FormationMediator.onSelectCommander(arg_14_1, arg_14_2)

		return
	end)
	self:bind(FormationMediator.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function FormationMediator:onSelectCommander(arg_16_1)
	local var_16_0 = getProxy(FleetProxy)
	local var_16_1 = getProxy(FleetProxy)
	local var_16_2 = var_16_1:getFleetById(arg_16_1):getCommanderByPos(self)
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if var_16_2 and iter_16_1 == var_16_2.id then
			table.remove(var_16_3, iter_16_0)

			break
		end
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
		maxCount = 1,
		mode = CommanderCatScene.MODE_SELECT,
		fleetType = CommanderCatScene.FLEET_TYPE_COMMON,
		activeCommander = var_16_2,
		ignoredIds = var_16_3,
		onCommander = function(arg_17_0)
			return true
		end,
		onSelected = function(self, arg_18_1)
			pg.m02:sendNotification(GAME.SELECT_FLEET_COMMANDER, {
				fleetId = arg_16_1,
				pos = self,
				commanderId = self[1],
				callback = function()
					if var_16_0.EdittingFleet then
						var_16_0.EdittingFleet.commanderIds = getProxy(FleetProxy):getFleetById(var_16_0.EdittingFleet.id).commanderIds
					end

					arg_18_1()

					return
				end
			})

			return
		end,
		onQuit = function(arg_20_0)
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = arg_16_1,
				pos = self,
				callback = function(self)
					if var_16_0.EdittingFleet then
						var_16_0.EdittingFleet.commanderIds = self.commanderIds
					end

					arg_20_0()

					return
				end
			})

			return
		end
	})

	return
end

function FormationMediator:refreshEdit(arg_22_1)
	local var_22_0 = getProxy(FleetProxy)

	var_22_0.EdittingFleet = arg_22_1

	local var_22_1 = var_22_0:GetRegularFleets()

	var_22_1[arg_22_1.id] = arg_22_1

	self.viewComponent:SetFleets(var_22_1)
	self.viewComponent:UpdateFleetView(false)

	return
end

function FormationMediator:commitEdit()
	local var_23_0 = getProxy(FleetProxy)
	local var_23_1 = var_23_0.EdittingFleet

	if var_23_0.EdittingFleet == nil or var_23_0.EdittingFleet:isFirstFleet() or var_23_0.EdittingFleet:isLegalToFight() == true or #var_23_0.EdittingFleet.ships == 0 then
		var_23_0:commitEdittingFleet(self)
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_formationMediaror_trash_warning", var_23_0.EdittingFleet.defaultName),
			onYes = function()
				local var_24_0 = getProxy(BayProxy):getRawData()

				for iter_24_0 = #var_23_1.ships, 1, -1 do
					var_23_1:removeShip(var_24_0[var_23_1.ships[iter_24_0]])
				end

				var_23_0:commitEdittingFleet(self)

				getProxy(PlayerProxy).combatFleetId = 1

				return
			end,
			onNo = function()
				return
			end
		})
	end

	return
end

function FormationMediator:listNotificationInterests()
	return {
		FleetProxy.FLEET_UPDATED,
		FleetProxy.FLEET_RENAMED,
		GAME.UPDATE_FLEET_DONE,
		PlayerProxy.UPDATED,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COOMMANDER_EQUIP_TO_FLEET_DONE
	}
end

function FormationMediator:handleNotification(arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == FleetProxy.FLEET_UPDATED then
		self.viewComponent:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
	elseif var_27_0 == FleetProxy.FLEET_RENAMED then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationMediator_changeNameSuccess"))
		self.viewComponent:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
		self.viewComponent:UpdateFleetView(true)
		self.viewComponent:DisplayRenamePanel(false)
	elseif var_27_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabFleet(getProxy(CommanderProxy):getPrefabFleet())
		self.viewComponent:updateCommanderFormation()
	elseif var_27_0 == GAME.COOMMANDER_EQUIP_TO_FLEET_DONE then
		self.viewComponent:updateCommanderFormation()
	end

	return
end

function FormationMediator:checkChangeShip(arg_28_1, arg_28_2)
	local var_28_0 = getProxy(BayProxy):getRawData()
	local var_28_2 = getProxy(FleetProxy):GetRegularFleetByShip(arg_28_2)

	if not (var_28_2 and var_28_2.id == self.id) and (not arg_28_1 or not arg_28_1:isSameKind(arg_28_2)) then
		for iter_28_0, iter_28_1 in ipairs(self.ships) do
			if var_28_0[iter_28_1]:isSameKind(arg_28_2) then
				local var_28_4 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end
	end

	return true
end

function FormationMediator:removeShipFromFleet(arg_29_1)
	if not self:canRemove(arg_29_1) then
		local var_29_0, var_29_1 = self:getShipPos(arg_29_1)

		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_29_1:getConfigTable().name, self.name, Fleet.C_TEAM_NAME[var_29_1]))

		return false
	end

	self:removeShip(arg_29_1)

	getProxy(FleetProxy).EdittingFleet = self

	return true
end

function FormationMediator.saveEdit()
	getProxy(FleetProxy):saveEdittingFleet()

	return
end

function FormationMediator:getDockCallbackFuncs(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = getProxy(FleetProxy)
	local var_31_1 = getProxy(BayProxy)
	local var_31_2 = getProxy(ChapterProxy)

	return function(arg_32_0, arg_32_1)
		local var_32_0, var_32_1 = ShipStatus.ShipStatusCheck("inFleet", arg_32_0, arg_32_1)

		if not var_32_0 then
			return var_32_0, var_32_1
		end

		local var_32_2, var_32_3 = FormationMediator.checkChangeShip(arg_31_2, arg_31_1, arg_32_0)

		if not var_32_2 then
			return false, var_32_3
		end

		local var_32_4 = var_31_0:GetRegularFleetByShip(arg_32_0)

		if var_32_4 ~= nil and var_32_4.id ~= arg_31_2.id then
			if arg_31_1 == nil and not var_32_4:canRemove(arg_32_0) then
				local var_32_5, var_32_6 = var_32_4:getShipPos(arg_32_0)
				local var_32_8 = i18n("ship_formationMediator_replaceError_onlyShip", var_32_4.defaultName, Fleet.C_TEAM_NAME[var_32_6])

				return
			end

			if arg_31_1 == nil then
				return true
			else
				local var_32_9, var_32_10 = FormationMediator.checkChangeShip(var_32_4, arg_32_0, arg_31_1)

				if not var_32_9 then
					return false, var_32_10
				end
			end
		end

		return true
	end, function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = var_31_1:getShipById(arg_33_0[1])

		if not var_33_0 then
			arg_33_1()

			return
		end

		local var_33_1 = var_31_0:GetRegularFleetByShip(var_33_0)

		if var_33_1 and var_33_1.id ~= arg_31_2.id then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("ship_formationMediator_quest_replace", var_33_1.defaultName),
				onYes = arg_33_1
			})
		else
			arg_33_1()

			return
		end

		return
	end, function(arg_34_0)
		local var_34_0 = var_31_1:getShipById(arg_34_0[1])

		if not var_34_0 then
			if arg_31_1 == nil then
				return
			end

			FormationMediator.removeShipFromFleet(arg_31_2, arg_31_1)

			return
		end

		;(function()
			local var_35_0 = var_31_0:GetRegularFleetByShip(var_34_0)
			local var_35_1 = arg_31_2:getShipPos(arg_31_1)

			if var_35_0 == nil then
				if arg_31_1 == nil then
					arg_31_2:insertShip(var_34_0, nil, arg_31_3)
				else
					arg_31_2:removeShip(arg_31_1)
					arg_31_2:insertShip(var_34_0, var_35_1, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			local var_35_2 = var_35_0:getShipPos(var_34_0)

			if var_35_0.id == arg_31_2.id then
				if arg_31_1 == nil then
					arg_31_2:removeShip(var_34_0)
					arg_31_2:insertShip(var_34_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					return
				end

				if arg_31_1.id == var_34_0.id then
					return
				end

				arg_31_2:removeShip(arg_31_1)
				arg_31_2:removeShip(var_34_0)

				if var_35_2 < var_35_1 then
					arg_31_2:insertShip(arg_31_1, var_35_2, arg_31_3)
					arg_31_2:insertShip(var_34_0, var_35_1, arg_31_3)
				else
					arg_31_2:insertShip(var_34_0, var_35_1, arg_31_3)
					arg_31_2:insertShip(arg_31_1, var_35_2, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			if not var_35_0:canRemove(var_34_0) and arg_31_1 == nil then
				local var_35_3, var_35_4 = var_35_0:getShipPos(var_34_0)

				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationMediator_replaceError_onlyShip", var_35_0.defaultName, Fleet.C_TEAM_NAME[var_35_4]))
			else
				var_35_0:removeShip(var_34_0)

				if arg_31_1 then
					var_35_0:insertShip(arg_31_1, var_35_2, arg_31_3)
					self:sendNotification(GAME.UPDATE_FLEET, {
						fleet = var_35_0
					})
					arg_31_2:removeShip(arg_31_1)
					arg_31_2:insertShip(var_34_0, var_35_1, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					FormationMediator.saveEdit()
					self:sendNotification(GAME.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				else
					self:sendNotification(GAME.UPDATE_FLEET, {
						fleet = var_35_0
					})
					arg_31_2:insertShip(var_34_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					FormationMediator.saveEdit()
					self:sendNotification(GAME.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				end
			end

			return
		end)()

		return
	end
end

return FormationMediator
