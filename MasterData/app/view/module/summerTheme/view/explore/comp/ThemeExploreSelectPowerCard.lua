local ThemeExploreSelectPowerCard = class("ThemeExploreSelectPowerCard", require("app.fairyGUI.summerTheme.UI_ThemeExploreSelectPowerCard"))

function ThemeExploreSelectPowerCard:updateCardInfo(arg_1_1)
	if not arg_1_1 then
		return
	end

	self.m_titleTxt:setText(arg_1_1.name)
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(arg_1_1.icon))
	g.core.common.Path:getQualityLineByQualityAndIndex(arg_1_1.quality, 2)
	self.m_quality:setURL(g.core.common.Path:getQualityLineByQualityAndIndex(arg_1_1.quality, 2))
	self.m_quality2:setURL(g.core.common.Path:getQualityLineByQualityAndIndex(arg_1_1.quality, 1))
	self.m_quality3:setURL(g.core.common.Path:getQualityLineByQualityAndIndex(arg_1_1.quality, 3))
	self.m_descComp:setTitle(arg_1_1.description)
end

return ThemeExploreSelectPowerCard
