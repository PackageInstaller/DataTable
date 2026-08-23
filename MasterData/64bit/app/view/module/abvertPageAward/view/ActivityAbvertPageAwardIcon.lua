local ActivityAbvertPageAwardIcon = class("ActivityAbvertPageAwardIcon", require("app.fairyGUI.activity.UI_ActivityAbvertPageAwardIcon"))

function ActivityAbvertPageAwardIcon:ctor()
	self._goods = {}

	self:addClickListener(handler(self, self._onClick))
end

function ActivityAbvertPageAwardIcon:updateAwardIcon(arg_2_1)
	self._goods = g.core.common.Goods:convert(arg_2_1)

	if self._goods then
		self:setIcon(self._goods.icon)
		self:setTitle(self._goods.name)
	end
end

function ActivityAbvertPageAwardIcon:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return ActivityAbvertPageAwardIcon
