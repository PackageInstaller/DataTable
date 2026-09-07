local BossRushFleetSelectMediator = class("BossRushFleetSelectMediator", import("view.base.ContextMediator"))

BossRushFleetSelectMediator.ON_OPEN_DECK = "BossRushFleetSelectMediator:ON_OPEN_DECK"
BossRushFleetSelectMediator.ON_FLEET_SHIPINFO = "BossRushFleetSelectMediator:ON_FLEET_SHIPINFO"
BossRushFleetSelectMediator.ON_TRACE = "BossRushFleetSelectMediator:ON_TRACE"
BossRushFleetSelectMediator.ON_UPDATE_CUSTOM_FLEET = "BossRushFleetSelectMediator:ON_UPDATE_CUSTOM_FLEET"
BossRushFleetSelectMediator.ON_PRECOMBAT = "BossRushFleetSelectMediator:ON_PRECOMBAT"
BossRushFleetSelectMediator.ON_ELITE_RECOMMEND = "BossRushFleetSelectMediator:ON_ELITE_RECOMMEND"
BossRushFleetSelectMediator.ON_ELITE_CLEAR = "BossRushFleetSelectMediator:ON_ELITE_CLEAR"
BossRushFleetSelectMediator.OPEN_COMMANDER_PANEL = "BossRushFleetSelectMediator:OPEN_COMMANDER_PANEL"
BossRushFleetSelectMediator.ON_SELECT_COMMANDER = "BossRushFleetSelectMediator:ON_SELECT_COMMANDER"
BossRushFleetSelectMediator.ON_COMMANDER_SKILL = "BossRushFleetSelectMediator:ON_COMMANDER_SKILL"
BossRushFleetSelectMediator.ON_SWITCH_MODE = "BossRushFleetSelectMediator:ON_SWITCH_MODE"

