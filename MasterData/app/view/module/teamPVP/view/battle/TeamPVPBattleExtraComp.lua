local TeamPVPBattleExtraComp = class("TeamPVPBattleExtraComp", require("app.fairyGUI.teamPVP.UI_TeamPVPBattleExtraComp"))

function TeamPVPBattleExtraComp:play()
	self.m_effBg:addEffectSpine({
		remove = true,
		name = "eff_ui_towerHard_round",
		isLoop = false
	})
	self.m_enterTransition:play()
end

return TeamPVPBattleExtraComp
