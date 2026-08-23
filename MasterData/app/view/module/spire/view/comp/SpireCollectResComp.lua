local SpireCollectResComp = class("SpireCollectResComp", require("app.fairyGUI.spire.UI_SpireCollectResComp"))

function SpireCollectResComp:ctor()
	return
end

function SpireCollectResComp:updateComp(arg_2_1, arg_2_2)
	if not arg_2_1 then
		self.m_showTypeController:setSelectedIndex(2)

		return
	end

	self.m_showTypeController:setSelectedIndex(arg_2_2 and 0 or 1)
	self.m_itemLoader:setURL(g.core.common.Goods:convert({
		size = 0,
		type = arg_2_1.type,
		value = arg_2_1.value
	}).icon_mini or "")
	self.m_addSize:setText(g.core.lang:get(308021, {
		addNum = arg_2_1.addSize
	}))
	self.m_addTime:setText(g.core.lang:get(432016, {
		onceTime = arg_2_1.onceTime / 3600
	}))
end

return SpireCollectResComp
