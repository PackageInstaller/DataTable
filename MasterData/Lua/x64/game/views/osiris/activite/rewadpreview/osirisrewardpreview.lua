ActivityInfinityPoolRewardPreviewBaseView = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseView")

local OsirisRewardPreview = class("OsirisRewardPreview", ActivityInfinityPoolRewardPreviewBaseView)

function OsirisRewardPreview:UIName()
	return "UI/VersionUI/OsirisUI/OsirisRewardUI"
end

function OsirisRewardPreview:GetRewardPreviewItem()
	return OsirisRewardPreviewItem
end

return OsirisRewardPreview
