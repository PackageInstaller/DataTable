local GotoScoreStage = class("GotoScoreStage", BattleSettlementStrategyBase)

function GotoScoreStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.stageData:GetType()

	if var_1_0 == BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION then
		self:GotoScoreStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	elseif var_1_0 == BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT then
		self:GotoScoreResult(ActivityAffixSelectData:GetLevelScore(arg_1_1.stageData:GetActivityID()), arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_, true)
	elseif var_1_0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD then
		self:GotoScoreResult(ActivityPt2Data:GetHardScore(), arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_, true)
	elseif var_1_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		self:GotoScoreResult(AdvanceTestData:GetBattleResultScore(), arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_, true)
	elseif var_1_0 == BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST then
		local var_1_1 = arg_1_1.stageData:GetStageId()
		local var_1_2 = 0

		for iter_1_0, iter_1_1 in pairs(ActivityAdvanceMonsterTestCfg.all) do
			if ActivityAdvanceMonsterTestCfg[iter_1_1].stage_id == var_1_1 then
				var_1_2 = iter_1_1

				break
			end
		end

		local var_1_3 = ActivityAdvanceMonsterTestCfg[var_1_2].base_point

		for iter_1_2, iter_1_3 in pairs((AdvanceMonsterTestData:GetCustomList(var_1_2))) do
			var_1_3 = var_1_3 + ActivityAffixPoolCfg[iter_1_3].point
		end

		self:GotoScoreResult(var_1_3, arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_, true)
	end
end

function GotoScoreStage:GotoScoreStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			rewardList = var_2_1,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, var_2_2)
	end or function()
		JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
	end
end

function GotoScoreStage:GotoScoreResult(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	if arg_6_6 == true then
		arg_6_2 = 3
	end

	local var_6_0, var_6_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_6_2) and function()
		gameContext:Go("/battleScorResult", {
			stageData = arg_6_3,
			rewardList = var_6_1,
			score = arg_6_1,
			battleResult = arg_6_5
		})
		EndBattleLogic(arg_6_2)
	end or function()
		manager.story:CheckBattleStory(arg_6_3:GetStageId(), manager.story.LOSE, function()
			if arg_6_7 then
				JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
					stageData = arg_6_3,
					starMissionData = arg_6_4,
					battleResult = arg_6_5,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			else
				JumpTools.OpenPageByJump("/battlefailed", {
					stageData = arg_6_3,
					starMissionData = arg_6_4,
					battleResult = arg_6_5,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(arg_6_2)
		end)
	end
end

return GotoScoreStage
