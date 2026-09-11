local ReversePacmanTechnologyRoleSkillToggle = class("ReversePacmanTechnologyRoleSkillToggle", import("view.base.BasePanel"))

function ReversePacmanTechnologyRoleSkillToggle:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyRoleSkillToggle.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanTechnologyRoleSkillToggle:Init()
	setText(self.uiNameText, i18n("reverse_pacman_support"))

	return
end

function ReversePacmanTechnologyRoleSkillToggle:didEnter()
	return
end

function ReversePacmanTechnologyRoleSkillToggle:OnSelected(arg_4_1)
	setActive(self.uiSelectedGo, arg_4_1)
	setActive(self.uiUnselectedGo, not arg_4_1)

	local var_4_0 = arg_4_1 and Color.NewHex("#61bac7") or Color.NewHex("#313131")

	setTextColor(self.uiNameText, var_4_0)
	setImageColor(self.uiIconImage, var_4_0)

	return
end

function ReversePacmanTechnologyRoleSkillToggle:RefreshTip()
	setActive(self.uiTipGo, ReversePacmanTools.GetActivity():GetRoleSkillTip())

	return
end

function ReversePacmanTechnologyRoleSkillToggle:willExit()
	self:detach()

	return
end

return ReversePacmanTechnologyRoleSkillToggle
