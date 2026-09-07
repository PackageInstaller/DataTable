local LimitChallengePreCombatMediator = class("LimitChallengePreCombatMediator", import("view.base.ContextMediator"))

LimitChallengePreCombatMediator.ON_UPDATE_CUSTOM_FLEET = "LimitChallengePreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
LimitChallengePreCombatMediator.ON_START = "LimitChallengePreCombatMediator:ON_START"
LimitChallengePreCombatMediator.BEGIN_STAGE = "LimitChallengePreCombatMediator:BEGIN_STAGE"
LimitChallengePreCombatMediator.OPEN_SHIP_INFO = "LimitChallengePreCombatMediator:OPEN_SHIP_INFO"
LimitChallengePreCombatMediator.CHANGE_FLEET_SHIP = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIP"
LimitChallengePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
LimitChallengePreCombatMediator.REMOVE_SHIP = "LimitChallengePreCombatMediator:REMOVE_SHIP"
LimitChallengePreCombatMediator.ON_AUTO = "LimitChallengePreCombatMediator:ON_AUTO"
LimitChallengePreCombatMediator.ON_SUB_AUTO = "LimitChallengePreCombatMediator:ON_SUB_AUTO"
LimitChallengePreCombatMediator.ON_CHANGE_FLEET = "LimitChallengePreCombatMediator:ON_CHANGE_FLEET"
LimitChallengePreCombatMediator.ON_CMD_SKILL = "LimitChallengePreCombatMediator:ON_CMD_SKILL"
LimitChallengePreCombatMediator.ON_SELECT_COMMANDER = "LimitChallengePreCombatMediator:ON_SELECT_COMMANDER"

