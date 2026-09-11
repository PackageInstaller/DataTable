local GotoActivitySwimsuitStage = class("GotoActivitySwimsuitStage", BattleSettlementStrategyBase)

function GotoActivitySwimsuitStage:OnGotoSettlement(arg_1_1)
	function BattleCallLuaCallBack()
		if isSuccess(arg_1_1.num) then
			local var_2_0 = GetResultReward()

			if #var_2_0 > 0 then
				SwimsuitBattleData:UpdateTicketNumAfterBattle(var_2_0[1][2])
			end

			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_1_1.num,
				rewardList = var_2_0,
				stageData = arg_1_1.stageData,
				starMissionData = arg_1_1.starMissionData,
				battleResult = arg_1_1.battleResult
			})
		else
			JumpTools.OpenPageByJump("/battlefailedWithButton", {
				stageData = arg_1_1.stageData,
				starMissionData = arg_1_1.starMissionData,
				battleResult = arg_1_1.battleResult,
				isHalfWay_ = self.tempData.isHalfWay_
			})
		end
	end
end

return GotoActivitySwimsuitStage
