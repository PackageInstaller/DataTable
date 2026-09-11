local ActivityToggleSpecialRewardItemView = class("ActivityToggleSpecialRewardItemView", (import("game.views.mardukSpecial.items.MardukSpecialRewardItemView")))

function ActivityToggleSpecialRewardItemView:InitUI()
	self:BindCfgUI()

	self.items_ = {
		ActivityToggleSpecialRewardConditionItemView.New(self.itemGo1_),
		ActivityToggleSpecialRewardConditionItemView.New(self.itemGo2_),
		ActivityToggleSpecialRewardConditionItemView.New(self.itemGo3_)
	}
end

return ActivityToggleSpecialRewardItemView
