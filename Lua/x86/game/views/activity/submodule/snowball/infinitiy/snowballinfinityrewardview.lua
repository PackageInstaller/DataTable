ActivityInfinityPoolRewardPreviewBaseView = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseView")

local var_0_0 = class("SnowBallInfinityRewardView", ActivityInfinityPoolRewardPreviewBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballRewardPopUI"
end

function var_0_0.GetRewardPreviewItem(arg_2_0)
	return OsirisRewardPreviewItem
end

return var_0_0
