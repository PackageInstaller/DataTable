local ActivityGachaARewardComp = class("ActivityGachaARewardComp", require("app.fairyGUI.activity.UI_ActivityGachaARewardComp"))

function ActivityGachaARewardComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._renderItem))
end

function ActivityGachaARewardComp:updateGachaARewardComp(arg_2_1)
	self._items = arg_2_1

	self.m_rewardList:setNumItems(#arg_2_1)
end

function ActivityGachaARewardComp:_renderItem(arg_3_1, arg_3_2)
	arg_3_2:updateGachaARewardCell(self._items[arg_3_1 + 1])
end

return ActivityGachaARewardComp
