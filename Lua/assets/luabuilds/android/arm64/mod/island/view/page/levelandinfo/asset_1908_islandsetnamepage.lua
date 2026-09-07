local IslandSetNamePage = class("IslandSetNamePage", import(".IslandEditNamePage"))

function IslandSetNamePage:getUIName()
	return "IslandNewNameUI"
end

function IslandSetNamePage:OnLoaded()
	IslandSetNamePage.super.OnLoaded(self)
	setText(self._tf:Find("frame/title"), i18n("island_rename_subtitle"))
	setActive(self.closeBtn, false)

	return
end

function IslandSetNamePage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:emit(IslandMediator.SET_NAME, getInputText(self.input), 2)

		return
	end, SFX_PANEL)

	return
end

function IslandSetNamePage:UpdateContent()
	setText(self.content, "")

	return
end

return IslandSetNamePage
