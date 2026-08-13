class = var_0_10000

local var_0_0 = "SettingsPaintingDownloadPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsPaintingDownload"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("painting_prefs_setting_label")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / Painting Download"
end

var_0_1.None = 0
var_0_1.Min = 1
var_0_1.Max = 2

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0._tf

	var_4_0[1] = var_2.Find(var_4_1, "prefs/1")

	local var_4_2 = arg_4_0._tf

	var_4_0[2] = var_2.Find(var_4_2, "prefs/2")
	arg_4_0.btns = {}
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		local function var_4_3(arg_5_0)
			if arg_5_0 then
				getProxy = var_2_10001
				SettingsProxy = var_2_10003

				local var_5_0 = var_2_10001(var_2_10003)
				local var_5_1 = var_1.GetPaintingDownloadPrefs(var_5_0)

				if iter_4_0 == var_5_1 then
					return
				else
					getProxy = var_2
					SettingsProxy = var_2_10004

					local var_5_2 = var_2(var_2_10004)

					var_2.SetPaintingDownloadPrefs(var_5_2, iter_4_0)

					pg = var_2

					local var_5_3 = var_2.TipsMgr.GetInstance()
					local var_5_4 = var_2.ShowTips

					i18n = var_5

					var_5_4(var_5_3, var_5("painting_prefs_switch_succ"))
				end
			end

			return
		end

		onToggle = var_1_10008

		local var_4_4 = arg_4_0
		local var_4_5 = iter_4_1
		local var_4_6 = var_4_3

		SFX_PANEL = var_1_10013

		var_1_10008(var_4_4, var_4_5, var_4_6, var_1_10013)

		setText = var_1_10008

		local var_4_7 = iter_4_1:Find("Text")

		i18n = var_4_5

		var_1_10008(var_4_7, var_4_5("painting_prefs_setting_" .. iter_4_0))

		var_1_10008 = arg_4_0.btns
		var_1_10008[iter_4_0] = iter_4_1
	end

	return
end

function var_0_1.OnUpdate(arg_6_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetPaintingDownloadPrefs(var_6_0)

	IsUnityEditor = var_1_10002

	if var_1_10002 and var_6_1 == var_0_1.None then
		var_6_1 = var_0_1.Max

		return
	end

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.btns[var_6_1], true)

	return
end

return var_0_1
