local ThemeTurnCardAwardIcon = class("ThemeTurnCardAwardIcon", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardAwardIcon"))

function ThemeTurnCardAwardIcon:updateIconData(arg_1_1, arg_1_2)
	self.m_icon:updateIcon(arg_1_1)
	self.m_getAwardController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return ThemeTurnCardAwardIcon
