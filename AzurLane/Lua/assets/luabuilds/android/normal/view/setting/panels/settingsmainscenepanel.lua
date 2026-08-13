class = var_0_10000

local var_0_0 = "SettingsMainScenePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

var_0_1.STANDBY_MODE_KEY = "STANDBY_MODE_KEY"
var_0_1.FLAGSHIP_INTERACTION_KEY = "FLAGSHIP_INTERACTION_KEY"

local var_0_2 = var_0_1.STANDBY_MODE_KEY
local var_0_3 = "TIME_SYSTEM_KEY"
local var_0_4 = var_0_1.FLAGSHIP_INTERACTION_KEY
local var_0_5 = "ENTER_STANDBY_MODE_TIME"
local var_0_6 = {
	[0] = 60,
	180,
	600
}

function var_0_1.IsEnableStandbyMode()
	return var_0_1.GetIntegerCache(var_0_2) == 1
end

function var_0_1.IsEnable24HourSystem()
	return var_0_1.GetIntegerCache(var_0_3) == 1
end

function var_0_1.IsEnableFlagShipInteraction()
	return var_0_1.GetIntegerCache(var_0_4) == 1
end

function var_0_1.GetEnterFlagShipValue()
	return (var_0_1.GetIntegerCache(var_0_5))
end

function var_0_1.GetEnterFlagShipTime()
	local var_5_0 = var_0_1.GetEnterFlagShipValue()
	local var_5_1

	if not var_0_6[var_5_0] then
		var_5_1 = 60
	end

	return var_5_1
end

function var_0_1.GetUIName(arg_6_0)
	return "SettingsMainScene"
end

function var_0_1.GetTitle(arg_7_0)
	i18n = var_1_10001

	return var_1_10001("main_scene_settings")
end

function var_0_1.GetTitleEn(arg_8_0)
	return "   / STANDBY MODE SETTINGS"
end

function var_0_1.OnInit(arg_9_0)
	arg_9_0.subToggles = {}

	arg_9_0:InitTimeSystemToggle()
	arg_9_0:InitFlagShipInteractionToggle()
	arg_9_0:InitEnterStandbyModeTime()
	arg_9_0:InitStandbyModeToggle()

	return
end

