local var_0_0 = class("BossSingleMediatorTemplate", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "BossSingleMediatorTemplate.GO_SCENE"
var_0_0.GO_SUBLAYER = "BossSingleMediatorTemplate.GO_SUBLAYER"
var_0_0.ON_PRECOMBAT = "BossSingleMediatorTemplate:ON_PRECOMBAT"
var_0_0.ON_COMMIT_FLEET = "BossSingleMediatorTemplate:ON_COMMIT_FLEET"
var_0_0.ON_FLEET_RECOMMEND = "BossSingleMediatorTemplate:ON_FLEET_RECOMMEND"
var_0_0.ON_FLEET_CLEAR = "BossSingleMediatorTemplate:ON_FLEET_CLEAR"
var_0_0.ON_OPEN_DOCK = "BossSingleMediatorTemplate:ON_OPEN_DOCK"
var_0_0.ON_FLEET_SHIPINFO = "BossSingleMediatorTemplate:ON_FLEET_SHIPINFO"
var_0_0.ON_SELECT_COMMANDER = "BossSingleMediatorTemplate:ON_SELECT_COMMANDER"
var_0_0.COMMANDER_FORMATION_OP = "BossSingleMediatorTemplate:COMMANDER_FORMATION_OP"
var_0_0.ON_COMMANDER_SKILL = "BossSingleMediatorTemplate:ON_COMMANDER_SKILL"
var_0_0.ON_PERFORM_COMBAT = "BossSingleMediatorTemplate:ON_PERFORM_COMBAT"

function var_0_0.GetPairedFleetIndex(arg_1_0)
	if arg_1_0 < Fleet.SUBMARINE_FLEET_ID then
		return arg_1_0 + 10
	else
		return arg_1_0 - 10
	end

	return
end

function var_0_0.BindBattleEvents(arg_2_0)
	arg_2_0.contextData.mediatorClass = arg_2_0.class

	local var_2_0 = getProxy(FleetProxy)
	local var_2_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE)

	if not var_2_1 then
		return
	end

	arg_2_0.contextData.bossActivity = var_2_1
	arg_2_0.contextData.activityID = var_2_1.id
	arg_2_0.contextData.stageIDs = var_2_1:GetStageIDs()
	arg_2_0.contextData.useOilLimit = var_2_1:GetOilLimits()
	arg_2_0.contextData.actFleets = getProxy(FleetProxy):getActivityFleets()[arg_2_0.contextData.activityID]

	arg_2_0.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle()
	arg_2_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_2_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_2_0:bind(ActivityMediator.EVENT_PT_OPERATION, function(arg_5_0, arg_5_1)
		arg_2_0:sendNotification(GAME.ACT_NEW_PT, arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_PRECOMBAT, function(arg_6_0, arg_6_1)
		local var_6_0 = var_2_0:getActivityFleets()[arg_2_0.contextData.activityID]

		if not var_6_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		var_6_0[arg_6_1]:RemoveUnusedItems()

		if var_6_0[arg_6_1]:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

			return
		end

		var_6_0[arg_6_1 + 10]:RemoveUnusedItems()

		local var_6_1 = arg_2_0.contextData.activityID

		if _.any({
			var_6_0[arg_6_1],
			var_6_0[arg_6_1 + 10]
		}, function(arg_7_0)
			local var_7_0, var_7_1 = arg_7_0:HaveShipsInEvent()

			if var_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_7_1)

				return true
			end

			return _.any(arg_7_0:getShipIds(), function(arg_8_0)
				local var_8_0 = getProxy(BayProxy):RawGetShipById(arg_8_0)

				if not var_8_0 then
					return
				end

				local var_8_1, var_8_2 = ShipStatus.ShipStatusCheck("inActivity", var_8_0, nil, {
					inActivity = var_6_1
				})

				if not var_8_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_8_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		arg_2_0:addSubLayers(Context.New({
			mediator = BossSinglePreCombatMediator,
			viewComponent = BossSinglePreCombatLayer,
			data = {
				system = SYSTEM_BOSS_SINGLE,
				stageId = arg_2_0.contextData.stageIDs[arg_6_1],
				actId = arg_2_0.contextData.activityID,
				fleets = {
					var_6_0[arg_6_1],
					var_6_0[arg_6_1 + 10]
				},
				costLimit = arg_2_0.contextData.useOilLimit[arg_6_1]
			},
			onRemoved = function()
				arg_2_0.viewComponent:updateEditPanel()

				return
			end
		}))

		return
	end)
	arg_2_0:bind(var_0_0.ON_COMMIT_FLEET, function()
		var_2_0:commitActivityFleet(arg_2_0.contextData.activityID)

		return
	end)
	arg_2_0:bind(var_0_0.ON_FLEET_RECOMMEND, function(arg_11_0, arg_11_1)
		var_2_0:recommendActivityFleet(arg_2_0.contextData.activityID, arg_11_1)

		arg_2_0.contextData.actFleets = var_2_0:getActivityFleets()[arg_2_0.contextData.activityID]

		arg_2_0.viewComponent:updateEditPanel()

		return
	end)
	arg_2_0:bind(var_0_0.ON_FLEET_CLEAR, function(arg_12_0, arg_12_1)
		local var_12_0 = var_2_0:getActivityFleets()[arg_2_0.contextData.activityID]

		var_12_0[arg_12_1]:clearFleet()
		var_2_0:updateActivityFleet(arg_2_0.contextData.activityID, arg_12_1, var_12_0[arg_12_1])

		arg_2_0.contextData.actFleets = var_12_0

		arg_2_0.viewComponent:updateEditPanel()

		return
	end)
	arg_2_0:bind(var_0_0.ON_OPEN_DOCK, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_2_0.contextData.activityID or 5620
		local var_13_1, var_13_2, var_13_3 = arg_2_0.getDockCallbackFuncs4ActicityFleet(arg_13_1.shipVO, arg_13_1.fleetIndex, arg_13_1.teamType)
		local var_13_4 = arg_2_0
		local var_13_6 = GAME.GO_SCENE
		local var_13_7 = SCENE.DOCKYARD
		local var_13_8 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = arg_13_1.shipVO ~= nil,
			teamFilter = arg_13_1.teamType,
			leftTopInfo = i18n("word_formation"),
			onShip = var_13_1,
			confirmSelect = var_13_2,
			onSelected = var_13_3,
			hideTagFlags = setmetatable({
				inActivity = var_13_0
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			otherSelectedIds = arg_13_1.fleet
		}

		var_13_8.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		var_13_5(var_13_4, var_13_6, var_13_7, var_13_8)

		return
	end)
	arg_2_0:bind(var_0_0.ON_FLEET_SHIPINFO, function(arg_14_0, arg_14_1)
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_14_1.shipId,
			shipVOs = arg_14_1.shipVOs
		})

		return
	end)
	arg_2_0:bind(var_0_0.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		arg_2_0:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_COMMANDER_SKILL, function(arg_16_0, arg_16_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_16_1
			}
		}))

		return
	end)
	arg_2_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = var_2_0:getActivityFleets()[arg_2_0.contextData.activityID][arg_17_1]

		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_2_0:getActivityFleets()[arg_2_0.contextData.activityID][arg_17_1]:getCommanders()[arg_17_2],
			fleetType = CommanderCatScene.FLEET_TYPE_BOSSSINGLE,
			ignoredIds = {},
			onCommander = function(arg_18_0)
				return true
			end,
			onSelected = function(arg_19_0, arg_19_1)
				local var_19_0 = getProxy(CommanderProxy):getCommanderById(arg_19_0[1])

				for iter_19_0, iter_19_1 in pairs(var_0) do
					if iter_19_0 == arg_17_1 then
						for iter_19_2, iter_19_3 in pairs(var_0) do
							if iter_19_3.groupId == var_19_0.groupId and iter_19_2 ~= arg_17_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					elseif iter_19_0 == var_0_0.GetPairedFleetIndex(arg_17_1) then
						for iter_19_4, iter_19_5 in pairs((iter_19_1:getCommanders())) do
							if arg_19_0[1] == iter_19_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_17_0:updateCommanderByPos(arg_17_2, var_19_0)
				var_2_0:updateActivityFleet(arg_2_0.contextData.activityID, arg_17_1, var_17_0)
				arg_19_1()

				return
			end,
			onQuit = function(arg_20_0)
				var_17_0:updateCommanderByPos(arg_17_2, nil)
				var_2_0:updateActivityFleet(arg_2_0.contextData.activityID, arg_17_1, var_17_0)
				arg_20_0()

				return
			end
		})

		return
	end)
	arg_2_0:bind(PreCombatMediator.BEGIN_STAGE_PROXY, function(arg_21_0, arg_21_1)
		arg_2_0:sendNotification(PreCombatMediator.BEGIN_STAGE_PROXY, {
			curFleetId = arg_21_1
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_PERFORM_COMBAT, function(arg_22_0, arg_22_1, arg_22_2)
		arg_2_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_22_1,
			exitCallback = arg_22_2
		})

		return
	end)

	return
