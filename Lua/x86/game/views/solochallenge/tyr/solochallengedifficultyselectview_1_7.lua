local var_0_0 = import("game.views.soloChallenge.SoloChallengeDifficultySelectView")
local var_0_1 = class("SoloChallengeDifficultySelectView_1_7", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeDifficultyUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "selectDifficulty")
end

function var_0_1.OnSelectItem(arg_3_0, arg_3_1)
	arg_3_0.difficultyIndex_ = arg_3_1

	SoloChallengeData:SetSelectedDifficultyIndex(arg_3_0.activityID_, arg_3_0.difficultyIndex_)
	arg_3_0.selectController_:SetSelectedState(tostring(arg_3_0.difficultyIndex_))
end

function var_0_1.RefreshUI(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.difficultyItemList_) do
		iter_4_1:SetData(arg_4_0.activityID_, iter_4_0)
	end

	arg_4_0.selectController_:SetSelectedState(tostring(arg_4_0.difficultyIndex_))
end

function var_0_1.OnStart(arg_5_0)
	SoloChallengeData:SetSelectedDifficultyIndex(arg_5_0.activityID_, arg_5_0.difficultyIndex_)
	arg_5_0:Go("/soloChallengeSelectView_1_7", {
		activityID = arg_5_0.activityID_,
		difficultyIndex = arg_5_0.difficultyIndex_
	})
end

return var_0_1
