local ActivityToggleSpecialRewardConditionItemView = class("ActivityToggleSpecialRewardConditionItemView", (import("game.views.mardukSpecial.items.MardukSpecialRewardConditionItemView")))

function ActivityToggleSpecialRewardConditionItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, CommonItem)
end

function ActivityToggleSpecialRewardConditionItemView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:RefreshData(formatReward(self.cfg_.reward_item_list[arg_2_1]))
	arg_2_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, self.cfg_.reward_item_list[arg_2_1])
	end)
end

return ActivityToggleSpecialRewardConditionItemView
