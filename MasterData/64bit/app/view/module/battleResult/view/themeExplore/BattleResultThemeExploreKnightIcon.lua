local BattleResultThemeExploreKnightIcon = class("BattleResultThemeExploreKnightIcon", require("app.fairyGUI.battleResult.UI_BattleResultThemeExploreKnightIcon"))

function BattleResultThemeExploreKnightIcon:updateHpIcon(arg_1_1)
	local var_1_0 = arg_1_1.knightData and arg_1_1.knightData:getAdvanceId() or arg_1_1.advId

	self.m_knightIcon:updateIcon({
		darkQuality = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		info = arg_1_1.info,
		advanceId = var_1_0
	})

	local var_1_1 = arg_1_1.hpTh

	self.m_hpProgress:setMax(1000)
	self.m_hpProgress:setValue(var_1_1)
	self.m_deadController:setSelectedIndex(var_1_1 > 0 and 0 or 1)
end

return BattleResultThemeExploreKnightIcon
