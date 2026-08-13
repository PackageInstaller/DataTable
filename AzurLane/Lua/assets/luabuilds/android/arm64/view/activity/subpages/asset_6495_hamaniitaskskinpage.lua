class = var_0_10000

local var_0_0 = "HamanIITaskSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.DayDoubleTaskTemplatePage"))

function var_0_1.UpdateProgress(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.setChildVisible(var_1_0, arg_1_0.dayTF, false)

	setActive = var_1
	findTF = var_1_0

	local var_1_1 = arg_1_0.dayTF

	tostring = var_1_10006

	var_1(var_1_0(var_1_1, var_1_10006(arg_1_0.nday)), true)

	return
end

function var_0_1.setChildVisible(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, arg_2_1.childCount do
		local var_2_0 = arg_2_1:GetChild(iter_2_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_2_0, arg_2_2)
	end

	return
end

function var_0_1.UpdateTask(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.UpdateTask(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_2:Find("go_btn")
	local var_3_1 = arg_3_2
	local var_3_2 = arg_3_2.Find(var_3_1, "get_btn")
	local var_3_3 = arg_3_2:Find("got_btn")

	setText = var_3_1

	local var_3_4 = arg_3_2:Find("go_btn/Text")

	i18n = var_1_10009

	var_3_1(var_3_4, var_1_10009("island_word_go"))

	setText = var_3_1

	local var_3_5 = arg_3_2:Find("get_btn/Text")

	i18n = var_9

	var_3_1(var_3_5, var_9("handbook_research_final_task_btn_claim"))

	setText = var_3_1

	local var_3_6 = arg_3_2:Find("got_btn/Text")

	i18n = var_9

	var_3_1(var_3_6, var_9("handbook_research_final_task_btn_finished"))

	return
end

return var_0_1
