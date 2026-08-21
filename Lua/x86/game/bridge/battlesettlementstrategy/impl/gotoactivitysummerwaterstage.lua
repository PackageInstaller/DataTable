local var_0_0 = class("GotoActivitySummerWaterStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	function BattleCallLuaCallBack()
		if isSuccess(arg_1_1.num) then
			local var_2_0 = GetResultReward()

			JumpTools.OpenPageByJump("/summerWaterBattleResult", {
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
				isHalfWay_ = arg_1_0.tempData.isHalfWay_
			})
		end
	end
end

return var_0_0
