local IslandSettingsEscapePanel = class("IslandSettingsEscapePanel", import("view.Setting.panels.SettingsBasePanel"))

function IslandSettingsEscapePanel:GetUIName()
	return "IslandSettingsEscape"
end

function IslandSettingsEscapePanel:GetTitle()
	return i18n("grapihcs3d_setting_common_title")
end

function IslandSettingsEscapePanel:GetTitleEn()
	return "  / "
end

function IslandSettingsEscapePanel:InitTitle()
	setText(self._tf:Find("title/title_point/title_text"), self:GetTitle())

	return
end

function IslandSettingsEscapePanel:OnInit()
	self.escapeBtn = self._tf:Find("options/escape/btn")

	setText(self._tf:Find("options/escape/mask/Text"), i18n("grapihcs3d_setting_common_unstuck"))
	setText(self._tf:Find("options/escape/btn/Text"), i18n("grapihcs3d_setting_common_use"))
	onButton(self, self.escapeBtn, function()
		pg.m02:sendNotification(GAME.ISLAND_RESET_SP)

		return
	end, SFX_PANEL)

	return
end

function IslandSettingsEscapePanel:GetFlags()
	return {}
end

return IslandSettingsEscapePanel
