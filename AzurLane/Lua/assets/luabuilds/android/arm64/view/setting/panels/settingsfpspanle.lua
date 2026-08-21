local var_0_0 = class("SettingsFpsPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsFPS"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_FPS")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / FPS SETTING"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.fps30Toggle = arg_4_0._tf:Find("options/30fps")
	arg_4_0.fps60Toggle = arg_4_0._tf:Find("options/60fps")

	onToggle(arg_4_0, arg_4_0.fps30Toggle, function(arg_5_0)
		if arg_5_0 then
			QualitySettings.vSyncCount = 0

			PlayerPrefs.SetInt("fps_limit", 30)

			Application.targetFrameRate = 30
		end

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	onToggle(arg_4_0, arg_4_0.fps60Toggle, function(arg_6_0)
		if arg_6_0 then
			QualitySettings.vSyncCount = 0

			PlayerPrefs.SetInt("fps_limit", 60)

			Application.targetFrameRate = 60
		end

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	setText(arg_4_0._tf:Find("options/30fps/Text"), "30" .. i18n("word_frame"))
	setText(arg_4_0._tf:Find("options/60fps/Text"), "60" .. i18n("word_frame"))

	return
end

function var_0_0.OnUpdate(arg_7_0)
	local var_7_0 = PlayerPrefs.GetInt("fps_limit", DevicePerformanceUtil.GetDefaultFps())

	if var_7_0 == 30 then
		triggerToggle(arg_7_0.fps30Toggle, true)
	end

	if var_7_0 == 60 then
		triggerToggle(arg_7_0.fps60Toggle, true)
	end

	return
end

return var_0_0
