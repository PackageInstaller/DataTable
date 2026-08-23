local ThemeExploreKnightIcon = class("ThemeExploreKnightIcon", require("app.fairyGUI.summerTheme.UI_ThemeExploreKnightIcon"))

function ThemeExploreKnightIcon:updateHpIcon(arg_1_1)
	local var_1_0 = arg_1_1.knightData and arg_1_1.knightData:getAdvanceId() or arg_1_1.advId

	self.m_knightIcon:updateIcon({
		changeControllers = true,
		hideSkin = true,
		darkQuality = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		info = arg_1_1.info,
		advanceId = var_1_0
	})
	self.m_hpProgress:setMax(1000)
	self.m_hpProgress:setValue(arg_1_1.hpTh)
end

return ThemeExploreKnightIcon
