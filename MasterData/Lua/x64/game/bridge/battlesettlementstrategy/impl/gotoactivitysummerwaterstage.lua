local GotoActivitySummerWaterStage = class("GotoActivitySummerWaterStage", BattleSettlementStrategyBase)

function GotoActivitySummerWaterStage:OnGotoSettlement(arg_1_1)
	function BattleCallLuaCallBack()
		if isSuccess(arg_1_1.num) then
			JumpTools.OpenPageByJump("/summerWaterBattleResult", {
				result = arg_1_1.num,
				rewardList = GetResultReward(),
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

return GotoActivitySummerWaterStage
