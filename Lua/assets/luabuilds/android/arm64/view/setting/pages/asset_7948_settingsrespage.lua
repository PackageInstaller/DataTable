local SettingsResPage = class("SettingsResPage", import(".SettingsOptionPage"))

function SettingsResPage:getUIName()
	return "SettingsCombinationWithBgPage"
end

function SettingsResPage:GetPanels()
	return {
		SettingsSoundPanle,
		SettingsResUpdatePanel
	}
end

return SettingsResPage
