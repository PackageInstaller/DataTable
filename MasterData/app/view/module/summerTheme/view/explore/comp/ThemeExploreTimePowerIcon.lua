local ThemeExploreTimePowerIcon = class("ThemeExploreTimePowerIcon", require("app.fairyGUI.summerTheme.UI_ThemeExploreTimePowerIcon"))

function ThemeExploreTimePowerIcon:updateIcon(arg_1_1)
	self.m_bgIcon:setURL("ui://summerTheme/pic_bg_pinzhi_" .. arg_1_1.quality + 1)
	self.m_itemIcon:setURL(g.core.common.Path:getThemeExplorePowerPic(arg_1_1.icon))
end

return ThemeExploreTimePowerIcon
