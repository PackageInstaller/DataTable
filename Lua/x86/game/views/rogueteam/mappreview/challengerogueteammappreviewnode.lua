ChallengeRogueTeamMapBaseView = import("game.views.rogueTeam.main.map.ChallengeRogueTeamMapBaseView")

local var_0_0 = class("ChallengeRogueTeamMapPreviewNode", ChallengeRogueTeamMapBaseView)

function var_0_0.GetNodeClass(arg_1_0)
	return ChallengeRogueTeamMapPreviewNodeItem
end

function var_0_0.OnEnterOver(arg_2_0)
	var_0_0.super.OnEnterOver(arg_2_0)

	arg_2_0.scrollView_.enabled = true
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.openSectionInfoFlag_ = true

	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0.scrollView_.onValueChanged:RemoveAllListeners()
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshItemList()
end

function var_0_0.IsOpenSectionInfo(arg_7_0)
	return arg_7_0.openSectionInfoFlag_
end

function var_0_0.SetOpenSectionInfoFlag(arg_8_0, arg_8_1)
	arg_8_0.openSectionInfoFlag_ = arg_8_1
end

return var_0_0
