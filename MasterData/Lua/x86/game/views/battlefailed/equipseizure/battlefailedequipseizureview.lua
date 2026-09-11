BattleFailedView = import("game.views.battleFailed.BattleFailedView")

local BattleFailedEquipSeizureView = class("BattleFailedEquipSeizureView", BattleFailedView)

function BattleFailedEquipSeizureView:OnEnter()
	BattleFailedEquipSeizureView.super.OnEnter(self)
	self:AddTimer()
end

function BattleFailedEquipSeizureView:OnExit()
	BattleFailedEquipSeizureView.super.OnExit(self)
	self:StopTimer()
end

function BattleFailedEquipSeizureView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:Quit()
	end, 20, 1)

	self.timer_:Start()
end

function BattleFailedEquipSeizureView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BattleFailedEquipSeizureView:QuitUI()
	gameContext:Go("/battleScorResult", {
		stageData = self.params_.stageData,
		rewardList = self.params_.rewardList,
		score = self.params_.score,
		battleResult = self.params_.battleResult
	})
end

return BattleFailedEquipSeizureView
