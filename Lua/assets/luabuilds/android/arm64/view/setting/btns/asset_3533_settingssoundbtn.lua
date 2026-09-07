local SettingsSoundBtn = class("SettingsSoundBtn", import(".SettingsDownloadableBtn"))

function SettingsSoundBtn:GetDownloadGroup()
	return "CV"
end

function SettingsSoundBtn:GetTitle()
	return i18n("setting_resdownload_title_sound")
end

return SettingsSoundBtn
