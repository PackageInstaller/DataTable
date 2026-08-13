class = var_0_10000

local var_0_0 = "SettingsSoundPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsSound"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_sound")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / VOICE SETTINGS"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bgmSlider = var_1.Find(var_4_0, "settings/bgm/slider")

	local var_4_1 = arg_4_0._tf

	arg_4_0.effectSlider = var_1.Find(var_4_1, "settings/sfx/slider")

	local var_4_2 = arg_4_0._tf

	arg_4_0.mainSlider = var_1.Find(var_4_2, "settings/cv/slider")

	local var_4_3 = arg_4_0._tf

	arg_4_0.soundRevertBtn = var_1.Find(var_4_3, "settings/buttons/reset")

	local var_4_4 = arg_4_0._tf

	arg_4_0.volumeSwitchToggleOn = var_1.Find(var_4_4, "settings/buttons/soundswitch/on")

	local var_4_5 = arg_4_0._tf

	arg_4_0.volumeSwitchToggleOff = var_1.Find(var_4_5, "settings/buttons/soundswitch/off")
	PlayerPrefs = var_1
	arg_4_0.isMute = var_1.GetInt("mute_audio", 0) == 1
	triggerToggle = var_1

	var_1(arg_4_0.volumeSwitchToggleOn, not arg_4_0.isMute)

	triggerToggle = var_1

	var_1(arg_4_0.volumeSwitchToggleOff, arg_4_0.isMute)

	onToggle = var_1

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.volumeSwitchToggleOn

	local function var_4_8(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnVolumeSwitch(var_5_0, arg_5_0)

		return
	end

	SFX_UI_TAG = var_1_10006
	SFX_UI_TAG = var_1_10007

	var_1(var_4_6, var_4_7, var_4_8, var_1_10006, var_1_10007)

	onButton = var_1

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.soundRevertBtn

	local function var_4_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		i18n = var_2_10004
		var_6_2.content = var_2_10004("sure_resume_volume")

		function var_6_2.onYes()
			triggerToggle = var_3_10000

			var_3_10000(arg_4_0.volumeSwitchToggleOn, true)

			setSlider = var_3_10000

			local var_7_0 = arg_4_0.bgmSlider
			local var_7_1 = 0
			local var_7_2 = 1

			DEFAULT_BGMVOLUME = var_3_10005

			var_3_10000(var_7_0, var_7_1, var_7_2, var_3_10005)

			setSlider = var_3_10000

			local var_7_3 = arg_4_0.effectSlider
			local var_7_4 = 0
			local var_7_5 = 1

			DEFAULT_SEVOLUME = var_3_10005

			var_3_10000(var_7_3, var_7_4, var_7_5, var_3_10005)

			setSlider = var_3_10000

			local var_7_6 = arg_4_0.mainSlider
			local var_7_7 = 0
			local var_7_8 = 1

			DEFAULT_CVVOLUME = var_3_10005

			var_3_10000(var_7_6, var_7_7, var_7_8, var_3_10005)

			return
		end

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_UI_CLICK = var_1_10006

	var_1(var_4_9, var_4_10, var_4_11, var_1_10006)

	setText = var_1

	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_3.Find(var_4_12, "settings/buttons/soundswitch/Text")

	i18n = var_4_10

	var_1(var_4_13, var_4_10("voice_control"))

	setText = var_1

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_3.Find(var_4_14, "settings/bgm/icon/Text")

	i18n = var_4

	var_1(var_4_15, var_4("settings_sound_title_bgm"))

	setText = var_1

	local var_4_16 = arg_4_0._tf
	local var_4_17 = var_3.Find(var_4_16, "settings/sfx/icon/Text")

	i18n = var_4

	var_1(var_4_17, var_4("settings_sound_title_effct"))

	setText = var_1

	local var_4_18 = arg_4_0._tf
	local var_4_19 = var_3.Find(var_4_18, "settings/cv/icon/Text")

	i18n = var_4

	var_1(var_4_19, var_4("settings_sound_title_cv"))

	return
end

function var_0_1.OnVolumeSwitch(arg_8_0, arg_8_1)
	if not arg_8_1 then
		PlayerPrefs = var_1_10002
		var_1_10002 = var_1_10002.SetFloat

		local var_8_0 = "bgm_vol_mute_setting"

		pg = var_1_10005

		local var_8_1 = var_1_10005.CriMgr.GetInstance()

		var_1_10002(var_8_0, var_1_10005.getBGMVolume(var_8_1))

		PlayerPrefs = var_1_10002
		var_1_10002 = var_1_10002.SetFloat

		local var_8_2 = "se_vol_mute_setting"

		pg = var_1_10005

		local var_8_3 = var_1_10005.CriMgr.GetInstance()

		var_1_10002(var_8_2, var_1_10005.getSEVolume(var_8_3))

		PlayerPrefs = var_1_10002
		var_1_10002 = var_1_10002.SetFloat

		local var_8_4 = "cv_vol_mute_setting"

		pg = var_1_10005

		local var_8_5 = var_1_10005.CriMgr.GetInstance()

		var_1_10002(var_8_4, var_1_10005.getCVVolume(var_8_5))

		pg = var_1_10002

		local var_8_6 = var_1_10002.CriMgr.GetInstance()

		var_1_10002.setBGMVolume(var_8_6, 0)

		pg = var_1_10002

		local var_8_7 = var_1_10002.CriMgr.GetInstance()

		var_1_10002.setSEVolume(var_8_7, 0)

		pg = var_1_10002

		local var_8_8 = var_1_10002.CriMgr.GetInstance()

		var_1_10002.setCVVolume(var_8_8, 0)

		PlayerPrefs = var_1_10002

		var_1_10002.SetInt("mute_audio", 1)
	else
		pg = var_1_10002

		local var_8_9 = var_1_10002.CriMgr.GetInstance()
		local var_8_10 = var_2.setBGMVolume

		PlayerPrefs = var_1_10005

		local var_8_11 = var_1_10005.GetFloat
		local var_8_12 = "bgm_vol_mute_setting"

		DEFAULT_BGMVOLUME = var_1_10008

		var_8_10(var_8_9, var_8_11(var_8_12, var_1_10008))

		pg = var_8_10

		local var_8_13 = var_8_10.CriMgr.GetInstance()
		local var_8_14 = var_2.setSEVolume

		PlayerPrefs = var_5

		local var_8_15 = var_5.GetFloat
		local var_8_16 = "se_vol_mute_setting"

		DEFAULT_SEVOLUME = var_1_10008

		var_8_14(var_8_13, var_8_15(var_8_16, var_1_10008))

		pg = var_8_14

		local var_8_17 = var_8_14.CriMgr.GetInstance()
		local var_8_18 = var_2.setCVVolume

		PlayerPrefs = var_5

		local var_8_19 = var_5.GetFloat
		local var_8_20 = "cv_vol_mute_setting"

		DEFAULT_CVVOLUME = var_1_10008

		var_8_18(var_8_17, var_8_19(var_8_20, var_1_10008))

		PlayerPrefs = var_8_18

		var_8_18.SetInt("mute_audio", 0)
	end

	arg_8_0.isMute = not arg_8_1

	arg_8_0:UpdateSlidersState()

	return
end

function var_0_1.InitBgmSlider(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.CriMgr.GetInstance()
	local var_9_1 = var_1.getBGMVolume(var_9_0)
	local var_9_2

	if arg_9_0.isMute then
		PlayerPrefs = var_9_2
		var_9_2 = var_9_2.GetFloat

		local var_9_3 = "bgm_vol_mute_setting"

		DEFAULT_BGMVOLUME = var_1_10005
		var_9_1 = var_9_2(var_9_3, var_1_10005)
	end

	setSlider = var_9_2

	var_9_2(arg_9_0.bgmSlider, 0, 1, var_9_1)

	OnSliderWithButton = var_9_2

	var_9_2(arg_9_0, arg_9_0.bgmSlider, function(arg_10_0)
		if arg_9_0.isMute then
			return
		end

		pg = var_1

		local var_10_0 = var_1.CriMgr.GetInstance()

		var_1.setBGMVolume(var_10_0, arg_10_0)

		return
	end)

	return
end

function var_0_1.InitEffectSlider(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.CriMgr.GetInstance()
	local var_11_1 = var_1.getSEVolume(var_11_0)
	local var_11_2

	if arg_11_0.isMute then
		PlayerPrefs = var_11_2
		var_11_2 = var_11_2.GetFloat

		local var_11_3 = "se_vol_mute_setting"

		DEFAULT_SEVOLUME = var_1_10005
		var_11_1 = var_11_2(var_11_3, var_1_10005)
	end

	setSlider = var_11_2

	var_11_2(arg_11_0.effectSlider, 0, 1, var_11_1)

	OnSliderWithButton = var_11_2

	var_11_2(arg_11_0, arg_11_0.effectSlider, function(arg_12_0)
		if arg_11_0.isMute then
			return
		end

		pg = var_1

		local var_12_0 = var_1.CriMgr.GetInstance()

		var_1.setSEVolume(var_12_0, arg_12_0)

		return
	end)

	return
end

function var_0_1.InitMainSlider(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.CriMgr.GetInstance()
	local var_13_1 = var_1.getCVVolume(var_13_0)
	local var_13_2

	if arg_13_0.isMute then
		PlayerPrefs = var_13_2
		var_13_2 = var_13_2.GetFloat

		local var_13_3 = "cv_vol_mute_setting"

		DEFAULT_CVVOLUME = var_1_10005
		var_13_1 = var_13_2(var_13_3, var_1_10005)
	end

	setSlider = var_13_2

	var_13_2(arg_13_0.mainSlider, 0, 1, var_13_1)

	OnSliderWithButton = var_13_2

	var_13_2(arg_13_0, arg_13_0.mainSlider, function(arg_14_0)
		if arg_13_0.isMute then
			return
		end

		pg = var_1

		local var_14_0 = var_1.CriMgr.GetInstance()

		var_1.setCVVolume(var_14_0, arg_14_0)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_15_0)
	arg_15_0:InitBgmSlider()
	arg_15_0:InitEffectSlider()
	arg_15_0:InitMainSlider()
	arg_15_0:UpdateSlidersState()

	return
end

function var_0_1.UpdateSlidersState(arg_16_0)
	local var_16_0 = arg_16_0.isMute

	arg_16_0:SetSliderEnable(arg_16_0.bgmSlider, not var_16_0)
	arg_16_0:SetSliderEnable(arg_16_0.effectSlider, not var_16_0)
	arg_16_0:SetSliderEnable(arg_16_0.mainSlider, not var_16_0)

	return
end

function var_0_1.SetSliderEnable(arg_17_0, arg_17_1, arg_17_2)
	tobool = var_1_10003
	arg_17_2 = var_1_10003(arg_17_2)
	arg_17_1:GetComponent("Slider").interactable = arg_17_2
	setButtonEnabled = var_1_10004

	var_1_10004(arg_17_1:Find("up"), arg_17_2)

	setButtonEnabled = var_1_10004

	var_1_10004(arg_17_1:Find("down"), arg_17_2)

	return
end

return var_0_1
