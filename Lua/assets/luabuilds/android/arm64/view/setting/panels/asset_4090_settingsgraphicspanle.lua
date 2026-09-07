local SettingsGraphicsPanle = class("SettingsGraphicsPanle", import(".SettingsBasePanel"))

SettingsGraphicsPanle.EVT_UPDTAE = "SettingsGraphicsPanle:EVT_UPDTAE"

function SettingsGraphicsPanle:GetUIName()
	return "SettingsStorySpeed"
end

function SettingsGraphicsPanle:GetTitle()
	return i18n("grapihcs3d_setting_quality")
end

function SettingsGraphicsPanle:GetTitleEn()
	return "  / STANDBY MODE SETTINGS"
end

function SettingsGraphicsPanle:OnInit()
	local var_4_0 = CustomIndexLayer.Clone2Full(self._tf:Find("speeds"), 4)

	self.lowToggle = var_4_0[1]
	self.mediumToggle = var_4_0[2]
	self.highToggle = var_4_0[3]
	self.playerToggle = var_4_0[4]

	for iter_4_0 = 1, 4 do
		onToggle(self, var_4_0[iter_4_0], function(arg_5_0)
			if arg_5_0 then
				if PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 0) ~= iter_4_0 then
					pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGraphics(iter_4_0))
					PlayerPrefs.SetInt("dorm3d_graphics_settings_new", iter_4_0)
				end

				pg.m02:sendNotification(NewSettingsMediator.SelectGraphicSettingLevel)
			end

			return
		end, SFX_UI_TAG, SFX_UI_TAG)
	end

	setText(self.lowToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(self.mediumToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(self.highToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(self.playerToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_custom"))

	return
end

function SettingsGraphicsPanle:OnUpdate()
	local var_6_0 = PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 2)

	if var_6_0 == 1 then
		triggerToggle(self.lowToggle, true)
	elseif var_6_0 == 2 then
		triggerToggle(self.mediumToggle, true)
	elseif var_6_0 == 3 then
		triggerToggle(self.highToggle, true)
	else
		triggerToggle(self.playerToggle, true)
	end

	return
end

return SettingsGraphicsPanle
