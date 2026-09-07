local ActivityBossMediatorTemplate = class("ActivityBossMediatorTemplate", import("view.base.ContextMediator"))

ActivityBossMediatorTemplate.ON_SUBMIT_TASK = "ActivityBossMediatorTemplate ON_SUBMIT_TASK"
ActivityBossMediatorTemplate.ON_RANK = "ActivityBossMediatorTemplate ON_RANK"
ActivityBossMediatorTemplate.ON_PRECOMBAT = "ActivityBossMediatorTemplate ON_PRECOMBAT"
ActivityBossMediatorTemplate.ON_EX_PRECOMBAT = "ActivityBossMediatorTemplate ON_EX_PRECOMBAT"
ActivityBossMediatorTemplate.ON_SP_PRECOMBAT = "ActivityBossMediatorTemplate ON_SP_PRECOMBAT"
ActivityBossMediatorTemplate.ON_COMMIT_FLEET = "ActivityBossMediatorTemplate ON_COMMIT_FLEET"
ActivityBossMediatorTemplate.ON_FLEET_RECOMMEND = "ActivityBossMediatorTemplate ON_FLEET_RECOMMEND"
ActivityBossMediatorTemplate.ON_FLEET_CLEAR = "ActivityBossMediatorTemplate ON_FLEET_CLEAR"
ActivityBossMediatorTemplate.ON_OPEN_DOCK = "ActivityBossMediatorTemplate ON_OPEN_DOCK"
ActivityBossMediatorTemplate.ON_FLEET_SHIPINFO = "ActivityBossMediatorTemplate ON_FLEET_SHIPINFO"
ActivityBossMediatorTemplate.ON_SELECT_COMMANDER = "ActivityBossMediatorTemplate ON_SELECT_COMMANDER"
ActivityBossMediatorTemplate.ON_PERFORM_COMBAT = "ActivityBossMediatorTemplate ON_PERFORM_COMBAT"
ActivityBossMediatorTemplate.ONEN_BUFF_SELECT = "ActivityBossMediatorTemplate ONEN_BUFF_SELECT"
ActivityBossMediatorTemplate.COMMANDER_FORMATION_OP = "ActivityBossMediatorTemplate COMMANDER_FORMATION_OP"
ActivityBossMediatorTemplate.ON_COMMANDER_SKILL = "ActivityBossMediatorTemplate ON_COMMANDER_SKILL"

local var_0_1 = {
	"word_easy",
	"word_normal_junhe",
	"word_hard"
}

function ActivityBossMediatorTemplate:GetPairedFleetIndex()
	if self < Fleet.SUBMARINE_FLEET_ID then
		return self + 10
	else
		return self - 10
	end

	return
end

function ActivityBossMediatorTemplate:register()
	self.contextData.mediatorClass = self.class
	self.activityProxy = getProxy(ActivityProxy)
	self.timeMgr = pg.TimeMgr.GetInstance()

	local var_2_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if not var_2_0 then
		return
	end

	self:BindEvent()
	self:UpdateActivityData(var_2_0)

	self.contextData.activityID = var_2_0 and var_2_0.id

	local var_2_1 = var_2_0:GetBossConfig()

	self.contextData.TicketID = var_2_1:GetTicketID()
	self.contextData.exStageID = var_2_1:GetEXStageID()
	self.contextData.normalStageIDs = var_2_1:GetNormalStageIDs()
	self.contextData.ticketInitPools = var_2_1:GetInitTicketPools()
	self.contextData.useOilLimit = var_2_1:GetOilLimits()
	self.contextData.DisplayItems = var_2_1:GetMilestoneRewards()
	self.contextData.spStageID = var_2_1:GetSPStageID()

	self:RequestAndUpdateView()

	self.contextData.actFleets = getProxy(FleetProxy):getActivityFleets()[var_2_0.id]

	local var_2_2 = var_2_0:GetBindPtActID()

	self.contextData.ptActId = var_2_2

	local var_2_3 = self.activityProxy:getActivityById(var_2_2)

	if var_2_3 then
		self.contextData.ptData = ActivityBossPtData.New(var_2_3)
	else
		errorMsg("没有找到当期BossPT活动 activity_event_pt link_id 未找到id: " .. var_2_0.id)
	end

	local var_2_4 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RANK)

	if var_2_4 and not var_2_4:isEnd() then
		local var_2_5 = getProxy(BillboardProxy)

		if var_2_5:canFetch(PowerRank.TYPE_ACT_BOSS_BATTLE, var_2_4.id) then
			self:sendNotification(GAME.GET_POWERRANK, {
				type = PowerRank.TYPE_ACT_BOSS_BATTLE,
				activityId = var_2_4.id
			})
		else
			self:UpdateRankData((var_2_5:getRankList(PowerRank.TYPE_ACT_BOSS_BATTLE, var_2_4.id)))
		end
	end

	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle()

	return
