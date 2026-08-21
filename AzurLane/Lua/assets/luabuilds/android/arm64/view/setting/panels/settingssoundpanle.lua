local var_0_0 = class("SettingsSoundPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsSound"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_sound")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / VOICE SETTINGS"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.bgmSlider = arg_4_0._tf:Find("settings/bgm/slider")
	arg_4_0.effectSlider = arg_4_0._tf:Find("settings/sfx/slider")
	arg_4_0.mainSlider = arg_4_0._tf:Find("settings/cv/slider")
	arg_4_0.soundRevertBtn = arg_4_0._tf:Find("settings/buttons/reset")
	arg_4_0.volumeSwitchToggleOn = arg_4_0._tf:Find("settings/buttons/soundswitch/on")
	arg_4_0.volumeSwitchToggleOff = arg_4_0._tf:Find("settings/buttons/soundswitch/off")
	arg_4_0.isMute = PlayerPrefs.GetInt("mute_audio", 0) == 1

	triggerToggle(arg_4_0.volumeSwitchToggleOn, not arg_4_0.isMute)
	triggerToggle(arg_4_0.volumeSwitchToggleOff, arg_4_0.isMute)
	onToggle(arg_4_0, arg_4_0.volumeSwitchToggleOn, function(arg_5_0)
		arg_4_0:OnVolumeSwitch(arg_5_0)

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	onButton(arg_4_0, arg_4_0.soundRevertBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("sure_resume_volume"),
			onYes = function()
				triggerToggle(arg_4_0.volumeSwitchToggleOn, true)
				setSlider(arg_4_0.bgmSlider, 0, 1, DEFAULT_BGMVOLUME)
				setSlider(arg_4_0.effectSlider, 0, 1, DEFAULT_SEVOLUME)
				setSlider(arg_4_0.mainSlider, 0, 1, DEFAULT_CVVOLUME)

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	setText(arg_4_0._tf:Find("settings/buttons/soundswitch/Text"), i18n("voice_control"))
	setText(arg_4_0._tf:Find("settings/bgm/icon/Text"), i18n("settings_sound_title_bgm"))
	setText(arg_4_0._tf:Find("settings/sfx/icon/Text"), i18n("settings_sound_title_effct"))
	setText(arg_4_0._tf:Find("settings/cv/icon/Text"), i18n("settings_sound_title_cv"))

	return
end

function var_0_0.OnVolumeSwitch(arg_8_0, arg_8_1)
	if not arg_8_1 then
		PlayerPrefs.SetFloat("bgm_vol_mute_setting", pg.CriMgr.GetInstance():getBGMVolume())
		PlayerPrefs.SetFloat("se_vol_mute_setting", pg.CriMgr.GetInstance():getSEVolume())
		PlayerPrefs.SetFloat("cv_vol_mute_setting", pg.CriMgr.GetInstance():getCVVolume())
		pg.CriMgr.GetInstance():setBGMVolume(0)
		pg.CriMgr.GetInstance():setSEVolume(0)
		pg.CriMgr.GetInstance():setCVVolume(0)
		PlayerPrefs.SetInt("mute_audio", 1)
	else
		pg.CriMgr.GetInstance():setBGMVolume(PlayerPrefs.GetFloat("bgm_vol_mute_setting", DEFAULT_BGMVOLUME))
		pg.CriMgr.GetInstance():setSEVolume(PlayerPrefs.GetFloat("se_vol_mute_setting", DEFAULT_SEVOLUME))
		pg.CriMgr.GetInstance():setCVVolume(PlayerPrefs.GetFloat("cv_vol_mute_setting", DEFAULT_CVVOLUME))
		PlayerPrefs.SetInt("mute_audio", 0)
	end

	arg_8_0.isMute = not arg_8_1

	arg_8_0:UpdateSlidersState()

	return
end

function var_0_0.InitBgmSlider(arg_9_0)
	local var_9_0 = pg.CriMgr.GetInstance():getBGMVolume()

	if arg_9_0.isMute then
		var_9_0 = PlayerPrefs.GetFloat("bgm_vol_mute_setting", DEFAULT_BGMVOLUME)
	end

	setSlider(arg_9_0.bgmSlider, 0, 1, var_9_0)
	OnSliderWithButton(arg_9_0, arg_9_0.bgmSlider, function(arg_10_0)
		if arg_9_0.isMute then
			return
		end

		pg.CriMgr.GetInstance():setBGMVolume(arg_10_0)

		return
	end)

	return
end

function var_0_0.InitEffectSlider(arg_11_0)
	local var_11_0 = pg.CriMgr.GetInstance():getSEVolume()

	if arg_11_0.isMute then
		var_11_0 = PlayerPrefs.GetFloat("se_vol_mute_setting", DEFAULT_SEVOLUME)
	end

	setSlider(arg_11_0.effectSlider, 0, 1, var_11_0)
	OnSliderWithButton(arg_11_0, arg_11_0.effectSlider, function(arg_12_0)
		if arg_11_0.isMute then
			return
		end

		pg.CriMgr.GetInstance():setSEVolume(arg_12_0)

		return
	end)

	return
end

function var_0_0.InitMainSlider(arg_13_0)
	local var_13_0 = pg.CriMgr.GetInstance():getCVVolume()

	if arg_13_0.isMute then
		var_13_0 = PlayerPrefs.GetFloat("cv_vol_mute_setting", DEFAULT_CVVOLUME)
	end

	setSlider(arg_13_0.mainSlider, 0, 1, var_13_0)
	OnSliderWithButton(arg_13_0, arg_13_0.mainSlider, function(arg_14_0)
		if arg_13_0.isMute then
			return
		end

		pg.CriMgr.GetInstance():setCVVolume(arg_14_0)

		return
	end)

	return
end

function var_0_0.OnUpdate(arg_15_0)
	arg_15_0:InitBgmSlider()
	arg_15_0:InitEffectSlider()
	arg_15_0:InitMainSlider()
	arg_15_0:UpdateSlidersState()

	return
end

function var_0_0.UpdateSlidersState(arg_16_0)
	arg_16_0:SetSliderEnable(arg_16_0.bgmSlider, not arg_16_0.isMute)
	arg_16_0:SetSliderEnable(arg_16_0.effectSlider, not arg_16_0.isMute)
	arg_16_0:SetSliderEnable(arg_16_0.mainSlider, not arg_16_0.isMute)

	return
end

function var_0_0.SetSliderEnable(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2 = tobool(arg_17_2)
	arg_17_1:GetComponent("Slider").interactable = arg_17_2

	setButtonEnabled(arg_17_1:Find("up"), arg_17_2)
	setButtonEnabled(arg_17_1:Find("down"), arg_17_2)

	return
end

return var_0_0
