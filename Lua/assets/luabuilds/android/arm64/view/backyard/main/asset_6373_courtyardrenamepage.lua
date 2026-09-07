local CourtYardRenamePage = class("CourtYardRenamePage", import("...base.BaseSubView"))

function CourtYardRenamePage:getUIName()
	return "CourtYardRenameUI"
end

function CourtYardRenamePage:OnLoaded()
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.closeBtn = self._tf:Find("frame/close")
	self.input = self._tf:Find("frame/input")

	setText(self._tf:Find("frame/cancel/Text"), i18n("word_cancel"))
	setText(self._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(self._tf:Find("frame/title"), i18n("backyard_rename_title"))
	setText(self._tf:Find("frame/input/placehoder"), i18n("backyard_rename_tip"))

	return
end

function CourtYardRenamePage:OnInit()
	onButton(self, self.confirmBtn, function()
		local var_4_0 = getInputText(self.input)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_should_input"))

			return
		end

		if not nameValidityCheck(var_4_0, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		self:emit(CourtYardMediator.RENAME, var_4_0)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CourtYardRenamePage:Flush()
	self:Show()

	return
end

function CourtYardRenamePage:OnDestroy()
	self:Hide()

	return
end

return CourtYardRenamePage
