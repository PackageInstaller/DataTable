local ChallengeMainMediator = class("ChallengeMainMediator", import("..base.ContextMediator"))

ChallengeMainMediator.ON_COMMIT_FLEET = "ChallengeMainMediator:ON_COMMIT_FLEET"
ChallengeMainMediator.ON_FLEET_SHIPINFO = "ChallengeMainMediator:ON_FLEET_SHIPINFO"
ChallengeMainMediator.ON_PRECOMBAT = "ChallengeMainMediator:ON_PRECOMBAT"
ChallengeMainMediator.ON_SELECT_ELITE_COMMANDER = "ChallengeMainMediator:ON_SELECT_ELITE_COMMANDER"
ChallengeMainMediator.ON_OPEN_RANK = "ChallengeMainMediator:ON_OPEN_RANK"
ChallengeMainMediator.COMMANDER_FORMATION_OP = "ChallengeMainMediator:COMMANDER_FORMATION_OP"
ChallengeMainMediator.ON_COMMANDER_SKILL = "ChallengeMainMediator:ON_COMMANDER_SKILL"

function ChallengeMainMediator:register()
	local var_1_0 = getProxy(FleetProxy)
	local var_1_1 = getProxy(ChallengeProxy)
	local var_1_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	self:bind(ChallengeMainMediator.ON_OPEN_RANK, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_CHALLENGE
		})

		return
	end)
	self:bind(ChallengeConst.CLICK_GET_AWARD_BTN, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1)

		return
	end)
	self:bind(ChallengeConst.RESET_DATA_EVENT, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.CHALLENGE2_RESET, {
			mode = arg_4_1,
			isInfiniteSeasonClear = arg_4_2
		})

		return
	end)
	self:bind(ActivityFleetPanel.ON_OPEN_DOCK, function(arg_5_0, arg_5_1)
		local var_5_1 = getProxy(BayProxy):getRawData()

		self.contextData.editFleet = true

		local var_5_2, var_5_3, var_5_4 = self:getDockCallbackFuncs(arg_5_1.fleet, arg_5_1.shipVO, arg_5_1.fleetIndex, arg_5_1.teamType)
		local var_5_5 = GAME.GO_SCENE
		local var_5_6 = SCENE.DOCKYARD
		local var_5_7 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = arg_5_1.shipVO ~= nil,
			teamFilter = arg_5_1.teamType,
			leftTopInfo = i18n("word_formation"),
			onShip = var_5_2,
			confirmSelect = var_5_3,
			onSelected = var_5_4,
			hideTagFlags = setmetatable({
				inActivity = var_1_2.id
			}, {
				__index = ShipStatus.TAG_HIDE_CHALLENGE
			}),
			otherSelectedIds = arg_5_1.fleet
		}

		var_5_7.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		self:sendNotification(var_5_5, var_5_6, var_5_7)

		return
	end)
	self:bind(ChallengeMainMediator.ON_COMMIT_FLEET, function()
		var_1_0:commitActivityFleet(var_1_2.id)

		return
	end)
	self:bind(ChallengeMainMediator.ON_FLEET_SHIPINFO, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_7_1.shipId,
			shipVOs = arg_7_1.shipVOs
		})

		self.contextData.editFleet = true

		return
	end)
	self:bind(ActivityFleetPanel.ON_FLEET_RECOMMEND, function(arg_8_0, arg_8_1)
		var_1_0:recommendActivityFleet(var_1_2.id, arg_8_1)
		self.viewComponent:setFleet(var_1_0:getActivityFleets()[var_1_2.id])
		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(ActivityFleetPanel.ON_FLEET_CLEAR, function(arg_9_0, arg_9_1)
		local var_9_0 = var_1_0:getActivityFleets()[var_1_2.id]

		var_9_0[arg_9_1]:clearFleet()
		var_1_0:updateActivityFleet(var_1_2.id, arg_9_1, var_9_0[arg_9_1])
		self.viewComponent:setFleet(var_9_0)
		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(ChallengeMainMediator.COMMANDER_FORMATION_OP, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_10_1
		})

		return
	end)
	self:bind(ChallengeMainMediator.ON_COMMANDER_SKILL, function(arg_11_0, arg_11_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_11_1
			}
		}))

		return
	end)
	self:bind(ChallengeMainMediator.ON_SELECT_ELITE_COMMANDER, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = var_1_0:getActivityFleets()[var_1_2.id]
		local var_12_1 = var_12_0[arg_12_1]
		local var_12_2 = var_12_0[arg_12_1]:getCommanders()

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_12_2[arg_12_2],
			ignoredIds = {},
			fleetType = CommanderCatScene.FLEET_TYPE_CHALLENGE,
			onCommander = function(arg_13_0)
				return true
			end,
			onSelected = function(self, arg_14_1)
				local var_14_0 = getProxy(CommanderProxy):getCommanderById(self[1])

				for iter_14_0, iter_14_1 in pairs(var_12_0) do
					if iter_14_0 == arg_12_1 then
						for iter_14_2, iter_14_3 in pairs(var_12_2) do
							if iter_14_3.groupId == var_14_0.groupId and iter_14_2 ~= arg_12_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					else
						for iter_14_4, iter_14_5 in pairs((iter_14_1:getCommanders())) do
							if self[1] == iter_14_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_12_1:updateCommanderByPos(arg_12_2, var_14_0)
				var_1_0:updateActivityFleet(var_1_2.id, arg_12_1, var_12_1)
				arg_14_1()

				return
			end,
			onQuit = function(arg_15_0)
				var_12_1:updateCommanderByPos(arg_12_2, nil)
				var_1_0:updateActivityFleet(var_1_2.id, arg_12_1, var_12_1)
				arg_15_0()

				return
			end
		})

		self.contextData.editFleet = true

		return
	end)
	self:bind(ChallengeMainMediator.ON_PRECOMBAT, function(arg_16_0, arg_16_1)
		if var_1_0:checkActivityFleet(var_1_2.id) ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		local var_16_0 = var_1_0:getActivityFleets()[var_1_2.id][arg_16_1 + 1]:isLegalToFight()

		if var_16_0 == TeamType.Vanguard then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_vo_vanguardFleet_must_hasShip"))

			return
		elseif var_16_0 == TeamType.Main then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_vo_mainFleet_must_hasShip"))

			return
		end

		self.viewComponent:hideFleetEdit()

		if not var_1_1:getUserChallengeInfo(arg_16_1) then
			self:sendNotification(GAME.CHALLENGE2_INITIAL, {
				mode = arg_16_1
			})

			return
		end

		self:addSubLayers(Context.New({
			mediator = ChallengePreCombatMediator,
			viewComponent = ChallengePreCombatLayer,
			data = {
				system = SYSTEM_CHALLENGE,
				actId = var_1_2.id,
				mode = arg_16_1,
				func = function()
					self:tryBattle()

					return
				end
			}
		}))

		return
	end)
	self.viewComponent:setFleet(var_1_0:getActivityFleets()[var_1_2.id])
	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))

	return
