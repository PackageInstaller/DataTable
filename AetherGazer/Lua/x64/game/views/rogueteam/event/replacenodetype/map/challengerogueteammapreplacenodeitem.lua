ChallengeRogueTeamPathBaseNode = import("game.views.rogueTeam.main.node.ChallengeRogueTeamPathBaseNode")

local var_0_0 = class("ChallengeRogueTeamMapReplaceNodeItem", ChallengeRogueTeamPathBaseNode)

function var_0_0.SetFollowNodeIDList(arg_1_0, arg_1_1)
	arg_1_0.followNodeIDList_ = arg_1_1
end

function var_0_0.RefreshState(arg_2_0, arg_2_1)
	if ChallengeRogueTeamData:PathGetSelectedNodeID() == arg_2_0.id_ then
		arg_2_0.isActiveController_:SetSelectedState("already")
	elseif arg_2_1 == ChallengeRogueTeamConst.NODE_STATE.CLEAN then
		arg_2_0.isActiveController_:SetSelectedState("already")
	elseif ChallengeRogueTeamTools.IsCanReplaceNode(arg_2_0.id_, arg_2_0.followNodeIDList_) then
		arg_2_0.isActiveController_:SetSelectedState("await")
	else
		arg_2_0.isActiveController_:SetSelectedState("not")
	end
end

function var_0_0.OnClickItem(arg_3_0)
	if ChallengeRogueTeamTools.IsCanReplaceNode(arg_3_0.id_, arg_3_0.followNodeIDList_) then
		JumpTools.OpenPageByJump("challengeRogueTeamReplaceNodePop", {
			selectNodeID = arg_3_0.id_
		})
	end
end

return var_0_0
