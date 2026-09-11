ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")

local OsirisLotteryView = class("OsirisLotteryView", ActivityInfinityPoolBaseView)

function OsirisLotteryView:GetAssetName()
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function OsirisLotteryView:GetInfinityPoolItem()
	return OsirisLotteryItem
end

function OsirisLotteryView:ClickRewardPreview()
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = self.poolID_
	})
end

return OsirisLotteryView
