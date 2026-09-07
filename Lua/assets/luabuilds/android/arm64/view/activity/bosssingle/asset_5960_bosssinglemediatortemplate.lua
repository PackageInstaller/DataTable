local BossSingleMediatorTemplate = class("BossSingleMediatorTemplate", import("view.base.ContextMediator"))

BossSingleMediatorTemplate.GO_SCENE = "BossSingleMediatorTemplate.GO_SCENE"
BossSingleMediatorTemplate.GO_SUBLAYER = "BossSingleMediatorTemplate.GO_SUBLAYER"
BossSingleMediatorTemplate.ON_PRECOMBAT = "BossSingleMediatorTemplate:ON_PRECOMBAT"
BossSingleMediatorTemplate.ON_COMMIT_FLEET = "BossSingleMediatorTemplate:ON_COMMIT_FLEET"
BossSingleMediatorTemplate.ON_FLEET_RECOMMEND = "BossSingleMediatorTemplate:ON_FLEET_RECOMMEND"
BossSingleMediatorTemplate.ON_FLEET_CLEAR = "BossSingleMediatorTemplate:ON_FLEET_CLEAR"
BossSingleMediatorTemplate.ON_OPEN_DOCK = "BossSingleMediatorTemplate:ON_OPEN_DOCK"
BossSingleMediatorTemplate.ON_FLEET_SHIPINFO = "BossSingleMediatorTemplate:ON_FLEET_SHIPINFO"
BossSingleMediatorTemplate.ON_SELECT_COMMANDER = "BossSingleMediatorTemplate:ON_SELECT_COMMANDER"
BossSingleMediatorTemplate.COMMANDER_FORMATION_OP = "BossSingleMediatorTemplate:COMMANDER_FORMATION_OP"
BossSingleMediatorTemplate.ON_COMMANDER_SKILL = "BossSingleMediatorTemplate:ON_COMMANDER_SKILL"
BossSingleMediatorTemplate.ON_PERFORM_COMBAT = "BossSingleMediatorTemplate:ON_PERFORM_COMBAT"

function BossSingleMediatorTemplate:GetPairedFleetIndex()
	if self < Fleet.SUBMARINE_FLEET_ID then
		return self + 10
	else
		return self - 10
	end

	return
end

