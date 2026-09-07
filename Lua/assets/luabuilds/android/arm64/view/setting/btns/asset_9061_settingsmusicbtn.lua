local SettingsMusicBtn = class("SettingsMusicBtn", import(".SettingsDownloadableBtn"))

function SettingsMusicBtn:GetDownloadGroup()
	return "GALLERY_BGM"
end

function SettingsMusicBtn:GetTitle()
	return i18n("setting_resdownload_title_music")
end

return SettingsMusicBtn
