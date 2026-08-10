local var_0_0 = class("BattleSettlementChallengeModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/System/BattleResult/Common/Module/BattleChallengeContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scoreTween = nil
end

function var_0_0.OnEnter(arg_4_0)
	return
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.RenderView(arg_6_0, arg_6_1)
	arg_6_0.battleCtx = arg_6_1

	local var_6_0 = arg_6_1.stageType
	local var_6_1 = arg_6_1.stageData
	local var_6_2 = arg_6_1.score

	if arg_6_1.scoreTitle then
		arg_6_0.scoreTitleTxt_.text = arg_6_1.scoreTitle
	end

	if var_6_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		arg_6_0:RefreshBossAdvanceScore()

		return
	end

	if var_6_0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA then
		arg_6_0.targetScore = ActivityAttributeArenaData:GetArenaScore(var_6_1:GetActivityID(), var_6_1:GetDest())

		arg_6_0:StartTween()

		return
	end

	if var_6_2 then
		if type(var_6_2) == "number" then
			arg_6_0.targetScore = var_6_2

			arg_6_0:StartTween()
		else
			arg_6_0.scoreText_.text = var_6_2
		end
	else
		local var_6_3 = var_6_1:GetActivityID()
		local var_6_4 = ActivityTools.GetActivityTheme(var_6_3)

		if var_6_4 == ActivityConst.THEME.SUMMER or var_6_3 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_6_5 = 0
			local var_6_6 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			local var_6_7 = GameSetting.limit_calculation_time_score_args.value
			local var_6_8 = var_6_7[1]
			local var_6_9 = var_6_7[2]
			local var_6_10 = var_6_7[3]
			local var_6_11 = var_6_7[4]

			if var_6_6 < var_6_10 then
				var_6_5 = var_6_8 * var_6_10 + var_6_9
			elseif var_6_6 < var_6_11 then
				var_6_5 = var_6_8 * var_6_6 + var_6_9
			else
				var_6_5 = var_6_8 * var_6_11 + var_6_9
			end

			local var_6_12 = 0
			local var_6_13 = 0
			local var_6_14, var_6_15, var_6_16 = BattleTools.GetBattleStatisticsData()
			local var_6_17 = tonumber(tostring(var_6_14[1].hurt))
			local var_6_18 = GameSetting.limit_calculation_injured_score_args.value

			if var_6_17 >= var_6_18[#var_6_18][1] then
				var_6_17 = var_6_18[#var_6_18][1]
			end

			for iter_6_0, iter_6_1 in ipairs(var_6_18) do
				if var_6_17 <= iter_6_1[1] then
					var_6_12 = iter_6_1[2]

					break
				end
			end

			local var_6_19 = var_6_1:GetDest()
			local var_6_20 = ActivityLimitCalculationCfg[var_6_19].reward_point

			arg_6_0.targetScore = math.floor((var_6_5 + var_6_12) * var_6_20 / 100)

			arg_6_0:StartTween()
		elseif var_6_4 == ActivityConst.THEME.FACTORY or ActivityConst.THEME.TYR then
			local var_6_21 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			arg_6_0.scoreText_.text = var_6_21 .. "s"
		end
	end
end

function var_0_0.RefreshBossAdvanceScore(arg_7_0)
	local var_7_0 = arg_7_0.battleCtx.stageData
	local var_7_1 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	local var_7_2 = var_7_0:GetBossIndex()
	local var_7_3 = BattleBossChallengeAdvanceData:GetBossList()[var_7_2]
	local var_7_4 = var_7_3.multipleIndex
	local var_7_5 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[var_7_3.multipleIndex]
	local var_7_6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

	for iter_7_0, iter_7_1 in pairs(var_7_3.condition[BossConst.TYPE_STAGE]) do
		if BattleInstance.CaculateStar(var_7_0, StageChallengeConditionPoolCfg[iter_7_1].condition, var_7_6).isComplete then
			var_7_5 = var_7_5 + StageChallengeConditionPoolCfg[iter_7_1].point
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_3.condition[BossConst.TYPE_AFFIX]) do
		var_7_5 = var_7_5 + ActivityAffixPoolCfg[iter_7_3].point
	end

	arg_7_0.targetScore = var_7_5

	arg_7_0:StartTween()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:StartTween()
end

function var_0_0.StartTween(arg_9_0)
	if not arg_9_0.targetScore then
		return
	end

	if not isNil(arg_9_0.scoreTween) then
		LeanTween.cancel(arg_9_0.scoreText_.gameObject)

		arg_9_0.scoreTween = nil
	end

	arg_9_0.scoreText_.text = 0
	arg_9_0.scoreTween = LeanTween.value(arg_9_0.scoreText_.gameObject, 0, arg_9_0.targetScore, 0.6):setEase(LeanTweenType.easeOutExpo):setTime(1):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
		arg_9_0.scoreText_.text = math.floor(arg_10_0)
	end)):setOnComplete(System.Action(function()
		arg_9_0.scoreText_.text = math.floor(arg_9_0.targetScore)
	end))
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	if not isNil(arg_12_0.scoreTween) then
		LeanTween.cancel(arg_12_0.scoreText_.gameObject)

		arg_12_0.scoreTween = nil
	end
end

return var_0_0
