local var_0_0 = class("SettingsMangaBtn", import(".SettingsDownloadableBtn"))

function var_0_0.GetDownloadGroup(arg_1_0)
	return "MANGA"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("setting_resdownload_title_manga")
end

return var_0_0
