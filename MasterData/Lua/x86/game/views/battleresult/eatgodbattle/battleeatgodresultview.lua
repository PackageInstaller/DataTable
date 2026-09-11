NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleEatGodResultView = class("BattleEatGodResultView", NewBattleSettlementView)

function BattleEatGodResultView:OnEnter()
	BattleEatGodResultView.super.OnEnter(self)

	self.missionView.awardDesc.text = GetTips("BATTLE_DROP")
end

return BattleEatGodResultView