end

function ChallengeMainMediator:listNotificationInterests()
	return {
		GAME.CHALLENGE2_INITIAL_DONE,
		GAME.CHALLENGE2_RESET_DONE,
		GAME.CHALLENGE2_INFO_DONE,
		GAME.SUBMIT_TASK_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	}
end

function ChallengeMainMediator:handleNotification(arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()
	local var_19_2 = getProxy(ChallengeProxy)

	if var_19_0 == GAME.CHALLENGE2_INITIAL_DONE then
		local var_19_3 = var_19_2:getUserChallengeInfo(var_19_1.mode)

		self:addSubLayers(Context.New({
			mediator = ChallengePreCombatMediator,
			viewComponent = ChallengePreCombatLayer,
			data = {
				system = SYSTEM_CHALLENGE,
				actId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE).id,
				mode = var_19_1.mode,
				func = function()
					self:tryBattle()

					return
				end
			}
		}))
		self.viewComponent:updateData()
		self.viewComponent:updatePaintingList()
		self.viewComponent:updateRoundText()
		self.viewComponent:updateSlider()
		self.viewComponent:updateFuncBtns()
	elseif var_19_0 == GAME.CHALLENGE2_RESET_DONE then
		if self.viewComponent.curMode == ChallengeProxy.MODE_INFINITE and not self.viewComponent:isFinishedCasualMode() then
			var_19_2:setCurMode(ChallengeProxy.MODE_CASUAL)
		end

		self.viewComponent:updateData()
		self.viewComponent:updateGrade(var_19_2:getChallengeInfo():getGradeList())
		self.viewComponent:updateSwitchModBtn()
		self.viewComponent:updatePaintingList()
		self.viewComponent:updateRoundText()
		self.viewComponent:updateSlider()
		self.viewComponent:updateFuncBtns()
	elseif var_19_0 == GAME.CHALLENGE2_INFO_DONE then
		if self.viewComponent.curMode == ChallengeProxy.MODE_INFINITE and not self.viewComponent:isFinishedCasualMode() then
			var_19_2:setCurMode(ChallengeProxy.MODE_CASUAL)
		end

		self.viewComponent:updateData()
		self.viewComponent:updateGrade(var_19_2:getChallengeInfo():getGradeList())
		self.viewComponent:updateTimePanel()
		self.viewComponent:updateSwitchModBtn()
		self.viewComponent:updatePaintingList()
		self.viewComponent:updateRoundText()
		self.viewComponent:updateSlider()
		self.viewComponent:updateFuncBtns()
	elseif var_19_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_19_1, function()
			self.viewComponent:updateAwardPanel()

			return
		end)
	elseif var_19_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
		self.viewComponent:updateCommanderPrefab()
	elseif var_19_0 == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		local var_19_4 = getProxy(FleetProxy):getActivityFleets()[var_19_1.actId]

		self.viewComponent:setFleet(var_19_4)
		self.viewComponent:updateEditPanel()
		self.viewComponent:updateCommanderFleet(var_19_4[var_19_1.fleetId])
	end

	return
end

function ChallengeMainMediator:getDockCallbackFuncs(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = getProxy(BayProxy)
	local var_22_1 = getProxy(FleetProxy)
	local var_22_2 = getProxy(ActivityProxy)
	local var_22_3 = var_22_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	return function(arg_23_0, arg_23_1)
		local var_23_0, var_23_1 = ShipStatus.ShipStatusCheck("inActivity", arg_23_0, arg_23_1, {
			inActivity = var_22_3.id
		})

		if not var_23_0 then
			return var_23_0, var_23_1
		end

		for iter_23_0, iter_23_1 in ipairs(arg_22_1) do
			if arg_23_0:isSameKind(var_22_0:getShipById(iter_23_1)) then
				local var_23_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1()

		return
	end, function(arg_25_0)
		local var_25_0 = var_22_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)
		local var_25_1 = var_22_1:getActivityFleets()[var_25_0.id][arg_22_3]

		if arg_22_2 then
			var_25_1:removeShip(arg_22_2)
		end

		if #arg_25_0 > 0 then
			var_25_1:insertShip(var_22_0:getShipById(arg_25_0[1]), nil, arg_22_4)
		end

		var_22_1:updateActivityFleet(var_25_0.id, arg_22_3, var_25_1)

		return
	end
end

return ChallengeMainMediator
