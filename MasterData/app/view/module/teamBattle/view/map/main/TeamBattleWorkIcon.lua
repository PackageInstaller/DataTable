local TeamBattleWorkIcon = class("TeamBattleWorkIcon", require("app.fairyGUI.teamBattle.UI_TeamBattleWorkIcon"))

function TeamBattleWorkIcon:updateIcon(arg_1_1)
	self:setIcon((table.concat({
		"ui://teamBattle/icon_hjtj_nandu",
		arg_1_1
	}, "")))
end

function TeamBattleWorkIcon:clearEff()
	self.m_eff:removeAllEffect()
end

function TeamBattleWorkIcon:playSelectEff()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamBattle_job",
		remove = true,
		isLoop = false
	})
end

return TeamBattleWorkIcon
