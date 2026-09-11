NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleSPHeroChallengeResultView = class("BattleSPHeroChallengeResultView", NewBattleSettlementView)

function BattleSPHeroChallengeResultView:OnEnter()
	BattleSPHeroChallengeResultView.super.OnEnter(self)

	self.missionView.awardDesc.text = GetTips("ACTIVITY_HERO_CHALLENGE_AWARD_TIP")
end

return BattleSPHeroChallengeResultView
