local ReversePacmanTechnologyPlayerSkillToggle = class("ReversePacmanTechnologyPlayerSkillToggle", import("view.base.BasePanel"))

function ReversePacmanTechnologyPlayerSkillToggle:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyPlayerSkillToggle.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanTechnologyPlayerSkillToggle:Init()
	setText(self.uiNameText, i18n("reverse_pacman_deploy"))

	return
end

function ReversePacmanTechnologyPlayerSkillToggle:didEnter()
	return
end

function ReversePacmanTechnologyPlayerSkillToggle:OnSelected(arg_4_1)
	setActive(self.uiSelectedGo, arg_4_1)
	setActive(self.uiUnselectedGo, not arg_4_1)

	local var_4_0 = arg_4_1 and Color.NewHex("#61bac7") or Color.NewHex("#313131")

	setTextColor(self.uiNameText, var_4_0)
	setImageColor(self.uiIconImage, var_4_0)

	return
end

function ReversePacmanTechnologyPlayerSkillToggle:RefreshTip()
	setActive(self.uiTipGo, ReversePacmanTools.GetActivity():GetPlayerSkillTip())

	return
end

function ReversePacmanTechnologyPlayerSkillToggle:willExit()
	self:detach()

	return
end

return ReversePacmanTechnologyPlayerSkillToggle