function BossSingleMediatorTemplate:BindBattleEvents()
	self.contextData.mediatorClass = self.class

	local var_2_0 = getProxy(FleetProxy)
	local var_2_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE)

	if not var_2_1 then
		return
	end

	self.contextData.bossActivity = var_2_1
	self.contextData.activityID = var_2_1.id
	self.contextData.stageIDs = var_2_1:GetStageIDs()
	self.contextData.useOilLimit = var_2_1:GetOilLimits()
	self.contextData.actFleets = getProxy(FleetProxy):getActivityFleets()[self.contextData.activityID]

	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle()
	self:bind(BossSingleMediatorTemplate.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(BossSingleMediatorTemplate.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(ActivityMediator.EVENT_PT_OPERATION, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_5_1)

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_PRECOMBAT, function(arg_6_0, arg_6_1)
		local var_6_0 = var_2_0:getActivityFleets()[self.contextData.activityID]

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

		local var_6_1 = {
			var_6_0[arg_6_1],
			var_6_0[arg_6_1 + 10]
		}
		local var_6_2 = self.contextData.activityID

		if _.any(var_6_1, function(arg_7_0)
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
					inActivity = var_6_2
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

		self:addSubLayers(Context.New({
			mediator = BossSinglePreCombatMediator,
			viewComponent = BossSinglePreCombatLayer,
			data = {
				system = SYSTEM_BOSS_SINGLE,
				stageId = self.contextData.stageIDs[arg_6_1],
				actId = self.contextData.activityID,
				fleets = var_6_1,
				costLimit = self.contextData.useOilLimit[arg_6_1]
			},
			onRemoved = function()
				self.viewComponent:updateEditPanel()

				return
			end
		}))

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_COMMIT_FLEET, function()
		var_2_0:commitActivityFleet(self.contextData.activityID)

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_FLEET_RECOMMEND, function(arg_11_0, arg_11_1)
		var_2_0:recommendActivityFleet(self.contextData.activityID, arg_11_1)

		self.contextData.actFleets = var_2_0:getActivityFleets()[self.contextData.activityID]

		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_FLEET_CLEAR, function(arg_12_0, arg_12_1)
		local var_12_0 = var_2_0:getActivityFleets()[self.contextData.activityID]

		var_12_0[arg_12_1]:clearFleet()
		var_2_0:updateActivityFleet(self.contextData.activityID, arg_12_1, var_12_0[arg_12_1])

		self.contextData.actFleets = var_12_0

		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_OPEN_DOCK, function(arg_13_0, arg_13_1)
		local var_13_0 = self.contextData.activityID or 5620
		local var_13_1, var_13_2, var_13_3 = self.getDockCallbackFuncs4ActicityFleet(arg_13_1.shipVO, arg_13_1.fleetIndex, arg_13_1.teamType)
		local var_13_4 = GAME.GO_SCENE
		local var_13_5 = SCENE.DOCKYARD
		local var_13_6 = {
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

		var_13_6.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		self:sendNotification(var_13_4, var_13_5, var_13_6)

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_FLEET_SHIPINFO, function(arg_14_0, arg_14_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_14_1.shipId,
			shipVOs = arg_14_1.shipVOs
		})

		return
	end)
	self:bind(BossSingleMediatorTemplate.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_COMMANDER_SKILL, function(arg_16_0, arg_16_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_16_1
			}
		}))

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_SELECT_COMMANDER, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = var_2_0:getActivityFleets()[self.contextData.activityID]
		local var_17_1 = var_17_0[arg_17_1]
		local var_17_2 = var_17_0[arg_17_1]:getCommanders()

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_17_2[arg_17_2],
			fleetType = CommanderCatScene.FLEET_TYPE_BOSSSINGLE,
			ignoredIds = {},
			onCommander = function(arg_18_0)
				return true
			end,
			onSelected = function(self, arg_19_1)
				local var_19_0 = getProxy(CommanderProxy):getCommanderById(self[1])

				for iter_19_0, iter_19_1 in pairs(var_17_0) do
					if iter_19_0 == arg_17_1 then
						for iter_19_2, iter_19_3 in pairs(var_17_2) do
							if iter_19_3.groupId == var_19_0.groupId and iter_19_2 ~= arg_17_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					elseif iter_19_0 == BossSingleMediatorTemplate.GetPairedFleetIndex(arg_17_1) then
						for iter_19_4, iter_19_5 in pairs((iter_19_1:getCommanders())) do
							if self[1] == iter_19_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_17_1:updateCommanderByPos(arg_17_2, var_19_0)
				var_2_0:updateActivityFleet(self.contextData.activityID, arg_17_1, var_17_1)
				arg_19_1()

				return
			end,
			onQuit = function(arg_20_0)
				var_17_1:updateCommanderByPos(arg_17_2, nil)
				var_2_0:updateActivityFleet(self.contextData.activityID, arg_17_1, var_17_1)
				arg_20_0()

				return
			end
		})

		return
	end)
	self:bind(PreCombatMediator.BEGIN_STAGE_PROXY, function(arg_21_0, arg_21_1)
		self:sendNotification(PreCombatMediator.BEGIN_STAGE_PROXY, {
			curFleetId = arg_21_1
		})

		return
	end)
	self:bind(BossSingleMediatorTemplate.ON_PERFORM_COMBAT, function(arg_22_0, arg_22_1, arg_22_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_22_1,
			exitCallback = arg_22_2
		})

		return
	end)

	return
end

function BossSingleMediatorTemplate:GetBattleHanldDic()
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

function BossSingleMediatorTemplate:getDockCallbackFuncs4ActicityFleet(arg_27_1, arg_27_2)
	local var_27_0 = getProxy(BayProxy)
	local var_27_1 = getProxy(FleetProxy)
	local var_27_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE)
	local var_27_3 = var_27_1:getActivityFleets()[var_27_2.id][arg_27_1]

	return function(arg_28_0, arg_28_1)
		local var_28_0, var_28_1 = ShipStatus.ShipStatusCheck("inActivity", arg_28_0, arg_28_1, {
			inActivity = var_27_2.id
		})

		if not var_28_0 then
			return var_28_0, var_28_1
		end

		if self and self:isSameKind(arg_28_0) then
			return true
		end

		for iter_28_0, iter_28_1 in ipairs(var_27_3.ships or {}) do
			if arg_28_0:isSameKind(var_27_0:getShipById(iter_28_1)) then
				local var_28_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1()

		return
	end, function(arg_30_0)
		if self then
			var_27_3:removeShip(self)
		end

		if #arg_30_0 > 0 then
			local var_30_0 = var_27_0:getShipById(arg_30_0[1])

			if not var_27_3:containShip(var_30_0) then
				var_27_3:insertShip(var_30_0, nil, arg_27_2)
			elseif self then
				var_27_3:insertShip(self, nil, arg_27_2)
			end

			var_27_3:RemoveUnusedItems()
		end

		var_27_1:updateActivityFleet(var_27_2.id, arg_27_1, var_27_3)

		return
	end
end

return BossSingleMediatorTemplate
