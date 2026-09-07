local IslandSettingsGraphicsPanle = class("IslandSettingsGraphicsPanle", import("view.Setting.panels.SettingsBasePanel"))

IslandSettingsGraphicsPanle.EVT_UPDTAE = "IslandSettingsGraphicsPanle:EVT_UPDTAE"

function IslandSettingsGraphicsPanle:GetUIName()
	return "IslandSettingsStorySpeed"
end

function IslandSettingsGraphicsPanle:GetTitle()
	return i18n("grapihcs3d_setting_quality")
end

function IslandSettingsGraphicsPanle:GetTitleEn()
	return "  / STANDBY MODE SETTINGS"
end

function IslandSettingsGraphicsPanle:InitTitle()
	setText(self._tf:Find("title/title_point/title_text"), self:GetTitle())

	return
end

function IslandSettingsGraphicsPanle:OnInit()
	local var_5_0 = CustomIndexLayer.Clone2Full(self._tf:Find("speeds"), 4)

	self.lowToggle = var_5_0[1]
	self.mediumToggle = var_5_0[2]
	self.highToggle = var_5_0[3]
	self.playerToggle = var_5_0[4]

	for iter_5_0 = 1, 4 do
		onToggle(self, var_5_0[iter_5_0], function(arg_6_0)
			if arg_6_0 then
				if PlayerPrefs.GetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 0) ~= iter_5_0 then
					PlayerPrefs.SetInt(GraphicSettingConst.PlayerGraphicLevelIsland, iter_5_0)
				end

				pg.m02:sendNotification(IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL)
			end

			return
		end, SFX_UI_TAG, SFX_UI_TAG)
	end

	setText(self.lowToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(self.lowToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(self.mediumToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(self.mediumToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(self.highToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(self.highToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(self.playerToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_custom"))
	setText(self.playerToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_custom"))

	return
end

function IslandSettingsGraphicsPanle:OnUpdate()
	local var_7_0 = PlayerPrefs.GetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 2)

	if var_7_0 == 1 then
		triggerToggle(self.lowToggle, true)
	elseif var_7_0 == 2 then
		triggerToggle(self.mediumToggle, true)
	elseif var_7_0 == 3 then
		triggerToggle(self.highToggle, true)
	else
		triggerToggle(self.playerToggle, true)
	end

	return
end

return IslandSettingsGraphicsPanle
