local var_0_0 = g.core.common.Goods
local TowerResComp = class("TowerResComp", require("app.fairyGUI.tower.UI_TowerResComp"))

function TowerResComp:update(arg_1_1, arg_1_2)
	if not arg_1_1 then
		self.m_showTypeController:setSelectedIndex(2)

		return
	end

	self.m_showTypeController:setSelectedIndex(arg_1_2 and 0 or 1)
	self.m_itemLoader:setURL(var_0_0:convert({
		size = 0,
		type = arg_1_1.type,
		value = arg_1_1.value
	}).icon_mini or "")
	self.m_addSize:setText(g.core.lang:get(308021, {
		addNum = arg_1_1.addSize
	}))
	self.m_addTime:setText(g.core.lang:get(308020, {
		onceTime = arg_1_1.onceTime
	}))
end

return TowerResComp
