local GotoActivityHeroEnhanceStage = class("GotoActivityHeroEnhanceStage", BattleSettlementStrategyBase)

function GotoActivityHeroEnhanceStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_3 = arg_1_1.battleResult

	if isSuccess(arg_1_1.num) then
		ActivityHeroEnhanceData:AddClearedStage(arg_1_1.stageData:GetActivityID(), arg_1_1.stageData:GetStageId())
	end

	local var_1_4, var_1_5 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_1_1.num) and function()
		manager.story:CheckBattleStory(var_1_1:GetStageId(), manager.story.WIN, function()
			gameContext:Go("/activityHeroEnhanceBattleResult", {
				noOnceMore = true,
				stageData = var_1_1,
				rewardList = var_1_5,
				battleResult = var_1_3
			})
			manager.story:RemovePlayer()
			EndBattleLogic(var_1_0)
		end)
	end or function()
		manager.story:CheckBattleStory(var_1_1:GetStageId(), manager.story.LOSE, function()
			JumpTools.OpenPageByJump("/activityHeroEnhanceBattleFailView", {
				stageData = var_1_1,
				battleResult = var_1_3
			})
			manager.story:RemovePlayer()
			EndBattleLogic(var_1_0)
		end)
	end
end

return GotoActivityHeroEnhanceStage
