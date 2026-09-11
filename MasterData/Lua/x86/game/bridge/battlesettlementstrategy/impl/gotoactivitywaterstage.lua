local GotoActivityWaterStage = class("GotoActivityWaterStage", BattleSettlementStrategyBase)

function GotoActivityWaterStage:OnGotoSettlement(arg_1_1)
	self:GotoActivityWaterStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoActivityWaterStage:GotoActivityWaterStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		JumpTools.OpenPageByJump("/xH3rdWaterSettlementView", {
			result = arg_2_1,
			rewardList = var_2_0,
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.LOSE, function()
			gameContext:Go("/xH3rdWaterBattleFailed", {
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_2_1)
		end)
	end
end

return GotoActivityWaterStage
