local var_0_0 = class("GotoEatGodStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoEatGodStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoEatGodStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	function BattleCallLuaCallBack()
		if isSuccess(arg_2_1) then
			local var_3_0 = GetResultReward()
			local var_3_1 = arg_2_2:GetStageId()

			if BattleGodEaterDailyMonsterCfg[var_3_1].sub_type == 2 then
				DailyMonsterData:UpdateStagePass(var_3_1)
			end

			JumpTools.OpenPageByJump("/battleEatGodResultView", {
				result = arg_2_1,
				rewardList = var_3_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedWithButton", {
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		end

		EndBattleLogic(arg_2_1)
	end
end

return var_0_0
