local SettingsGalleryBtn = class("SettingsGalleryBtn", import(".SettingsDownloadableBtn"))

function SettingsGalleryBtn:GetDownloadGroup()
	return "GALLERY_PIC"
end

function SettingsGalleryBtn:GetTitle()
	return i18n("setting_resdownload_title_gallery")
end

return SettingsGalleryBtn
