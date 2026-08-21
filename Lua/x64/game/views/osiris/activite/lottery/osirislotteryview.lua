ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")

local var_0_0 = class("OsirisLotteryView", ActivityInfinityPoolBaseView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function var_0_0.GetInfinityPoolItem(arg_2_0)
	return OsirisLotteryItem
end

function var_0_0.ClickRewardPreview(arg_3_0)
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = arg_3_0.poolID_
	})
end

return var_0_0
