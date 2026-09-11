local GotoCoreVerificationStage = class("GotoCoreVerificationStage", BattleSettlementStrategyBase)

function GotoCoreVerificationStage:OnGotoSettlement(arg_1_1)
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
				isHalfWay_ = self.tempData.isHalfWay_
			})
		end

		EndBattleLogic(arg_1_1.num)
	end
end

return GotoCoreVerificationStage
