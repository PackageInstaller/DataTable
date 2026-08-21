ActivityInfinityPoolRewardPreviewBaseItem = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseItem")

local var_0_0 = class("ActivityInfinityPoolRewardPreviewItem", ActivityInfinityPoolRewardPreviewBaseItem)

function var_0_0.GetRewardItem(arg_1_0, arg_1_1)
	return RewardPoolFactoryItem.New(arg_1_0.commonParent_, arg_1_1, true)
end

return var_0_0
