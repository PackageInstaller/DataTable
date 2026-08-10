local var_0_0 = import("game.views.soloChallenge.Factory.FactorySoloChallengeSelectView")
local var_0_1 = class("SoloChallengeSelectView_1_7", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeConfigUI"
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)

	arg_2_0.activityID_ = arg_2_0.params_.activityID
	arg_2_0.difficultyIndex_ = arg_2_0.params_.difficultyIndex
	arg_2_0.stageList_ = ActivitySoloChallengeCfg[arg_2_0.activityID_].stage_id[arg_2_0.difficultyIndex_][2]

	arg_2_0:SetDefaultCustom()
end

function var_0_1.SetDefaultCustom(arg_3_0)
	return
end

function var_0_1.OnResetData(arg_4_0, arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		SoloChallengeData:ResetLockData(arg_4_2)

		local var_4_0 = ActivitySoloChallengeCfg[arg_4_0.activityID_].main_activity_id

		JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
			activityID = var_4_0
		})
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_1.OnGoBack(arg_5_0)
	local var_5_0 = ActivitySoloChallengeCfg[arg_5_0.activityID_].main_activity_id

	JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
		activityID = var_5_0
	})
end

return var_0_1
