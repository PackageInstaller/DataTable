local ReversePacmanInterviewRoleTypeToggle = class("ReversePacmanInterviewRoleTypeToggle", import("view.base.BasePanel"))

function ReversePacmanInterviewRoleTypeToggle:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	ReversePacmanInterviewRoleTypeToggle.super.Ctor(self, self._go)

	self._parentClass = arg_1_2
	self.roleType = arg_1_3

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanInterviewRoleTypeToggle:Init()
	if self.roleType == ReversePacmanHomeConst.ROLE_TYPE.ALL then
		setText(self.uiNameText, i18n("reverse_pacman_ship_type_0"))
	elseif self.roleType == ReversePacmanHomeConst.ROLE_TYPE.CHASER then
		setText(self.uiNameText, i18n("reverse_pacman_ship_type_1"))
	elseif self.roleType == ReversePacmanHomeConst.ROLE_TYPE.AMBUSHER then
		setText(self.uiNameText, i18n("reverse_pacman_ship_type_2"))
	elseif self.roleType == ReversePacmanHomeConst.ROLE_TYPE.PLANNER then
		setText(self.uiNameText, i18n("reverse_pacman_ship_type_3"))
	end

	onToggle(self, self.uiToggle, function(arg_3_0)
		if arg_3_0 then
			self:emit(ReversePacmanInterviewRoleList.ON_CLICK_TOGGLE, self.roleType)
		end

		return
	end)

	return
end

function ReversePacmanInterviewRoleTypeToggle:didEnter()
	return
end

function ReversePacmanInterviewRoleTypeToggle:OnTriggerToggle()
	triggerToggle(self.uiToggle, true)

	return
end

function ReversePacmanInterviewRoleTypeToggle:willExit()
	self:detach()

	return
end

return ReversePacmanInterviewRoleTypeToggle
