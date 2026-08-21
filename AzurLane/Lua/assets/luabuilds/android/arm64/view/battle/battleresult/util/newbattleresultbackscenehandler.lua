local var_0_0 = class("NewBattleResultBackSceneHandler", pm.Mediator)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)
	pg.m02:registerMediator(arg_1_0)

	arg_1_0.contextData = arg_1_1

	return
end

function var_0_0.Execute(arg_2_0)
	if arg_2_0.contextData.system == SYSTEM_DUEL then
		arg_2_0:ExitDuelSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_ACT_BOSS then
		arg_2_0:ExitActBossSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_ROUTINE or arg_2_0.contextData.system == SYSTEM_SUB_ROUTINE then
		arg_2_0:ExitRoutineSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_SCENARIO then
		arg_2_0:ExitScenarioSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_CHALLENGE then
		arg_2_0:ExitChallengeSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_HP_SHARE_ACT_BOSS or arg_2_0.contextData.system == SYSTEM_BOSS_EXPERIMENT or arg_2_0.contextData.system == SYSTEM_ACT_BOSS_SP then
		arg_2_0:ExitShareBossSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_WORLD_BOSS then
		arg_2_0:ExitWorldBossSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_WORLD then
		arg_2_0:ExitWorldSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_BOSS_RUSH or arg_2_0.contextData.system == SYSTEM_BOSS_RUSH_EX or arg_2_0.contextData.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		if arg_2_0:CheckBossRushSystem(arg_2_0.contextData) then
			arg_2_0:ResultRushBossSystem(arg_2_0.contextData)
		end
	elseif arg_2_0.contextData.system == SYSTEM_LIMIT_CHALLENGE then
		arg_2_0:ExitLimitChallengeSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_BOSS_SINGLE then
		arg_2_0:ExitBossSingleSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_BOSS_SINGLE_VARIABLE then
		arg_2_0:ExitBossSingleVariableSystem(arg_2_0.contextData)
	elseif arg_2_0.contextData.system == SYSTEM_REWARD_PERFORM then
		arg_2_0:ExitRewardPerform(arg_2_0.contextData)
	else
		arg_2_0:ExitCommonSystem(arg_2_0.contextData)
	end

	getProxy(MetaCharacterProxy):clearLastMetaSkillExpInfoList()

	return
end

