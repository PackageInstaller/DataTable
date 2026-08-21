local var_0_0 = class("BattleResultMediator", import("..base.ContextMediator"))

var_0_0.ON_BACK_TO_LEVEL_SCENE = "BattleResultMediator.ON_BACK_TO_LEVEL_SCENE"
var_0_0.ON_BACK_TO_DUEL_SCENE = "BattleResultMediator.ON_BACK_TO_DUEL_SCENE"
var_0_0.ON_GO_TO_TASK_SCENE = "BattleResultMediator.ON_GO_TO_TASK_SCENE"
var_0_0.GET_NEW_SHIP = "BattleResultMediator.GET_NEW_SHIP"
var_0_0.ON_GO_TO_MAIN_SCENE = "BattleResultMediator.ON_GO_TO_MAIN_SCENE"
var_0_0.ON_NEXT_CHALLENGE = "BattleResultMediator.ON_NEXT_CHALLENGE"
var_0_0.ON_CHALLENGE_RANK = "BattleResultMediator:ON_CHALLENGE_RANK"
var_0_0.ON_CHALLENGE_SHARE = "BattleResultMediator:ON_CHALLENGE_SHARE"
var_0_0.ON_CHALLENGE_DEFEAT_SCENE = "BattleResultMediator:ON_CHALLENGE_DEFEAT_SCENE"
var_0_0.DIRECT_EXIT = "BattleResultMediator:DIRECT_EXIT"
var_0_0.REENTER_STAGE = "BattleResultMediator:REENTER_STAGE"
var_0_0.OPEN_FAIL_TIP_LAYER = "BattleResultMediator:OPEN_FAIL_TIP_LAYER"
var_0_0.PRE_BATTLE_FAIL_EXIT = "BattleResultMediator:PRE_BATTLE_FAIL_EXIT"
var_0_0.ON_ENTER_BATTLE_RESULT = "BattleResultMediator:ON_ENTER_BATTLE_RESULT"
var_0_0.SET_SKIP_FLAG = "BattleResultMediator:SET_SKIP_FLAG"
var_0_0.ON_COMPLETE_BATTLE_RESULT = "BattleResultMediator:ON_COMPLETE_BATTLE_RESULT"

