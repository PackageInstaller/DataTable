class = var_0_10000

local var_0_0 = "SpecialWeaponActPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".LevelOpenActPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "AD/task_list/content/tpl/status/got/Text")

	i18n = var_1_10004

	var_1(var_1_1, var_1_10004("word_status_inEventFinished"))

	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "AD/tips/Text")

	i18n = var_4

	var_1(var_1_3, var_4("spweapon_activity_ui_text1"))

	setText = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.Find(var_1_4, "AD/tips/Text (1)")

	i18n = var_4

	var_1(var_1_5, var_4("spweapon_activity_ui_text2"))

	return
end

function var_0_1.UpdateTask(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.UpdateTask(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_2
	local var_2_1 = arg_2_2.getTaskStatus(var_2_0)
	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_1.Find(var_2_2, "canvas")

	setCanvasGroupAlpha = var_2_0

	var_2_0(var_2_3, 1)

	setActive = var_2_0

	var_2_0(arg_2_1:Find("mask"), var_2_1 == 2)

	local var_2_4 = arg_2_2:getConfig("desc")

	if var_2_1 == 2 then
		setSlider = var_2_2

		var_2_2(var_2_3:Find("progress"), 0, 1, 1)
	else
		var_2_2 = arg_2_2:getProgress()

		local var_2_5 = arg_2_2:getConfig("target_num")
		local var_2_6 = var_2_4
		local var_2_7 = " "

		setColorStr = var_10
		var_2_4 = var_2_6 .. var_2_7 .. var_10("(" .. var_2_2 .. "/" .. var_2_5 .. ")", "#FFD585FF")
		setSlider = var_2_6

		var_2_6(var_2_3:Find("progress"), 0, var_2_5, var_2_2)
	end

	setText = var_2_2

	var_2_2(arg_2_1:Find("canvas/Text"), var_2_4)

	return
end

return var_0_1
