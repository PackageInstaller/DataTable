local ReversePacmanTechnologyPlayerSkillItem = class("ReversePacmanTechnologyPlayerSkillItem", import("view.activity.ReversePacman.technology.roleSkill.ReversePacmanTechnologyRoleSkillItem"))

function ReversePacmanTechnologyPlayerSkillItem:Init()
	ReversePacmanTechnologyPlayerSkillItem.super.Init(self)
	setText(self.uiBuyText, i18n("reverse_pacman_level_upgrade"))
	setText(self.uiBuyText2, i18n("reverse_pacman_level_upgrade"))
	setText(self.uiSoldOutText, i18n("reverse_pacman_sold_out"))

	return
end

return ReversePacmanTechnologyPlayerSkillItem
