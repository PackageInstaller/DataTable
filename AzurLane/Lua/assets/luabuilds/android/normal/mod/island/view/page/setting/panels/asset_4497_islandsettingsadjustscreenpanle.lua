class = var_0_10000

local var_0_0 = "IslandSettingsAdjustScreenPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.Setting.panels.SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandSettingsAdjustScreen"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_AdjustScr")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / SCREEN SETTING"
end

function var_0_1.InitTitle(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_2.Find(var_4_0, "title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_1.OnInit(arg_5_0)
	findTF = var_1_10001
	arg_5_0.notchSlider = var_1_10001(arg_5_0._tf, "slider")

	return
end

function var_0_1.OnUpdate(arg_6_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	math = var_1_10002

	local var_6_1 = var_1_10002.clamp

	Screen = var_1_10003

	local var_6_2 = var_1_10003.width

	Screen = var_1_10004

	local var_6_3 = var_6_1(var_6_2 / var_1_10004.height - 0.001, 1.3333333333333333, 2.3333333333333335)

	setSlider = var_3

	local var_6_4 = arg_6_0.notchSlider

	ADAPT_MIN = var_5

	var_3(var_6_4, var_5, var_6_3, var_6_0:GetScreenRatio())

	OnSliderWithButton = var_3

	var_3(arg_6_0, arg_6_0.notchSlider, function(arg_7_0)
		local var_7_0 = var_6_0

		var_1.SetScreenRatio(var_7_0, arg_7_0)

		NotchAdapt = var_1
		var_1.CheckNotchRatio = arg_7_0

		return
	end)

	return
end

return var_0_1
