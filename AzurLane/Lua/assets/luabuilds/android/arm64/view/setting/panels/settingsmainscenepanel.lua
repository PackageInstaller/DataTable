local var_0_0 = class("SettingsMainScenePanel", import(".SettingsBasePanel"))

var_0_0.STANDBY_MODE_KEY = "STANDBY_MODE_KEY"
var_0_0.FLAGSHIP_INTERACTION_KEY = "FLAGSHIP_INTERACTION_KEY"

local var_0_1 = var_0_0.STANDBY_MODE_KEY
local var_0_2 = "TIME_SYSTEM_KEY"
local var_0_3 = var_0_0.FLAGSHIP_INTERACTION_KEY
local var_0_4 = "ENTER_STANDBY_MODE_TIME"
local var_0_5 = {
	[0] = 60,
	180,
	600
}

function var_0_0.IsEnableStandbyMode()
	return var_0_0.GetIntegerCache(var_0_1) == 1
end

function var_0_0.IsEnable24HourSystem()
	return var_0_0.GetIntegerCache(var_0_2) == 1
end

function var_0_0.IsEnableFlagShipInteraction()
	return var_0_0.GetIntegerCache(var_0_3) == 1
end

function var_0_0.GetEnterFlagShipValue()
	return (var_0_0.GetIntegerCache(var_0_4))
end

function var_0_0.GetEnterFlagShipTime()
	return var_0_5[var_0_0.GetEnterFlagShipValue()] or 60
end

function var_0_0.GetUIName(arg_6_0)
	return "SettingsMainScene"
end

function var_0_0.GetTitle(arg_7_0)
	return i18n("main_scene_settings")
end

function var_0_0.GetTitleEn(arg_8_0)
	return "   / STANDBY MODE SETTINGS"
end

function var_0_0.OnInit(arg_9_0)
	arg_9_0.subToggles = {}

	arg_9_0:InitTimeSystemToggle()
	arg_9_0:InitFlagShipInteractionToggle()
	arg_9_0:InitEnterStandbyModeTime()
	arg_9_0:InitStandbyModeToggle()

	return
end

function var_0_0.CommonToggleSetting(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
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

	onToggle(arg_10_0, var_10_0, function(arg_11_0)
		if arg_11_0 then
			var_0_0.SetIntegerCache(arg_10_2, 1)

			if arg_10_5 then
				arg_10_5(true)
			end
		end

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, var_10_1, function(arg_12_0)
		if arg_12_0 then
			var_0_0.SetIntegerCache(arg_10_2, 0)

			if arg_10_5 then
				arg_10_5(false)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitStandbyModeToggle(arg_13_0)
	arg_13_0:CommonToggleSetting(arg_13_0._tf:Find("options/1"), var_0_1, i18n("settings_enable_standby_mode"), var_0_0.IsEnableStandbyMode(), function(arg_14_0)
		arg_13_0:EnableOrDisableSubToggles(arg_14_0)

		return
	end)

	return
end

function var_0_0.EnableOrDisableSubToggles(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.subToggles) do
		local var_15_0 = GetOrAddComponent(iter_15_1, typeof(CanvasGroup))

		var_15_0.alpha = arg_15_1 and 1 or 0.7
		var_15_0.blocksRaycasts = arg_15_1
	end

	return
end

function var_0_0.InitTimeSystemToggle(arg_16_0)
	local var_16_0 = arg_16_0._tf:Find("options/2")

	arg_16_0:CommonToggleSetting(var_16_0, var_0_2, i18n("settings_time_system"), var_0_0.IsEnable24HourSystem())
	table.insert(arg_16_0.subToggles, var_16_0)

	return
end

function var_0_0.InitFlagShipInteractionToggle(arg_17_0)
	local var_17_0 = arg_17_0._tf:Find("options/3")

	arg_17_0:CommonToggleSetting(var_17_0, var_0_3, i18n("settings_flagship_interaction"), var_0_0.IsEnableFlagShipInteraction())
	table.insert(arg_17_0.subToggles, var_17_0)

	return
end

function var_0_0.InitEnterStandbyModeTime(arg_18_0)
	local var_18_0 = arg_18_0._tf:Find("time")

	setScrollText(var_18_0:Find("notify_tpl/mask/Text"), i18n("settings_enter_standby_mode_time"))

	local var_18_1 = {
		[0] = var_18_0:Find("notify_tpl/1"),
		var_18_0:Find("notify_tpl/2"),
		(var_18_0:Find("notify_tpl/3"))
	}

	table.insert(arg_18_0.subToggles, var_18_0)

	local var_18_2 = var_18_1[var_0_0.GetEnterFlagShipValue()]

	if var_18_2 then
		triggerToggle(var_18_2, true)
	end

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		onToggle(arg_18_0, iter_18_1, function(arg_19_0)
			if arg_19_0 then
				var_0_0.SetIntegerCache(var_0_4, iter_18_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SetIntegerCache(arg_20_0, arg_20_1)
	PlayerPrefs.SetInt(arg_20_0 .. "_" .. getProxy(PlayerProxy):getRawData().id, arg_20_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.GetIntegerCache(arg_21_0)
	return (PlayerPrefs.GetInt(arg_21_0 .. "_" .. getProxy(PlayerProxy):getRawData().id, 0))
end

return var_0_0
