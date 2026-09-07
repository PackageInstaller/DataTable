local BattleResultMediator = class("BattleResultMediator", import("..base.ContextMediator"))

BattleResultMediator.ON_BACK_TO_LEVEL_SCENE = "BattleResultMediator.ON_BACK_TO_LEVEL_SCENE"
BattleResultMediator.ON_BACK_TO_DUEL_SCENE = "BattleResultMediator.ON_BACK_TO_DUEL_SCENE"
BattleResultMediator.ON_GO_TO_TASK_SCENE = "BattleResultMediator.ON_GO_TO_TASK_SCENE"
BattleResultMediator.GET_NEW_SHIP = "BattleResultMediator.GET_NEW_SHIP"
BattleResultMediator.ON_GO_TO_MAIN_SCENE = "BattleResultMediator.ON_GO_TO_MAIN_SCENE"
BattleResultMediator.ON_NEXT_CHALLENGE = "BattleResultMediator.ON_NEXT_CHALLENGE"
BattleResultMediator.ON_CHALLENGE_RANK = "BattleResultMediator:ON_CHALLENGE_RANK"
BattleResultMediator.ON_CHALLENGE_SHARE = "BattleResultMediator:ON_CHALLENGE_SHARE"
BattleResultMediator.ON_CHALLENGE_DEFEAT_SCENE = "BattleResultMediator:ON_CHALLENGE_DEFEAT_SCENE"
BattleResultMediator.DIRECT_EXIT = "BattleResultMediator:DIRECT_EXIT"
BattleResultMediator.REENTER_STAGE = "BattleResultMediator:REENTER_STAGE"
BattleResultMediator.OPEN_FAIL_TIP_LAYER = "BattleResultMediator:OPEN_FAIL_TIP_LAYER"
BattleResultMediator.PRE_BATTLE_FAIL_EXIT = "BattleResultMediator:PRE_BATTLE_FAIL_EXIT"
BattleResultMediator.ON_ENTER_BATTLE_RESULT = "BattleResultMediator:ON_ENTER_BATTLE_RESULT"
BattleResultMediator.SET_SKIP_FLAG = "BattleResultMediator:SET_SKIP_FLAG"
BattleResultMediator.ON_COMPLETE_BATTLE_RESULT = "BattleResultMediator:ON_COMPLETE_BATTLE_RESULT"

