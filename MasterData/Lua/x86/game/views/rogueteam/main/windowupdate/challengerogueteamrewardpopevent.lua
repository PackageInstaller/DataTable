local ChallengeRogueTeamRewardPopEvent = class("ChallengeRogueTeamRewardPopEvent")

function ChallengeRogueTeamRewardPopEvent:Ctor()
	self.CheckObtainDataHandler_ = handler(self, self.CheckObtainData)
end

function ChallengeRogueTeamRewardPopEvent:OnEnter()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATA_REWARD_WINDOW, self.CheckObtainDataHandler_)
end

function ChallengeRogueTeamRewardPopEvent:OnTop()
	self:CheckObtainData()
end

function ChallengeRogueTeamRewardPopEvent:OnExit()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATA_REWARD_WINDOW, self.CheckObtainDataHandler_)
end

function ChallengeRogueTeamRewardPopEvent:Dispose()
	self.CheckObtainDataHandler_ = nil
end

function ChallengeRogueTeamRewardPopEvent:CheckObtainData()
	ChallengeRogueTeamAction.TriggerPopWindow()
end

return ChallengeRogueTeamRewardPopEvent
