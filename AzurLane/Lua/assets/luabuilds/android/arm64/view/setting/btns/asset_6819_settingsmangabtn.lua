class = var_0_10000

local var_0_0 = "SettingsMangaBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsDownloadableBtn"))

function var_0_1.GetDownloadGroup(arg_1_0)
	return "MANGA"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("setting_resdownload_title_manga")
end

return var_0_1