function BattleResultMediator:register()
	local var_1_0 = getProxy(PlayerProxy):getData()
	local var_1_1 = getProxy(FleetProxy)
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = getProxy(ChapterProxy)
	local var_1_4 = self.contextData.system

	if self.contextData.system == SYSTEM_DUEL then
		local var_1_5 = getProxy(MilitaryExerciseProxy)
		local var_1_6 = var_1_5:getPreRivalById(self.contextData.rivalId)

		assert(var_1_6, "should exist rival--" .. self.contextData.rivalId)
		self.viewComponent:setRivalVO(var_1_6)
		self.viewComponent:setRank(var_1_0, var_1_5:getSeasonInfo())
	elseif var_1_4 == SYSTEM_CHALLENGE then
		local var_1_7 = getProxy(ChallengeProxy)

		self.viewComponent:setChallengeInfo(var_1_7:getUserChallengeInfo(self.contextData.mode), var_1_7:userSeaonExpire(self.contextData.mode))
	else
		if var_1_4 ~= SYSTEM_SCENARIO and var_1_4 ~= SYSTEM_ROUTINE and var_1_4 ~= SYSTEM_ACT_BOSS and var_1_4 ~= SYSTEM_BOSS_SINGLE and var_1_4 ~= SYSTEM_BOSS_SINGLE_VARIABLE and var_1_4 ~= SYSTEM_HP_SHARE_ACT_BOSS and var_1_4 ~= SYSTEM_SUB_ROUTINE then
			if var_1_4 == SYSTEM_WORLD then
				self.viewComponent:setExpBuff(_.detect(BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF), function(arg_2_0)
					return arg_2_0:getConfig("benefit_type") == "rookie_battle_exp"
				end), (getProxy(ActivityProxy):getBuffShipList()))
			end
		end

		self.viewComponent:setPlayer(var_1_0)
	end

	local var_1_8

	if var_1_4 == SYSTEM_SCENARIO then
		var_1_8 = {}

		local var_1_9

		if var_1_4 == SYSTEM_SCENARIO then
			var_1_9 = var_1_3:getActiveChapter()
		end

		local var_1_10 = var_1_9.fleet[TeamType.Vanguard]

		for iter_1_0, iter_1_1 in ipairs(var_1_9.fleet[TeamType.Main]) do
			table.insert(var_1_8, iter_1_1)
		end

		for iter_1_2, iter_1_3 in ipairs(var_1_10) do
			table.insert(var_1_8, iter_1_3)
		end

		local var_1_11 = _.detect(var_1_9.fleets, function(arg_3_0)
			return arg_3_0:getFleetType() == FleetType.Submarine
		end)

		if var_1_11 then
			for iter_1_4, iter_1_5 in ipairs((var_1_11:getShipsByTeam(TeamType.Submarine, true))) do
				table.insert(var_1_8, iter_1_5)
			end
		end

		self.viewComponent:SetSkipFlag(var_1_3:GetChapterAutoFlag(var_1_9.id) == 1)
	elseif var_1_4 == SYSTEM_WORLD then
		var_1_8 = {}

		local var_1_12 = nowWorld()
		local var_1_13 = var_1_12:GetActiveMap()
		local var_1_14 = var_1_13:GetFleet()

		for iter_1_6, iter_1_7 in ipairs((var_1_14:GetTeamShipVOs(TeamType.Main, true))) do
			table.insert(var_1_8, iter_1_7)
		end

		for iter_1_8, iter_1_9 in ipairs((var_1_14:GetTeamShipVOs(TeamType.Vanguard, true))) do
			table.insert(var_1_8, iter_1_9)
		end

		local var_1_15 = var_1_13:GetSubmarineFleet()

		if var_1_15 then
			for iter_1_10, iter_1_11 in ipairs((var_1_15:GetTeamShipVOs(TeamType.Submarine, true))) do
				table.insert(var_1_8, iter_1_11)
			end
		end

		self.viewComponent:SetSkipFlag(var_1_12.isAutoFight)
	elseif var_1_4 == SYSTEM_CHALLENGE then
		self:bind(BattleResultMediator.ON_CHALLENGE_SHARE, function(arg_4_0)
			self:addSubLayers(Context.New({
				mediator = ChallengeShareMediator,
				viewComponent = ChallengeShareLayer,
				data = {
					mode = self.contextData.mode
				}
			}))

			return
		end)
		self:bind(BattleResultMediator.ON_CHALLENGE_DEFEAT_SCENE, function(arg_5_0, arg_5_1)
			self:addSubLayers(Context.New({
				mediator = ChallengePassedMediator,
				viewComponent = ChallengePassedLayer,
				data = {
					mode = self.contextData.mode
				},
				onRemoved = arg_5_1.callback
			}))

			return
		end)
	elseif var_1_4 == SYSTEM_WORLD_BOSS then
		var_1_8 = getProxy(BayProxy):getShipsByFleet((nowWorld():GetBossProxy():GetFleet(self.contextData.bossId)))

		self.viewComponent:setTitle(self.contextData.name)
	elseif var_1_4 == SYSTEM_DODGEM then
		-- block empty
	elseif var_1_4 == SYSTEM_SUBMARINE_RUN then
		-- block empty
	elseif var_1_4 == SYSTEM_REWARD_PERFORM then
		-- block empty
	elseif var_1_4 == SYSTEM_AIRFIGHT then
		-- block empty
	elseif var_1_4 == SYSTEM_CARDPUZZLE then
		-- block empty
	elseif var_1_4 == SYSTEM_HP_SHARE_ACT_BOSS or var_1_4 == SYSTEM_ACT_BOSS or var_1_4 == SYSTEM_BOSS_SINGLE or var_1_4 == SYSTEM_BOSS_SINGLE_VARIABLE or var_1_4 == SYSTEM_BOSS_EXPERIMENT then
		local var_1_16 = self.contextData.actId

		if var_1_4 == SYSTEM_HP_SHARE_ACT_BOSS then
			self.viewComponent:setActId(var_1_16)
		end

		local var_1_17 = var_1_1:getActivityFleets()[var_1_16]

		var_1_8 = var_1_2:getShipsByFleet(var_1_17[self.contextData.mainFleetId])

		for iter_1_12, iter_1_13 in ipairs((var_1_2:getShipsByFleet(var_1_17[self.contextData.mainFleetId + 10]))) do
			table.insert(var_1_8, iter_1_13)
		end
	elseif var_1_4 == SYSTEM_GUILD then
		var_1_8 = {}

		local var_1_18 = getProxy(GuildProxy)
		local var_1_19 = var_1_18:getData():GetActiveEvent():GetBossMission()

		for iter_1_14, iter_1_15 in ipairs(var_1_19.GetMainFleet(var_1_18):GetShips()) do
			table.insert(var_1_8, iter_1_15.ship)
		end

		for iter_1_16, iter_1_17 in ipairs(var_1_19:GetSubFleet():GetShips()) do
			table.insert(var_1_8, iter_1_17.ship)
		end
	elseif var_1_4 == SYSTEM_BOSS_RUSH or var_1_4 == SYSTEM_BOSS_RUSH_EX or var_1_4 == SYSTEM_BOSS_RUSH_COLLABRATE then
		local var_1_20 = self.contextData.actId
		local var_1_21 = getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetSeriesData()

		assert(var_1_21)

		var_1_8 = var_1_2:getShipsByFleet(var_1_1:getActivityFleets()[var_1_20][var_1_21:GetStageFleets(var_1_21:GetMode(), (var_1_21:GetStaegLevel()))])
	else
		var_1_8 = var_1_2:getShipsByFleet((var_1_1:getFleetById(self.contextData.mainFleetId)))
	end

	self.viewComponent:setShips(var_1_8)
	self:bind(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, function(arg_6_0, arg_6_1)
		local var_6_0 = getProxy(ContextProxy)

		if var_1_4 == SYSTEM_DUEL then
			self.viewComponent:emit(BattleResultMediator.ON_BACK_TO_DUEL_SCENE)

			return
		elseif var_1_4 == SYSTEM_ACT_BOSS then
			local var_6_1, var_6_2 = var_6_0:getContextByMediator(PreCombatMediator)

			if var_6_1 then
				var_6_2:removeChild(var_6_1)
			end

			if var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
				self:sendNotification(ContinuousOperationMediator.CONTINUE_OPERATION)
				existCall(self.viewComponent.HideConfirmPanel, self.viewComponent)

				local var_6_3 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
				local var_6_4 = var_6_3:IsOilLimit(self.contextData.stageId)
				local var_6_5 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]
				local var_6_6 = 0
				local var_6_7 = pg.activity_event_worldboss[var_6_3:getConfig("config_id")].use_oil_limit[self.contextData.mainFleetId]

				local function var_6_8(arg_7_0, arg_7_1)
					local var_7_0 = arg_7_0:GetCostSum().oil

					if arg_7_1 > 0 then
						var_7_0 = math.min(var_7_0, arg_7_1)
					end

					var_6_6 = var_6_6 + var_7_0

					return
				end

				var_6_8(var_6_5[self.contextData.mainFleetId], (var_6_4 or nil) and (var_6_7[1] or 0))
				var_6_8(var_6_5[self.contextData.mainFleetId + 10], (var_6_4 or nil) and (var_6_7[2] or 0))

				if var_6_6 > getProxy(PlayerProxy):getRawData().oil then
					self:DisplayTotalReward((i18n("multiple_sorties_stop_reason1")))

					return
				end

				if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
					self:DisplayTotalReward((i18n("multiple_sorties_stop_reason3")))

					return
				end

				local var_6_9 = _.map(_.values(var_6_5[self.contextData.mainFleetId].ships), function(arg_8_0)
					local var_8_0 = getProxy(BayProxy):getShipById(arg_8_0)

					if var_8_0 and var_8_0.energy == Ship.ENERGY_LOW then
						return var_8_0
					end

					return
				end)

				if #var_6_9 > 0 then
					self:DisplayTotalReward((i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[self.contextData.mainFleetId], table.concat(_.map(var_6_9, function(arg_9_0)
						return "「" .. arg_9_0:getConfig("name") .. "」"
					end), ""))))

					return
				end

				if self.contextData.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
					self:DisplayTotalReward((i18n("multiple_sorties_stop_reason4")))

					return
				end

				local var_6_10 = pg.GuildMsgBoxMgr.GetInstance()

				if var_6_10:GetShouldShowBattleTip() then
					local var_6_11 = getProxy(GuildProxy):getRawData()
					local var_6_12 = var_6_11 and var_6_11:getWeeklyTask()

					if var_6_12 and var_6_12.id ~= 0 then
						var_6_10:SubmitTask(function(arg_10_0, arg_10_1)
							if arg_10_1 then
								var_6_10:CancelShouldShowBattleTip()
							end

							return
						end)
					end
				end

				local var_6_13 = var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator)

				if var_6_13 and not var_6_13.data.autoFlag then
					self:DisplayTotalReward()

					return
				end

				if self.contextData.continuousBattleTimes < 1 then
					self:DisplayTotalReward()

					return
				end

				self:sendNotification(BattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

				return
			end
		elseif var_1_4 == SYSTEM_ROUTINE or var_1_4 == SYSTEM_SUB_ROUTINE then
			local var_6_14 = var_6_0:getContextByMediator(DailyLevelMediator)

			if var_6_14 then
				var_6_14:removeChild((var_6_14:getContextByMediator(PreCombatMediator)))
			end
		elseif var_1_4 == SYSTEM_SCENARIO then
			local var_6_15 = var_6_0:getContextByMediator(LevelMediator2)
			local var_6_16 = var_6_15:getContextByMediator(ChapterPreCombatMediator)

			if var_6_16 then
				var_6_15:removeChild(var_6_16)
			end

			if self.contextData.score > 1 then
				self:showExtraChapterActSocre()
			end

			local var_6_17 = getProxy(ChapterProxy)
			local var_6_18 = var_6_17:getActiveChapter()

			if var_6_18 then
				if var_6_18:existOni() then
					var_6_18:clearSubmarineFleet()
					var_6_17:updateChapter(var_6_18)
				elseif var_6_18:isPlayingWithBombEnemy() then
					var_6_18.fleets = {
						var_6_18.fleet
					}
					var_6_18.findex = 1

					var_6_17:updateChapter(var_6_18)
				end
			end
		elseif var_1_4 == SYSTEM_CHALLENGE then
			local var_6_19 = getProxy(ChallengeProxy)
			local var_6_20 = var_6_19:getUserChallengeInfo(self.contextData.mode)

			if self.contextData.score < ys.Battle.BattleConst.BattleScore.S then
				self:sendNotification(GAME.CHALLENGE2_RESET, {
					mode = self.contextData.mode
				})
			else
				local var_6_21 = var_6_20:IsFinish()

				var_6_20:updateLevelForward()

				if var_6_20:getMode() == ChallengeProxy.MODE_INFINITE and var_6_21 then
					var_6_20:setInfiniteDungeonIDListByLevel()
				end
			end

			if not var_6_19:userSeaonExpire(var_6_20:getMode()) then
				var_6_19:getChallengeInfo():checkRecord(var_6_20)
			end

			if not arg_6_1.goToNext then
				local var_6_22 = var_6_0:getContextByMediator(ChallengeMainMediator)

				if var_6_22 then
					var_6_22:removeChild((var_6_22:getContextByMediator(ChallengePreCombatMediator)))
				end
			end
		elseif var_1_4 == SYSTEM_HP_SHARE_ACT_BOSS then
			local var_6_23, var_6_24 = var_6_0:getContextByMediator(PreCombatMediator)

			if var_6_23 then
				var_6_24:removeChild(var_6_23)
			end
		elseif var_1_4 == SYSTEM_WORLD_BOSS then
			local var_6_25 = var_6_0:getContextByMediator(WorldBossMediator)
			local var_6_26 = var_6_25:getContextByMediator(WorldBossFormationMediator)

			if var_6_26 then
				var_6_25:removeChild(var_6_26)
			end
		elseif var_1_4 == SYSTEM_WORLD then
			local var_6_27 = var_6_0:getContextByMediator(WorldMediator)
			local var_6_28 = var_6_27:getContextByMediator(WorldPreCombatMediator) or var_6_27:getContextByMediator(WorldBossInformationMediator)

			if var_6_28 then
				var_6_27:removeChild(var_6_28)
			end
		elseif var_1_4 == SYSTEM_BOSS_RUSH or var_1_4 == SYSTEM_BOSS_RUSH_EX or var_1_4 == SYSTEM_BOSS_RUSH_COLLABRATE then
			local var_6_29 = self.contextData.score > ys.Battle.BattleConst.BattleScore.C
			local var_6_30 = self.contextData.actId
			local var_6_31 = getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetSeriesData()

			assert(var_6_31)

			local var_6_32 = var_6_31:GetStaegLevel() + 1
			local var_6_33 = var_6_31:GetExpeditionIds()
			local var_6_34 = var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator)
			local var_6_35 = not var_6_34 or var_6_34.data.autoFlag

			self.contextData.isAutoFight = not var_6_34 or var_6_34.data.autoFlag

			if var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
				local var_6_36 = pg.GuildMsgBoxMgr.GetInstance()

				if var_6_36:GetShouldShowBattleTip() then
					local var_6_37 = getProxy(GuildProxy):getRawData()
					local var_6_38 = var_6_37 and var_6_37:getWeeklyTask()

					if var_6_38 and var_6_38.id ~= 0 then
						var_6_36:SubmitTask(function(arg_11_0, arg_11_1)
							if arg_11_1 then
								var_6_36:CancelShouldShowBattleTip()
							end

							return
						end)
					end
				end
			end

			if not var_6_29 or var_6_32 > #var_6_33 or not var_6_35 then
				local var_6_39 = var_6_0:GetPrevContext(1)
				local var_6_40 = var_6_39:getContextByMediator(BossRushPreCombatMediator)

				if var_6_40 then
					var_6_39:removeChild(var_6_40)
				end

				local var_6_41 = var_6_39:getContextByMediator(BossRushFleetSelectMediator)

				if var_6_41 then
					var_6_39:removeChild(var_6_41)
				end

				self:sendNotification(GAME.BOSSRUSH_SETTLE, {
					actId = self.contextData.actId
				})
			else
				seriesAsync({
					function(arg_12_0)
						self:addSubLayers(Context.New({
							mediator = ChallengePassedMediator,
							viewComponent = BossRushPassedLayer,
							data = {
								curIndex = var_6_32 - 1,
								maxIndex = #var_6_33
							},
							onRemoved = arg_12_0
						}))

						return
					end,
					function(arg_13_0)
						self:sendNotification(GAME.BEGIN_STAGE, {
							system = self.contextData.system,
							actId = var_6_30,
							continuousBattleTimes = self.contextData.continuousBattleTimes,
							totalBattleTimes = self.contextData.totalBattleTimes
						})

						return
					end
				})
			end

			return
		elseif var_1_4 == SYSTEM_CARDPUZZLE then
			-- block empty
		elseif var_1_4 == SYSTEM_BOSS_SINGLE or var_1_4 == SYSTEM_BOSS_SINGLE_VARIABLE then
			local var_6_42, var_6_43 = var_6_0:getContextByMediator(PreCombatMediator)

			if var_6_42 then
				var_6_43:removeChild(var_6_42)
			end

			if var_6_0:getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				self:sendNotification(BossSingleContinuousOperationMediator.CONTINUE_OPERATION)
				existCall(self.viewComponent.HideConfirmPanel, self.viewComponent)

				local var_6_44 = getProxy(ActivityProxy)
				local var_6_45 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]
				local var_6_46 = 0
				local var_6_47 = var_6_44:getActivityById(self.contextData.actId):GetOilLimits()[self.contextData.mainFleetId]

				local function var_6_48(arg_14_0, arg_14_1)
					local var_14_0 = arg_14_0:GetCostSum().oil

					if arg_14_1 > 0 then
						var_14_0 = math.min(var_14_0, arg_14_1)
					end

					var_6_46 = var_6_46 + var_14_0

					return
				end

				var_6_48(var_6_44[self.contextData.mainFleetId], var_6_47[1] or 0)
				var_6_48(var_6_45[self.contextData.mainFleetId + 10], var_6_47[2] or 0)

				if 0 > getProxy(PlayerProxy):getRawData().oil then
					self:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason1")))

					return
				end

				if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
					self:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason3")))

					return
				end

				local var_6_49 = _.map(_.values(var_6_45[self.contextData.mainFleetId].ships), function(arg_15_0)
					local var_15_0 = getProxy(BayProxy):getShipById(arg_15_0)

					if var_15_0 and var_15_0.energy == Ship.ENERGY_LOW then
						return var_15_0
					end

					return
				end)

				if #var_6_49 > 0 then
					self:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[self.contextData.mainFleetId], table.concat(_.map(var_6_49, function(arg_16_0)
						return "「" .. arg_16_0:getConfig("name") .. "」"
					end), ""))))

					return
				end

				if self.contextData.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
					self:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason4")))

					return
				end

				local var_6_50 = pg.GuildMsgBoxMgr.GetInstance()

				if var_6_50:GetShouldShowBattleTip() then
					local var_6_51 = getProxy(GuildProxy):getRawData()
					local var_6_52 = var_6_51 and var_6_51:getWeeklyTask()

					if var_6_52 and var_6_52.id ~= 0 then
						var_6_50:SubmitTask(function(arg_17_0, arg_17_1)
							if arg_17_1 then
								var_6_50:CancelShouldShowBattleTip()
							end

							return
						end)
					end
				end

				local var_6_53 = var_6_0:getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)

				if var_6_53 and not var_6_53.data.autoFlag then
					self:DisplayBossSingleTotalReward()

					return
				end

				if self.contextData.continuousBattleTimes < 1 then
					self:DisplayBossSingleTotalReward()

					return
				end

				self:sendNotification(BattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

				return
			end
		else
			local var_6_54 = var_6_0:getContextByMediator(LevelMediator2)

			if var_6_54 then
				var_6_54:removeChild((var_6_54:getContextByMediator(PreCombatMediator)))
			end
		end

		self:sendNotification(GAME.GO_BACK)

		return
	end)
	self:bind(BattleResultMediator.ON_GO_TO_MAIN_SCENE, function(arg_18_0)
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.MAINUI)

		return
	end)
	self:bind(BattleResultMediator.ON_GO_TO_TASK_SCENE, function(arg_19_0)
		local var_19_0 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

		if var_19_0 then
			var_19_0:removeChild((var_19_0:getContextByMediator(PreCombatMediator)))
		end

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.TASK)

		return
	end)
	self:bind(BattleResultMediator.ON_BACK_TO_DUEL_SCENE, function(arg_20_0)
		local var_20_0 = getProxy(ContextProxy):getContextByMediator(MilitaryExerciseMediator)

		if var_20_0 then
			var_20_0:removeChild((var_20_0:getContextByMediator(ExercisePreCombatMediator)))
		end

		self:sendNotification(GAME.GO_BACK)

		return
	end)
	self:bind(BattleResultMediator.GET_NEW_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		self:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_21_1,
				autoExitTime = arg_21_3
			},
			onRemoved = arg_21_2
		}))

		return
	end)
	self:bind(BattleResultMediator.OPEN_FAIL_TIP_LAYER, function(arg_22_0)
		setActive(self.viewComponent._tf, false)
		self:addSubLayers(Context.New({
			mediator = BattleFailTipMediator,
			viewComponent = BattleFailTipLayer,
			data = {
				mainShips = var_1_8,
				battleSystem = self.contextData.system
			},
			onRemoved = function()
				self.viewComponent:emit(BattleResultMediator.ON_BACK_TO_DUEL_SCENE)

				return
			end
		}))

		return
	end)
	self:bind(BattleResultMediator.DIRECT_EXIT, function(arg_24_0, arg_24_1)
		self:sendNotification(GAME.GO_BACK)

		return
	end)
	self:bind(BattleResultMediator.REENTER_STAGE, function(arg_25_0)
		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = self.contextData.stageId,
			mainFleetId = self.contextData.mainFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			rivalId = self.contextData.rivalId,
			variableBuffList = self.contextData.variableBuffList,
			continuousBattleTimes = self.contextData.continuousBattleTimes,
			totalBattleTimes = self.contextData.totalBattleTimes,
			useVariableTicket = self.contextData.useVariableTicket
		})

		return
	end)
	self:bind(BattleResultMediator.PRE_BATTLE_FAIL_EXIT, function(arg_26_0)
		if var_1_4 == SYSTEM_SCENARIO then
			getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
		end

		return
	end)
	self:bind(GAME.ACT_BOSS_EXCHANGE_TICKET, function(arg_27_0, arg_27_1)
		self:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
			stageId = arg_27_1
		})

		return
	end)

	local var_1_22 = 0

	if var_1_8 then
		for iter_1_18, iter_1_19 in ipairs(var_1_8) do
			var_1_22 = iter_1_19:getBattleTotalExpend() + var_1_22
		end
	end

	originalPrint("耗时：", self.contextData.statistics._totalTime, "秒")
	originalPrint("编队基础油耗：", var_1_22)

	if self.contextData.statistics._enemyInfoList then
		for iter_1_20, iter_1_21 in pairs(self.contextData.statistics._enemyInfoList) do
			originalPrint("目标ID>>", iter_1_21.id, "<< 受到伤害共 >>", iter_1_21.damage, "<< 点")
		end
	end

	local var_1_23 = false

	if var_1_4 == SYSTEM_SCENARIO then
		var_1_23 = getProxy(ChapterProxy):GetChapterAutoFlag(var_1_3:getActiveChapter().id) == 1
	elseif var_1_4 == SYSTEM_WORLD then
		var_1_23 = nowWorld().isAutoFight
	end

	if ys.Battle.BattleState.IsAutoBotActive() and PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0 and not var_1_23 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
		LuaHelper.Vibrate()
	end

	self:sendNotification(BattleResultMediator.ON_ENTER_BATTLE_RESULT)

	return
