class = var_0_10000

local var_0_0 = "IslandSettingsGraphicsPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.Setting.panels.SettingsBasePanel"))

var_0_1.EVT_UPDTAE = "IslandSettingsGraphicsPanle:EVT_UPDTAE"

function var_0_1.GetUIName(arg_1_0)
	return "IslandSettingsStorySpeed"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_quality")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / STANDBY MODE SETTINGS"
end

function var_0_1.InitTitle(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_3.Find(var_4_0, "title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_1.OnInit(arg_5_0)
	CustomIndexLayer = var_1_10001

	local var_5_0 = var_1_10001.Clone2Full
	local var_5_1 = arg_5_0._tf

	arg_5_0.lowToggle = var_5_0(var_3.Find(var_5_1, "speeds"), 4)[1]
	arg_5_0.mediumToggle = var_1[2]
	arg_5_0.highToggle = var_1[3]
	arg_5_0.playerToggle = var_1[4]

	for iter_5_0 = 1, 4 do
		onToggle = var_6

		local var_5_2 = arg_5_0
		local var_5_3 = var_1[iter_5_0]

		local function var_5_4(arg_6_0)
			if arg_6_0 then
				PlayerPrefs = var_2_10001

				local var_6_0 = var_2_10001.GetInt

				GraphicSettingConst = var_2_10003

				local var_6_1

				if var_6_0(var_2_10003.PlayerGraphicLevelIsland, 0) ~= iter_5_0 then
					PlayerPrefs = var_6_1
					var_6_1 = var_6_1.SetInt
					GraphicSettingConst = var_4

					var_6_1(var_4.PlayerGraphicLevelIsland, iter_5_0)
				end

				pg = var_6_1

				local var_6_2 = var_6_1.m02
				local var_6_3 = var_2.sendNotification

				IslandSettingsPage = var_2_10005

				var_6_3(var_6_2, var_2_10005.SELECTGRAPHICSETTINGLEVEL)
			end

			return
		end

		SFX_UI_TAG = var_1_10011
		SFX_UI_TAG = var_1_10012

		var_6(var_5_2, var_5_3, var_5_4, var_1_10011, var_1_10012)
	end

	setText = var_2

	local var_5_5 = arg_5_0.lowToggle
	local var_5_6 = var_4.Find(var_5_5, "off/Text")

	i18n = iter_5_0

	var_2(var_5_6, iter_5_0("grapihcs3d_setting_quality_option_low"))

	setText = var_2

	local var_5_7 = arg_5_0.lowToggle
	local var_5_8 = var_4.Find(var_5_7, "on/Text")

	i18n = var_5

	var_2(var_5_8, var_5("grapihcs3d_setting_quality_option_low"))

	setText = var_2

	local var_5_9 = arg_5_0.mediumToggle
	local var_5_10 = var_4.Find(var_5_9, "off/Text")

	i18n = var_5

	var_2(var_5_10, var_5("grapihcs3d_setting_quality_option_medium"))

	setText = var_2

	local var_5_11 = arg_5_0.mediumToggle
	local var_5_12 = var_4.Find(var_5_11, "on/Text")

	i18n = var_5

	var_2(var_5_12, var_5("grapihcs3d_setting_quality_option_medium"))

	setText = var_2

	local var_5_13 = arg_5_0.highToggle
	local var_5_14 = var_4.Find(var_5_13, "off/Text")

	i18n = var_5

	var_2(var_5_14, var_5("grapihcs3d_setting_quality_option_high"))

	setText = var_2

	local var_5_15 = arg_5_0.highToggle
	local var_5_16 = var_4.Find(var_5_15, "on/Text")

	i18n = var_5

	var_2(var_5_16, var_5("grapihcs3d_setting_quality_option_high"))

	setText = var_2

	local var_5_17 = arg_5_0.playerToggle
	local var_5_18 = var_4.Find(var_5_17, "off/Text")

	i18n = var_5

	var_2(var_5_18, var_5("grapihcs3d_setting_quality_option_custom"))

	setText = var_2

	local var_5_19 = arg_5_0.playerToggle
	local var_5_20 = var_4.Find(var_5_19, "on/Text")

	i18n = var_5

	var_2(var_5_20, var_5("grapihcs3d_setting_quality_option_custom"))

	return
end

function var_0_1.OnUpdate(arg_7_0)
	PlayerPrefs = var_1_10001

	local var_7_0 = var_1_10001.GetInt

	GraphicSettingConst = var_1_10003

	if var_7_0(var_1_10003.PlayerGraphicLevelIsland, 2) == 1 then
		triggerToggle = var_1_10002

		var_1_10002(arg_7_0.lowToggle, true)
	elseif var_1 == 2 then
		triggerToggle = var_1_10002

		var_1_10002(arg_7_0.mediumToggle, true)
	elseif var_1 == 3 then
		triggerToggle = var_1_10002

		var_1_10002(arg_7_0.highToggle, true)
	else
		triggerToggle = var_1_10002

		var_1_10002(arg_7_0.playerToggle, true)
	end

	return
end

return var_0_1
