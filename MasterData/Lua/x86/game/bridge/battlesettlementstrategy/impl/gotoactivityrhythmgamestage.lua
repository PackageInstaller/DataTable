local GotoActivityRhythmGameStage = class("GotoActivityRhythmGameStage", BattleSettlementStrategyBase)

function GotoActivityRhythmGameStage:OnGotoSettlement(arg_1_1)
	self:GotoActivityRhythmGameStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoActivityRhythmGameStage:GotoActivityRhythmGameStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	LuaHidTools.ForceSelectKeyboard(nil)

	if arg_2_5 == true then
		arg_2_1 = 3
	end

	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = manager.time:DescCdTime3(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
			manager.story:RemovePlayer()
			JumpTools.OpenPageByJump("/activityRhythmScoreResultView", {
				stageData = arg_2_2,
				rewardList = var_2_1,
				score = var_2_2,
				battleResult = arg_2_4
			})
			ActivityRhythmGameData:InitUnlockStageData()
			ActivityRhythmGameData:InitUnlockCommandData()
			EndBattleLogic(arg_2_1)
		end, false)
	end or function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
			manager.story:RemovePlayer()
			JumpTools.OpenPageByJump("/battlefailedWithButton", {
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4,
				isHalfWay_ = self.tempData.isHalfWay_
			})
			EndBattleLogic(arg_2_1)
		end, false)
	end
end

return GotoActivityRhythmGameStage