function var_0_0.register(arg_1_0)
	local var_1_9000
	local var_1_0 = getProxy(PlayerProxy):getData()
	local var_1_1 = getProxy(FleetProxy)
	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = getProxy(ChapterProxy)
	local var_1_4 = arg_1_0.contextData.system

	if arg_1_0.contextData.system == SYSTEM_DUEL then
		local var_1_5 = getProxy(MilitaryExerciseProxy)
		local var_1_6 = var_1_5:getPreRivalById(arg_1_0.contextData.rivalId)

		assert(var_1_6, "should exist rival--" .. arg_1_0.contextData.rivalId)
		arg_1_0.viewComponent:setRivalVO(var_1_6)
		arg_1_0.viewComponent:setRank(var_1_0, var_1_5:getSeasonInfo())

		goto label_1_0
	end

	if var_1_4 == SYSTEM_CHALLENGE then
		local var_1_7 = getProxy(ChallengeProxy)

		arg_1_0.viewComponent:setChallengeInfo(var_1_7:getUserChallengeInfo(arg_1_0.contextData.mode), var_1_7:userSeaonExpire(arg_1_0.contextData.mode))

		goto label_1_0
	end

	::label_1_0::

	if var_1_4 ~= SYSTEM_SCENARIO and var_1_4 ~= SYSTEM_ROUTINE and var_1_4 ~= SYSTEM_ACT_BOSS and var_1_4 ~= SYSTEM_BOSS_SINGLE and var_1_4 ~= SYSTEM_BOSS_SINGLE_VARIABLE and var_1_4 ~= SYSTEM_HP_SHARE_ACT_BOSS and var_1_4 ~= SYSTEM_SUB_ROUTINE then
		if var_1_4 == SYSTEM_WORLD then
			arg_1_0.viewComponent:setExpBuff(_.detect(BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF), function(arg_2_0)
				return arg_2_0:getConfig("benefit_type") == "rookie_battle_exp"
			end), (getProxy(ActivityProxy):getBuffShipList()))
		end

		arg_1_0.viewComponent:setPlayer(var_1_0)

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

			arg_1_0.viewComponent:SetSkipFlag(var_1_3:GetChapterAutoFlag(var_1_9.id) == 1)
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

			arg_1_0.viewComponent:SetSkipFlag(var_1_12.isAutoFight)
		elseif var_1_4 == SYSTEM_CHALLENGE then
			arg_1_0:bind(var_0_0.ON_CHALLENGE_SHARE, function(arg_4_0)
				arg_1_0:addSubLayers(Context.New({
					mediator = ChallengeShareMediator,
					viewComponent = ChallengeShareLayer,
					data = {
						mode = arg_1_0.contextData.mode
					}
				}))

				return
			end)
			arg_1_0:bind(var_0_0.ON_CHALLENGE_DEFEAT_SCENE, function(arg_5_0, arg_5_1)
				arg_1_0:addSubLayers(Context.New({
					mediator = ChallengePassedMediator,
					viewComponent = ChallengePassedLayer,
					data = {
						mode = arg_1_0.contextData.mode
					},
					onRemoved = arg_5_1.callback
				}))

				return
			end)
		elseif var_1_4 == SYSTEM_WORLD_BOSS then
			var_1_8 = getProxy(BayProxy):getShipsByFleet((nowWorld():GetBossProxy():GetFleet(arg_1_0.contextData.bossId)))

			arg_1_0.viewComponent:setTitle(arg_1_0.contextData.name)
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
			local var_1_16 = arg_1_0.contextData.actId

			if var_1_4 == SYSTEM_HP_SHARE_ACT_BOSS then
				arg_1_0.viewComponent:setActId(var_1_16)
			end

			local var_1_17 = var_1_1:getActivityFleets()[var_1_16]

			var_1_8 = var_1_2:getShipsByFleet(var_1_17[arg_1_0.contextData.mainFleetId])

			for iter_1_12, iter_1_13 in ipairs((var_1_2:getShipsByFleet(var_1_17[arg_1_0.contextData.mainFleetId + 10]))) do
				table.insert(var_1_8, iter_1_13)
			end
		elseif var_1_4 == SYSTEM_GUILD then
			var_1_8 = {}

			local var_1_18 = getProxy(GuildProxy)
			local var_1_19 = var_1_18.getData(var_1_9000):GetActiveEvent():GetBossMission()

			for iter_1_14, iter_1_15 in ipairs(var_1_19.GetMainFleet(var_1_18):GetShips()) do
				table.insert(var_1_8, iter_1_15.ship)
			end

			for iter_1_16, iter_1_17 in ipairs(var_1_19:GetSubFleet():GetShips()) do
				table.insert(var_1_8, iter_1_17.ship)
			end
		elseif var_1_4 == SYSTEM_BOSS_RUSH or var_1_4 == SYSTEM_BOSS_RUSH_EX or var_1_4 == SYSTEM_BOSS_RUSH_COLLABRATE then
			local var_1_20 = arg_1_0.contextData.actId
			local var_1_21 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId):GetSeriesData()

			assert(var_1_21)

			var_1_8 = var_1_2:getShipsByFleet(var_1_1:getActivityFleets()[var_1_20][var_1_21:GetStageFleets(var_1_21:GetMode(), (var_1_21:GetStaegLevel()))])
		else
			var_1_8 = var_1_2:getShipsByFleet((var_1_1:getFleetById(arg_1_0.contextData.mainFleetId)))
		end

		arg_1_0.viewComponent:setShips(var_1_8)
		arg_1_0:bind(var_0_0.ON_BACK_TO_LEVEL_SCENE, function(arg_6_0, arg_6_1)
			local var_6_9000
			local var_6_0 = getProxy(ContextProxy)

			if var_1_4 == SYSTEM_DUEL then
				arg_1_0.viewComponent:emit(BattleResultMediator.ON_BACK_TO_DUEL_SCENE)

				do return end

				goto label_6_0
			end

			::label_6_0::

			if var_1_4 == SYSTEM_ACT_BOSS then
				local var_6_1, var_6_2 = var_6_0:getContextByMediator(PreCombatMediator)

				if var_6_1 then
					var_6_2:removeChild(var_6_1)
				end

				local var_6_3 = var_6_0:getCurrentContext()

				if var_6_3:getContextByMediator(ContinuousOperationMediator) then
					arg_1_0:sendNotification(ContinuousOperationMediator.CONTINUE_OPERATION)
					existCall(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

					local var_6_4 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId)
					local var_6_5 = var_6_4:IsOilLimit(arg_1_0.contextData.stageId)
					local var_6_6 = getProxy(FleetProxy):getActivityFleets()[arg_1_0.contextData.actId]
					local var_6_7 = 0
					local var_6_8 = pg.activity_event_worldboss[var_6_4:getConfig("config_id")].use_oil_limit[arg_1_0.contextData.mainFleetId]
					local var_6_11 = var_6_6[arg_1_0.contextData.mainFleetId]

					if var_6_5 then
						local var_6_12 = var_6_8[1] or 0

						var_6_10(var_6_11, var_6_12)

						local var_6_14 = var_6_6[arg_1_0.contextData.mainFleetId + 10]

						if var_6_5 then
							do
								local var_6_15 = var_6_8[2] or 0

								var_6_13(var_6_14, var_6_15)

								if var_6_7 > getProxy(PlayerProxy):getRawData().oil then
									arg_1_0:DisplayTotalReward((i18n("multiple_sorties_stop_reason1")))

									return
								end

								local var_6_16 = getProxy(BayProxy)

								if var_6_16:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
									arg_1_0:DisplayTotalReward((i18n("multiple_sorties_stop_reason3")))

									return
								end

								local var_6_17 = _.map(_.values(var_6_6[arg_1_0.contextData.mainFleetId].ships), function(arg_8_0)
									local var_8_0 = getProxy(BayProxy):getShipById(arg_8_0)

									if var_8_0 and var_8_0.energy == Ship.ENERGY_LOW then
										return var_8_0
									end

									return
								end)

								if #var_6_17 > 0 then
									arg_1_0:DisplayTotalReward((i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId], table.concat(_.map(var_6_17, function(arg_9_0)
										return "「" .. arg_9_0:getConfig("name") .. "」"
									end), ""))))

									return
								end

								if arg_1_0.contextData.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
									arg_1_0:DisplayTotalReward((i18n("multiple_sorties_stop_reason4")))

									return
								end

								local var_6_18 = pg.GuildMsgBoxMgr.GetInstance()

								if var_6_18:GetShouldShowBattleTip() then
									local var_6_19 = getProxy(GuildProxy):getRawData()
									local var_6_20 = var_6_19 and var_6_19:getWeeklyTask()

									if var_6_20 and var_6_20.id ~= 0 then
										var_6_18:SubmitTask(function(arg_10_0, arg_10_1)
											if arg_10_1 then
												var_6_18:CancelShouldShowBattleTip()
											end

											return
										end)
									end
								end

								local var_6_21 = var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator)

								if var_6_21 and not var_6_21.data.autoFlag then
									arg_1_0:DisplayTotalReward()

									return
								end

								if arg_1_0.contextData.continuousBattleTimes < 1 then
									arg_1_0:DisplayTotalReward()

									return
								end

								arg_1_0:sendNotification(BattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

								do return end

								goto label_6_0

								if var_1_4 == SYSTEM_ROUTINE or var_1_4 == SYSTEM_SUB_ROUTINE then
									local var_6_22 = var_6_0:getContextByMediator(DailyLevelMediator)

									if var_6_22 then
										var_6_22:removeChild((var_6_22:getContextByMediator(PreCombatMediator)))
									end
								elseif var_1_4 == SYSTEM_SCENARIO then
									local var_6_23 = var_6_0:getContextByMediator(LevelMediator2)
									local var_6_24 = var_6_23:getContextByMediator(ChapterPreCombatMediator)

									if var_6_24 then
										var_6_23:removeChild(var_6_24)
									end

									if arg_1_0.contextData.score > 1 then
										arg_1_0:showExtraChapterActSocre()
									end

									local var_6_25 = getProxy(ChapterProxy)
									local var_6_26 = var_6_25:getActiveChapter()

									if var_6_26 then
										if var_6_26:existOni() then
											var_6_26:clearSubmarineFleet()
											var_6_25:updateChapter(var_6_26)
										elseif var_6_26:isPlayingWithBombEnemy() then
											var_6_26.fleets = {
												var_6_26.fleet
											}
											var_6_26.findex = 1

											var_6_25:updateChapter(var_6_26)
										end
									end
								elseif var_1_4 == SYSTEM_CHALLENGE then
									local var_6_27 = getProxy(ChallengeProxy)
									local var_6_28 = var_6_27:getUserChallengeInfo(arg_1_0.contextData.mode)

									if arg_1_0.contextData.score < ys.Battle.BattleConst.BattleScore.S then
										arg_1_0:sendNotification(GAME.CHALLENGE2_RESET, {
											mode = arg_1_0.contextData.mode
										})
									else
										local var_6_29 = var_6_28:IsFinish()

										var_6_28:updateLevelForward()

										if var_6_28:getMode() == ChallengeProxy.MODE_INFINITE and var_6_29 then
											var_6_28:setInfiniteDungeonIDListByLevel()
										end
									end

									local var_6_30 = var_6_27:getChallengeInfo()

									if not var_6_27:userSeaonExpire(var_6_28:getMode()) then
										var_6_30:checkRecord(var_6_28)
									end

									if not arg_6_1.goToNext then
										local var_6_31 = var_6_0:getContextByMediator(ChallengeMainMediator)

										if var_6_31 then
											var_6_31:removeChild((var_6_31:getContextByMediator(ChallengePreCombatMediator)))
										end
									end
								elseif var_1_4 == SYSTEM_HP_SHARE_ACT_BOSS then
									local var_6_32, var_6_33 = var_6_0:getContextByMediator(PreCombatMediator)

									if var_6_32 then
										var_6_33:removeChild(var_6_32)
									end
								elseif var_1_4 == SYSTEM_WORLD_BOSS then
									local var_6_34 = var_6_0:getContextByMediator(WorldBossMediator)
									local var_6_35 = var_6_34:getContextByMediator(WorldBossFormationMediator)

									if var_6_35 then
										var_6_34:removeChild(var_6_35)
									end
								elseif var_1_4 == SYSTEM_WORLD then
									local var_6_36 = var_6_0:getContextByMediator(WorldMediator)
									local var_6_37 = var_6_36:getContextByMediator(WorldPreCombatMediator) or var_6_36:getContextByMediator(WorldBossInformationMediator)

									if var_6_37 then
										var_6_36:removeChild(var_6_37)
									end
								elseif var_1_4 == SYSTEM_BOSS_RUSH or var_1_4 == SYSTEM_BOSS_RUSH_EX or var_1_4 == SYSTEM_BOSS_RUSH_COLLABRATE then
									local var_6_38 = arg_1_0.contextData.score > ys.Battle.BattleConst.BattleScore.C
									local var_6_39 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId):GetSeriesData()

									assert(var_6_39)

									local var_6_40 = var_6_39:GetStaegLevel() + 1
									local var_6_41 = var_6_39:GetExpeditionIds()
									local var_6_42 = var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator)
									local var_6_43 = not var_6_42 or var_6_42.data.autoFlag

									arg_1_0.contextData.isAutoFight = not var_6_42 or var_6_42.data.autoFlag

									if var_6_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
										local var_6_44 = pg.GuildMsgBoxMgr.GetInstance()

										if var_6_44:GetShouldShowBattleTip() then
											local var_6_45 = getProxy(GuildProxy):getRawData()
											local var_6_46 = var_6_45 and var_6_45:getWeeklyTask()

											if var_6_46 and var_6_46.id ~= 0 then
												var_6_44:SubmitTask(function(arg_11_0, arg_11_1)
													if arg_11_1 then
														var_6_44:CancelShouldShowBattleTip()
													end

													return
												end)
											end
										end
									end

									if not var_6_38 or var_6_40 > #var_6_41 or not var_6_43 then
										local var_6_47 = var_6_0:GetPrevContext(1)
										local var_6_48 = var_6_47:getContextByMediator(BossRushPreCombatMediator)

										if var_6_48 then
											var_6_47:removeChild(var_6_48)
										end

										local var_6_49 = var_6_47:getContextByMediator(BossRushFleetSelectMediator)

										if var_6_49 then
											var_6_47:removeChild(var_6_49)
										end

										arg_1_0:sendNotification(GAME.BOSSRUSH_SETTLE, {
											actId = arg_1_0.contextData.actId
										})
									else
										seriesAsync({
											function(arg_12_0)
												arg_1_0:addSubLayers(Context.New({
													mediator = ChallengePassedMediator,
													viewComponent = BossRushPassedLayer,
													data = {
														curIndex = var_6_40 - 1,
														maxIndex = #var_6_41
													},
													onRemoved = arg_12_0
												}))

												return
											end,
											function(arg_13_0)
												arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
													system = arg_1_0.contextData.system,
													actId = var_0,
													continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes,
													totalBattleTimes = arg_1_0.contextData.totalBattleTimes
												})

												return
											end
										})
									end

									return
								elseif var_1_4 == SYSTEM_CARDPUZZLE then
									-- block empty
								elseif var_1_4 == SYSTEM_BOSS_SINGLE or var_1_4 == SYSTEM_BOSS_SINGLE_VARIABLE then
									local var_6_50, var_6_51 = var_6_0:getContextByMediator(PreCombatMediator)

									if var_6_50 then
										var_6_51:removeChild(var_6_50)
									end

									local var_6_52 = var_6_0:getCurrentContext()

									if var_6_52:getContextByMediator(BossSingleContinuousOperationMediator) then
										arg_1_0:sendNotification(BossSingleContinuousOperationMediator.CONTINUE_OPERATION)
										existCall(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

										local var_6_53 = getProxy(ActivityProxy)
										local var_6_54 = var_6_53.getActivityById(var_6_9000, arg_1_0.contextData.actId)
										local var_6_55 = getProxy(FleetProxy):getActivityFleets()[arg_1_0.contextData.actId]
										local var_6_56 = 0
										local var_6_57 = var_6_54:GetOilLimits()[arg_1_0.contextData.mainFleetId]
										local var_6_58 = var_6_57[1] or 0

										;(function(arg_14_0, arg_14_1)
											local var_14_0 = arg_14_0:GetCostSum().oil

											if arg_14_1 > 0 then
												var_14_0 = math.min(var_14_0, arg_14_1)
											end

											var_6_56 = var_6_56 + var_14_0

											return
										end)(var_6_53[arg_1_0.contextData.mainFleetId], var_6_58)

										local var_6_59 = var_6_57[2] or 0

										;(function(arg_14_0, arg_14_1)
											local var_14_0 = arg_14_0:GetCostSum().oil

											if arg_14_1 > 0 then
												var_14_0 = math.min(var_14_0, arg_14_1)
											end

											var_6_56 = var_6_56 + var_14_0

											return
										end)(var_6_55[arg_1_0.contextData.mainFleetId + 10], var_6_59)

										if 0 > getProxy(PlayerProxy):getRawData().oil then
											arg_1_0:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason1")))

											return
										end

										local var_6_60 = getProxy(BayProxy)

										if var_6_60:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
											arg_1_0:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason3")))

											return
										end

										local var_6_61 = _.map(_.values(var_6_55[arg_1_0.contextData.mainFleetId].ships), function(arg_15_0)
											local var_15_0 = getProxy(BayProxy):getShipById(arg_15_0)

											if var_15_0 and var_15_0.energy == Ship.ENERGY_LOW then
												return var_15_0
											end

											return
										end)

										if #var_6_61 > 0 then
											arg_1_0:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId], table.concat(_.map(var_6_61, function(arg_16_0)
												return "「" .. arg_16_0:getConfig("name") .. "」"
											end), ""))))

											return
										end

										if arg_1_0.contextData.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
											arg_1_0:DisplayBossSingleTotalReward((i18n("multiple_sorties_stop_reason4")))

											return
										end

										local var_6_62 = pg.GuildMsgBoxMgr.GetInstance()

										if var_6_62:GetShouldShowBattleTip() then
											local var_6_63 = getProxy(GuildProxy):getRawData()
											local var_6_64 = var_6_63 and var_6_63:getWeeklyTask()

											if var_6_64 and var_6_64.id ~= 0 then
												var_6_62:SubmitTask(function(arg_17_0, arg_17_1)
													if arg_17_1 then
														var_6_62:CancelShouldShowBattleTip()
													end

													return
												end)
											end
										end

										local var_6_65 = var_6_0:getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)

										if var_6_65 and not var_6_65.data.autoFlag then
											arg_1_0:DisplayBossSingleTotalReward()

											return
										end

										if arg_1_0.contextData.continuousBattleTimes < 1 then
											arg_1_0:DisplayBossSingleTotalReward()

											return
										end

										arg_1_0:sendNotification(BattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

										return
									end
								else
									local var_6_66 = var_6_0:getContextByMediator(LevelMediator2)

									if var_6_66 then
										var_6_66:removeChild((var_6_66:getContextByMediator(PreCombatMediator)))
									end
								end
							end

							arg_1_0:sendNotification(GAME.GO_BACK)

							return
						end
					end
				end
			end
		end)
		arg_1_0:bind(var_0_0.ON_GO_TO_MAIN_SCENE, function(arg_18_0)
			arg_1_0:sendNotification(GAME.CHANGE_SCENE, SCENE.MAINUI)

			return
		end)
		arg_1_0:bind(var_0_0.ON_GO_TO_TASK_SCENE, function(arg_19_0)
			local var_19_0 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_19_0 then
				var_19_0:removeChild((var_19_0:getContextByMediator(PreCombatMediator)))
			end

			arg_1_0:sendNotification(GAME.CHANGE_SCENE, SCENE.TASK)

			return
		end)
		arg_1_0:bind(var_0_0.ON_BACK_TO_DUEL_SCENE, function(arg_20_0)
			local var_20_0 = getProxy(ContextProxy):getContextByMediator(MilitaryExerciseMediator)

			if var_20_0 then
				var_20_0:removeChild((var_20_0:getContextByMediator(ExercisePreCombatMediator)))
			end

			arg_1_0:sendNotification(GAME.GO_BACK)

			return
		end)
		arg_1_0:bind(var_0_0.GET_NEW_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
			arg_1_0:addSubLayers(Context.New({
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
		arg_1_0:bind(var_0_0.OPEN_FAIL_TIP_LAYER, function(arg_22_0)
			setActive(arg_1_0.viewComponent._tf, false)
			arg_1_0:addSubLayers(Context.New({
				mediator = BattleFailTipMediator,
				viewComponent = BattleFailTipLayer,
				data = {
					mainShips = var_1_8,
					battleSystem = arg_1_0.contextData.system
				},
				onRemoved = function()
					arg_1_0.viewComponent:emit(BattleResultMediator.ON_BACK_TO_DUEL_SCENE)

					return
				end
			}))

			return
		end)
		arg_1_0:bind(var_0_0.DIRECT_EXIT, function(arg_24_0, arg_24_1)
			arg_1_0:sendNotification(GAME.GO_BACK)

			return
		end)
		arg_1_0:bind(var_0_0.REENTER_STAGE, function(arg_25_0)
			arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
				stageId = arg_1_0.contextData.stageId,
				mainFleetId = arg_1_0.contextData.mainFleetId,
				system = arg_1_0.contextData.system,
				actId = arg_1_0.contextData.actId,
				rivalId = arg_1_0.contextData.rivalId,
				variableBuffList = arg_1_0.contextData.variableBuffList,
				continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes,
				totalBattleTimes = arg_1_0.contextData.totalBattleTimes,
				useVariableTicket = arg_1_0.contextData.useVariableTicket
			})

			return
		end)
		arg_1_0:bind(var_0_0.PRE_BATTLE_FAIL_EXIT, function(arg_26_0)
			if var_1_4 == SYSTEM_SCENARIO then
				getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
			end

			return
		end)
		arg_1_0:bind(GAME.ACT_BOSS_EXCHANGE_TICKET, function(arg_27_0, arg_27_1)
			arg_1_0:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
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

		originalPrint("耗时：", arg_1_0.contextData.statistics._totalTime, "秒")
		originalPrint("编队基础油耗：", var_1_22)

		if arg_1_0.contextData.statistics._enemyInfoList then
			for iter_1_20, iter_1_21 in pairs(arg_1_0.contextData.statistics._enemyInfoList) do
				originalPrint("目标ID>>", iter_1_21.id, "<< 受到伤害共 >>", iter_1_21.damage, "<< 点")
			end
		end

		local var_1_23 = false

		if var_1_4 == SYSTEM_SCENARIO then
			var_1_23 = getProxy(ChapterProxy):GetChapterAutoFlag(var_1_3:getActiveChapter().id) == 1
		elseif var_1_4 == SYSTEM_WORLD then
			var_1_23 = nowWorld().isAutoFight
		end

		local var_1_24 = PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0

		if ys.Battle.BattleState.IsAutoBotActive() and var_1_24 and not var_1_23 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
			LuaHelper.Vibrate()
		end

		arg_1_0:sendNotification(var_0_0.ON_ENTER_BATTLE_RESULT)

		return
	end
end

function var_0_0.showExtraChapterActSocre(arg_28_0)
	local var_28_0 = getProxy(ActivityProxy)
	local var_28_1 = getProxy(ChapterProxy)
	local var_28_2 = var_28_1:getActiveChapter()
	local var_28_3 = var_28_2 and var_28_1:getMapById(var_28_2:getConfig("map"))

	for iter_28_0, iter_28_1 in ipairs((var_28_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK))) do
		if iter_28_1 and not iter_28_1:isEnd() then
			if iter_28_1:getConfig("config_data")[1] == arg_28_0.contextData.stageId and var_28_3 and var_28_3:isActExtra() then
				local var_28_4 = math.floor(arg_28_0.contextData.statistics._totalTime)
				local var_28_5 = arg_28_0.contextData.prefabFleet
				local var_28_6

				if not arg_28_0.contextData.prefabFleet then
					var_28_5 = arg_28_0.contextData.oldMainShips
					var_28_6 = var_28_4
				end

				local var_28_7, var_28_8 = ActivityLevelConst.getExtraChapterSocre(arg_28_0.contextData.stageId, var_28_4, ActivityLevelConst.getShipsPower(var_28_5), iter_28_1)
				local var_28_9 = var_28_8 < var_28_7 and i18n("extra_chapter_record_updated") or i18n("extra_chapter_record_not_updated")

				if var_28_8 < var_28_7 then
					iter_28_1.data1 = var_28_7

					var_28_0:updateActivity(iter_28_1)

					var_28_8 = var_28_7
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("extra_chapter_socre_tip", var_28_7, var_28_8, var_28_9)
				})
			end
		end
	end

	return
