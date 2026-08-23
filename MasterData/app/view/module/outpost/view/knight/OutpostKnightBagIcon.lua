local OutpostKnightBagIcon = class("OutpostKnightBagIcon", require("app.fairyGUI.outpost.UI_OutpostKnightBagIcon"))

function OutpostKnightBagIcon:ctor()
	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)
end

function OutpostKnightBagIcon:updateIcon(arg_2_1)
	if arg_2_1 then
		self.m_icon:updateItemIcon(arg_2_1)
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
	end
end

return OutpostKnightBagIcon
