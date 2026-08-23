local RichmanItemIcon = class("RichmanItemIcon", require("app.fairyGUI.richman.UI_RichmanItemIcon"))

function RichmanItemIcon:updateIcon(arg_1_1)
	self.m_icon:updateIcon(arg_1_1)
	self.m_chance:setVisible((arg_1_1.chance or 1000) < 1000)
end

return RichmanItemIcon
