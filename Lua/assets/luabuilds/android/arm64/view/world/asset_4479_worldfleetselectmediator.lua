local WorldFleetSelectMediator = class("WorldFleetSelectMediator", import("..base.ContextMediator"))

WorldFleetSelectMediator.OnSelectShip = "WorldFleetSelectMediator.OnSelectShip"
WorldFleetSelectMediator.OnGO = "WorldFleetSelectMediator.OnGO"
WorldFleetSelectMediator.OnShipDetail = "WorldFleetSelectMediator.OnShipDetail"
WorldFleetSelectMediator.OnSelectEliteCommander = "WorldFleetSelectMediator.OnSelectEliteCommander"
WorldFleetSelectMediator.OnCommanderFormationOp = "WorldFleetSelectMediator.OnCommanderFormationOp"
WorldFleetSelectMediator.OnCommanderSkill = "WorldFleetSelectMediator.OnCommanderSkill"

function WorldFleetSelectMediator:register()
	self:bind(WorldFleetSelectMediator.OnSelectShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(self.contextData.fleets) do
			for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
				for iter_2_4 = 1, 3 do
					if iter_2_3[arg_2_1][iter_2_4] then
						table.insert(var_2_0, iter_2_3[arg_2_1][iter_2_4])
					end
				end
			end
		end

		local var_2_1, var_2_2, var_2_3 = self:GetDockCallbackFuncs(arg_2_2, arg_2_3, var_2_0)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = tobool(arg_2_2[arg_2_3]),
			teamFilter = arg_2_1,
			leftTopInfo = i18n("word_formation"),
			onShip = var_2_1,
			confirmSelect = var_2_2,
			onSelected = var_2_3,
			hideTagFlags = ShipStatus.TAG_HIDE_WORLD,
			otherSelectedIds = var_2_0
		})

		return
	end)
	self:bind(WorldFleetSelectMediator.OnGO, function(arg_3_0)
		local var_3_0 = nowWorld()
		local var_3_1 = self.contextData.fleets

		if self.contextData.mapId then
			self:sendNotification(GAME.WORLD_ACTIVATE, {
				id = self.contextData.mapId,
				enter_map_id = self.contextData.entranceId,
				elite_fleet_list = var_3_0:FormationIds2NetIds(self.contextData.fleets),
				camp = var_3_0:GetRealm()
			})
		else
			local var_3_2 = {}

			if not var_3_0:CompareRedeploy(self.contextData.fleets) then
				table.insert(var_3_2, function(arg_4_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("world_redeploy_not_change"),
						onYes = arg_4_0
					})

					return
				end)
			end

			table.insert(var_3_2, function(arg_5_0)
				local var_5_0 = var_3_0:CalcOrderCost(WorldConst.OpReqRedeploy)
				local var_5_1 = var_3_0.staminaMgr:GetTotalStamina()
				local var_5_2 = pg.MsgboxMgr.GetInstance()
				local var_5_3 = {}

				var_5_3.content = i18n("world_redeploy_cost_tip", setColorStr(var_5_0, COLOR_GREEN), setColorStr(var_5_1, (var_5_0 <= var_5_1 or nil) and (COLOR_GREEN or COLOR_RED)))

				function var_5_3.onYes()
					if var_3_0.staminaMgr:GetTotalStamina() < var_5_0 then
						var_3_0.staminaMgr:Show()
					else
						arg_5_0()
					end

					return
				end

				var_5_2:ShowMsgBox(var_5_3)

				return
			end)
			seriesAsync(var_3_2, function()
				self:sendNotification(GAME.WORLD_FLEET_REDEPLOY, {
					elite_fleet_list = var_3_0:FormationIds2NetIds(var_3_1)
				})

				return
			end)
		end

		return
	end)
	self:bind(WorldFleetSelectMediator.OnShipDetail, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_8_1.shipId,
			shipVOs = arg_8_1.shipVOs
		})

		return
	end)
	self:bind(WorldFleetSelectMediator.OnCommanderFormationOp, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_9_1
		})

		return
	end)
	self:bind(WorldFleetSelectMediator.OnCommanderSkill, function(arg_10_0, arg_10_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				isWorld = true,
				skill = arg_10_1
			}
		}))

		return
	end)
	self:bind(WorldFleetSelectMediator.OnSelectEliteCommander, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = self.contextData.fleets[arg_11_1][arg_11_2]
		local var_11_1 = Fleet.New({
			ship_list = {},
			commanders = self.contextData.fleets[arg_11_1][arg_11_2].commanders
		})
		local var_11_2 = var_11_1:getCommanders()

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			fleetType = CommanderCatScene.FLEET_TYPE_WORLD,
			fleets = self.contextData.fleets,
			activeCommander = var_11_2[arg_11_3],
			ignoredIds = {},
			onCommander = function(arg_12_0)
				return true
			end,
			onSelected = function(self, arg_13_1)
				local var_13_0 = getProxy(CommanderProxy):getCommanderById(self[1])

				for iter_13_0, iter_13_1 in pairs(self.contextData.fleets) do
					for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
						if iter_13_0 == arg_11_1 and iter_13_2 == arg_11_2 then
							for iter_13_4, iter_13_5 in pairs(var_11_2) do
								if iter_13_5.groupId == var_13_0.groupId and iter_13_4 ~= arg_11_3 then
									pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

									return
								end
							end
						else
							for iter_13_6, iter_13_7 in pairs(iter_13_3.commanders) do
								if self[1] == iter_13_7.id then
									pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

									return
								end
							end
						end
					end
				end

				var_11_1:updateCommanderByPos(arg_11_3, var_13_0)

				var_11_0.commanders = var_11_1:outputCommanders()

				arg_13_1()

				return
			end,
			onQuit = function(arg_14_0)
				var_11_1:updateCommanderByPos(arg_11_3, nil)

				var_11_0.commanders = var_11_1:outputCommanders()

				arg_14_0()

				return
			end
		})

		self.contextData.editFleet = true

		return
	end)
	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))

	return