end

function BattleResultMediator:showExtraChapterActSocre()
	local var_28_9000
	local var_28_0 = getProxy(ActivityProxy)
	local var_28_1 = getProxy(ChapterProxy)
	local var_28_2 = var_28_1:getActiveChapter()
	local var_28_3 = var_28_2 and var_28_1:getMapById(var_28_2:getConfig("map"))

	for iter_28_0, iter_28_1 in ipairs((var_28_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK))) do
		if iter_28_1 and not iter_28_1:isEnd() then
			if iter_28_1:getConfig("config_data")[1] == self.contextData.stageId and var_28_3 and var_28_3:isActExtra() then
				local var_28_4 = self.contextData.prefabFleet

				if not self.contextData.prefabFleet then
					var_28_4 = self.contextData.oldMainShips

					local var_28_5 = math.floor(self.contextData.statistics._totalTime)
				end

				local var_28_6, var_28_7 = ActivityLevelConst.getExtraChapterSocre(self.contextData.stageId, var_28_9000, ActivityLevelConst.getShipsPower(var_28_4), iter_28_1)
				local var_28_8 = var_28_7 < var_28_6 and i18n("extra_chapter_record_updated") or i18n("extra_chapter_record_not_updated")

				if var_28_7 < var_28_6 then
					iter_28_1.data1 = var_28_6

					var_28_0:updateActivity(iter_28_1)

					var_28_7 = var_28_6
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("extra_chapter_socre_tip", var_28_6, var_28_7, var_28_8)
				})
			end
		end
	end

	return
