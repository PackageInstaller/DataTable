local TeamBattleCommonIcon = class("TeamBattleCommonIcon", require("app.fairyGUI.teamBattle.UI_TeamBattleCommonIcon"))

function TeamBattleCommonIcon:updateKnightIcon(arg_1_1)
	self.m_iconComp:updateIcon({
		struct = arg_1_1
	})

	local var_1_0 = arg_1_1:getHpPercent()

	self.m_hpProgress:setPercent({
		max = 100,
		cur = var_1_0
	})

	if var_1_0 > 0 then
		self.m_isDeadController:setSelectedIndex(0)
	else
		self.m_isDeadController:setSelectedIndex(1)
	end
end

return TeamBattleCommonIcon
