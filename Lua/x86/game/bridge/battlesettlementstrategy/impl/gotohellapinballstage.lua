local var_0_0 = class("GotoHellaPinballStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoHellaPinballStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoHellaPinballStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("pinballBattleSettlement", {
				isSuccess = true,
				stageData = arg_2_2
			})
			EndBattleLogic(arg_2_1)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("pinballBattleSettlement", {
				isSuccess = false,
				stageData = arg_2_2
			})
			EndBattleLogic(arg_2_1)
		end
	end
end

return var_0_0
