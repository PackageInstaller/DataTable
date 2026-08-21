local var_0_0 = class("GotoActivityWaterCooperationStage", BattleCooperationSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult

	arg_1_0:GotoCooperationResult(var_1_0, var_1_1, var_1_2, var_1_3)
end

function var_0_0.GotoCooperationResult(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if isSuccess(arg_2_1) then
		local var_2_0 = arg_2_0:GetResultReward()

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
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2)
	end
end

return var_0_0
