local var_0_0 = class("GotoActivityHeroEnhanceStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = var_1_1:GetActivityID()

	if isSuccess(var_1_0) then
		ActivityHeroEnhanceData:AddClearedStage(var_1_4, var_1_1:GetStageId())
	end

	local var_1_5, var_1_6 = GetResultReward()

	if isSuccess(var_1_0) then
		function BattleCallLuaCallBack()
			local var_2_0 = var_1_1:GetStageId()

			manager.story:CheckBattleStory(var_2_0, manager.story.WIN, function()
				gameContext:Go("/activityHeroEnhanceBattleResult", {
					noOnceMore = true,
					stageData = var_1_1,
					rewardList = var_1_6,
					battleResult = var_1_3
				})
				manager.story:RemovePlayer()
				EndBattleLogic(var_1_0)
			end)
		end
	else
		function BattleCallLuaCallBack()
			local var_4_0 = var_1_1:GetStageId()

			manager.story:CheckBattleStory(var_4_0, manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/activityHeroEnhanceBattleFailView", {
					stageData = var_1_1,
					battleResult = var_1_3
				})
				manager.story:RemovePlayer()
				EndBattleLogic(var_1_0)
			end)
		end
	end
end

return var_0_0
