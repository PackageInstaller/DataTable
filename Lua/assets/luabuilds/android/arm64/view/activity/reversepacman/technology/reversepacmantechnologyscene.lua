local ReversePacmanTechnologyScene = class("ReversePacmanTechnologyScene", import("view.base.BaseUI"))

ReversePacmanTechnologyScene.TOGGLE_TYPE = {
	ROLE_SKILL = 2,
	PLAYER_SKILL = 3,
	HR = 1
}

function ReversePacmanTechnologyScene:getUIName()
	return "ReversePacmanTechnologyUI"
end

function ReversePacmanTechnologyScene:init()
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.uiBackBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onToggle(self, self.uiHrBtn, function(arg_5_0)
		if arg_5_0 then
			self:ShowHrPanel()
		elseif self.hrView then
			local var_5_0 = ReversePacmanTools.GetActivity()

			if var_5_0:GetGiftTip() then
				var_5_0:SetGiftTip()
				self:RefreshTips()
			end
		end

		self.hrToggleItem:OnSelected(arg_5_0)
		setActive(self.uiHrPanel, arg_5_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.uiRoleSkillBtn, function(arg_6_0)
		if arg_6_0 then
			self:ShowRoleSkillPanel()
		elseif self.rollSkillView then
			local var_6_0 = ReversePacmanTools.GetActivity()

			if var_6_0:GetRoleSkillTip() then
				var_6_0:SetRoleSkillTip()
				self:RefreshTips()
			end
		end

		self.roleSkillToggleItem:OnSelected(arg_6_0)
		setActive(self.uiRoleSkillPanel, arg_6_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.uiPlayerSkillBtn, function(arg_7_0)
		if arg_7_0 then
			self:ShowPlayerSkillPanel()
		elseif self.playerSkillView then
			local var_7_0 = ReversePacmanTools.GetActivity()

			if var_7_0:GetPlayerSkillTip() then
				var_7_0:SetPlayerSkillTip()
				self:RefreshTips()
			end
		end

		self.playerSkillToggleItem:OnSelected(arg_7_0)
		setActive(self.uiPlayerSkillPanel, arg_7_0)

		return
	end, SFX_PANEL)
	setText(self.uiTitleText, i18n("reverse_pacman_select_logistics_sys"))
	setActive(self.uiHrPanel, false)
	setActive(self.uiRoleSkillPanel, false)
	setActive(self.uiPlayerSkillPanel, false)

	self.hrToggleItem = ReversePacmanTechnologyHrToggle.New(self.uiHrBtn, self)
	self.roleSkillToggleItem = ReversePacmanTechnologyRoleSkillToggle.New(self.uiRoleSkillBtn, self)
	self.playerSkillToggleItem = ReversePacmanTechnologyPlayerSkillToggle.New(self.uiPlayerSkillBtn, self)

	return
end

function ReversePacmanTechnologyScene:didEnter()
	self:BlurPanel(self._tf)

	local var_8_0 = ReversePacmanTools.GetActivity()
	local var_8_1 = self.contextData.toggleType

	if var_8_0:GetGiftTip() then
		var_8_1 = ReversePacmanTechnologyScene.TOGGLE_TYPE.HR
	elseif var_8_0:GetRoleSkillTip() then
		var_8_1 = ReversePacmanTechnologyScene.TOGGLE_TYPE.ROLE_SKILL
	elseif var_8_0:GetPlayerSkillTip() then
		var_8_1 = ReversePacmanTechnologyScene.TOGGLE_TYPE.PLAYER_SKILL
	end

	if var_8_1 == ReversePacmanTechnologyScene.TOGGLE_TYPE.ROLE_SKILL then
		triggerToggle(self.uiRoleSkillBtn, true)
	elseif var_8_1 == ReversePacmanTechnologyScene.TOGGLE_TYPE.PLAYER_SKILL then
		triggerToggle(self.uiPlayerSkillBtn, true)
	else
		triggerToggle(self.uiHrBtn, true)
	end

	self:RefreshTips()

	return
end

function ReversePacmanTechnologyScene:ShowHrPanel()
	self.hrView = self.hrView or ReversePacmanTechnologyHrView.New(self.uiHrPanel, self)

	self.hrView:Show()

	return
end

function ReversePacmanTechnologyScene:ShowRoleSkillPanel()
	self.rollSkillView = self.rollSkillView or ReversePacmanTechnologyRoleSkillView.New(self.uiRoleSkillPanel, self)

	return
end

function ReversePacmanTechnologyScene:ShowPlayerSkillPanel()
	self.playerSkillView = self.playerSkillView or ReversePacmanTechnologyPlayerSkillView.New(self.uiPlayerSkillPanel, self)

	return
end

function ReversePacmanTechnologyScene:RefreshTips()
	self.hrToggleItem:RefreshTip()
	self.roleSkillToggleItem:RefreshTip()
	self.playerSkillToggleItem:RefreshTip()

	return
end

function ReversePacmanTechnologyScene:willExit()
	self:UnOverlayPanel(self._tf)
	self.hrToggleItem:willExit()

	self.hrToggleItem = nil

	self.roleSkillToggleItem:willExit()

	self.roleSkillToggleItem = nil

	self.playerSkillToggleItem:willExit()

	self.playerSkillToggleItem = nil

	if self.hrView then
		local var_13_0 = ReversePacmanTools.GetActivity()

		if var_13_0:GetGiftTip() then
			var_13_0:SetGiftTip()
		end

		self.hrView:willExit()

		self.hrView = nil
	end

	if self.rollSkillView then
		local var_13_1 = ReversePacmanTools.GetActivity()

		if var_13_1:GetRoleSkillTip() then
			var_13_1:SetRoleSkillTip()
		end

		self.rollSkillView:willExit()

		self.rollSkillView = nil
	end

	if self.playerSkillView then
		local var_13_2 = ReversePacmanTools.GetActivity()

		if var_13_2:GetPlayerSkillTip() then
			var_13_2:SetPlayerSkillTip()
		end

		self.playerSkillView:willExit()

		self.playerSkillView = nil
	end

	return
end

return ReversePacmanTechnologyScene
