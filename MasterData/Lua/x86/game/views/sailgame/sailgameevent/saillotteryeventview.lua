local SailBattleEventView = class("SailBattleEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailBattleEventView:AcceptEvent()
	JumpTools.OpenPageByJump("/sailLotteryGame", {
		activityID = self.activityID_,
		stageIndex = self.stageIndex_
	})
end

function SailBattleEventView:RefreshReward()
	SetActive(self.rewardPanelGo_, false)
end

return SailBattleEventView