function var_0_0.ExitDuelSystem(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(ContextProxy):getContextByMediator(MilitaryExerciseMediator)

	if var_3_0 then
		var_3_0:removeChild((var_3_0:getContextByMediator(ExercisePreCombatMediator)))
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitActBossSystem(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = getProxy(ContextProxy):getContextByMediator(ActivityBossPreCombatMediator)

	if var_4_0 then
		var_4_1:removeChild(var_4_0)
	end

	local var_4_2 = getProxy(ContextProxy):getCurrentContext()

	if var_4_2:getContextByMediator(ContinuousOperationMediator) then
		arg_4_0:CheckActBossSystem(arg_4_1)
	else
		pg.m02:sendNotification(GAME.GO_BACK)
	end

	return
end

function var_0_0.ExitRoutineSystem(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(ContextProxy):getContextByMediator(DailyLevelMediator)

	if var_5_0 then
		var_5_0:removeChild((var_5_0:getContextByMediator(PreCombatMediator)))
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitScenarioSystem(arg_6_0, arg_6_1)
	if arg_6_1.needHelpMessage or arg_6_1.score == ys.Battle.BattleConst.BattleScore.C then
		getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
	end

	local var_6_0 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

	if var_6_0 then
		local var_6_1 = var_6_0:getContextByMediator(ChapterPreCombatMediator)

		if var_6_1 then
			var_6_0:removeChild(var_6_1)
		end
	end

	if arg_6_1.score > ys.Battle.BattleConst.BattleScore.C then
		arg_6_0:ShowExtraChapterActSocre(arg_6_1)
	end

	getProxy(ChapterProxy):WriteBackOnExitBattleResult()
	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitChallengeSystem(arg_7_0, arg_7_1)
	getProxy(ChallengeProxy):WriteBackOnExitBattleResult(arg_7_0.contextData.score, arg_7_0.contextData.mode)

	if not arg_7_1.goToNext then
		arg_7_1.goToNext = nil

		local var_7_0 = getProxy(ContextProxy):getContextByMediator(ChallengeMainMediator)

		if var_7_0 then
			var_7_0:removeChild((var_7_0:getContextByMediator(ChallengePreCombatMediator)))
		end
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitShareBossSystem(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = getProxy(ContextProxy):getContextByMediator(ActivityBossPreCombatMediator)

	if var_8_0 then
		var_8_1:removeChild(var_8_0)
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitWorldBossSystem(arg_9_0, arg_9_1)
	local var_9_0 = getProxy(ContextProxy):getContextByMediator(WorldBossMediator)
	local var_9_1 = var_9_0:getContextByMediator(WorldBossFormationMediator)

	if var_9_1 and not arg_9_1.isSimulate then
		var_9_0:removeChild(var_9_1)
	end

	pg.m02:sendNotification(GAME.WORLD_BOSS_BATTLE_QUIT, {
		id = arg_9_1.bossId
	})
	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitWorldSystem(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(ContextProxy):getContextByMediator(WorldMediator)
	local var_10_1 = var_10_0:getContextByMediator(WorldPreCombatMediator) or var_10_0:getContextByMediator(WorldBossInformationMediator)

	if var_10_1 then
		var_10_0:removeChild(var_10_1)
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ResultRushBossSystem(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(ContextProxy)
	local var_11_1, var_11_2 = var_11_0:getContextByMediator(BossRushPreCombatMediator)

	if var_11_1 then
		var_11_2:removeChild(var_11_1)
	end

	local var_11_3, var_11_4 = var_11_0:getContextByMediator(BossRushFleetSelectMediator)

	if var_11_3 then
		var_11_4:removeChild(var_11_3)
	end

	if arg_11_1.score <= ys.Battle.BattleConst.BattleScore.C and arg_11_1.system == SYSTEM_BOSS_RUSH_EX then
		arg_11_0:addSubLayers(Context.New({
			mediator = BattleFailTipMediator,
			viewComponent = BattleFailTipLayer,
			data = {
				mainShips = arg_11_1.newMainShips,
				battleSystem = arg_11_1.system
			},
			onRemoved = function()
				pg.m02:sendNotification(GAME.GO_BACK)

				return
			end
		}))

		return
	end

	pg.m02:sendNotification(GAME.BOSSRUSH_SETTLE, {
		actId = arg_11_1.actId
	})

	return
end

function var_0_0.ExitRushBossSystem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.actId
	local var_13_1 = arg_13_2.seriesData
	local var_13_2 = arg_13_1.score > ys.Battle.BattleConst.BattleScore.C
	local var_13_3
	local var_13_4

	if arg_13_1.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		var_13_3 = BossRushDALBattleResultMediator
		var_13_4 = BossRushDALBattleResultLayer
	elseif arg_13_1.system == SYSTEM_BOSS_RUSH_EX then
		var_13_3 = BossRushBattleResultMediator
		var_13_4 = BossRushConst.GetEXBattleResultLayer(var_13_0)
	else
		var_13_3 = BossRushBattleResultMediator
		var_13_4 = BossRushBattleResultLayer
	end

	arg_13_0:addSubLayers(Context.New({
		mediator = var_13_3,
		viewComponent = var_13_4,
		data = {
			awards = arg_13_2.awards,
			system = arg_13_1.system,
			actId = var_13_0,
			seriesData = var_13_1,
			win = var_13_2,
			OnClose = arg_13_2.callback,
			isAutoFight = arg_13_0.contextData.isAutoFight
		}
	}), true)
	LoadContextCommand.RemoveLayerByMediator(NewBattleResultMediator)

	return
end

function var_0_0.ExitLimitChallengeSystem(arg_14_0, arg_14_1)
	local var_14_0 = getProxy(ContextProxy):getContextByMediator(LimitChallengeMediator)

	if var_14_0 then
		local var_14_1 = var_14_0:getContextByMediator(LimitChallengePreCombatMediator)

		if var_14_1 then
			var_14_0:removeChild(var_14_1)
		end
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitBossSingleSystem(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = getProxy(ContextProxy):getContextByMediator(BossSinglePreCombatMediator)

	if var_15_0 then
		local var_15_2 = var_15_1:removeChild(var_15_0)
	end

	local var_15_3 = getProxy(ContextProxy):getCurrentContext()

	if var_15_3:getContextByMediator(BossSingleContinuousOperationMediator) then
		arg_15_0:CheckBossSingleSystem(arg_15_1)
	else
		pg.m02:sendNotification(GAME.GO_BACK)
	end

	return
end

function var_0_0.ExitBossSingleVariableSystem(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = getProxy(ContextProxy):getContextByMediator(BossSinglePreCombatMediator)

	if var_16_0 then
		local var_16_2 = var_16_1:removeChild(var_16_0)
	end

	local var_16_3 = getProxy(ContextProxy):getCurrentContext()

	if var_16_3:getContextByMediator(BossSingleContinuousOperationMediator) then
		arg_16_0:CheckBossSingleSystem(arg_16_1)
	else
		pg.m02:sendNotification(GAME.GO_BACK)
	end

	return
end

function var_0_0.ExitRewardPerform(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = getProxy(ContextProxy):getContextByMediator(BossSinglePreCombatLiteMediator)

	if var_17_0 then
		local var_17_2 = var_17_1:removeChild(var_17_0)
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.ExitCommonSystem(arg_18_0, arg_18_1)
	local var_18_0 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

	if var_18_0 then
		local var_18_1 = var_18_0:getContextByMediator(PreCombatMediator)

		if var_18_1 then
			var_18_0:removeChild(var_18_1)
		end
	end

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

local function var_0_1()
	for iter_19_0, iter_19_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK))) do
		if iter_19_1 and not iter_19_1:isEnd() then
			table.insert({}, iter_19_1)
		end
	end

	return {}
end

function var_0_0.ShowExtraChapterActSocre(arg_20_0, arg_20_1)
	local var_20_0 = getProxy(ChapterProxy):getActiveChapter()

	for iter_20_0, iter_20_1 in ipairs((var_0_1())) do
		if iter_20_1:getConfig("config_data")[1] == arg_20_1.stageId and var_20_0:IsEXChapter() then
			local var_20_1 = math.floor(arg_20_1.statistics._totalTime)
			local var_20_2 = arg_20_1.prefabFleet
			local var_20_3, var_20_4

			if not arg_20_1.prefabFleet then
				var_20_2 = arg_20_1.oldMainShips
				var_20_3 = arg_20_1.stageId
				var_20_4 = var_20_1
			end

			local var_20_5, var_20_6 = ActivityLevelConst.getExtraChapterSocre(arg_20_1.stageId, var_20_1, ActivityLevelConst.getShipsPower(var_20_2), iter_20_1)
			local var_20_7 = var_20_6 < var_20_5 and i18n("extra_chapter_record_updated") or i18n("extra_chapter_record_not_updated")

			if var_20_6 < var_20_5 then
				iter_20_1.data1 = var_20_5

				getProxy(ActivityProxy):updateActivity(iter_20_1)

				var_20_6 = var_20_5
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("extra_chapter_socre_tip", var_20_5, var_20_6, var_20_7)
			})
		end
	end

	return
end

local function var_0_2(arg_21_0)
	local var_21_0 = getProxy(ActivityProxy):getActivityById(arg_21_0.actId)
	local var_21_1 = var_21_0:IsOilLimit(arg_21_0.stageId)
	local var_21_2 = getProxy(FleetProxy):getActivityFleets()[arg_21_0.actId]
	local var_21_3 = 0
	local var_21_4 = pg.activity_event_worldboss[var_21_0:getConfig("config_id")].use_oil_limit[arg_21_0.mainFleetId]
	local var_21_7 = var_21_2[arg_21_0.mainFleetId]

	if var_21_1 then
		local var_21_8 = var_21_4[1] or 0

		var_21_6(var_21_7, var_21_8)

		local var_21_10 = var_21_2[arg_21_0.mainFleetId + 10]

		if var_21_1 then
			local var_21_11 = var_21_4[2] or 0

			var_21_9(var_21_10, var_21_11)

			return var_21_3
		end
	end
end

local function var_0_3(arg_23_0, arg_23_1)
	local var_23_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator)

	if var_23_0 then
		local var_23_2 = getProxy(ChapterProxy)

		LoadContextCommand.LoadLayerOnTopContext(Context.New({
			mediator = ActivityBossTotalRewardPanelMediator,
			viewComponent = ActivityBossTotalRewardPanel,
			data = {
				onClose = function()
					pg.m02:sendNotification(GAME.GO_BACK)

					return
				end,
				stopReason = arg_23_1,
				rewards = var_23_2:PopActBossRewards(),
				isAutoFight = var_23_1,
				continuousBattleTimes = arg_23_0.continuousBattleTimes,
				totalBattleTimes = arg_23_0.totalBattleTimes
			}
		}))

		return
	end
end

local function var_0_4(arg_25_0, arg_25_1)
	local var_25_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)

	if var_25_0 then
		local var_25_2 = getProxy(ChapterProxy)

		LoadContextCommand.LoadLayerOnTopContext(Context.New({
			mediator = BossSingleTotalRewardPanelMediator,
			viewComponent = BossSingleTotalRewardPanel,
			data = {
				onConfirm = function()
					pg.m02:sendNotification(GAME.GO_BACK)

					return
				end,
				onClose = function()
					local var_27_0 = getProxy(ContextProxy):getContextByMediator(ClueMapMediator)

					if var_27_0 then
						var_27_0.cleanChild = true

						warning("ClueMapMediator")
					end

					local var_27_1 = getProxy(ContextProxy):getContextByMediator(BossSinglePreCombatMediator)

					if var_27_1 then
						var_27_1.skipBack = true

						warning("BossSinglePreCombatMediator")
					end

					pg.m02:sendNotification(GAME.GO_BACK)

					return
				end,
				stopReason = arg_25_1,
				rewards = var_25_2:PopBossSingleRewards(),
				isAutoFight = var_25_1,
				continuousBattleTimes = arg_25_0.continuousBattleTimes,
				totalBattleTimes = arg_25_0.totalBattleTimes
			}
		}))

		return
	end
end

local function var_0_5()
	local var_28_0 = pg.GuildMsgBoxMgr.GetInstance()

	if var_28_0:GetShouldShowBattleTip() then
		local var_28_1 = getProxy(GuildProxy):getRawData()
		local var_28_2 = var_28_1 and var_28_1:getWeeklyTask()

		if var_28_2 and var_28_2.id ~= 0 then
			var_28_0:SubmitTask(function(arg_29_0, arg_29_1)
				if arg_29_1 then
					var_28_0:CancelShouldShowBattleTip()
				end

				return
			end)
		end
	end

	return
end

function var_0_0.CheckActBossSystem(arg_30_0, arg_30_1)
	pg.m02:sendNotification(ContinuousOperationMediator.CONTINUE_OPERATION)

	if var_0_2(arg_30_1) > getProxy(PlayerProxy):getRawData().oil then
		var_0_3(arg_30_1, i18n("multiple_sorties_stop_reason1"))

		return
	end

	local var_30_0 = getProxy(BayProxy)

	if var_30_0:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
		var_0_3(arg_30_1, i18n("multiple_sorties_stop_reason3"))

		return
	end

	local var_30_1 = getProxy(FleetProxy)
	local var_30_2 = _.map(_.values(var_30_1:getActivityFleets()[arg_30_1.actId][arg_30_1.mainFleetId].ships), function(arg_31_0)
		local var_31_0 = getProxy(BayProxy):getShipById(arg_31_0)

		if var_31_0 and var_31_0.energy == Ship.ENERGY_LOW then
			return var_31_0
		end

		return
	end)

	if #var_30_2 > 0 then
		var_0_3(arg_30_1, i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[arg_30_1.mainFleetId], table.concat(_.map(var_30_2, function(arg_32_0)
			return "「" .. arg_32_0:getConfig("name") .. "」"
		end), "")))

		return
	end

	if arg_30_1.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
		var_0_3(arg_30_1, i18n("multiple_sorties_stop_reason4"))

		return
	end

	var_0_5()

	local var_30_3 = getProxy(ContextProxy)
	local var_30_4 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator)

	if var_30_4 and not var_30_4.data.autoFlag then
		var_0_3(arg_30_1)

		return
	end

	if arg_30_1.continuousBattleTimes < 1 then
		var_0_3(arg_30_1)

		return
	end

	pg.m02:sendNotification(NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

	return
end

function var_0_0.ContinuousBossRush(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	pg.m02:sendNotification(GAME.BEGIN_STAGE, {
		system = arg_33_1,
		actId = arg_33_2,
		continuousBattleTimes = arg_33_5,
		totalBattleTimes = arg_33_6,
		curIndex = arg_33_3 - 1,
		maxIndex = #arg_33_4
	})

	return
end

function var_0_0.CheckBossRushSystem(arg_34_0, arg_34_1)
	local var_34_0 = getProxy(ContextProxy)
	local var_34_1 = arg_34_1.score > ys.Battle.BattleConst.BattleScore.C
	local var_34_2 = arg_34_1.actId
	local var_34_3 = getProxy(ActivityProxy):getActivityById(arg_34_1.actId):GetSeriesData()

	assert(var_34_3)

	local var_34_4 = var_34_3:GetStaegLevel() + 1
	local var_34_5 = var_34_3:GetExpeditionIds()

	if var_34_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
		var_0_5()
	end

	local var_34_6 = var_34_0:getCurrentContext():getContextByMediator(ContinuousOperationMediator)
	local var_34_7 = not var_34_6 or var_34_6.data.autoFlag
	local var_34_8 = not var_34_1 or var_34_4 > #var_34_5 or not var_34_7

	arg_34_0.contextData.isAutoFight = not var_34_6 or var_34_6.data.autoFlag

	if not var_34_8 then
		arg_34_0:ContinuousBossRush(arg_34_1.system, var_34_2, var_34_4, var_34_5, arg_34_1.continuousBattleTimes, arg_34_1.totalBattleTimes)
	end

	return var_34_8
end

local function var_0_6(arg_35_0)
	local var_35_9000
	local var_35_0 = getProxy(ActivityProxy)
	local var_35_1 = var_35_0.getActivityById(var_35_9000, arg_35_0.actId)
	local var_35_2 = var_35_1:GetEnemyDataByStageId(arg_35_0.stageId):GetOilLimit()
	local var_35_3 = getProxy(FleetProxy):getActivityFleets()[arg_35_0.actId]
	local var_35_4 = 0
	local var_35_6 = var_35_0[1] or 0

	;(function(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0:GetCostSum().oil

		if arg_36_1 > 0 then
			var_36_0 = math.min(var_36_0, arg_36_1)
		end

		var_35_4 = var_35_4 + var_36_0

		return
	end)(var_35_3[arg_35_0.mainFleetId], var_35_6)

	if var_35_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		local var_35_7 = Fleet.MEGA_SUBMARINE_FLEET_OFFSET or 10
		local var_35_9 = var_35_2[2] or 0

		var_35_8(var_35_3[arg_35_0.mainFleetId + var_35_7], var_35_9)

		return var_35_4
	end
end

function var_0_0.CheckBossSingleSystem(arg_37_0, arg_37_1)
	pg.m02:sendNotification(BossSingleContinuousOperationMediator.CONTINUE_OPERATION)

	if var_0_6(arg_37_1) > getProxy(PlayerProxy):getRawData().oil then
		var_0_4(arg_37_1, i18n("multiple_sorties_stop_reason1"))

		return
	end

	local var_37_0 = getProxy(BayProxy)

	if var_37_0:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
		var_0_4(arg_37_1, i18n("multiple_sorties_stop_reason3"))

		return
	end

	local var_37_1 = getProxy(FleetProxy)
	local var_37_2 = _.map(_.values(var_37_1:getActivityFleets()[arg_37_1.actId][arg_37_1.mainFleetId].ships), function(arg_38_0)
		local var_38_0 = getProxy(BayProxy):getShipById(arg_38_0)

		if var_38_0 and var_38_0.energy == Ship.ENERGY_LOW then
			return var_38_0
		end

		return
	end)

	if #var_37_2 > 0 then
		var_0_4(arg_37_1, i18n("multiple_sorties_stop_reason2", Fleet.DEFAULT_NAME_BOSS_ACT[arg_37_1.mainFleetId], table.concat(_.map(var_37_2, function(arg_39_0)
			return "「" .. arg_39_0:getConfig("name") .. "」"
		end), "")))

		return
	end

	if arg_37_1.statistics._battleScore <= ys.Battle.BattleConst.BattleScore.C then
		var_0_4(arg_37_1, i18n("multiple_sorties_stop_reason4"))

		return
	end

	var_0_5()

	local var_37_3 = getProxy(ContextProxy)
	local var_37_4 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator)

	if var_37_4 and not var_37_4.data.autoFlag then
		var_0_4(arg_37_1)

		return
	end

	if arg_37_1.continuousBattleTimes < 1 then
		var_0_4(arg_37_1)

		return
	end

	pg.m02:sendNotification(NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT)

	return
end

local function var_0_7(arg_40_0, arg_40_1)
	local var_40_0 = getProxy(ActivityProxy):getActivityById(arg_40_0)
	local var_40_1 = getProxy(PlayerProxy):getRawData():getResource(pg.activity_event_worldboss[var_40_0:getConfig("config_id")].ticket)

	if var_40_0:GetStageBonus(arg_40_1) == 0 then
		local var_40_2 = getProxy(SettingsProxy)

		if var_40_2:isTipActBossExchangeTicket() == 1 and var_40_1 > 0 then
			return true
		end
	end

	return false
end

local function var_0_8(arg_41_0)
	pg.m02:sendNotification(GAME.BEGIN_STAGE, {
		stageId = arg_41_0.stageId,
		mainFleetId = arg_41_0.mainFleetId,
		system = arg_41_0.system,
		actId = arg_41_0.actId,
		rivalId = arg_41_0.rivalId,
		continuousBattleTimes = arg_41_0.continuousBattleTimes,
		variableBuffList = arg_41_0.variableBuffList,
		totalBattleTimes = arg_41_0.totalBattleTimes,
		useVariableTicket = arg_41_0.useVariableTicket
	})

	return
end

function var_0_0.listNotificationInterests(arg_42_0)
	return {
		GAME.BOSSRUSH_SETTLE_DONE,
		ContinuousOperationMediator.ON_REENTER,
		BossSingleContinuousOperationMediator.ON_REENTER
	}
end

function var_0_0.handleNotification(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getName()
	local var_43_1 = arg_43_1:getBody()

	if var_43_0 == GAME.BOSSRUSH_SETTLE_DONE then
		arg_43_0:ExitRushBossSystem(arg_43_0.contextData, var_43_1)
	elseif var_43_0 == ContinuousOperationMediator.ON_REENTER then
		if not var_43_1.autoFlag then
			var_0_3(arg_43_0.contextData)

			return
		end

		if var_0_7(arg_43_0.contextData.actId, arg_43_0.contextData.stageId) then
			pg.m02:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
				stageId = arg_43_0.contextData.stageId
			})
		else
			var_0_8(arg_43_0.contextData)
		end
	elseif var_43_0 == BossSingleContinuousOperationMediator.ON_REENTER then
		if not var_43_1.autoFlag then
			var_0_4(arg_43_0.contextData)

			return
		end

		var_0_8(arg_43_0.contextData)
	end

	return
end

function var_0_0.addSubLayers(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	assert(isa(arg_44_1, Context), "should be an instance of Context")

	local var_44_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewBattleResultMediator)

	if arg_44_2 then
		while var_44_0.parent do
			var_44_0 = var_44_0.parent
		end
	end

	arg_44_0:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = var_44_0,
		context = arg_44_1,
		callback = arg_44_3
	})

	return
end

function var_0_0.Dispose(arg_45_0)
	pg.m02:removeMediator(arg_45_0.__cname)

	return
end

return var_0_0
