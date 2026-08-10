local var_0_0 = class("SoloChallengeRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, arg_4_0:GetRewardItemClass())
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshLevelName()
	arg_8_0:RefreshScroll()
end

function var_0_0.RefreshLevelName(arg_9_0)
	arg_9_0.levelNameText_.text = GetI18NText(ActivitySoloChallengeCfg[arg_9_0.activityID_].name)
end

function var_0_0.RefreshScroll(arg_10_0)
	arg_10_0.scrollHelper_:StartScroll(arg_10_0:GetAwardListLength())
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshData({
		activityID = arg_11_0.activityID_,
		difficultyIndex = arg_11_1
	})
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.GetAwardListLength(arg_13_0)
	return #ActivitySoloChallengeCfg[arg_13_0.activityID_].reward_item_list
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
	arg_14_0.scrollHelper_:Dispose()
end

function var_0_0.GetRewardItemClass(arg_15_0)
	return SoloChallengeRewardItem
end

return var_0_0
