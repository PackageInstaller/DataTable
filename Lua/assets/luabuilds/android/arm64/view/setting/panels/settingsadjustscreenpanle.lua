local var_0_0 = class("IslandSettingsAdjustScreenPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsAdjustScreen"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_AdjustScr")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / SCREEN SETTING"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.notchSlider = findTF(arg_4_0._tf, "slider")

	return
end

function var_0_0.OnUpdate(arg_5_0)
	local var_5_0 = getProxy(SettingsProxy)

	setSlider(arg_5_0.notchSlider, ADAPT_MIN, math.clamp(Screen.width / Screen.height - 0.001, 1.3333333333333333, 2.3333333333333335), getProxy(SettingsProxy):GetScreenRatio())
	OnSliderWithButton(arg_5_0, arg_5_0.notchSlider, function(arg_6_0)
		var_5_0:SetScreenRatio(arg_6_0)

		NotchAdapt.CheckNotchRatio = arg_6_0

		return
	end)

	return
end

return var_0_0
