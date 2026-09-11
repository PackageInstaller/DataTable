NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleSPKaliChallengeResultView = class("BattleSPKaliChallengeResultView", NewBattleSettlementView)

function BattleSPKaliChallengeResultView:OnEnter()
	BattleSPKaliChallengeResultView.super.OnEnter(self)

	self.missionView.awardDesc.text = GetTips("ACTIVITY_HERO_CHALLENGE_AWARD_TIP")
end

return BattleSPKaliChallengeResultView
