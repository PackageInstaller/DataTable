ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")

local ActivityInfinityPoolFactoryView = class("ActivityInfinityPoolFactoryView", ActivityInfinityPoolBaseView)

function ActivityInfinityPoolFactoryView:GetAssetName()
	return "UI/MardukUI/catMatch/MardukInfinitypoolUI"
end

function ActivityInfinityPoolFactoryView:GetInfinityPoolItem()
	return ActivityInfinityPoolFactoryItem
end

function ActivityInfinityPoolFactoryView:ClickRewardPreview()
	JumpTools.OpenPageByJump("infinityRewardPreviewFactory", {
		poolID = self.poolID_
	})
end

function ActivityInfinityPoolFactoryView:RefreshUI()
	ActivityInfinityPoolFactoryView.super.RefreshUI(self)

	self.phaseText_.text = GetTips(string.format("PHASE_%s", self.phase_))
end

function ActivityInfinityPoolFactoryView:GetRewardItem(arg_5_1)
	return RewardPoolFactoryItem.New(self.goMainReward_, arg_5_1, true)
end

return ActivityInfinityPoolFactoryView
