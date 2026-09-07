local SettingsFpsPanle = class("SettingsFpsPanle", import(".SettingsBasePanel"))

function SettingsFpsPanle:GetUIName()
	return "SettingsFPS"
end

function SettingsFpsPanle:GetTitle()
	return i18n("Settings_title_FPS")
end

function SettingsFpsPanle:GetTitleEn()
	return "  / FPS SETTING"
end

function SettingsFpsPanle:OnInit()
	self.fps30Toggle = self._tf:Find("options/30fps")
	self.fps60Toggle = self._tf:Find("options/60fps")

	onToggle(self, self.fps30Toggle, function(arg_5_0)
		if arg_5_0 then
			QualitySettings.vSyncCount = 0

			PlayerPrefs.SetInt("fps_limit", 30)

			Application.targetFrameRate = 30
		end

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	onToggle(self, self.fps60Toggle, function(arg_6_0)
		if arg_6_0 then
			QualitySettings.vSyncCount = 0

			PlayerPrefs.SetInt("fps_limit", 60)

			Application.targetFrameRate = 60
		end

		return
	end, SFX_UI_TAG, SFX_UI_TAG)
	setText(self._tf:Find("options/30fps/Text"), "30" .. i18n("word_frame"))
	setText(self._tf:Find("options/60fps/Text"), "60" .. i18n("word_frame"))

	return
end

function SettingsFpsPanle:OnUpdate()
	local var_7_0 = PlayerPrefs.GetInt("fps_limit", DevicePerformanceUtil.GetDefaultFps())

	if var_7_0 == 30 then
		triggerToggle(self.fps30Toggle, true)
	end

	if var_7_0 == 60 then
		triggerToggle(self.fps60Toggle, true)
	end

	return
end

return SettingsFpsPanle
