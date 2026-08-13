class = var_0_10000

local var_0_0 = "SettingsStoryAutoPlayPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsStoryAutoplay"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("story_autoplay_setting_label")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / AUTO"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0._tf

	var_4_0[1] = var_2.Find(var_4_1, "speeds/1")

	local var_4_2 = arg_4_0._tf

	var_4_0[2] = var_2.Find(var_4_2, "speeds/2")
	arg_4_0.btns = {}
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		onToggle = var_1_10007

		local var_4_3 = arg_4_0
		local var_4_4 = iter_4_1

		local function var_4_5(arg_5_0)
			if arg_5_0 then
				getProxy = var_2_10001
				SettingsProxy = var_2_10003

				local var_5_0 = var_2_10001(var_2_10003)

				var_1.SetStoryAutoPlayFlag(var_5_0, iter_4_0 - 1)
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_4_3, var_4_4, var_4_5, var_1_10012)

		setText = var_1_10007

		local var_4_6 = iter_4_1:Find("Text")

		i18n = var_4_4

		var_1_10007(var_4_6, var_4_4("story_autoplay_setting_" .. iter_4_0))

		var_1_10007 = arg_4_0.btns
		var_1_10007[iter_4_0] = iter_4_1
	end

	return
end

function var_0_1.OnUpdate(arg_6_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetStoryAutoPlayFlag(var_6_0) and 2 or 1

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.btns[var_6_1], true)

	return
end

return var_0_1
