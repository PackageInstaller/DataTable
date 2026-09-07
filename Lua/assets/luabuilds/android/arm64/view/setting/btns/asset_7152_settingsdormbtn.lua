local SettingsDormBtn = class("SettingsDormBtn", import(".SettingsDownloadableBtn"))

function SettingsDormBtn:GetDownloadGroup()
	return "DORM"
end

function SettingsDormBtn:GetTitle()
	return i18n("setting_resdownload_title_dorm")
end

return SettingsDormBtn
