local var_0_0 = class("GotoCoreVerificationStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	function BattleCallLuaCallBack()
		if isSuccess(arg_1_1.num) then
			JumpTools.OpenPageByJump("/coreVerificationBattleResult", {
				result = arg_1_1.num,
				rewardList = {},
				stageData = arg_1_1.stageData,
				starMissionData = arg_1_1.starMissionData,
				battleResult = arg_1_1.battleResult
			})
		else
			JumpTools.OpenPageByJump("/battleCoreVerificationFailed", {
				stageData = arg_1_1.stageData,
				starMissionData = arg_1_1.starMissionData,
				battleResult = arg_1_1.battleResult,
				isHalfWay_ = arg_1_0.tempData.isHalfWay_
			})
		end

		EndBattleLogic(arg_1_1.num)
	end
end

return var_0_0
