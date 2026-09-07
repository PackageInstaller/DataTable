local IslandSettingsAdjustScreenPanle = class("IslandSettingsAdjustScreenPanle", import(".SettingsBasePanel"))

function IslandSettingsAdjustScreenPanle:GetUIName()
	return "SettingsAdjustScreen"
end

function IslandSettingsAdjustScreenPanle:GetTitle()
	return i18n("Settings_title_AdjustScr")
end

function IslandSettingsAdjustScreenPanle:GetTitleEn()
	return "  / SCREEN SETTING"
end

function IslandSettingsAdjustScreenPanle:OnInit()
	self.notchSlider = findTF(self._tf, "slider")

	return
end

function IslandSettingsAdjustScreenPanle:OnUpdate()
	local var_5_0 = getProxy(SettingsProxy)

	setSlider(self.notchSlider, ADAPT_MIN, math.clamp(Screen.width / Screen.height - 0.001, 1.3333333333333333, 2.3333333333333335), var_5_0:GetScreenRatio())
	OnSliderWithButton(self, self.notchSlider, function(arg_6_0)
		var_5_0:SetScreenRatio(arg_6_0)

		NotchAdapt.CheckNotchRatio = arg_6_0

		return
	end)

	return
end

return IslandSettingsAdjustScreenPanle
