local ThemeExploreRewardIconComp = class("ThemeExploreRewardIconComp", require("app.fairyGUI.summerTheme.UI_ThemeExploreRewardIconComp"))

function ThemeExploreRewardIconComp:updateCompView(arg_1_1)
	self.m_itemIcon:updateIcon(arg_1_1)

	if arg_1_1.isReward then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ThemeExploreRewardIconComp