end

function ActivityBossMediatorTemplate:BindEvent()
	local var_3_0 = getProxy(FleetProxy)
	local var_3_1 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	assert(var_3_1)
	self:bind(ActivityBossMediatorTemplate.ON_RANK, function(arg_4_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			index = PowerRank.TYPE_ACT_BOSS_BATTLE
		})

		return
	end)
	self:bind(ActivityMediator.EVENT_PT_OPERATION, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_5_1)

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_SUBMIT_TASK, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_6_1)

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_PRECOMBAT, function(arg_7_0, arg_7_1)
		local var_7_0 = var_3_0:getActivityFleets()[var_3_1.id]

		if not var_7_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		var_7_0[arg_7_1]:RemoveUnusedItems()

		if var_7_0[arg_7_1]:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

			return
		end

		var_7_0[arg_7_1 + 10]:RemoveUnusedItems()

		local var_7_1 = {
			var_7_0[arg_7_1],
			var_7_0[arg_7_1 + 10]
		}
		local var_7_2 = var_3_1.id

		if _.any(var_7_1, function(arg_8_0)
			local var_8_0, var_8_1 = arg_8_0:HaveShipsInEvent()

			if var_8_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_8_1)

				return true
			end

			return _.any(arg_8_0:getShipIds(), function(arg_9_0)
				local var_9_0 = getProxy(BayProxy):RawGetShipById(arg_9_0)

				if not var_9_0 then
					return
				end

				local var_9_1, var_9_2 = ShipStatus.ShipStatusCheck("inActivity", var_9_0, nil, {
					inActivity = var_7_2
				})

				if not var_9_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_9_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		local var_7_4 = self.contextData.normalStageIDs[arg_7_1]

		self:addSubLayers(Context.New({
			mediator = ActivityBossPreCombatMediator,
			viewComponent = ActivityBossPreCombatLayer,
			data = {
				system = SYSTEM_ACT_BOSS,
				stageId = self.contextData.normalStageIDs[arg_7_1],
				actId = var_3_1.id,
				fleets = var_7_1,
				costLimit = (not self.contextData.activity:IsOilLimit(self.contextData.normalStageIDs[arg_7_1]) or nil) and {
					0,
					0
				},
				OnConfirm = function(arg_10_0)
					if not self.contextData.activity:checkBattleTimeInBossAct() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

						return
					end

					local var_10_0 = getProxy(SettingsProxy):isTipActBossExchangeTicket()

					if getProxy(PlayerProxy):getRawData():getResource(self.contextData.TicketID) > 0 then
						local var_10_2

						if (self.contextData.stageTickets[var_7_4] or 0) > 0 then
							var_10_2 = false

							goto label_10_0
						end
					end

					var_10_2 = true

					::label_10_0::

					if var_10_0 == nil and var_10_2 then
						local var_10_3 = {
							type = DROP_TYPE_RESOURCE
						}

						var_10_3.id = self.contextData.TicketID or 1

						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							noText = "text_inconsume",
							hideYes = true,
							content = i18n("tip_exchange_ticket", i18n(var_0_1[arg_7_1])),
							custom = {
								{
									text = "text_consume",
									sound = SFX_CONFIRM,
									onCallback = function()
										getProxy(SettingsProxy):setActBossExchangeTicketTip(1)

										self.contextData.ready2battleCb = arg_10_0

										self:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
											stageId = var_7_4
										})

										return
									end,
									btnType = pg.MsgboxMgr.BUTTON_BLUE_WITH_ICON,
									iconName = {
										(Drop.New(var_10_3):getIcon())
									}
								}
							},
							onNo = function()
								getProxy(SettingsProxy):setActBossExchangeTicketTip(0)
								arg_10_0()

								return
							end,
							onClose = function()
								return
							end
						})
					elseif var_10_2 and var_10_0 == 1 then
						self.contextData.ready2battleCb = arg_10_0

						self:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
							stageId = var_7_4
						})
					else
						arg_10_0()
					end

					return
				end
			},
			onRemoved = function()
				self.viewComponent:updateEditPanel()

				return
			end
		}))

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_EX_PRECOMBAT, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = var_3_0:getActivityFleets()[var_3_1.id]

		if not var_15_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		var_15_0[arg_15_1]:RemoveUnusedItems()

		if var_15_0[arg_15_1]:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

			return
		end

		var_15_0[arg_15_1 + 10]:RemoveUnusedItems()

		local var_15_1 = {
			var_15_0[arg_15_1],
			var_15_0[arg_15_1 + 10]
		}
		local var_15_2 = var_3_1.id

		if _.any(var_15_1, function(arg_16_0)
			local var_16_0, var_16_1 = arg_16_0:HaveShipsInEvent()

			if var_16_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_16_1)

				return true
			end

			return _.any(arg_16_0:getShipIds(), function(arg_17_0)
				local var_17_0 = getProxy(BayProxy):RawGetShipById(arg_17_0)

				if not var_17_0 then
					return
				end

				local var_17_1, var_17_2 = ShipStatus.ShipStatusCheck("inActivity", var_17_0, nil, {
					inActivity = var_15_2
				})

				if not var_17_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_17_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		seriesAsync({
			function(arg_18_0)
				local var_18_0 = "NG0017"

				if not arg_15_2 then
					if not pg.NewStoryMgr.GetInstance():IsPlayed("NG0017") then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							hideYes = false,
							showStopRemind = true,
							hideNo = false,
							helps = pg.gametip.worldbossex_help.tip,
							type = MSGBOX_TYPE_HELP,
							stopRamindContent = i18n("dont_remind"),
							onYes = function()
								if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
									pg.m02:sendNotification(GAME.STORY_UPDATE, {
										storyId = var_18_0
									})
								end

								arg_18_0()

								return
							end,
							onNo = function()
								if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
									pg.m02:sendNotification(GAME.STORY_UPDATE, {
										storyId = var_18_0
									})
								end

								return
							end
						})

						goto label_18_0
					end
				end

				arg_18_0()

				::label_18_0::

				return
			end,
			function(arg_21_0)
				self:addSubLayers(Context.New({
					mediator = ActivityBossPreCombatMediator,
					viewComponent = ActivityBossPreCombatLayer,
					data = {
						system = var_21_0,
						stageId = nil,
						actId = var_3_1.id,
						fleets = var_15_1,
						costLimit = (not self.contextData.activity:IsOilLimit(self.contextData.exStageID) or nil) and {
							0,
							0
						},
						OnConfirm = function(arg_22_0)
							if not self.contextData.activity:checkBattleTimeInBossAct() then
								pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

								return
							end

							arg_22_0()

							return
						end
					}
				}))

				return
			end
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_SP_PRECOMBAT, function(arg_23_0, arg_23_1)
		local var_23_0 = var_3_0:getActivityFleets()[var_3_1.id]

		if not var_23_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		var_23_0[arg_23_1]:RemoveUnusedItems()

		if var_23_0[arg_23_1]:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

			return
		end

		var_23_0[arg_23_1 + 10]:RemoveUnusedItems()

		local var_23_1 = {
			var_23_0[arg_23_1],
			var_23_0[arg_23_1 + 10]
		}
		local var_23_2 = var_3_1.id

		if _.any(var_23_1, function(arg_24_0)
			local var_24_0, var_24_1 = arg_24_0:HaveShipsInEvent()

			if var_24_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_24_1)

				return true
			end

			return _.any(arg_24_0:getShipIds(), function(arg_25_0)
				local var_25_0 = getProxy(BayProxy):RawGetShipById(arg_25_0)

				if not var_25_0 then
					return
				end

				local var_25_1, var_25_2 = ShipStatus.ShipStatusCheck("inActivity", var_25_0, nil, {
					inActivity = var_23_2
				})

				if not var_25_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_25_2)

					return true
				end

				return
			end)
		end) then
			return
		end

		seriesAsync({
			function(arg_26_0)
				self:addSubLayers(Context.New({
					mediator = ActivityBossPreCombatMediator,
					viewComponent = ActivityBossPreCombatLayer,
					data = {
						system = SYSTEM_ACT_BOSS_SP,
						stageId = self.contextData.spStageID,
						actId = var_3_1.id,
						fleets = var_23_1,
						costLimit = {
							0,
							0
						},
						OnConfirm = function(arg_27_0)
							if not self.contextData.activity:checkBattleTimeInBossAct() then
								pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

								return
							end

							arg_27_0()

							return
						end
					}
				}))

				return
			end
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_COMMIT_FLEET, function()
		var_3_0:commitActivityFleet(var_3_1.id)

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_FLEET_RECOMMEND, function(arg_29_0, arg_29_1)
		var_3_0:recommendActivityFleet(var_3_1.id, arg_29_1)

		self.contextData.actFleets = var_3_0:getActivityFleets()[var_3_1.id]

		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_FLEET_CLEAR, function(arg_30_0, arg_30_1)
		local var_30_0 = var_3_0:getActivityFleets()[var_3_1.id]

		var_30_0[arg_30_1]:clearFleet()
		var_3_0:updateActivityFleet(var_3_1.id, arg_30_1, var_30_0[arg_30_1])

		self.contextData.actFleets = var_30_0

		self.viewComponent:updateEditPanel()

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_OPEN_DOCK, function(arg_31_0, arg_31_1)
		local var_31_0, var_31_1, var_31_2 = self.getDockCallbackFuncs4ActicityFleet(arg_31_1.shipVO, arg_31_1.fleetIndex, arg_31_1.teamType)
		local var_31_3 = GAME.GO_SCENE
		local var_31_4 = SCENE.DOCKYARD
		local var_31_5 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = arg_31_1.shipVO ~= nil,
			teamFilter = arg_31_1.teamType,
			leftTopInfo = i18n("word_formation"),
			onShip = var_31_0,
			confirmSelect = var_31_1,
			onSelected = var_31_2,
			hideTagFlags = setmetatable({
				inActivity = var_3_1.id
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			otherSelectedIds = arg_31_1.fleet
		}

		var_31_5.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		self:sendNotification(var_31_3, var_31_4, var_31_5)

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_FLEET_SHIPINFO, function(arg_32_0, arg_32_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_32_1.shipId,
			shipVOs = arg_32_1.shipVOs
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.COMMANDER_FORMATION_OP, function(arg_33_0, arg_33_1)
		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_33_1
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_COMMANDER_SKILL, function(arg_34_0, arg_34_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_34_1
			}
		}))

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_SELECT_COMMANDER, function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = var_3_0:getActivityFleets()[var_3_1.id]
		local var_35_1 = var_35_0[arg_35_1]
		local var_35_2 = var_35_0[arg_35_1]:getCommanders()

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_35_2[arg_35_2],
			fleetType = CommanderCatScene.FLEET_TYPE_ACTBOSS,
			ignoredIds = {},
			onCommander = function(arg_36_0)
				return true
			end,
			onSelected = function(self, arg_37_1)
				local var_37_0 = getProxy(CommanderProxy):getCommanderById(self[1])

				for iter_37_0, iter_37_1 in pairs(var_35_0) do
					if iter_37_0 == arg_35_1 then
						for iter_37_2, iter_37_3 in pairs(var_35_2) do
							if iter_37_3.groupId == var_37_0.groupId and iter_37_2 ~= arg_35_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					elseif iter_37_0 == ActivityBossMediatorTemplate.GetPairedFleetIndex(arg_35_1) then
						for iter_37_4, iter_37_5 in pairs((iter_37_1:getCommanders())) do
							if self[1] == iter_37_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_35_1:updateCommanderByPos(arg_35_2, var_37_0)
				var_3_0:updateActivityFleet(var_3_1.id, arg_35_1, var_35_1)
				arg_37_1()

				return
			end,
			onQuit = function(arg_38_0)
				var_35_1:updateCommanderByPos(arg_35_2, nil)
				var_3_0:updateActivityFleet(var_3_1.id, arg_35_1, var_35_1)
				arg_38_0()

				return
			end
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ON_PERFORM_COMBAT, function(arg_39_0, arg_39_1, arg_39_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			memory = true,
			mainFleetId = 1,
			system = SYSTEM_PERFORM,
			stageId = arg_39_1,
			exitCallback = arg_39_2
		})

		return
	end)
	self:bind(PreCombatMediator.BEGIN_STAGE_PROXY, function(arg_40_0, arg_40_1)
		self:sendNotification(PreCombatMediator.BEGIN_STAGE_PROXY, {
			curFleetId = arg_40_1
		})

		return
	end)
	self:bind(ActivityBossMediatorTemplate.ONEN_BUFF_SELECT, function(arg_41_0)
		local var_41_0 = ActivityBossBuffSelectLayer

		;(function(arg_42_0)
			if not arg_42_0 or arg_42_0:isEnd() then
				return
			end

			local var_42_0 = arg_42_0:getConfig("config_client").buff_scene

			if not var_42_0 then
				return
			end

			var_41_0 = _G[var_42_0]

			return
		end)(self.contextData.activity)

		local var_41_1 = {
			mediator = ActivityBossBuffSelectMediator,
			viewComponent = ActivityBossBuffSelectLayer
		}
		local var_41_2 = {}

		var_41_2.spEnemyInfo = self.contextData.activity:GetBossConfig():GetSPEnemy()
		var_41_2.score = self.contextData.activity:GetHighestScore()
		var_41_1.data = var_41_2

		self:addSubLayers(Context.New(var_41_1))

		return
	end)

	return
