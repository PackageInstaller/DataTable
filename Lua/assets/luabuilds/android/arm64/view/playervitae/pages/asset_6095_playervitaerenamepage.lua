local PlayerVitaeRenamePage = class("PlayerVitaeRenamePage", import("...base.BaseSubView"))

function PlayerVitaeRenamePage:getUIName()
	return "PlayerVitaeRenamePage"
end

function PlayerVitaeRenamePage:OnLoaded()
	self.content = self._tf:Find("frame/border/tip"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("frame/queren")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.inputField = self._tf:Find("frame/name_field")

	setText(self._tf:Find("frame/top/title_list/infomation/title"), i18n("change_player_name_title"))
	setText(self._tf:Find("frame/border/prompt"), i18n("change_player_name_subtitle"))
	setText(self._tf:Find("frame/name_field/Placeholder"), i18n("change_player_name_input_tip"))
	setText(self.confirmBtn:Find("Image"), i18n("word_ok"))
	setText(self.cancelBtn:Find("Image"), i18n("word_cancel"))

	return
end

function PlayerVitaeRenamePage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:emit(PlayerVitaeMediator.ON_CHANGE_PLAYER_NAME, (getInputText(self.inputField)))
		setInputText(self.inputField, "")
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function PlayerVitaeRenamePage:Show(arg_7_1)
	PlayerVitaeRenamePage.super.Show(self)

	local var_7_0 = Drop.Create(arg_7_1:getModifyNameComsume())

	self.content.text = i18n("player_name_change_windows_tip", var_7_0:getName(), var_7_0:getOwnedCount() .. "/" .. var_7_0.count)

	return
end

function PlayerVitaeRenamePage:OnDestroy()
	self:Hide()

	return
end

return PlayerVitaeRenamePage
