local RoleSkinCostIcon = class("RoleSkinCostIcon", require("app.fairyGUI.roleSkin.UI_RoleSkinCostIcon"))

function RoleSkinCostIcon:updateIcon(arg_1_1)
	self.m_costIcon:updateIcon(arg_1_1)
	self.m_numText:setText(arg_1_1.numCost)
	self.m_isEnoughController:setSelectedIndex(arg_1_1.numCost <= arg_1_1.size and 1 or 0)
end

return RoleSkinCostIcon
