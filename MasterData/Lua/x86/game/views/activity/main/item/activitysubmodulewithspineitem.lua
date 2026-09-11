ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivitySubmoduleWithSpineItem = class("ActivitySubmoduleWithSpineItem", ActivitySubmoduleItem)

function ActivitySubmoduleWithSpineItem:InitUI()
	ActivitySubmoduleWithSpineItem.super.InitUI(self)

	self.spine_ = self.spineGo_.transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))
end

function ActivitySubmoduleWithSpineItem:RefreshLock()
	ActivitySubmoduleWithSpineItem.super.RefreshLock(self)

	self.spine_.color = (manager.time:GetServerTime() >= self.stopTime_ or manager.time:GetServerTime() < self.startTime_) and Color(0.7058823529411765, 0.6823529411764706, 0.6823529411764706) or Color(1, 1, 1)
end

return ActivitySubmoduleWithSpineItem
