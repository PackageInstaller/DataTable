ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")

local var_0_0 = class("ActivityInfinityPoolFactoryView", ActivityInfinityPoolBaseView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/MardukUI/catMatch/MardukInfinitypoolUI"
end

function var_0_0.GetInfinityPoolItem(arg_2_0)
	return ActivityInfinityPoolFactoryItem
end

function var_0_0.ClickRewardPreview(arg_3_0)
	JumpTools.OpenPageByJump("infinityRewardPreviewFactory", {
		poolID = arg_3_0.poolID_
	})
end

function var_0_0.RefreshUI(arg_4_0)
	var_0_0.super.RefreshUI(arg_4_0)

	arg_4_0.phaseText_.text = GetTips(string.format("PHASE_%s", arg_4_0.phase_))
end

function var_0_0.GetRewardItem(arg_5_0, arg_5_1)
	return RewardPoolFactoryItem.New(arg_5_0.goMainReward_, arg_5_1, true)
end

return var_0_0
