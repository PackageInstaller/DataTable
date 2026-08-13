class = var_0_10000

local var_0_0 = "SettingsFpsPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsFPS"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_FPS")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / FPS SETTING"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.fps30Toggle = var_1.Find(var_4_0, "options/30fps")

	local var_4_1 = arg_4_0._tf

	arg_4_0.fps60Toggle = var_1.Find(var_4_1, "options/60fps")
	onToggle = var_1

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.fps30Toggle

	local function var_4_4(arg_5_0)
		if arg_5_0 then
			QualitySettings = var_2_10001
			var_2_10001.vSyncCount = 0
			PlayerPrefs = var_2_10001

			var_2_10001.SetInt("fps_limit", 30)

			Application = var_1
			var_1.targetFrameRate = 30
		end

		return
	end

	SFX_UI_TAG = var_1_10005
	SFX_UI_TAG = var_1_10006

	var_1(var_4_2, var_4_3, var_4_4, var_1_10005, var_1_10006)

	onToggle = var_1

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.fps60Toggle

	local function var_4_7(arg_6_0)
		if arg_6_0 then
			QualitySettings = var_2_10001
			var_2_10001.vSyncCount = 0
			PlayerPrefs = var_2_10001

			var_2_10001.SetInt("fps_limit", 60)

			Application = var_1
			var_1.targetFrameRate = 60
		end

		return
	end

	SFX_UI_TAG = var_1_10005
	SFX_UI_TAG = var_1_10006

	var_1(var_4_5, var_4_6, var_4_7, var_1_10005, var_1_10006)

	setText = var_1

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_2.Find(var_4_8, "options/30fps/Text")
	local var_4_10 = "30"

	i18n = var_4

	var_1(var_4_9, var_4_10 .. var_4("word_frame"))

	setText = var_1

	local var_4_11 = arg_4_0._tf
	local var_4_12 = var_2.Find(var_4_11, "options/60fps/Text")
	local var_4_13 = "60"

	i18n = var_4

	var_1(var_4_12, var_4_13 .. var_4("word_frame"))

	return
end

function var_0_1.OnUpdate(arg_7_0)
	PlayerPrefs = var_1_10001

	local var_7_0 = var_1_10001.GetInt
	local var_7_1 = "fps_limit"

	DevicePerformanceUtil = var_1_10003

	if var_7_0(var_7_1, var_1_10003.GetDefaultFps()) == 30 then
		triggerToggle = var_7_1

		var_7_1(arg_7_0.fps30Toggle, true)
	end

	if var_1 == 60 then
		triggerToggle = var_7_1

		var_7_1(arg_7_0.fps60Toggle, true)
	end

	return
end

return var_0_1
