ActivityInfinityPoolRewardPreviewBaseView = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseView")

local SnowBallInfinityRewardView = class("SnowBallInfinityRewardView", ActivityInfinityPoolRewardPreviewBaseView)

function SnowBallInfinityRewardView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballRewardPopUI"
end

function SnowBallInfinityRewardView:GetRewardPreviewItem()
	return OsirisRewardPreviewItem
end

return SnowBallInfinityRewardView
