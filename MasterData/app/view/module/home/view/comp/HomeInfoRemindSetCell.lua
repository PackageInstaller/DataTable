local HomeInfoRemindSetCell = class("HomeInfoRemindSetCell", require("app.fairyGUI.home.UI_HomeInfoRemindSetCell"))

function HomeInfoRemindSetCell:ctor()
	self._data = nil

	self.m_checkBtn:addClickListener(handler(self, self._onClickCheck))
end

function HomeInfoRemindSetCell:updateCell(arg_2_1)
	self.m_title:setText(g.core.lang:get(429551, {
		name = g.core.config.function_info.get(arg_2_1.functionId).name
	}))
	self.m_checkBtn:setSelected(arg_2_1.selected)

	self._data = arg_2_1
end

function HomeInfoRemindSetCell:_onClickCheck()
	self._data.selected = not self._data.selected
end

return HomeInfoRemindSetCell
