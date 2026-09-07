local SettingsLive2DBtn = class("SettingsLive2DBtn", import(".SettingsDownloadableBtn"))

function SettingsLive2DBtn:GetDownloadGroup()
	return "L2D"
end

function SettingsLive2DBtn:GetTitle()
	return i18n("setting_resdownload_title_live2d")
end

return SettingsLive2DBtn
