ChallengeRogueTeamMapBaseView = import("game.views.rogueTeam.main.map.ChallengeRogueTeamMapBaseView")

local ChallengeRogueTeamMapReplaceNode = class("ChallengeRogueTeamMapReplaceNode", ChallengeRogueTeamMapBaseView)

function ChallengeRogueTeamMapReplaceNode:GetNodeClass()
	return ChallengeRogueTeamMapReplaceNodeItem
end

function ChallengeRogueTeamMapReplaceNode:OnEnter()
	ChallengeRogueTeamMapReplaceNode.super.OnEnter(self)

	self.nodeIDList_ = ChallengeRogueTeamTools.GetFollowNodeIDList()
end

function ChallengeRogueTeamMapReplaceNode:RefreshItem(arg_3_1)
	arg_3_1:SetFollowNodeIDList(self.nodeIDList_)
	arg_3_1:RefreshUI()
end

return ChallengeRogueTeamMapReplaceNode
