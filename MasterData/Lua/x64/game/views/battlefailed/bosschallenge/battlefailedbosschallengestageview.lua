NewBattleChallengeFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local BattleFailedBossChallengeStageView = class("BattleFailedBossChallengeStageView", NewBattleChallengeFailedWithButtonView)

function BattleFailedBossChallengeStageView:OnEnter()
	BattleFailedBossChallengeStageView.super.OnEnter(self)
end

function BattleFailedBossChallengeStageView:OnExit()
	BattleFailedBossChallengeStageView.super.OnExit(self)
end

function BattleFailedBossChallengeStageView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:QuitUI()
	end, 20, 1)

	self.timer_:Start()
end

function BattleFailedBossChallengeStageView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return BattleFailedBossChallengeStageView
