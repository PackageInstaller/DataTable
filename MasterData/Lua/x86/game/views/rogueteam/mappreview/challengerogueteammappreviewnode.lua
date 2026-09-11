ChallengeRogueTeamMapBaseView = import("game.views.rogueTeam.main.map.ChallengeRogueTeamMapBaseView")

local ChallengeRogueTeamMapPreviewNode = class("ChallengeRogueTeamMapPreviewNode", ChallengeRogueTeamMapBaseView)

function ChallengeRogueTeamMapPreviewNode:GetNodeClass()
	return ChallengeRogueTeamMapPreviewNodeItem
end

function ChallengeRogueTeamMapPreviewNode:OnEnterOver()
	ChallengeRogueTeamMapPreviewNode.super.OnEnterOver(self)

	self.scrollView_.enabled = true
end

function ChallengeRogueTeamMapPreviewNode:OnEnter()
	self.openSectionInfoFlag_ = true

	ChallengeRogueTeamMapPreviewNode.super.OnEnter(self)
	self.scrollView_.onValueChanged:RemoveAllListeners()
end

function ChallengeRogueTeamMapPreviewNode:OnExit()
	ChallengeRogueTeamMapPreviewNode.super.OnExit(self)
end

function ChallengeRogueTeamMapPreviewNode:Dispose()
	ChallengeRogueTeamMapPreviewNode.super.Dispose(self)
end

function ChallengeRogueTeamMapPreviewNode:RefreshUI()
	self:RefreshItemList()
end

function ChallengeRogueTeamMapPreviewNode:IsOpenSectionInfo()
	return self.openSectionInfoFlag_
end

function ChallengeRogueTeamMapPreviewNode:SetOpenSectionInfoFlag(arg_8_1)
	self.openSectionInfoFlag_ = arg_8_1
end

return ChallengeRogueTeamMapPreviewNode
