local SettingsSoundPanle = class("SettingsSoundPanle", import(".SettingsBasePanel"))

function SettingsSoundPanle:GetUIName()
	return "SettingsSound"
end

function SettingsSoundPanle:GetTitle()
	return i18n("Settings_title_sound")
end

function SettingsSoundPanle:GetTitleEn()
	return "  / VOICE SETTINGS"
end

function SettingsSoundPanle:OnInit()
	self.bgmSlider = self._tf:Find("settings/bgm/slider")
	self.effectSlider = self._tf:Find("settings/sfx/slider")
	self.mainSlider = self._tf:Find("settings/cv/slider")
	self.soundRevertBtn = self._tf:Find("settings/buttons/reset")
	self.volumeSwitchToggleOn = self._tf:Find("settings/buttons/soundswitch/on")
	self.volumeSwitchToggleOff = self._tf:Find("settings/buttons/soundswitch/off")
	self.isMute = PlayerPrefs.GetInt("mute_audio", 0) == 1

	triggerToggle(self.volumeSwitchToggleOn, not self.isMute)
	triggerToggle(self.volumeSwitchToggleOff, self.isMute)
	onToggle(self, self.volumeSwitchToggleOn, function(arg_5_0)
		self:OnVolumeSwitch(arg_5_0)

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	onButton(self, self.soundRevertBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("sure_resume_volume"),
			onYes = function()
				triggerToggle(self.volumeSwitchToggleOn, true)
				setSlider(self.bgmSlider, 0, 1, DEFAULT_BGMVOLUME)
				setSlider(self.effectSlider, 0, 1, DEFAULT_SEVOLUME)
				setSlider(self.mainSlider, 0, 1, DEFAULT_CVVOLUME)

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	setText(self._tf:Find("settings/buttons/soundswitch/Text"), i18n("voice_control"))
	setText(self._tf:Find("settings/bgm/icon/Text"), i18n("settings_sound_title_bgm"))
	setText(self._tf:Find("settings/sfx/icon/Text"), i18n("settings_sound_title_effct"))
	setText(self._tf:Find("settings/cv/icon/Text"), i18n("settings_sound_title_cv"))

	return
end

function SettingsSoundPanle:OnVolumeSwitch(arg_8_1)
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

	self.isMute = not arg_8_1

	self:UpdateSlidersState()

	return
end

function SettingsSoundPanle:InitBgmSlider()
	local var_9_0 = pg.CriMgr.GetInstance():getBGMVolume()

	setSlider(self.bgmSlider, 0, 1, (self.isMute or nil) and PlayerPrefs.GetFloat("bgm_vol_mute_setting", DEFAULT_BGMVOLUME))
	OnSliderWithButton(self, self.bgmSlider, function(arg_10_0)
		if self.isMute then
			return
		end

		pg.CriMgr.GetInstance():setBGMVolume(arg_10_0)

		return
	end)

	return
end

function SettingsSoundPanle:InitEffectSlider()
	local var_11_0 = pg.CriMgr.GetInstance():getSEVolume()

	setSlider(self.effectSlider, 0, 1, (self.isMute or nil) and PlayerPrefs.GetFloat("se_vol_mute_setting", DEFAULT_SEVOLUME))
	OnSliderWithButton(self, self.effectSlider, function(arg_12_0)
		if self.isMute then
			return
		end

		pg.CriMgr.GetInstance():setSEVolume(arg_12_0)

		return
	end)

	return
end

function SettingsSoundPanle:InitMainSlider()
	local var_13_0 = pg.CriMgr.GetInstance():getCVVolume()

	setSlider(self.mainSlider, 0, 1, (self.isMute or nil) and PlayerPrefs.GetFloat("cv_vol_mute_setting", DEFAULT_CVVOLUME))
	OnSliderWithButton(self, self.mainSlider, function(arg_14_0)
		if self.isMute then
			return
		end

		pg.CriMgr.GetInstance():setCVVolume(arg_14_0)

		return
	end)

	return
end

function SettingsSoundPanle:OnUpdate()
	self:InitBgmSlider()
	self:InitEffectSlider()
	self:InitMainSlider()
	self:UpdateSlidersState()

	return
end

function SettingsSoundPanle:UpdateSlidersState()
	self:SetSliderEnable(self.bgmSlider, not self.isMute)
	self:SetSliderEnable(self.effectSlider, not self.isMute)
	self:SetSliderEnable(self.mainSlider, not self.isMute)

	return
end

function SettingsSoundPanle:SetSliderEnable(arg_17_1, arg_17_2)
	arg_17_2 = tobool(arg_17_2)
	arg_17_1:GetComponent("Slider").interactable = arg_17_2

	setButtonEnabled(arg_17_1:Find("up"), arg_17_2)
	setButtonEnabled(arg_17_1:Find("down"), arg_17_2)

	return
end

return SettingsSoundPanle
