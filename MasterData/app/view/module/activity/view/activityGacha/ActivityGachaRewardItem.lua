local var_0_0 = g.core.common.Goods
local ActivityGachaRewardItem = class("ActivityGachaRewardItem", require("app.fairyGUI.activity.UI_ActivityGachaRewardItem"))

function ActivityGachaRewardItem:ctor()
	self:addClickListener(handler(self, self._onDetailClick))
end

function ActivityGachaRewardItem:updateItem(arg_2_1)
	local var_2_0 = var_0_0:convert(arg_2_1.award)

	self._good = var_2_0

	self.m_qualityLoader:setURL("ui://activity/pic_ljs_pinzhi_2")
	self.m_itemLoader:setURL(var_2_0.icon)
	self.m_numTxt:setText("x" .. var_2_0.size)

	if arg_2_1.lastNum <= 0 then
		self.m_allGetController:setSelectedIndex(1)
		self.m_itemLoader:setColor(cc.c3b(100, 100, 100))
	else
		self.m_allGetController:setSelectedIndex(0)
		self.m_itemLoader:setColor(cc.c3b(255, 255, 255))
	end
end

function ActivityGachaRewardItem:_onDetailClick()
	if not self._good then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop(self._good)
end

return ActivityGachaRewardItem
