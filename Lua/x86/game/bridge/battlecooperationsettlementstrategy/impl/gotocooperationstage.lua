local var_0_0 = class("GotoCooperationStage", BattleCooperationSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoCooperationResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

return var_0_0
