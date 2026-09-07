local IslandEditCardNameBox = class("IslandEditCardNameBox", import("view.base.BaseSubView"))

function IslandEditCardNameBox:getUIName()
	return "IslandEditCardNameBox"
end

function IslandEditCardNameBox:OnLoaded()
	self.input = self._tf:Find("frame/name/InputField")
	self.closeBtn = self._tf:Find("frame/close")
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.content = self._tf:Find("frame/Text")

	setText(self._tf:Find("frame/title"), i18n("island_rename_title"))
	setText(self._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(self._tf:Find("frame/name/InputField/Placeholder"), i18n("island_rename_input_tip"))

	self.animator = self._tf:GetComponent(typeof(Animation))
	self.aniDft = self._tf:GetComponent(typeof(DftAniEvent))
	self.isPlayingAnimation = false

	return
end

function IslandEditCardNameBox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:emit(IslandSelfCardMediator.SET_CARD_NAME, getInputText(self.input), 1)

		return
	end, SFX_PANEL)

	return
end

function IslandEditCardNameBox:Show(arg_7_1)
	IslandEditCardNameBox.super.Show(self)

	self.isPlayingAnimation = false
	self.callback = arg_7_1

	self:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.animator:Play("anim_IslandEditNameUI_In")

	return
end

function IslandEditCardNameBox:Hide()
	if self.isPlayingAnimation then
		return
	end

	self.isPlayingAnimation = true

	self:PlayExitAniamtion(function()
		self.isPlayingAnimation = false

		self.aniDft:SetEndEvent(nil)
		IslandEditCardNameBox.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		return
	end)

	return
end

function IslandEditCardNameBox:PlayExitAniamtion(arg_10_1)
	self.aniDft:SetEndEvent(function()
		if arg_10_1 then
			arg_10_1()
		end

		return
	end)
	self.animator:Play("anim_IslandEditNameUI_Out")

	return
end

function IslandEditCardNameBox:UpdateContent()
	setInputText(self.input, "")
	setText(self.content, i18n("island_rename_consutme_tip"))

	return
end

function IslandEditCardNameBox:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self.aniDft:SetEndEvent(nil)

	return
end

return IslandEditCardNameBox
