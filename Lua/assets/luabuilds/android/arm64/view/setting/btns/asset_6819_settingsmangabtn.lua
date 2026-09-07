local SettingsMangaBtn = class("SettingsMangaBtn", import(".SettingsDownloadableBtn"))

function SettingsMangaBtn:GetDownloadGroup()
	return "MANGA"
end

function SettingsMangaBtn:GetTitle()
	return i18n("setting_resdownload_title_manga")
end

return SettingsMangaBtn