end

function var_0_0.listNotificationInterests(arg_29_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.ACT_BOSS_EXCHANGE_TICKET_DONE,
		ContinuousOperationMediator.CONTINUE_OPERATION,
		var_0_0.SET_SKIP_FLAG,
		GAME.BOSSRUSH_SETTLE_DONE,
		ContinuousOperationMediator.ON_REENTER,
		BossSingleContinuousOperationMediator.CONTINUE_OPERATION,
		BossSingleContinuousOperationMediator.ON_REENTER
	}
end

function var_0_0.handleNotification(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:getName()
	local var_30_1 = arg_30_1:getBody()

	if var_30_0 == GAME.BEGIN_STAGE_DONE then
		arg_30_0:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_30_1)
	elseif var_30_0 == GAME.ACT_BOSS_EXCHANGE_TICKET_DONE then
		existCall(arg_30_0.viewComponent.OnActBossExchangeTicket, arg_30_0.viewComponent)
	elseif var_30_0 == var_0_0.SET_SKIP_FLAG then
		arg_30_0.viewComponent:SetSkipFlag(var_30_1)
	elseif var_30_0 == ContinuousOperationMediator.CONTINUE_OPERATION then
		arg_30_0.contextData.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
	elseif var_30_0 == GAME.BOSSRUSH_SETTLE_DONE then
		local var_30_2 = arg_30_0.contextData.system
		local var_30_3 = arg_30_0.contextData.actId
		local var_30_4 = var_30_1.seriesData
		local var_30_5 = arg_30_0.contextData.score > ys.Battle.BattleConst.BattleScore.C

		if arg_30_0.contextData.score <= ys.Battle.BattleConst.BattleScore.C and var_30_2 == SYSTEM_BOSS_RUSH_EX then
			arg_30_0.viewComponent:emit(BattleResultMediator.OPEN_FAIL_TIP_LAYER)

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

		arg_30_0:addSubLayers(Context.New({
			mediator = var_30_6,
			viewComponent = var_30_7,
			data = {
				awards = var_30_1.awards,
				system = arg_30_0.contextData.system,
				actId = var_30_3,
				seriesData = var_30_4,
				win = var_30_5,
				OnClose = var_30_1.callback,
				isAutoFight = arg_30_0.contextData.isAutoFight
			}
		}), true)
		arg_30_0.viewComponent:closeView()
	elseif var_30_0 == ContinuousOperationMediator.ON_REENTER then
		if not var_30_1.autoFlag then
			arg_30_0:DisplayTotalReward()

			return
		end

		local var_30_8 = getProxy(ActivityProxy):getActivityById(arg_30_0.contextData.actId)
		local var_30_9 = getProxy(PlayerProxy):getRawData():getResource(pg.activity_event_worldboss[var_30_8:getConfig("config_id")].ticket)

		if var_30_8:GetStageBonus(arg_30_0.contextData.stageId) == 0 then
			local var_30_10 = getProxy(SettingsProxy)

			if var_30_10:isTipActBossExchangeTicket() == 1 and var_30_9 > 0 then
				arg_30_0:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
					stageId = arg_30_0.contextData.stageId
				})

				return
			end
		end

		arg_30_0.viewComponent:emit(var_0_0.REENTER_STAGE)
	elseif var_30_0 == BossSingleContinuousOperationMediator.CONTINUE_OPERATION then
		arg_30_0.contextData.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
	elseif var_30_0 == BossSingleContinuousOperationMediator.ON_REENTER then
		if not var_30_1.autoFlag then
			arg_30_0:DisplayBossSingleTotalReward()

			return
		end

		arg_30_0.viewComponent:emit(var_0_0.REENTER_STAGE)
	end

	return
