local GotoActivityWaterCooperationStage = class("GotoActivityWaterCooperationStage", BattleCooperationSettlementStrategyBase)

function GotoActivityWaterCooperationStage:OnGotoSettlement(arg_1_1)
	self:GotoCooperationResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoActivityWaterCooperationStage:GotoCooperationResult(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if isSuccess(arg_2_1) then
		local var_2_0 = self:GetResultReward()

		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/summerWaterBattleResult", {
				result = arg_2_1,
				rewardList = var_2_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2)
	end
end

return GotoActivityWaterCooperationStage
