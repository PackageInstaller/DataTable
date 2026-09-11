ActivityInfinityPoolBaseItem = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseItem")

local ActivityInfinityPoolFactoryItem = class("ActivityInfinityPoolFactoryItem", ActivityInfinityPoolBaseItem)

function ActivityInfinityPoolFactoryItem:Ctor(...)
	ActivityInfinityPoolFactoryItem.super.Ctor(self, ...)

	self.unLockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function ActivityInfinityPoolFactoryItem:RefreshUI()
	ActivityInfinityPoolFactoryItem.super.RefreshUI(self)
	self:RefreshRewardPanel()
end

function ActivityInfinityPoolFactoryItem:RefreshRewardPanel()
	if OsirisInfinityPoolData:GetPoolData(self.poolID_).openBoxList[self.index_] then
		self.unLockController_:SetSelectedState("on")
	else
		self.unLockController_:SetSelectedState("off")
	end
end

function ActivityInfinityPoolFactoryItem:GetRewardItem(arg_4_1)
	return RewardPoolFactoryItem.New(self.goItemParent_, arg_4_1, true)
end

return ActivityInfinityPoolFactoryItem
