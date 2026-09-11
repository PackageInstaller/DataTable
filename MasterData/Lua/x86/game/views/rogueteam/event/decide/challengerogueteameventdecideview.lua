local ChallengeRogueTeamEventDecideView = class("ChallengeRogueTeamEventDecideView", ReduxView)

function ChallengeRogueTeamEventDecideView:UIName()
	return "Widget/System/Activity_Roulike/RogueDeterminePopUI"
end

function ChallengeRogueTeamEventDecideView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamEventDecideView:Init()
	return
end

function ChallengeRogueTeamEventDecideView:OnEnter()
	self:AddTimer()
end

function ChallengeRogueTeamEventDecideView:OnExit()
	self:StopTimer()
end

function ChallengeRogueTeamEventDecideView:Dispose()
	ChallengeRogueTeamEventDecideView.super.Dispose(self)
end

function ChallengeRogueTeamEventDecideView:AddListeners()
	return
end

function ChallengeRogueTeamEventDecideView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:DoNextStep()
	end, GameSetting.rogue_Team_event_decide_effect.value[1] / 1000, 1)

	self.timer_:Start()
end

function ChallengeRogueTeamEventDecideView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChallengeRogueTeamEventDecideView:DoNextStep()
	self:StopTimer()

	if self.params_.stageID ~= 0 then
		ChallengeRogueTeamAction.GotoRogueTeamEventReserve(self.params_.stageID, true)
	else
		self:Back()
	end
end

return ChallengeRogueTeamEventDecideView
