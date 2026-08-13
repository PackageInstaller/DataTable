class = var_0_10000

local var_0_0 = "SettingsGraphicsPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

var_0_1.EVT_UPDTAE = "SettingsGraphicsPanle:EVT_UPDTAE"

function var_0_1.GetUIName(arg_1_0)
	return "SettingsStorySpeed"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_quality")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_1.OnInit(arg_4_0)
	CustomIndexLayer = var_1_10001

	local var_4_0 = var_1_10001.Clone2Full
	local var_4_1 = arg_4_0._tf

	arg_4_0.lowToggle = var_4_0(var_2.Find(var_4_1, "speeds"), 4)[1]
	arg_4_0.mediumToggle = var_1[2]
	arg_4_0.highToggle = var_1[3]
	arg_4_0.playerToggle = var_1[4]

	for iter_4_0 = 1, 4 do
		onToggle = var_1_10006

		local var_4_2 = arg_4_0
		local var_4_3 = var_1[iter_4_0]

		local function var_4_4(arg_5_0)
			if arg_5_0 then
				PlayerPrefs = var_2_10001

				local var_5_1

				if var_2_10001.GetInt("dorm3d_graphics_settings_new", 0) ~= iter_4_0 then
					pg = var_5_1

					local var_5_0 = var_5_1.m02

					var_5_1 = var_5_1.sendNotification
					GAME = var_2_10004
					var_2_10004 = var_2_10004.APARTMENT_TRACK
					Dorm3dTrackCommand = var_2_10005

					var_5_1(var_5_0, var_2_10004, var_2_10005.BuildDataGraphics(iter_4_0))

					PlayerPrefs = var_5_1

					var_5_1.SetInt("dorm3d_graphics_settings_new", iter_4_0)
				end

				pg = var_5_1

				local var_5_2 = var_5_1.m02
				local var_5_3 = var_2.sendNotification

				NewSettingsMediator = var_2_10004

				var_5_3(var_5_2, var_2_10004.SelectGraphicSettingLevel)
			end

			return
		end

		SFX_UI_TAG = var_1_10010
		SFX_UI_TAG = var_1_10011

		var_1_10006(var_4_2, var_4_3, var_4_4, var_1_10010, var_1_10011)
	end

	setText = var_2

	local var_4_5 = arg_4_0.lowToggle
	local var_4_6 = var_3.Find(var_4_5, "Text")

	i18n = var_4_5

	var_2(var_4_6, var_4_5("grapihcs3d_setting_quality_option_low"))

	setText = var_2

	local var_4_7 = arg_4_0.mediumToggle
	local var_4_8 = var_3.Find(var_4_7, "Text")

	i18n = var_4_7

	var_2(var_4_8, var_4_7("grapihcs3d_setting_quality_option_medium"))

	setText = var_2

	local var_4_9 = arg_4_0.highToggle
	local var_4_10 = var_3.Find(var_4_9, "Text")

	i18n = var_4_9

	var_2(var_4_10, var_4_9("grapihcs3d_setting_quality_option_high"))

	setText = var_2

	local var_4_11 = arg_4_0.playerToggle
	local var_4_12 = var_3.Find(var_4_11, "Text")

	i18n = var_4_11

	var_2(var_4_12, var_4_11("grapihcs3d_setting_quality_option_custom"))

	return
end

function var_0_1.OnUpdate(arg_6_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.GetInt("dorm3d_graphics_settings_new", 2) == 1 then
		triggerToggle = var_2

		var_2(arg_6_0.lowToggle, true)
	elseif var_1 == 2 then
		triggerToggle = var_2

		var_2(arg_6_0.mediumToggle, true)
	elseif var_1 == 3 then
		triggerToggle = var_2

		var_2(arg_6_0.highToggle, true)
	else
		triggerToggle = var_2

		var_2(arg_6_0.playerToggle, true)
	end

	return
end

return var_0_1
