class = var_0_10000

local var_0_0 = "SettingsResPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsOptionPage"))

function var_0_1.getUIName(arg_1_0)
	return "SettingsCombinationWithBgPage"
end

function var_0_1.GetPanels(arg_2_0)
	local var_2_0 = {}

	SettingsSoundPanle = var_1_10002
	var_2_0[1] = var_1_10002
	SettingsResUpdatePanel = var_1_10002
	var_2_0[2] = var_1_10002

	return var_2_0
end

return var_0_1
