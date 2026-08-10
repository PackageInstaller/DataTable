local var_0_0 = import("game.views.soloChallenge.SoloChallengeSelectView")
local var_0_1 = class("FactorySoloChallengeSelectView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBattleTeamUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.scrollView_, FactorySoloChallengeSelectItem)
	arg_2_0.goBackHandler_ = handler(arg_2_0, arg_2_0.OnGoBack)
end

function var_0_1.UpdateBar(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_3_0.goBackHandler_)
end

function var_0_1.OnResetData(arg_4_0, arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		SoloChallengeData:ResetLockData(arg_4_2)

		local var_4_0 = ActivitySoloChallengeCfg[arg_4_0.activityID_].main_activity_id

		JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
			activityID = var_4_0
		})
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_1.OnGoBack(arg_5_0)
	local var_5_0 = ActivitySoloChallengeCfg[arg_5_0.activityID_].main_activity_id

	JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
		activityID = var_5_0
	})
	JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
		activityID = arg_5_0.activityID_
	})
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0.goBackHandler_ = nil

	var_0_1.super.Dispose(arg_6_0)
end

return var_0_1
