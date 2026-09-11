ChallengeRogueTeamPathBaseNode = import("game.views.rogueTeam.main.node.ChallengeRogueTeamPathBaseNode")

local ChallengeRogueTeamMapReplaceNodeItem = class("ChallengeRogueTeamMapReplaceNodeItem", ChallengeRogueTeamPathBaseNode)

function ChallengeRogueTeamMapReplaceNodeItem:SetFollowNodeIDList(arg_1_1)
	self.followNodeIDList_ = arg_1_1
end

function ChallengeRogueTeamMapReplaceNodeItem:RefreshState(arg_2_1)
	if ChallengeRogueTeamData:PathGetSelectedNodeID() == self.id_ then
		self.isActiveController_:SetSelectedState("already")
	elseif arg_2_1 == ChallengeRogueTeamConst.NODE_STATE.CLEAN then
		self.isActiveController_:SetSelectedState("already")
	elseif ChallengeRogueTeamTools.IsCanReplaceNode(self.id_, self.followNodeIDList_) then
		self.isActiveController_:SetSelectedState("await")
	else
		self.isActiveController_:SetSelectedState("not")
	end
end

function ChallengeRogueTeamMapReplaceNodeItem:OnClickItem()
	if ChallengeRogueTeamTools.IsCanReplaceNode(self.id_, self.followNodeIDList_) then
		JumpTools.OpenPageByJump("challengeRogueTeamReplaceNodePop", {
			selectNodeID = self.id_
		})
	end
end

return ChallengeRogueTeamMapReplaceNodeItem