function LimitChallengePreCombatMediator:register()
	self:bindEvent()

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	local var_1_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator")

	var_1_0 = var_1_0 and not LOCK_COMMANDER

	self.viewComponent:SetOpenCommander(var_1_0)

	local var_1_1 = _.map({
		FleetProxy.CHALLENGE_FLEET_ID,
		FleetProxy.CHALLENGE_SUB_FLEET_ID
	}, function(arg_2_0)
		return getProxy(FleetProxy):getFleetById(arg_2_0)
	end)

	self.fleets = var_1_1
	self.contextData.fleets = var_1_1

	self.viewComponent:SetFleets(var_1_1)

	self.contextData.fleetIndex = self.contextData.fleetIndex or 1

	self.viewComponent:SetCurrentFleet(var_1_1[self.contextData.fleetIndex].id)
	self.viewComponent:SetSubFlag(var_1_1[#var_1_1]:isLegalToFight() == true)
	self.viewComponent:SetStageID(self.contextData.stageId)

	return
end

function LimitChallengePreCombatMediator:bindEvent()
	self:bind(LimitChallengePreCombatMediator.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		self:changeFleet(arg_4_1)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoBtn(arg_5_1)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		self:onAutoSubBtn(arg_6_1)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		self:refreshEdit(arg_7_1)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		self:removeShipFromFleet(arg_8_2, arg_8_1)
		self:refreshEdit(arg_8_2)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
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
	self:bind(LimitChallengePreCombatMediator.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = _.flatten(_.map(self.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))
		local var_10_1, var_10_2, var_10_3 = LimitChallengePreCombatMediator.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_0, self.contextData.actId)
		local var_10_4 = GAME.GO_SCENE
		local var_10_5 = SCENE.DOCKYARD
		local var_10_6 = {
			selectedMin = 0,
			skipSelect = true,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = false,
			leastLimitMsg = i18n("battle_preCombatMediator_leastLimit"),
			quitTeam = arg_10_1 ~= nil,
			teamFilter = arg_10_3,
			onShip = var_10_1,
			confirmSelect = var_10_2,
			onSelected = var_10_3,
			hideTagFlags = ShipStatus.TAG_HIDE_CHALLENGE,
			blockTagFlags = {
				inEvent = true
			},
			otherSelectedIds = var_10_0
		}

		var_10_6.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		self:sendNotification(var_10_4, var_10_5, var_10_6)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_.each(self.contextData.fleets, function(arg_13_0)
			self:sendNotification(GAME.UPDATE_FLEET, {
				fleet = arg_13_0
			})

			local var_13_0 = arg_13_0:GetRawCommanderIds()

			_.each({
				1,
				2
			}, function(arg_14_0)
				local var_14_0 = {
					fleetId = arg_13_0.id,
					pos = arg_14_0
				}

				var_14_0.commanderId = var_13_0[arg_14_0] or 0

				self:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, var_14_0)

				return
			end)

			return
		end)

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_START, function(arg_15_0)
		self.viewComponent:emit(LimitChallengePreCombatMediator.ON_UPDATE_CUSTOM_FLEET)
		seriesAsync({
			function(arg_16_0)
				for iter_16_0 = 1, #self.contextData.fleets - 1 do
					if self.contextData.fleets[iter_16_0]:isLegalToFight() ~= true then
						pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

						return
					end
				end

				local var_16_0 = {}

				if _.any(self.contextData.fleets, function(arg_17_0)
					return _.any(arg_17_0:GetRawShipIds(), function(arg_18_0)
						local var_18_0 = getProxy(BayProxy):RawGetShipById(arg_18_0)

						if var_16_0[var_18_0:getGroupId()] then
							return true
						end

						var_16_0[var_18_0:getGroupId()] = true

						return
					end)
				end) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_exist_same_kind_ship"))

					return
				end

				arg_16_0()

				return
			end,
			function(arg_19_0)
				table.SerialIpairsAsync(self.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0, var_20_1 = arg_20_1:HaveShipsInEvent()

					if var_20_0 then
						pg.TipsMgr.GetInstance():ShowTips(var_20_1)

						return
					end

					if _.any(arg_20_1:getShipIds(), function(arg_21_0)
						local var_21_0 = getProxy(BayProxy):RawGetShipById(arg_21_0)

						if not var_21_0 then
							return
						end

						local var_21_1, var_21_2 = ShipStatus.ShipStatusCheck("inChallenge", var_21_0)

						if not var_21_1 then
							pg.TipsMgr.GetInstance():ShowTips(var_21_2)

							return true
						end

						return
					end) then
						return
					end

					arg_20_2()

					return
				end, arg_19_0)

				return
			end,
			function(arg_22_0)
				self.viewComponent:emit(LimitChallengePreCombatMediator.BEGIN_STAGE)

				return
			end
		})

		return
	end)
	self:bind(LimitChallengePreCombatMediator.BEGIN_STAGE, function(arg_23_0)
		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = self.contextData.stageId,
			system = self.contextData.system,
			actId = self.contextData.actId
		})

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_CMD_SKILL, function(arg_24_0, arg_24_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_24_1
			}
		}))

		return
	end)
	self:bind(LimitChallengePreCombatMediator.ON_SELECT_COMMANDER, function(arg_25_0, arg_25_1, arg_25_2)
		LimitChallengePreCombatMediator.onSelectCommander(_.map({
			FleetProxy.CHALLENGE_FLEET_ID,
			FleetProxy.CHALLENGE_SUB_FLEET_ID
		}, function(arg_26_0)
			return getProxy(FleetProxy):getFleetById(arg_26_0)
		end), arg_25_1, arg_25_2)

		return
	end)

	return
end

function LimitChallengePreCombatMediator:onAutoBtn(arg_27_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_27_1.isOn,
		toggle = arg_27_1.toggle,
		system = self.contextData.system
	})

	return
end

function LimitChallengePreCombatMediator:onAutoSubBtn(arg_28_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_28_1.isOn,
		toggle = arg_28_1.toggle,
		system = self.contextData.system
	})

	return
end

function LimitChallengePreCombatMediator:changeFleet(arg_29_1)
	self.contextData.fleetIndex = table.indexof(self.contextData.fleets, _.detect(self.contextData.fleets, function(arg_30_0)
		return arg_30_0.id == arg_29_1
	end))

	self.viewComponent:SetCurrentFleet(arg_29_1)
	self.viewComponent:UpdateFleetView(true)
	self.viewComponent:SetFleetStepper()

	return
end

