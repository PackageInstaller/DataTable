local TeamPVPBattleExtraComp = class("TeamPVPBattleExtraComp", require("app.fairyGUI.teamPVP.UI_TeamPVPBattleExtraComp"))

function TeamPVPBattleExtraComp:play()
	self.m_effBg:addEffectSpine({
		isLoop = false,
		name = "eff_ui_towerHard_round",
		remove = true
	})
	self.m_enterTransition:play()
end

return TeamPVPBattleExtraComp
