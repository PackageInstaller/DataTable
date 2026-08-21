NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleEatGodResultView", NewBattleSettlementView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.missionView.awardDesc.text = GetTips("BATTLE_DROP")
end

return var_0_0