end

function ActivityBossMediatorTemplate:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_DONE,
		GAME.ACT_NEW_PT_DONE,
		GAME.ACT_BOSS_EXCHANGE_TICKET_DONE,
		GAME.GET_POWERRANK_DONE,
		ActivityBossBuffSelectMediator.ON_START,
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE
	}
end

function ActivityBossMediatorTemplate:handleNotification(arg_44_1)
	local var_44_0 = arg_44_1:getName()
	local var_44_1 = arg_44_1:getBody()

	if var_44_0 == ActivityProxy.ACTIVITY_ADDED or var_44_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_44_1.id == self.contextData.ptActId then
			if self.contextData.ptData then
				self.contextData.ptData:Update(var_44_1)
			else
				self.contextData.ptData = ActivityBossPtData.New(var_44_1)
			end

			self:UpdateView()
		elseif var_44_1.id == self.contextData.activityID then
			self:UpdateActivityData(var_44_1)
			self:UpdateView()
		end
	elseif var_44_0 == PlayerProxy.UPDATED then
		self:RequestAndUpdateView()
	elseif var_44_0 == GAME.BEGIN_STAGE_DONE then
		self.contextData.editFleet = nil

		if not getProxy(ContextProxy):getContextByMediator(PreCombatMediator) then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_44_1)
		end
	elseif var_44_0 == GAME.ACT_BOSS_EXCHANGE_TICKET_DONE then
		if self.contextData.ready2battleCb then
			self.contextData.ready2battleCb()

			self.contextData.ready2battleCb = nil
		end
	elseif var_44_0 == GAME.GET_POWERRANK_DONE then
		if var_44_1.type == PowerRank.TYPE_ACT_BOSS_BATTLE then
			self:UpdateRankData(var_44_1.list)
		end
	elseif var_44_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_44_1.awards)
	elseif var_44_0 == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		local var_44_2 = getProxy(FleetProxy):getActivityFleets()[var_44_1.actId]

		self.contextData.actFleets = var_44_2

		self.viewComponent:updateEditPanel()
		self.viewComponent:updateCommanderFleet(var_44_2[var_44_1.fleetId])
	elseif var_44_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
		self.viewComponent:updateCommanderPrefab()
	elseif var_44_0 == ActivityBossBuffSelectMediator.ON_START then
		self.viewComponent:ShowSPFleet()
	end

	return
