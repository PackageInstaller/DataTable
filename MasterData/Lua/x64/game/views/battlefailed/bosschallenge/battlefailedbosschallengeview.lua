NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local BattleFailedBossChallengeView = class("BattleFailedBossChallengeView", NewBattleFailedWithButtonView)

function BattleFailedBossChallengeView:OnEnter()
	BattleFailedBossChallengeView.super.OnEnter(self)
end

function BattleFailedBossChallengeView:OnExit()
	BattleFailedBossChallengeView.super.OnExit(self)
end

function BattleFailedBossChallengeView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:QuitUI()
	end, 20, 1)

	self.timer_:Start()
end

function BattleFailedBossChallengeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return BattleFailedBossChallengeView
