local var_0_0 = class("SpecialWeaponActPage", import(".LevelOpenActPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	setText(arg_1_0._tf:Find("AD/task_list/content/tpl/status/got/Text"), i18n("word_status_inEventFinished"))
	setText(arg_1_0._tf:Find("AD/tips/Text"), i18n("spweapon_activity_ui_text1"))
	setText(arg_1_0._tf:Find("AD/tips/Text (1)"), i18n("spweapon_activity_ui_text2"))

	return
end

function var_0_0.UpdateTask(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.UpdateTask(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_2:getTaskStatus()
	local var_2_1 = arg_2_1:Find("canvas")

	setCanvasGroupAlpha(var_2_1, 1)
	setActive(arg_2_1:Find("mask"), var_2_0 == 2)

	local var_2_2 = arg_2_2:getConfig("desc")

	if var_2_0 == 2 then
		setSlider(var_2_1:Find("progress"), 0, 1, 1)
	else
		local var_2_3 = arg_2_2:getProgress()
		local var_2_4 = arg_2_2:getConfig("target_num")

		var_2_2 = var_2_2 .. " " .. setColorStr("(" .. var_2_3 .. "/" .. var_2_4 .. ")", "#FFD585FF")

		setSlider(var_2_1:Find("progress"), 0, var_2_4, var_2_3)
	end

	setText(arg_2_1:Find("canvas/Text"), var_2_2)

	return
end

return var_0_0
