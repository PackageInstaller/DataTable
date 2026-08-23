local ThemeExploreShowRewardPop = class("ThemeExploreShowRewardPop", require("app.fairyGUI.summerTheme.UI_ThemeExploreShowRewardPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeExploreShowRewardPop",
		pkgName = "summerTheme",
		pkgPath = "ui/summerTheme/summerTheme"
	})
end)

function ThemeExploreShowRewardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._showItems = arg_2_1.items

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rewardList:setNumItems(#self._showItems)
end

function ThemeExploreShowRewardPop:_onRewardItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCompView(self._showItems[arg_3_1 + 1])
end

return ThemeExploreShowRewardPop
