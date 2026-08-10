local var_0_0 = import("game.views.battleResult.newBattleSettlement.module.BattleSettlementMissionModule")
local var_0_1 = class("MatrixBattleSettlementMissionModule", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/System/MatrixlUI/BattleResultMatrixContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

return var_0_1