end

function var_0_0.GetBattleHanldDic(arg_23_0)
	return {
		[GAME.BEGIN_STAGE_DONE] = function(arg_24_0, arg_24_1)
			arg_24_0.contextData.editFleet = nil

			if not getProxy(ContextProxy):getContextByMediator(PreCombatMediator) then
				arg_24_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, (arg_24_1:getBody()))
			end

			return
		end,
		[GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE] = function(arg_25_0, arg_25_1)
			local var_25_0 = arg_25_1:getBody()
			local var_25_1 = getProxy(FleetProxy):getActivityFleets()[var_25_0.actId]

			arg_25_0.contextData.actFleets = var_25_1

			arg_25_0.viewComponent:updateEditPanel()
			arg_25_0.viewComponent:updateCommanderFleet(var_25_1[var_25_0.fleetId])

			return
		end,
		[CommanderProxy.PREFAB_FLEET_UPDATE] = function(arg_26_0, arg_26_1)
			local var_26_0 = arg_26_1:getBody()

			arg_26_0.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
			arg_26_0.viewComponent:updateCommanderPrefab()

			return
		end
	}
end

function var_0_0.getDockCallbackFuncs4ActicityFleet(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = getProxy(BayProxy)
	local var_27_1 = getProxy(FleetProxy)
	local var_27_2 = getProxy(FleetProxy):getActivityFleets()[getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE).id][arg_27_1]

	return function(arg_28_0, arg_28_1)
		local var_28_0, var_28_1 = ShipStatus.ShipStatusCheck("inActivity", arg_28_0, arg_28_1, {
			inActivity = var_0.id
		})

		if not var_28_0 then
			return var_28_0, var_28_1
		end

		if arg_27_0 and arg_27_0:isSameKind(arg_28_0) then
			return true
		end

		local var_28_3 = var_27_2.ships or {}

		for iter_28_0, iter_28_1 in var_28_2(var_28_3) do
			if arg_28_0:isSameKind(var_27_0:getShipById(iter_28_1)) then
				local var_28_5 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1()

		return
	end, function(arg_30_0)
		if arg_27_0 then
			var_27_2:removeShip(arg_27_0)
		end

		if #arg_30_0 > 0 then
			local var_30_0 = var_27_0:getShipById(arg_30_0[1])

			if not var_27_2:containShip(var_30_0) then
				var_27_2:insertShip(var_30_0, nil, arg_27_2)
			elseif arg_27_0 then
				var_27_2:insertShip(arg_27_0, nil, arg_27_2)
			end

			var_27_2:RemoveUnusedItems()
		end

		var_27_1:updateActivityFleet(var_0.id, arg_27_1, var_27_2)

		return
	end
end

return var_0_0
