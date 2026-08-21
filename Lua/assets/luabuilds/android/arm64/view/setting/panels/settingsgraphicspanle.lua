local var_0_0 = class("SettingsGraphicsPanle", import(".SettingsBasePanel"))

var_0_0.EVT_UPDTAE = "SettingsGraphicsPanle:EVT_UPDTAE"

function var_0_0.GetUIName(arg_1_0)
	return "SettingsStorySpeed"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("grapihcs3d_setting_quality")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_0.OnInit(arg_4_0)
	local var_4_0 = CustomIndexLayer.Clone2Full(arg_4_0._tf:Find("speeds"), 4)

	arg_4_0.lowToggle = var_4_0[1]
	arg_4_0.mediumToggle = var_4_0[2]
	arg_4_0.highToggle = var_4_0[3]
	arg_4_0.playerToggle = var_4_0[4]

	for iter_4_0 = 1, 4 do
		onToggle(arg_4_0, var_4_0[iter_4_0], function(arg_5_0)
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

	setText(arg_4_0.lowToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(arg_4_0.mediumToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(arg_4_0.highToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(arg_4_0.playerToggle:Find("Text"), i18n("grapihcs3d_setting_quality_option_custom"))

	return
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 2)

	if var_6_0 == 1 then
		triggerToggle(arg_6_0.lowToggle, true)
	elseif var_6_0 == 2 then
		triggerToggle(arg_6_0.mediumToggle, true)
	elseif var_6_0 == 3 then
		triggerToggle(arg_6_0.highToggle, true)
	else
		triggerToggle(arg_6_0.playerToggle, true)
	end

	return
end

return var_0_0