end

function var_0_0.DisplayTotalReward(arg_31_0, arg_31_1)
	local var_31_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator)

	if var_31_0 then
		local var_31_2 = getProxy(ChapterProxy)

		LoadContextCommand.LoadLayerOnTopContext(Context.New({
			mediator = ActivityBossTotalRewardPanelMediator,
			viewComponent = ActivityBossTotalRewardPanel,
			data = {
				onClose = function()
					arg_31_0.viewComponent:emit(BaseUI.ON_BACK)

					return
				end,
				stopReason = arg_31_1,
				rewards = var_31_2:PopActBossRewards(),
				isAutoFight = var_31_1,
				continuousBattleTimes = arg_31_0.contextData.continuousBattleTimes,
				totalBattleTimes = arg_31_0.contextData.totalBattleTimes
			}
		}))

		return
	end
end

function var_0_0.DisplayBossSingleTotalReward(arg_33_0, arg_33_1)
	local var_33_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)

	if var_33_0 then
		local var_33_2 = getProxy(ChapterProxy)

		LoadContextCommand.LoadLayerOnTopContext(Context.New({
			mediator = BossSingleTotalRewardPanelMediator,
			viewComponent = BossSingleTotalRewardPanel,
			data = {
				onConfirm = function()
					arg_33_0.viewComponent:emit(BaseUI.ON_BACK)

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

					arg_33_0.viewComponent:emit(BaseUI.ON_BACK)

					return
				end,
				stopReason = arg_33_1,
				rewards = var_33_2:PopBossSingleRewards(),
				isAutoFight = var_33_1,
				continuousBattleTimes = arg_33_0.contextData.continuousBattleTimes,
				totalBattleTimes = arg_33_0.contextData.totalBattleTimes
			}
		}))

		return
	end
end

function var_0_0.GetResultView(arg_36_0)
	var_0_0.RESULT_VIEW_TRANSFORM = var_0_0.RESULT_VIEW_TRANSFORM or {
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

	return var_0_0.RESULT_VIEW_TRANSFORM[arg_36_0] or BattleResultLayer
end

return var_0_0
