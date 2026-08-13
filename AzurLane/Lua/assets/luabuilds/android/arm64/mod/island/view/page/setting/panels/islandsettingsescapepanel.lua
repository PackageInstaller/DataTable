class = var_0_10000

local var_0_0 = "IslandSettingsEscapePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.Setting.panels.SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandSettingsEscape"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_common_title")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / "
end

function var_0_1.InitTitle(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_3.Find(var_4_0, "title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.escapeBtn = var_1.Find(var_5_0, "options/escape/btn")
	setText = var_1

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "options/escape/mask/Text")

	i18n = var_4

	var_1(var_5_2, var_4("grapihcs3d_setting_common_unstuck"))

	setText = var_1

	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_3.Find(var_5_3, "options/escape/btn/Text")

	i18n = var_4

	var_1(var_5_4, var_4("grapihcs3d_setting_common_use"))

	onButton = var_1

	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.escapeBtn

	local function var_5_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.ISLAND_RESET_SP)

		return
	end

	SFX_PANEL = var_6

	var_1(var_5_5, var_5_6, var_5_7, var_6)

	return
end

function var_0_1.GetFlags(arg_7_0)
	return {}
end

return var_0_1