end

function ActivityBossMediatorTemplate:RequestAndUpdateView()
	self:sendNotification(GAME.ACTIVITY_BOSS_PAGE_UPDATE, {
		activity_id = self.contextData.activityID
	})

	return
end

function ActivityBossMediatorTemplate:UpdateView()
	self.viewComponent:UpdateView()

	return
end

function ActivityBossMediatorTemplate:UpdateRankData(arg_47_1)
	self.viewComponent:UpdateRank(arg_47_1)

	return
end

function ActivityBossMediatorTemplate:UpdateActivityData(arg_48_1)
	self.contextData.activity = arg_48_1
	self.contextData.bossHP = arg_48_1:GetBossHP()
	self.contextData.mileStones = arg_48_1:GetMileStones()
	self.contextData.stageTickets = arg_48_1:GetTickets()

	return
end

function ActivityBossMediatorTemplate:getDockCallbackFuncs4ActicityFleet(arg_49_1, arg_49_2)
	local var_49_0 = getProxy(BayProxy)
	local var_49_1 = getProxy(FleetProxy)
	local var_49_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
	local var_49_3 = var_49_1:getActivityFleets()[var_49_2.id][arg_49_1]

	return function(arg_50_0, arg_50_1)
		local var_50_0, var_50_1 = ShipStatus.ShipStatusCheck("inActivity", arg_50_0, arg_50_1, {
			inActivity = var_49_2.id
		})

		if not var_50_0 then
			return var_50_0, var_50_1
		end

		if self and self:isSameKind(arg_50_0) then
			return true
		end

		for iter_50_0, iter_50_1 in ipairs(var_49_3.ships) do
			if arg_50_0:isSameKind(var_49_0:getShipById(iter_50_1)) then
				local var_50_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_51_0, arg_51_1, arg_51_2)
		arg_51_1()

		return
	end, function(arg_52_0)
		if self then
			var_49_3:removeShip(self)
		end

		if #arg_52_0 > 0 then
			local var_52_0 = var_49_0:getShipById(arg_52_0[1])

			if not var_49_3:containShip(var_52_0) then
				var_49_3:insertShip(var_52_0, nil, arg_49_2)
			elseif self then
				var_49_3:insertShip(self, nil, arg_49_2)
			end

			var_49_3:RemoveUnusedItems()
		end

		var_49_1:updateActivityFleet(var_49_2.id, arg_49_1, var_49_3)

		return
	end
end

return ActivityBossMediatorTemplate
