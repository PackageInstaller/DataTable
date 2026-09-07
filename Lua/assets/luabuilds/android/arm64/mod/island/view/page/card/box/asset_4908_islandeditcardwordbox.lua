local IslandEditCardWordBox = class("IslandEditCardWordBox", import("view.base.BaseSubView"))

function IslandEditCardWordBox:getUIName()
	return "IslandEditCardWordBox"
end

function IslandEditCardWordBox:OnLoaded()
	setText(self._tf:Find("frame/title"), i18n("island_card_word_title"))

	self.closeBtn = self._tf:Find("frame/close")
	self.cancelBtn = self._tf:Find("cancel")

	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))

	self.confirmBtn = self._tf:Find("confirm")

	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	self.input = self._tf:Find("InputField")

	return
end

function IslandEditCardWordBox:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:emit(IslandSelfCardMediator.SET_CARD_WORD, (getInputText(self.input)))

		return
	end, SFX_PANEL)

	return
end

function IslandEditCardWordBox:Show()
	IslandEditCardWordBox.super.Show(self)
	setInputText(self.input, "")
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandEditCardWordBox:Hide()
	IslandEditCardWordBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandEditCardWordBox:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return IslandEditCardWordBox
