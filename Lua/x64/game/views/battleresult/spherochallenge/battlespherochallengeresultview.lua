NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleSPHeroChallengeResultView", NewBattleSettlementView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.missionView.awardDesc.text = GetTips("ACTIVITY_HERO_CHALLENGE_AWARD_TIP")
end

return var_0_0