end

function WorldFleetSelectMediator:listNotificationInterests()
	return {
		GAME.WORLD_ACTIVATE_DONE,
		GAME.WORLD_FLEET_REDEPLOY_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COMMANDER_WORLD_FORMATION_OP_DONE
	}
end

function WorldFleetSelectMediator:handleNotification(arg_16_1)
	local var_16_0 = arg_16_1:getName()

	if var_16_0 == GAME.WORLD_ACTIVATE_DONE then
		local var_16_1 = nowWorld()
		local var_16_2 = {}

		if var_16_1:IsSystemOpen(WorldConst.SystemDailyTask) then
			table.insert(var_16_2, function(arg_17_0)
				var_16_1:GetTaskProxy():checkDailyTask(arg_17_0)

				return
			end)
		end

		seriesAsync(var_16_2, function()
			self:SetFleetSuccess()

			return
		end)
	elseif var_16_0 == GAME.WORLD_FLEET_REDEPLOY_DONE then
		self:SetFleetSuccess()
	elseif var_16_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
		self.viewComponent:updateCommanderPrefab()
	elseif var_16_0 == GAME.COMMANDER_WORLD_FORMATION_OP_DONE then
		self.viewComponent:UpdateFleets()
		self.viewComponent:updateCommanderFleet(arg_16_1:getBody().fleet)
	end

	return
end

function WorldFleetSelectMediator:GetDockCallbackFuncs(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = getProxy(BayProxy)

	return function(arg_20_0, arg_20_1)
		local var_20_0, var_20_1 = ShipStatus.ShipStatusCheck("inWorld", arg_20_0, arg_20_1)

		if not var_20_0 then
			return var_20_0, var_20_1
		end

		for iter_20_0, iter_20_1 in ipairs(arg_19_3) do
			if arg_20_0.id ~= iter_20_1 and arg_20_0:isSameKind(var_19_0:getShipById(iter_20_1)) then
				local var_20_3 = i18n("event_same_type_not_allowed")

				return
			end
		end

		return true
	end, function(arg_21_0, arg_21_1, arg_21_2)
		arg_21_1()

		return
	end, function(arg_22_0)
		for iter_22_0, iter_22_1 in pairs(self.contextData.fleets) do
			for iter_22_2, iter_22_3 in ipairs(iter_22_1) do
				for iter_22_4, iter_22_5 in pairs(iter_22_3) do
					for iter_22_6 = 3, 1, -1 do
						if arg_19_1 == iter_22_5 and iter_22_6 == arg_19_2 then
							iter_22_5[iter_22_6] = arg_22_0[1]
						elseif iter_22_5[iter_22_6] == arg_22_0[1] then
							iter_22_5[iter_22_6] = nil
						end
					end
				end
			end
		end

		return
	end
end

function WorldFleetSelectMediator:SetFleetSuccess()
	local var_23_0 = {
		inPort = true
	}

	if self.contextData.mapId then
		if nowWorld():IsReseted() then
			var_23_0 = {
				inShop = true
			}
		end
	end

	local var_23_1 = getProxy(ContextProxy):getContextByMediator(WorldMediator)

	if var_23_1 then
		var_23_1:extendData(var_23_0)
		self.viewComponent:closeView()
	else
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.WORLD, var_23_0)
	end

	return
end

return WorldFleetSelectMediator
