local SettingsMapBtn = class("SettingsMapBtn", import(".SettingsDownloadableBtn"))

function SettingsMapBtn:GetDownloadGroup()
	return "MAP"
end

function SettingsMapBtn:GetTitle()
	return i18n("setting_resdownload_title_map")
end

return SettingsMapBtn
