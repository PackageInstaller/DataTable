local TeamBattleResultKnightIcon = class("TeamBattleResultKnightIcon", require("app.fairyGUI.battleResult.UI_TeamBattleResultKnightIcon"))

function TeamBattleResultKnightIcon:updateKnightIcon(arg_1_1)
	self.m_baseIcon:updateIcon({
		struct = arg_1_1.knightData
	})
	self.m_hpProgress:setMax(1000)
	self.m_hpProgress:setValue(arg_1_1.hpTh)
	self.m_isDeadController:setSelectedIndex(arg_1_1.hpTh <= 0 and 1 or 0)
end

return TeamBattleResultKnightIcon
