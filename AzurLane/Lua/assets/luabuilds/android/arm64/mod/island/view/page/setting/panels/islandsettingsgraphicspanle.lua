local var_0_0 = class("IslandSettingsGraphicsPanle", import("view.Setting.panels.SettingsBasePanel"))

var_0_0.EVT_UPDTAE = "IslandSettingsGraphicsPanle:EVT_UPDTAE"

function var_0_0.GetUIName(arg_1_0)
	return "IslandSettingsStorySpeed"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("grapihcs3d_setting_quality")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_0.InitTitle(arg_4_0)
	setText(arg_4_0._tf:Find("title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_0.OnInit(arg_5_0)
	local var_5_0 = CustomIndexLayer.Clone2Full(arg_5_0._tf:Find("speeds"), 4)

	arg_5_0.lowToggle = var_5_0[1]
	arg_5_0.mediumToggle = var_5_0[2]
	arg_5_0.highToggle = var_5_0[3]
	arg_5_0.playerToggle = var_5_0[4]

	for iter_5_0 = 1, 4 do
		onToggle(arg_5_0, var_5_0[iter_5_0], function(arg_6_0)
			if arg_6_0 then
				if PlayerPrefs.GetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 0) ~= iter_5_0 then
					PlayerPrefs.SetInt(GraphicSettingConst.PlayerGraphicLevelIsland, iter_5_0)
				end

				pg.m02:sendNotification(IslandSettingsPage.SELECTGRAPHICSETTINGLEVEL)
			end

			return
		end, SFX_UI_TAG, SFX_UI_TAG)
	end

	setText(arg_5_0.lowToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(arg_5_0.lowToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_low"))
	setText(arg_5_0.mediumToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(arg_5_0.mediumToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_medium"))
	setText(arg_5_0.highToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(arg_5_0.highToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_high"))
	setText(arg_5_0.playerToggle:Find("off/Text"), i18n("grapihcs3d_setting_quality_option_custom"))
	setText(arg_5_0.playerToggle:Find("on/Text"), i18n("grapihcs3d_setting_quality_option_custom"))

	return
end

function var_0_0.OnUpdate(arg_7_0)
	local var_7_0 = PlayerPrefs.GetInt(GraphicSettingConst.PlayerGraphicLevelIsland, 2)

	if var_7_0 == 1 then
		triggerToggle(arg_7_0.lowToggle, true)
	elseif var_7_0 == 2 then
		triggerToggle(arg_7_0.mediumToggle, true)
	elseif var_7_0 == 3 then
		triggerToggle(arg_7_0.highToggle, true)
	else
		triggerToggle(arg_7_0.playerToggle, true)
	end

	return
end

return var_0_0
