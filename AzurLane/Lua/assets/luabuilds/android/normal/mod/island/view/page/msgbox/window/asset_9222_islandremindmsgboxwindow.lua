class = var_0_10000

local var_0_0 = "IslandRemindMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithRemind"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.remindToggle = var_1.Find(var_2_0, "remind")
	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "remind/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("island_no_remind_today"))

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.onYes then
			arg_3_0.onYes()
		end

		local var_4_0 = arg_3_0
		local var_4_1 = var_0.SaveValue
		local var_4_2 = arg_3_0.settings.key

		if arg_3_0.flag then
			GetZeroTime = var_3

			local var_4_3

			if not var_3() then
				var_4_3 = 0
			end

			var_4_1(var_4_0, var_4_2, var_4_3)

			local var_4_4 = arg_3_0

			var_0.Hide(var_4_4)

			return
		end
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0)
	var_0_1.super.OnShow(arg_5_0)

	local var_5_0 = arg_5_0.settings

	arg_5_0.flag = false
	assert = var_2

	var_2(var_5_0.key)
	arg_5_0:Flush(var_5_0)

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1)
	onToggle = var_1_10002

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.remindToggle

	local function var_6_2(arg_7_0)
		arg_6_0.flag = arg_7_0

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_6_0, var_6_1, var_6_2, var_1_10006)

	triggerToggle = var_1_10002

	var_1_10002(arg_6_0.remindToggle, arg_6_0.flag)

	return
end

function var_0_1.SaveValue(arg_8_0, arg_8_1, arg_8_2)
	PlayerPrefs = var_1_10003

	var_1_10003.SetInt(arg_8_1, arg_8_2)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

return var_0_1
