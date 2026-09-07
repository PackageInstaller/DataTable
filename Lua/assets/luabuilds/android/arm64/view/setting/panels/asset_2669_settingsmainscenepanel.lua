local SettingsMainScenePanel = class("SettingsMainScenePanel", import(".SettingsBasePanel"))

SettingsMainScenePanel.STANDBY_MODE_KEY = "STANDBY_MODE_KEY"
SettingsMainScenePanel.FLAGSHIP_INTERACTION_KEY = "FLAGSHIP_INTERACTION_KEY"

local var_0_1 = SettingsMainScenePanel.STANDBY_MODE_KEY
local var_0_2 = "TIME_SYSTEM_KEY"
local var_0_3 = SettingsMainScenePanel.FLAGSHIP_INTERACTION_KEY
local var_0_4 = "ENTER_STANDBY_MODE_TIME"
local var_0_5 = {
	[0] = 60,
	180,
	600
}

function SettingsMainScenePanel.IsEnableStandbyMode()
	return SettingsMainScenePanel.GetIntegerCache(var_0_1) == 1
end

function SettingsMainScenePanel.IsEnable24HourSystem()
	return SettingsMainScenePanel.GetIntegerCache(var_0_2) == 1
end

function SettingsMainScenePanel.IsEnableFlagShipInteraction()
	return SettingsMainScenePanel.GetIntegerCache(var_0_3) == 1
end

function SettingsMainScenePanel.GetEnterFlagShipValue()
	return (SettingsMainScenePanel.GetIntegerCache(var_0_4))
end

function SettingsMainScenePanel.GetEnterFlagShipTime()
	return var_0_5[SettingsMainScenePanel.GetEnterFlagShipValue()] or 60
end

function SettingsMainScenePanel:GetUIName()
	return "SettingsMainScene"
end

function SettingsMainScenePanel:GetTitle()
	return i18n("main_scene_settings")
end

function SettingsMainScenePanel:GetTitleEn()
	return "   / STANDBY MODE SETTINGS"
end

function SettingsMainScenePanel:OnInit()
	self.subToggles = {}

	self:InitTimeSystemToggle()
	self:InitFlagShipInteractionToggle()
	self:InitEnterStandbyModeTime()
	self:InitStandbyModeToggle()

	return
end

function SettingsMainScenePanel:CommonToggleSetting(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	setScrollText(arg_10_1:Find("mask/Text"), arg_10_3)

	local var_10_0 = arg_10_1:Find("on")
	local var_10_1 = arg_10_1:Find("off")

	if arg_10_4 then
		if arg_10_5 then
			arg_10_5(true)
		end

		triggerToggle(var_10_0, true)
	else
		if arg_10_5 then
			arg_10_5(false)
		end

		triggerToggle(var_10_1, true)
	end

	onToggle(self, var_10_0, function(arg_11_0)
		if arg_11_0 then
			SettingsMainScenePanel.SetIntegerCache(arg_10_2, 1)

			if arg_10_5 then
				arg_10_5(true)
			end
		end

		return
	end, SFX_PANEL)
	onToggle(self, var_10_1, function(arg_12_0)
		if arg_12_0 then
			SettingsMainScenePanel.SetIntegerCache(arg_10_2, 0)

			if arg_10_5 then
				arg_10_5(false)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function SettingsMainScenePanel:InitStandbyModeToggle()
	self:CommonToggleSetting(self._tf:Find("options/1"), var_0_1, i18n("settings_enable_standby_mode"), SettingsMainScenePanel.IsEnableStandbyMode(), function(arg_14_0)
		self:EnableOrDisableSubToggles(arg_14_0)

		return
	end)

	return
end

function SettingsMainScenePanel:EnableOrDisableSubToggles(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.subToggles) do
		local var_15_0 = GetOrAddComponent(iter_15_1, typeof(CanvasGroup))

		var_15_0.alpha = arg_15_1 and 1 or 0.7
		var_15_0.blocksRaycasts = arg_15_1
	end

	return
end

function SettingsMainScenePanel:InitTimeSystemToggle()
	local var_16_0 = self._tf:Find("options/2")

	self:CommonToggleSetting(var_16_0, var_0_2, i18n("settings_time_system"), SettingsMainScenePanel.IsEnable24HourSystem())
	table.insert(self.subToggles, var_16_0)

	return
end

function SettingsMainScenePanel:InitFlagShipInteractionToggle()
	local var_17_0 = self._tf:Find("options/3")

	self:CommonToggleSetting(var_17_0, var_0_3, i18n("settings_flagship_interaction"), SettingsMainScenePanel.IsEnableFlagShipInteraction())
	table.insert(self.subToggles, var_17_0)

	return
end

function SettingsMainScenePanel:InitEnterStandbyModeTime()
	local var_18_0 = self._tf:Find("time")

	setScrollText(var_18_0:Find("notify_tpl/mask/Text"), i18n("settings_enter_standby_mode_time"))

	local var_18_1 = {
		[0] = var_18_0:Find("notify_tpl/1"),
		var_18_0:Find("notify_tpl/2"),
		(var_18_0:Find("notify_tpl/3"))
	}

	table.insert(self.subToggles, var_18_0)

	local var_18_2 = var_18_1[SettingsMainScenePanel.GetEnterFlagShipValue()]

	if var_18_2 then
		triggerToggle(var_18_2, true)
	end

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		onToggle(self, iter_18_1, function(arg_19_0)
			if arg_19_0 then
				SettingsMainScenePanel.SetIntegerCache(var_0_4, iter_18_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function SettingsMainScenePanel:SetIntegerCache(arg_20_1)
	PlayerPrefs.SetInt(self .. "_" .. getProxy(PlayerProxy):getRawData().id, arg_20_1)
	PlayerPrefs.Save()

	return
end

function SettingsMainScenePanel:GetIntegerCache()
	return (PlayerPrefs.GetInt(self .. "_" .. getProxy(PlayerProxy):getRawData().id, 0))
end

return SettingsMainScenePanel
