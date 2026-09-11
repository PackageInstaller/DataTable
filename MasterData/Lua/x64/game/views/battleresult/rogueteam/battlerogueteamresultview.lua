NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleRogueTeamResultView = class("BattleRogueTeamResultView", NewBattleSettlementView)

function BattleRogueTeamResultView:InitUI()
	BattleRogueTeamResultView.super.InitUI(self)

	self.panelView_ = BattleRogueTeamResultDropPanel.New(self.rogueTeamPanel_)

	SetActive(self.contentContainer_.gameObject, false)
end

function BattleRogueTeamResultView:OnEnter()
	BattleRogueTeamResultView.super.OnEnter(self)
	self.panelView_:OnEnter()
end

function BattleRogueTeamResultView:Dispose()
	self.panelView_:Dispose()

	self.panelView_ = nil

	BattleRogueTeamResultView.super.Dispose(self)
end

return BattleRogueTeamResultView