function BossRushFleetSelectMediator:register()
	self:bind(BossRushFleetSelectMediator.ON_OPEN_DECK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.shipVO
		local var_2_1 = _.flatten(_.map(self.contextData.fleets, function(arg_3_0)
			return arg_3_0:GetRawShipIds()
		end))
		local var_2_2 = arg_2_1.teamType
		local var_2_3, var_2_4, var_2_5 = self.getDockCallbackFuncs(arg_2_1.shipVO, self.contextData.fleets[arg_2_1.fleetIndex], arg_2_1.teamType, var_2_1, self.contextData.actId)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_2_0 ~= nil,
			teamFilter = var_2_2,
			leftTopInfo = i18n("word_formation"),
			onShip = var_2_3,
			confirmSelect = var_2_4,
			onSelected = var_2_5,
			hideTagFlags = setmetatable({
				inActivity = self.contextData.actId
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			otherSelectedIds = var_2_1
		})

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_FLEET_SHIPINFO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_4_1.shipId,
			shipVOs = arg_4_1.shipVOs
		})

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_UPDATE_CUSTOM_FLEET, function(arg_5_0)
		_.each(self.contextData.fullFleets, function(arg_6_0)
			getProxy(FleetProxy):updateActivityFleet(self.contextData.actId, arg_6_0.id, arg_6_0)

			return
		end)

		local var_5_0 = {}

		_.each(self.contextData.fullFleets, function(arg_7_0)
			var_5_0[arg_7_0.id] = arg_7_0

			return
		end)
		self:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
			actID = self.contextData.actId,
			fleets = var_5_0
		})

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_TRACE, function(arg_8_0)
		self.viewComponent:emit(BossRushFleetSelectMediator.ON_UPDATE_CUSTOM_FLEET)
		self:sendNotification(GAME.BOSSRUSH_TRACE, {
			actId = self.contextData.actId,
			seriesId = self.contextData.seriesData.id,
			mode = self.contextData.mode
		})

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_ELITE_RECOMMEND, function(arg_9_0, arg_9_1)
		local var_9_0 = self.contextData.fleets[arg_9_1.index]
		local var_9_2 = table.shallowCopy(var_9_0:GetRawShipIds())
		local var_9_3 = underscore(self.contextData.fleets):chain():map(function(arg_10_0)
			return arg_10_0:GetRawShipIds()
		end):flatten():value()
		local var_9_4 = getProxy(BayProxy):getRawData()

		local function var_9_5(arg_11_0, arg_11_1)
			for iter_11_0, iter_11_1 in ipairs((getProxy(BayProxy):getActivityRecommendShips(arg_11_0, var_9_3, TeamType.GetTeamShipMax(arg_11_1) - #underscore.filter(var_9_0:GetRawShipIds(), function(arg_12_0)
				return var_9_4[arg_12_0]:getTeamType() == arg_11_1
			end), self.contextData.actId))) do
				var_9_0:insertShip(iter_11_1, nil, iter_11_1:getTeamType())
				table.insert(var_9_2, iter_11_1.id)
				table.insert(var_9_3, iter_11_1.id)
			end

			return
		end

		if arg_9_1.index == #self.contextData.fleets then
			var_9_5(ShipType.SubShipType, TeamType.Submarine)
		else
			var_9_5(ShipType.MainShipType, TeamType.Main)
			var_9_5(ShipType.VanguardShipType, TeamType.Vanguard)
		end

		self.viewComponent:updateEliteFleets()

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_ELITE_CLEAR, function(arg_13_0, arg_13_1)
		self.contextData.fleets[arg_13_1.index]:clearFleet()
		self.viewComponent:updateEliteFleets()

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_PRECOMBAT, function(arg_14_0)
		self:addSubLayers(Context.New({
			mediator = BossRushPreCombatMediator,
			viewComponent = BossRushPreCombatLayer,
			data = {
				seriesData = self.contextData.seriesData,
				actId = self.contextData.actId,
				system = self.contextData.system,
				mode = self.contextData.mode,
				stageIds = self.contextData.stageIds,
				fleets = table.shallowCopy(self.contextData.fleets),
				fleetIndex = self.contextData.fleetIndex
			}
		}), true)

		return
	end)
	self:bind(BossRushFleetSelectMediator.OPEN_COMMANDER_PANEL, function(arg_15_0, arg_15_1)
		self:openCommanderPanel(arg_15_1, self.contextData.fleetIndex)

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_SELECT_COMMANDER, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = self.contextData.fleets
		local var_16_1 = self.contextData.fleets[arg_16_1]
		local var_16_2 = self.contextData.fleets[arg_16_1]:getCommanders()

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_16_2[arg_16_2],
			fleetType = CommanderCatScene.FLEET_TYPE_BOSSRUSH,
			fleets = self.contextData.fleets,
			ignoredIds = {},
			onCommander = function(arg_17_0)
				return true
			end,
			onSelected = function(self, arg_18_1)
				local var_18_0 = getProxy(CommanderProxy):getCommanderById(self[1])

				for iter_18_0, iter_18_1 in pairs(var_16_0) do
					if iter_18_0 == arg_16_1 then
						for iter_18_2, iter_18_3 in pairs(var_16_2) do
							if iter_18_3.groupId == var_18_0.groupId and iter_18_2 ~= arg_16_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					else
						for iter_18_4, iter_18_5 in pairs((iter_18_1:getCommanders())) do
							if self[1] == iter_18_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_16_1:updateCommanderByPos(arg_16_2, var_18_0)
				arg_18_1()

				return
			end,
			onQuit = function(arg_19_0)
				var_16_1:updateCommanderByPos(arg_16_2, nil)
				arg_19_0()

				return
			end
		})

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_COMMANDER_SKILL, function(arg_20_0, arg_20_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_20_1
			}
		}))

		return
	end)
	self:bind(BossRushFleetSelectMediator.ON_SWITCH_MODE, function(arg_21_0, arg_21_1)
		self:OnSwitchMode(arg_21_1)

		return
	end)

	local var_1_0 = self.contextData.seriesData

	self.contextData.stageIds = self.contextData.seriesData:GetExpeditionIds()
	self.contextData.fullFleets = var_1_0:GetFleets()

	if not self.contextData.mode then
		local var_1_1 = PlayerPrefs.GetInt("series_mode_flag" .. var_1_0.id, -1)

		if var_1_1 ~= -1 then
			self.contextData.mode = var_1_1
		end
	end

	self.contextData.mode = self.contextData.mode or BossRushSeriesData.MODE.MULTIPLE

	if not var_1_0:IsSingleFight() then
		self.contextData.mode = BossRushSeriesData.MODE.MULTIPLE
	end

	local var_1_2 = self.contextData.fullFleets

	self.contextData.fleets = self.contextData.mode == BossRushSeriesData.MODE.SINGLE and {
		var_1_2[1],
		var_1_2[#var_1_2]
	} or self.contextData.fleets or underscore.rest(var_1_2)
	self.contextData.fleetIndex = self.contextData.fleetIndex or 1

	if self.contextData.fleetIndex > #self.contextData.fleets then
		self.contextData.fleetIndex = 1
	end

	if var_1_0.__cname == "CollabrateBossRushSeriesData" then
		self.contextData.system = SYSTEM_BOSS_RUSH_COLLABRATE
	elseif var_1_0:GetType() ~= BossRushSeriesData.TYPE.EXTRA then
		self.contextData.system = SYSTEM_BOSS_RUSH or SYSTEM_BOSS_RUSH_EX
	end

	self.contextData.actId = var_1_0.actId

	self.viewComponent:setHardShipVOs(getProxy(BayProxy):getRawData())

	return
end

function BossRushFleetSelectMediator:OnSwitchMode(arg_22_1)
	assert(arg_22_1)

	self.contextData.mode = arg_22_1

	if self.contextData.mode == BossRushSeriesData.MODE.SINGLE then
		if arg_22_1 ~= self.contextData.mode then
			self.contextData.fleetIndex = self.contextData.fleetIndex < #self.contextData.fleets and 1 or 2
		end

		self.contextData.fleets = {
			self.contextData.fullFleets[1],
			self.contextData.fullFleets[#self.contextData.fullFleets]
		}
	else
		self.contextData.fleets = underscore.rest(self.contextData.fullFleets)

		if arg_22_1 ~= self.contextData.mode and self.contextData.fleetIndex == 2 then
			self.contextData.fleetIndex = #self.contextData.fleets
		end
	end

	PlayerPrefs.SetInt("series_mode_flag" .. self.contextData.seriesData.id, arg_22_1)

	return
end

function BossRushFleetSelectMediator:openCommanderPanel(arg_23_1, arg_23_2)
	local var_23_0 = self.contextData.actId

	self:addSubLayers(Context.New({
		mediator = BossRushCMDFormationMediator,
		viewComponent = BossRushCMDFormationView,
		data = {
			fleet = arg_23_1,
			callback = function(self)
				if self.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
					self.viewComponent:emit(BossRushFleetSelectMediator.ON_COMMANDER_SKILL, self.skill)
				elseif self.type == LevelUIConst.COMMANDER_OP_ADD then
					self:closeCommanderPanel()
					self.viewComponent:emit(BossRushFleetSelectMediator.ON_SELECT_COMMANDER, arg_23_2, self.pos)
				else
					self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
						data = {
							FleetType = LevelUIConst.FLEET_TYPE_BOSSRUSH,
							data = self,
							fleetId = arg_23_1.id,
							actId = var_23_0,
							fleets = self.contextData.fleets
						}
					})
				end

				return
			end
		}
	}))

	return