end

function BattleResultMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.ACT_BOSS_EXCHANGE_TICKET_DONE,
		ContinuousOperationMediator.CONTINUE_OPERATION,
		BattleResultMediator.SET_SKIP_FLAG,
		GAME.BOSSRUSH_SETTLE_DONE,
		ContinuousOperationMediator.ON_REENTER,
		BossSingleContinuousOperationMediator.CONTINUE_OPERATION,
		BossSingleContinuousOperationMediator.ON_REENTER
	}
end

function BattleResultMediator:handleNotification(arg_30_1)
	local var_30_0 = arg_30_1:getName()
	local var_30_1 = arg_30_1:getBody()

	if var_30_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_30_1)
	elseif var_30_0 == GAME.ACT_BOSS_EXCHANGE_TICKET_DONE then
		existCall(self.viewComponent.OnActBossExchangeTicket, self.viewComponent)
	elseif var_30_0 == BattleResultMediator.SET_SKIP_FLAG then
		self.viewComponent:SetSkipFlag(var_30_1)
	elseif var_30_0 == ContinuousOperationMediator.CONTINUE_OPERATION then
		self.contextData.continuousBattleTimes = self.contextData.continuousBattleTimes - 1
	elseif var_30_0 == GAME.BOSSRUSH_SETTLE_DONE then
		local var_30_2 = self.contextData.system
		local var_30_3 = self.contextData.actId
		local var_30_4 = var_30_1.seriesData
		local var_30_5 = self.contextData.score > ys.Battle.BattleConst.BattleScore.C

		if self.contextData.score <= ys.Battle.BattleConst.BattleScore.C and var_30_2 == SYSTEM_BOSS_RUSH_EX then
			self.viewComponent:emit(BattleResultMediator.OPEN_FAIL_TIP_LAYER)

			return
		end

		local var_30_6
		local var_30_7

		if var_30_2 == SYSTEM_BOSS_RUSH_COLLABRATE then
			var_30_6 = BossRushDALBattleResultMediator
			var_30_7 = BossRushDALBattleResultLayer
		elseif var_30_2 == SYSTEM_BOSS_RUSH_EX then
			var_30_6 = BossRushBattleResultMediator
			var_30_7 = BossRushConst.GetEXBattleResultLayer(var_30_3)
		else
			var_30_6 = BossRushBattleResultMediator
			var_30_7 = BossRushBattleResultLayer
		end

		self:addSubLayers(Context.New({
			mediator = var_30_6,
			viewComponent = var_30_7,
			data = {
				awards = var_30_1.awards,
				system = self.contextData.system,
				actId = var_30_3,
				seriesData = var_30_4,
				win = var_30_5,
				OnClose = var_30_1.callback,
				isAutoFight = self.contextData.isAutoFight
			}
		}), true)
		self.viewComponent:closeView()
	elseif var_30_0 == ContinuousOperationMediator.ON_REENTER then
		if not var_30_1.autoFlag then
			self:DisplayTotalReward()

			return
		end

		local var_30_8 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)

		if var_30_8:GetStageBonus(self.contextData.stageId) == 0 then
			if getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1 and getProxy(PlayerProxy):getRawData():getResource(pg.activity_event_worldboss[var_30_8:getConfig("config_id")].ticket) > 0 then
				self:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
					stageId = self.contextData.stageId
				})

				return
			end
		end

		self.viewComponent:emit(BattleResultMediator.REENTER_STAGE)
	elseif var_30_0 == BossSingleContinuousOperationMediator.CONTINUE_OPERATION then
		self.contextData.continuousBattleTimes = self.contextData.continuousBattleTimes - 1
	elseif var_30_0 == BossSingleContinuousOperationMediator.ON_REENTER then
		if not var_30_1.autoFlag then
			self:DisplayBossSingleTotalReward()

			return
		end

		self.viewComponent:emit(BattleResultMediator.REENTER_STAGE)
	end

	return
