local var_0_0 = class("SettingsResPage", import(".SettingsOptionPage"))

function var_0_0.getUIName(arg_1_0)
	return "SettingsCombinationWithBgPage"
end

function var_0_0.GetPanels(arg_2_0)
	return {
		SettingsSoundPanle,
		SettingsResUpdatePanel
	}
end

return var_0_0