end

function BossRushFleetSelectMediator:closeCommanderPanel()
	local var_25_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushCMDFormationMediator)

	if var_25_0 then
		self:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_25_0
		})
	end

	return
end

function BossRushFleetSelectMediator:listNotificationInterests()
	return {
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE,
		BossRushPreCombatMediator.ON_FLEET_REFRESHED
	}
end

function BossRushFleetSelectMediator:handleNotification(arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == nil then
		-- block empty
	elseif var_27_0 == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		self.viewComponent:updateEliteFleets()
	elseif var_27_0 == BossRushPreCombatMediator.ON_FLEET_REFRESHED then
		self.viewComponent:updateEliteFleets()
	end

	return
end

function BossRushFleetSelectMediator:remove()
	return
end

function BossRushFleetSelectMediator:getDockCallbackFuncs(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = getProxy(BayProxy)

	return function(arg_30_0, arg_30_1)
		local var_30_0, var_30_1 = ShipStatus.ShipStatusCheck("inActivity", arg_30_0, arg_30_1, {
			inActivity = arg_29_4
		})

		if not var_30_0 then
			return var_30_0, var_30_1
		end

		if self and self:isSameKind(arg_30_0) then
			return true
		end

		for iter_30_0, iter_30_1 in ipairs(arg_29_3) do
			if arg_30_0:isSameKind(var_29_0:getShipById(iter_30_1)) then
				local var_30_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_31_0, arg_31_1, arg_31_2)
		arg_31_1()

		return
	end, function(arg_32_0)
		if self then
			arg_29_1:removeShip(self)
		end

		if #arg_32_0 > 0 then
			local var_32_0 = var_29_0:getShipById(arg_32_0[1])

			if not arg_29_1:containShip(var_32_0) then
				arg_29_1:insertShip(var_32_0, nil, arg_29_2)
			elseif self then
				arg_29_1:insertShip(self, nil, arg_29_2)
			end

			arg_29_1:RemoveUnusedItems()
		end

		getProxy(FleetProxy):updateActivityFleet(arg_29_4, arg_29_1.id, arg_29_1)

		return
	end
end

return BossRushFleetSelectMediator
