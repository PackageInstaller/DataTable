local var_0_0 = class("WorldFleetSelectMediator", import("..base.ContextMediator"))

var_0_0.OnSelectShip = "WorldFleetSelectMediator.OnSelectShip"
var_0_0.OnGO = "WorldFleetSelectMediator.OnGO"
var_0_0.OnShipDetail = "WorldFleetSelectMediator.OnShipDetail"
var_0_0.OnSelectEliteCommander = "WorldFleetSelectMediator.OnSelectEliteCommander"
var_0_0.OnCommanderFormationOp = "WorldFleetSelectMediator.OnCommanderFormationOp"
var_0_0.OnCommanderSkill = "WorldFleetSelectMediator.OnCommanderSkill"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnSelectShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		for iter_2_0, iter_2_1 in pairs(arg_1_0.contextData.fleets) do
			for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
				for iter_2_4 = 1, 3 do
					if iter_2_3[arg_2_1][iter_2_4] then
						table.insert({}, iter_2_3[arg_2_1][iter_2_4])
					end
				end
			end
		end

		local var_2_0, var_2_1, var_2_2 = arg_1_0:GetDockCallbackFuncs(arg_2_2, arg_2_3, {})

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = tobool(arg_2_2[arg_2_3]),
			teamFilter = arg_2_1,
			leftTopInfo = i18n("word_formation"),
			onShip = var_2_0,
			confirmSelect = var_2_1,
			onSelected = var_2_2,
			hideTagFlags = ShipStatus.TAG_HIDE_WORLD,
			otherSelectedIds = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnGO, function(arg_3_0)
		local var_3_0 = nowWorld()
		local var_3_1 = arg_1_0.contextData.fleets

		if arg_1_0.contextData.mapId then
			arg_1_0:sendNotification(GAME.WORLD_ACTIVATE, {
				id = arg_1_0.contextData.mapId,
				enter_map_id = arg_1_0.contextData.entranceId,
				elite_fleet_list = var_3_0:FormationIds2NetIds(arg_1_0.contextData.fleets),
				camp = var_3_0:GetRealm()
			})
		else
			local var_3_2 = {}

			if not var_3_0:CompareRedeploy(arg_1_0.contextData.fleets) then
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
				local var_5_3 = var_5_2
				local var_5_5 = {}
				local var_5_7 = "world_redeploy_cost_tip"
				local var_5_8 = setColorStr(var_5_0, COLOR_GREEN)

				if var_5_0 <= var_5_1 then
					var_5_5.content = var_5_6(var_5_7, var_5_8, var_5_9(var_5_10, var_5_11))

					function var_5_5.onYes()
						if var_3_0.staminaMgr:GetTotalStamina() < var_5_0 then
							var_3_0.staminaMgr:Show()
						else
							arg_5_0()
						end

						return
					end

					var_5_4(var_5_3, var_5_5)

					return
				end
			end)
			seriesAsync(var_3_2, function()
				arg_1_0:sendNotification(GAME.WORLD_FLEET_REDEPLOY, {
					elite_fleet_list = var_3_0:FormationIds2NetIds(var_3_1)
				})

				return
			end)
		end

		return
	end)
	arg_1_0:bind(var_0_0.OnShipDetail, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_8_1.shipId,
			shipVOs = arg_8_1.shipVOs
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnCommanderFormationOp, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnCommanderSkill, function(arg_10_0, arg_10_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				isWorld = true,
				skill = arg_10_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OnSelectEliteCommander, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = Fleet.New({
			ship_list = {},
			commanders = arg_1_0.contextData.fleets[arg_11_1][arg_11_2].commanders
		})

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			fleetType = CommanderCatScene.FLEET_TYPE_WORLD,
			fleets = arg_1_0.contextData.fleets,
			activeCommander = Fleet.New({
				ship_list = {},
				commanders = arg_1_0.contextData.fleets[arg_11_1][arg_11_2].commanders
			}):getCommanders()[arg_11_3],
			ignoredIds = {},
			onCommander = function(arg_12_0)
				return true
			end,
			onSelected = function(arg_13_0, arg_13_1)
				local var_13_0 = getProxy(CommanderProxy):getCommanderById(arg_13_0[1])

				for iter_13_0, iter_13_1 in pairs(arg_1_0.contextData.fleets) do
					for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
						if iter_13_0 == arg_11_1 and iter_13_2 == arg_11_2 then
							for iter_13_4, iter_13_5 in pairs(var_0) do
								if iter_13_5.groupId == var_13_0.groupId and iter_13_4 ~= arg_11_3 then
									pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

									return
								end
							end
						else
							for iter_13_6, iter_13_7 in pairs(iter_13_3.commanders) do
								if arg_13_0[1] == iter_13_7.id then
									pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

									return
								end
							end
						end
					end
				end

				var_11_0:updateCommanderByPos(arg_11_3, var_13_0)

				var_0.commanders = var_11_0:outputCommanders()

				arg_13_1()

				return
			end,
			onQuit = function(arg_14_0)
				var_11_0:updateCommanderByPos(arg_11_3, nil)

				var_0.commanders = var_11_0:outputCommanders()

				arg_14_0()

				return
			end
		})

		arg_1_0.contextData.editFleet = true

		return
	end)
	arg_1_0.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))

	return
end

function var_0_0.listNotificationInterests(arg_15_0)
	return {
		GAME.WORLD_ACTIVATE_DONE,
		GAME.WORLD_FLEET_REDEPLOY_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COMMANDER_WORLD_FORMATION_OP_DONE
	}
end

function var_0_0.handleNotification(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getName()

	if var_16_0 == GAME.WORLD_ACTIVATE_DONE then
		local var_16_1 = nowWorld()

		if nowWorld():IsSystemOpen(WorldConst.SystemDailyTask) then
			table.insert({}, function(arg_17_0)
				var_16_1:GetTaskProxy():checkDailyTask(arg_17_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_16_0:SetFleetSuccess()

			return
		end)
	elseif var_16_0 == GAME.WORLD_FLEET_REDEPLOY_DONE then
		arg_16_0:SetFleetSuccess()
	elseif var_16_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		arg_16_0.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
		arg_16_0.viewComponent:updateCommanderPrefab()
	elseif var_16_0 == GAME.COMMANDER_WORLD_FORMATION_OP_DONE then
		arg_16_0.viewComponent:UpdateFleets()
		arg_16_0.viewComponent:updateCommanderFleet(arg_16_1:getBody().fleet)
	end

	return
end

function var_0_0.GetDockCallbackFuncs(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
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
		for iter_22_0, iter_22_1 in pairs(arg_19_0.contextData.fleets) do
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

function var_0_0.SetFleetSuccess(arg_23_0)
	local var_23_0 = {
		inPort = true
	}

	if arg_23_0.contextData.mapId then
		if nowWorld():IsReseted() then
			var_23_0 = {
				inShop = true
			}
		end
	end

	local var_23_1 = getProxy(ContextProxy):getContextByMediator(WorldMediator)

	if var_23_1 then
		var_23_1:extendData(var_23_0)
		arg_23_0.viewComponent:closeView()
	else
		arg_23_0:sendNotification(GAME.CHANGE_SCENE, SCENE.WORLD, var_23_0)
	end

	return
end

return var_0_0
