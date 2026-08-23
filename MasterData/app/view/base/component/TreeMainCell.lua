local TreeMainCell = class("TreeMainCell", require("app.fairyGUI.base_new.UI_BaseTreeCell"))

function TreeMainCell:ctor()
	return
end

function TreeMainCell:updateTreeCell(arg_2_1, arg_2_2)
	self:setTitle(arg_2_1:getElem():getTitle())

	if arg_2_1:isOpen() then
		self.m_signController:setSelectedIndex(1)
	else
		self.m_signController:setSelectedIndex(0)
	end
end

return TreeMainCell
