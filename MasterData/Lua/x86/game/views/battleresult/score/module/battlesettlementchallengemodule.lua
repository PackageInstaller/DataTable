local BattleSettlementChallengeModule = class("BattleSettlementChallengeModule", ReduxView)

function BattleSettlementChallengeModule:OnCtor(arg_1_1)
	self.gameObject_ = self:InstView(arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSettlementChallengeModule:InstView(arg_2_1)
	return (Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleChallengeContent"), arg_2_1))
end

function BattleSettlementChallengeModule:Init()
	self:BindCfgUI()

	self.scoreTween = nil
end

function BattleSettlementChallengeModule:OnEnter()
	return
end

function BattleSettlementChallengeModule:OnExit()
	return
end

function BattleSettlementChallengeModule:RenderView(arg_6_1)
	self.battleCtx = arg_6_1

	local var_6_0 = arg_6_1.stageData

	if arg_6_1.scoreTitle then
		self.scoreTitleTxt_.text = arg_6_1.scoreTitle
	end

	if arg_6_1.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		self:RefreshBossAdvanceScore()

		return
	end

	if arg_6_1.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA then
		self.targetScore = ActivityAttributeArenaData:GetArenaScore(var_6_0:GetActivityID(), var_6_0:GetDest())

		self:StartTween()

		return
	end

	if arg_6_1.score then
		if type(arg_6_1.score) == "number" then
			self.targetScore = arg_6_1.score

			self:StartTween()
		else
			self.scoreText_.text = arg_6_1.score
		end
	else
		local var_6_1 = var_6_0:GetActivityID()
		local var_6_2 = ActivityTools.GetActivityTheme(var_6_1)

		if var_6_2 == ActivityConst.THEME.SUMMER or var_6_1 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
			local var_6_3 = 0
			local var_6_4 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

			var_6_3 = var_6_4 < GameSetting.limit_calculation_time_score_args.value[3] and GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[3] + GameSetting.limit_calculation_time_score_args.value[2] or var_6_4 < GameSetting.limit_calculation_time_score_args.value[4] and GameSetting.limit_calculation_time_score_args.value[1] * var_6_4 + GameSetting.limit_calculation_time_score_args.value[2] or GameSetting.limit_calculation_time_score_args.value[1] * GameSetting.limit_calculation_time_score_args.value[4] + GameSetting.limit_calculation_time_score_args.value[2]

			local var_6_5 = 0
			local var_6_7, var_6_8, var_6_9 = BattleTools.GetBattleStatisticsData()
			local var_6_10 = tonumber(tostring(var_6_7[1].hurt))

			if var_6_10 >= GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1] then
				var_6_10 = GameSetting.limit_calculation_injured_score_args.value[#GameSetting.limit_calculation_injured_score_args.value][1]
			end

			for iter_6_0, iter_6_1 in ipairs(GameSetting.limit_calculation_injured_score_args.value) do
				if var_6_10 <= iter_6_1[1] then
					var_6_5 = iter_6_1[2]

					break
				end
			end

			self.targetScore = math.floor((var_6_3 + var_6_5) * ActivityLimitCalculationCfg[var_6_0:GetDest()].reward_point / 100)

			self:StartTween()
		elseif var_6_2 ~= ActivityConst.THEME.FACTORY then
			if ActivityConst.THEME.TYR then
				self.scoreText_.text = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) .. "s"
			end
		end
	end
end

function BattleSettlementChallengeModule:RefreshBossAdvanceScore()
	local var_7_0 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	local var_7_1 = BattleBossChallengeAdvanceData:GetBossList()[self.battleCtx.stageData:GetBossIndex()]
	local var_7_3 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[var_7_1.multipleIndex]
	local var_7_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

	for iter_7_0, iter_7_1 in pairs(var_7_1.condition[BossConst.TYPE_STAGE]) do
		if BattleInstance.CaculateStar(self.battleCtx.stageData, StageChallengeConditionPoolCfg[iter_7_1].condition, var_7_4).isComplete then
			var_7_3 = var_7_3 + StageChallengeConditionPoolCfg[iter_7_1].point
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_1.condition[BossConst.TYPE_AFFIX]) do
		var_7_3 = var_7_3 + ActivityAffixPoolCfg[iter_7_3].point
	end

	self.targetScore = var_7_3

	self:StartTween()
end

function BattleSettlementChallengeModule:OnTop()
	self:StartTween()
end

function BattleSettlementChallengeModule:StartTween()
	if not self.targetScore then
		return
	end

	if not isNil(self.scoreTween) then
		LeanTween.cancel(self.scoreText_.gameObject)

		self.scoreTween = nil
	end

	self.scoreText_.text = 0
	self.scoreTween = LeanTween.value(self.scoreText_.gameObject, 0, self.targetScore, 0.6):setEase(LeanTweenType.easeOutExpo):setTime(1):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
		self.scoreText_.text = math.floor(arg_10_0)
	end)):setOnComplete(System.Action(function()
		self.scoreText_.text = math.floor(self.targetScore)
	end))
end

function BattleSettlementChallengeModule:Dispose()
	BattleSettlementChallengeModule.super.Dispose(self)

	if not isNil(self.scoreTween) then
		LeanTween.cancel(self.scoreText_.gameObject)

		self.scoreTween = nil
	end
end

return BattleSettlementChallengeModule