function var_0_1.CommonToggleSetting(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	setScrollText = var_1_10006

	var_1_10006(arg_10_1:Find("mask/Text"), arg_10_3)

	local var_10_0 = arg_10_1:Find("on")
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.Find(var_10_1, "off")

	if arg_10_4 then
		if arg_10_5 then
			arg_10_5(true)
		end

		triggerToggle = var_10_1

		var_10_1(var_10_0, true)
	else
		if arg_10_5 then
			arg_10_5(false)
		end

		triggerToggle = var_10_1

		var_10_1(var_10_2, true)
	end

	onToggle = var_10_1

	local var_10_3 = arg_10_0
	local var_10_4 = var_10_0

	local function var_10_5(arg_11_0)
		if arg_11_0 then
			var_0_1.SetIntegerCache(arg_10_2, 1)

			if arg_10_5 then
				arg_10_5(true)
			end
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_10_1(var_10_3, var_10_4, var_10_5, var_1_10012)

	onToggle = var_10_1

	local var_10_6 = arg_10_0
	local var_10_7 = var_10_2

	local function var_10_8(arg_12_0)
		if arg_12_0 then
			var_0_1.SetIntegerCache(arg_10_2, 0)

			if arg_10_5 then
				arg_10_5(false)
			end
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_10_1(var_10_6, var_10_7, var_10_8, var_1_10012)

	return
end

function var_0_1.InitStandbyModeToggle(arg_13_0)
	local var_13_0 = arg_13_0._tf
	local var_13_1 = var_1.Find(var_13_0, "options/1")
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.CommonToggleSetting
	local var_13_4 = var_13_1
	local var_13_5 = var_0_2

	i18n = var_1_10006

	var_13_3(var_13_2, var_13_4, var_13_5, var_1_10006("settings_enable_standby_mode"), var_0_1.IsEnableStandbyMode(), function(arg_14_0)
		local var_14_0 = arg_13_0

		var_1.EnableOrDisableSubToggles(var_14_0, arg_14_0)

		return
	end)

	return
end

function var_0_1.EnableOrDisableSubToggles(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.subToggles) do
		GetOrAddComponent = var_1_10007

		local var_15_0 = iter_15_1

		typeof = var_1_10009
		CanvasGroup = var_1_10010
		var_1_10007 = var_1_10007(var_15_0, var_1_10009(var_1_10010))
		var_1_10007.alpha = arg_15_1 and 1 or 0.7
		var_1_10007.blocksRaycasts = arg_15_1
	end

	return
end

function var_0_1.InitTimeSystemToggle(arg_16_0)
	local var_16_0 = arg_16_0._tf
	local var_16_1 = var_1.Find(var_16_0, "options/2")
	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.CommonToggleSetting
	local var_16_4 = var_16_1
	local var_16_5 = var_0_3

	i18n = var_1_10006

	var_16_3(var_16_2, var_16_4, var_16_5, var_1_10006("settings_time_system"), var_0_1.IsEnable24HourSystem())

	table = var_16_3

	var_16_3.insert(arg_16_0.subToggles, var_16_1)

	return
end

function var_0_1.InitFlagShipInteractionToggle(arg_17_0)
	local var_17_0 = arg_17_0._tf
	local var_17_1 = var_1.Find(var_17_0, "options/3")
	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.CommonToggleSetting
	local var_17_4 = var_17_1
	local var_17_5 = var_0_4

	i18n = var_1_10006

	var_17_3(var_17_2, var_17_4, var_17_5, var_1_10006("settings_flagship_interaction"), var_0_1.IsEnableFlagShipInteraction())

	table = var_17_3

	var_17_3.insert(arg_17_0.subToggles, var_17_1)

	return
end

function var_0_1.InitEnterStandbyModeTime(arg_18_0)
	local var_18_0 = arg_18_0._tf
	local var_18_1 = var_1.Find(var_18_0, "time")

	setScrollText = var_18_0

	local var_18_2 = var_18_1
	local var_18_3 = var_18_1.Find(var_18_2, "notify_tpl/mask/Text")

	i18n = var_18_2

	var_18_0(var_18_3, var_18_2("settings_enter_standby_mode_time"))

	local var_18_4 = {
		[0] = var_18_1:Find("notify_tpl/1"),
		var_18_1:Find("notify_tpl/2"),
		(var_18_1:Find("notify_tpl/3"))
	}

	table = var_3

	var_3.insert(arg_18_0.subToggles, var_18_1)

	if var_18_4[var_0_1.GetEnterFlagShipValue()] then
		triggerToggle = var_5

		var_5(var_4, true)
	end

	pairs = var_5

	for iter_18_0, iter_18_1 in var_5(var_18_4) do
		onToggle = var_1_10010

		local var_18_5 = arg_18_0
		local var_18_6 = iter_18_1

		local function var_18_7(arg_19_0)
			if arg_19_0 then
				var_0_1.SetIntegerCache(var_0_5, iter_18_0)
			end

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10010(var_18_5, var_18_6, var_18_7, var_1_10014)
	end

	return
end

function var_0_1.SetIntegerCache(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0
	local var_20_1 = "_"

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_20_2 = var_1_10004(var_1_10005)
	local var_20_3 = var_20_0 .. var_20_1 .. var_4.getRawData(var_20_2).id

	PlayerPrefs = var_20_1

	var_20_1.SetInt(var_20_3, arg_20_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.GetIntegerCache(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = "_"

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_21_2 = var_1_10003(var_1_10004)
	local var_21_3 = var_21_0 .. var_21_1 .. var_3.getRawData(var_21_2).id

	PlayerPrefs = var_21_1

	return (var_21_1.GetInt(var_21_3, 0))
end

return var_0_1
