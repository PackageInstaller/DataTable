local var_0_0 = class("GotoActivityRhythmGameStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityRhythmGameStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoActivityRhythmGameStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	LuaHidTools.ForceSelectKeyboard(nil)

	if arg_2_5 == true then
		arg_2_1 = 3
	end

	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = manager.time:DescCdTime3(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_3_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_3_0, manager.story.WIN, function()
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
		end
	else
		function BattleCallLuaCallBack()
			local var_5_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_5_0, manager.story.LOSE, function()
				manager.story:RemovePlayer()
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = arg_2_2,
					starMissionData = arg_2_3,
					battleResult = arg_2_4,
					isHalfWay_ = arg_2_0.tempData.isHalfWay_
				})
				EndBattleLogic(arg_2_1)
			end, false)
		end
	end
end

return var_0_0
