local TeamBattlePlayerInfoComp = class("TeamBattlePlayerInfoComp", require("app.fairyGUI.teamBattle.UI_TeamBattlePlayerInfoComp"))

function TeamBattlePlayerInfoComp:updateInfoComp(arg_1_1)
	self.m_fightValue:setText(arg_1_1.fight_value)
	self.m_level:setText(g.core.lang:get(302054, {
		level = arg_1_1.level
	}))
	self.m_name:setText(arg_1_1.name, false, true)
end

return TeamBattlePlayerInfoComp
