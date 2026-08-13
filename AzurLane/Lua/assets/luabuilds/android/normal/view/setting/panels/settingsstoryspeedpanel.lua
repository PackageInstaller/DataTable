class = var_0_10000

local var_0_0 = "SettingsStorySpeedPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsStorySpeed"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("story_setting_label")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / AUTO SPEED"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "speeds")

	arg_4_0.btns = {}

	for iter_4_0 = 1, var_4_1.childCount do
		local var_4_2 = var_4_1
		local var_4_3 = var_4_1.GetChild(var_4_2, iter_4_0 - 1)

		onToggle = var_4_2

		local var_4_4 = arg_4_0
		local var_4_5 = var_4_3

		local function var_4_6(arg_5_0)
			if arg_5_0 then
				Story = var_2_10001

				local var_5_0 = var_2_10001.STORY_AUTO_SPEED[iter_4_0]

				getProxy = var_2
				SettingsProxy = var_2_10003

				local var_5_1 = var_2(var_2_10003)

				var_2.SetStorySpeed(var_5_1, var_5_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_4_2(var_4_4, var_4_5, var_4_6, var_1_10011)

		setText = var_4_2

		local var_4_7 = var_4_3
		local var_4_8 = var_4_3.Find(var_4_7, "Text")

		i18n = var_4_7

		var_4_2(var_4_8, var_4_7("setting_story_speed_" .. iter_4_0))

		arg_4_0.btns[iter_4_0] = var_4_3
	end

	return
end

function var_0_1.OnUpdate(arg_6_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.GetStorySpeed(var_6_0)

	table = var_6_0

	local var_6_2 = var_6_0.indexof

	Story = var_1_10003

	local var_6_3

	if not var_6_2(var_1_10003.STORY_AUTO_SPEED, var_6_1) then
		var_6_3 = 2
	end

	triggerToggle = var_3

	var_3(arg_6_0.btns[var_6_3], true)

	return
end

return var_0_1