function LimitChallengePreCombatMediator:refreshEdit(arg_31_1)
	self.viewComponent:UpdateFleetView(false)
	self.viewComponent:SetSubFlag(self.contextData.fleets[#self.contextData.fleets]:isLegalToFight() == true)
	getProxy(FleetProxy):updateFleet(arg_31_1)

	return
end

function LimitChallengePreCombatMediator:removeShipFromFleet(arg_32_1, arg_32_2)
	if not arg_32_1:canRemove(arg_32_2) then
		local var_32_0, var_32_1 = arg_32_1:getShipPos(arg_32_2)

		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_32_2:getConfigTable().name, arg_32_1.name, Fleet.C_TEAM_NAME[var_32_1]))

		return false
	end

	arg_32_1:removeShip(arg_32_2)

	return true
end

function LimitChallengePreCombatMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO
	}
end

function LimitChallengePreCombatMediator:handleNotification(arg_34_1)
	local var_34_0 = arg_34_1:getName()
	local var_34_1 = arg_34_1:getBody()

	if var_34_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_34_1)
	elseif var_34_0 == GAME.BEGIN_STAGE_ERRO and var_34_1 == 3 then
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

function LimitChallengePreCombatMediator:remove()
	LimitChallengePreCombatMediator.super.remove(self)

	return
end

function LimitChallengePreCombatMediator:getDockCallbackFuncs(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = getProxy(BayProxy)

	return function(arg_38_0, arg_38_1)
		local var_38_0, var_38_1 = ShipStatus.ShipStatusCheck("inChallenge", arg_38_0, arg_38_1)

		if not var_38_0 then
			return var_38_0, var_38_1
		end

		if self and self:isSameKind(arg_38_0) then
			return true
		end

		for iter_38_0, iter_38_1 in ipairs(arg_37_3) do
			if arg_38_0:isSameKind(var_37_0:getShipById(iter_38_1)) then
				local var_38_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1()

		return
	end, function(arg_40_0)
		if #arg_40_0 == 0 then
			if self then
				arg_37_1:removeShip(self)
			end
		elseif #arg_40_0 > 0 then
			local var_40_0 = arg_37_1:getShipPos(self)
			local var_40_1 = var_37_0:getShipById(arg_40_0[1])

			if var_40_0 then
				arg_37_1:removeShip(self)

				if var_40_1.id == self.id then
					var_40_0 = nil
				end
			end

			arg_37_1:insertShip(var_40_1, var_40_0, arg_37_2)
			arg_37_1:RemoveUnusedItems()
		end

		getProxy(FleetProxy):updateFleet(arg_37_1)

		return
	end
end

function LimitChallengePreCombatMediator:onSelectCommander(arg_41_1, arg_41_2)
	local var_41_0 = _.detect(self, function(arg_42_0)
		return arg_42_0.id == arg_41_2
	end)

	assert(var_41_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
		maxCount = 1,
		mode = CommanderCatScene.MODE_SELECT,
		fleetType = CommanderCatScene.FLEET_TYPE_LIMIT_CHALLENGE,
		activeCommander = var_41_0:getCommanderByPos(arg_41_1),
		ignoredIds = {},
		onCommander = function(arg_43_0)
			return true
		end,
		onSelected = function(self, arg_44_1)
			local var_44_0 = getProxy(CommanderProxy):getCommanderById(self[1])

			for iter_44_0, iter_44_1 in pairs(self) do
				if iter_44_1.id == arg_41_2 then
					for iter_44_2, iter_44_3 in pairs((iter_44_1:getCommanders())) do
						if iter_44_3.groupId == var_44_0.groupId and iter_44_2 ~= arg_41_1 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

							return
						end
					end
				else
					for iter_44_4, iter_44_5 in pairs((iter_44_1:getCommanders())) do
						if self[1] == iter_44_5.id then
							pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			var_41_0:updateCommanderByPos(arg_41_1, var_44_0)
			getProxy(FleetProxy):updateFleet(var_41_0)
			arg_44_1()

			return
		end,
		onQuit = function(arg_45_0)
			var_41_0:updateCommanderByPos(arg_41_1, nil)
			getProxy(FleetProxy):updateFleet(var_41_0)
			arg_45_0()

			return
		end
	})

	return
end

return LimitChallengePreCombatMediator
