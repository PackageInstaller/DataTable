class = var_0_10000

local var_0_0 = "IslandSettingsAdjustScreenPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAdjustScreen"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_AdjustScr")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / SCREEN SETTING"
end

function var_0_1.OnInit(arg_4_0)
	findTF = var_1_10001
	arg_4_0.notchSlider = var_1_10001(arg_4_0._tf, "slider")

	return
end

function var_0_1.OnUpdate(arg_5_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)

	math = var_1_10002

	local var_5_1 = var_1_10002.clamp

	Screen = var_1_10004

	local var_5_2 = var_1_10004.width

	Screen = var_1_10005

	local var_5_3 = var_5_1(var_5_2 / var_1_10005.height - 0.001, 1.3333333333333333, 2.3333333333333335)

	setSlider = var_1_10003

	local var_5_4 = arg_5_0.notchSlider

	ADAPT_MIN = var_6

	var_1_10003(var_5_4, var_6, var_5_3, var_5_0:GetScreenRatio())

	OnSliderWithButton = var_1_10003

	var_1_10003(arg_5_0, arg_5_0.notchSlider, function(arg_6_0)
		local var_6_0 = var_5_0

		var_1.SetScreenRatio(var_6_0, arg_6_0)

		NotchAdapt = var_1
		var_1.CheckNotchRatio = arg_6_0

		return
	end)

	return
end

return var_0_1
