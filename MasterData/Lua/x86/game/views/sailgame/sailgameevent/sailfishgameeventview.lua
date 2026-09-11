local SailFishGameEventView = class("SailFishGameEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailFishGameEventView:AcceptEvent()
	JumpTools.OpenPageByJump("/sailFishingGame", {
		activityID = self.activityID_,
		stageIndex = self.stageIndex
	})
end

function SailFishGameEventView:RefreshReward()
	SetActive(self.rewardPanelGo_, false)
end

return SailFishGameEventView
