local ThemeBossAwardIcon = class("ThemeBossAwardIcon", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossAwardIcon"))

function ThemeBossAwardIcon:updateIconCell(arg_1_1, arg_1_2)
	self.m_itemIcon:updateIcon(arg_1_1)
	self.m_isGetController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return ThemeBossAwardIcon