end

function BattleResultMediator:DisplayTotalReward(arg_31_1)
	local var_31_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator)
	local var_31_1

	if var_31_0 then
		var_31_1 = var_31_0.data.autoFlag or nil
	end

	local var_31_2 = getProxy(ChapterProxy)

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = ActivityBossTotalRewardPanelMediator,
		viewComponent = ActivityBossTotalRewardPanel,
		data = {
			onClose = function()
				self.viewComponent:emit(BaseUI.ON_BACK)

				return
			end,
			stopReason = arg_31_1,
			rewards = var_31_2:PopActBossRewards(),
			isAutoFight = var_31_1,
			continuousBattleTimes = self.contextData.continuousBattleTimes,
			totalBattleTimes = self.contextData.totalBattleTimes
		}
	}))

	return
end

function BattleResultMediator:DisplayBossSingleTotalReward(arg_33_1)
	local var_33_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)
	local var_33_1

	if var_33_0 then
		var_33_1 = var_33_0.data.autoFlag or nil
	end

	local var_33_2 = getProxy(ChapterProxy)

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = BossSingleTotalRewardPanelMediator,
		viewComponent = BossSingleTotalRewardPanel,
		data = {
			onConfirm = function()
				self.viewComponent:emit(BaseUI.ON_BACK)

				return
			end,
			onClose = function()
				local var_35_0 = getProxy(ContextProxy):getContextByMediator(ClueMapMediator)

				if var_35_0 then
					var_35_0.cleanChild = true

					warning("ClueMapMediator")
				end

				local var_35_1 = getProxy(ContextProxy):getContextByMediator(BossSinglePreCombatMediator)

				if var_35_1 then
					var_35_1.skipBack = true

					warning("BossSinglePreCombatMediator")
				end

				self.viewComponent:emit(BaseUI.ON_BACK)

				return
			end,
			stopReason = arg_33_1,
			rewards = var_33_2:PopBossSingleRewards(),
			isAutoFight = var_33_1,
			continuousBattleTimes = self.contextData.continuousBattleTimes,
			totalBattleTimes = self.contextData.totalBattleTimes
		}
	}))

	return
