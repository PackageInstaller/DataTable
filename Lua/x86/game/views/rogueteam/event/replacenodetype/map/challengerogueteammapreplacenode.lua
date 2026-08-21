ChallengeRogueTeamMapBaseView = import("game.views.rogueTeam.main.map.ChallengeRogueTeamMapBaseView")

local var_0_0 = class("ChallengeRogueTeamMapReplaceNode", ChallengeRogueTeamMapBaseView)

function var_0_0.GetNodeClass(arg_1_0)
	return ChallengeRogueTeamMapReplaceNodeItem
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	arg_2_0.nodeIDList_ = ChallengeRogueTeamTools.GetFollowNodeIDList()
end

function var_0_0.RefreshItem(arg_3_0, arg_3_1)
	arg_3_1:SetFollowNodeIDList(arg_3_0.nodeIDList_)
	arg_3_1:RefreshUI()
end

return var_0_0
