local IslandEditNamePage = class("IslandEditNamePage", import("...base.IslandBasePage"))

function IslandEditNamePage:getUIName()
	return "IslandEditNameui"
end

function IslandEditNamePage:OnLoaded()
	self.input = self._tf:Find("frame/name/InputField")
	self.closeBtn = self._tf:Find("frame/close")
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.content = self._tf:Find("frame/Text")

	setText(self._tf:Find("frame/title"), i18n("island_rename_title"))
	setText(self._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(self._tf:Find("frame/name/InputField/Placeholder"), i18n("island_rename_input_tip"))

	return
end

function IslandEditNamePage:AddListeners()
	self:AddListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)

	return
end

function IslandEditNamePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)

	return
end

function IslandEditNamePage:OnModifyName()
	self:Hide()

	if self.callback then
		self.callback()
	end

	return
end

function IslandEditNamePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:emit(IslandMediator.SET_NAME, getInputText(self.input), 1)

		return
	end, SFX_PANEL)

	return
end

function IslandEditNamePage:Show(arg_10_1)
	IslandEditNamePage.super.Show(self)

	self.callback = arg_10_1

	self:UpdateContent()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function IslandEditNamePage:Hide()
	self:PlayExitAniamtion(function()
		IslandEditNamePage.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		return
	end)

	return
end

function IslandEditNamePage:PlayExitAniamtion(arg_13_1)
	self.isPlayingAnimation = true

	if arg_13_1 then
		arg_13_1()
	end

	return
end

function IslandEditNamePage:UpdateContent()
	setInputText(self.input, "")
	setText(self.content, i18n("island_rename_consutme_tip"))

	return
end

function IslandEditNamePage:OnDestroy()
	self.callback = nil

	return
end

return IslandEditNamePage