end

function BattleResultMediator:GetResultView()
	BattleResultMediator.RESULT_VIEW_TRANSFORM = BattleResultMediator.RESULT_VIEW_TRANSFORM or {
		[SYSTEM_CHALLENGE] = BattleChallengeResultLayer,
		[SYSTEM_DODGEM] = BattleDodgemResultLayer,
		[SYSTEM_SUBMARINE_RUN] = BattleSubmarineRunResultLayer,
		[SYSTEM_SUB_ROUTINE] = BattleSubmarineRoutineResultLayer,
		[SYSTEM_HP_SHARE_ACT_BOSS] = BattleContributionResultLayer,
		[SYSTEM_BOSS_EXPERIMENT] = BattleExperimentResultLayer,
		[SYSTEM_ACT_BOSS] = BattleActivityBossResultLayer,
		[SYSTEM_WORLD_BOSS] = BattleWorldBossResultLayer,
		[SYSTEM_REWARD_PERFORM] = BattleRewardPerformResultLayer,
		[SYSTEM_AIRFIGHT] = BattleAirFightResultLayer,
		[SYSTEM_GUILD] = BattleGuildBossResultLayer,
		[SYSTEM_CARDPUZZLE] = BattleAirFightResultLayer
	}

	return BattleResultMediator.RESULT_VIEW_TRANSFORM[self] or BattleResultLayer
end

return BattleResultMediator
