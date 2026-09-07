local CommanderRenamePage = class("CommanderRenamePage", import("...base.BaseSubView"))

function CommanderRenamePage:getUIName()
	return "CommandeRenameUI"
end

function CommanderRenamePage:OnInit()
	onButton(self, self._tf:Find("frame/close_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/cancel_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.input = findTF(self._tf, "frame/bg/content/input")
	self.confirmBtn = self._tf:Find("frame/confirm_btn")

	setText(self._tf:Find("frame/bg/content/label"), i18n("commander_rename_tip"))

	return
end

function CommanderRenamePage:Show(arg_6_1)
	self.isShowMsgBox = true

	setActive(self._tf, true)
	self._tf:SetAsLastSibling()
	setInputText(self.input, "")
	onButton(self, self.confirmBtn, function()
		local var_7_0 = getInputText(self.input)

		if not var_7_0 or var_7_0 == "" then
			return
		end

		self:emit(CommanderCatMediator.RENAME, arg_6_1.id, var_7_0)
		self:Hide()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommanderRenamePage:Hide()
	self.isShowMsgBox = nil

	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CommanderRenamePage:OnDestroy()
	if self.isShowMsgBox then
		self:Hide()
	end

	return
end

return CommanderRenamePage
