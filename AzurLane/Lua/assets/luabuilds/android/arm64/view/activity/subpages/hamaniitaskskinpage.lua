local var_0_0 = class("HamanIITaskSkinPage", import(".TemplatePage.DayDoubleTaskTemplatePage"))

function var_0_0.UpdateProgress(arg_1_0)
	arg_1_0:setChildVisible(arg_1_0.dayTF, false)
	setActive(findTF(arg_1_0.dayTF, tostring(arg_1_0.nday)), true)

	return
end

function var_0_0.setChildVisible(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, arg_2_1.childCount do
		setActive(arg_2_1:GetChild(iter_2_0 - 1), arg_2_2)
	end

	return
end

function var_0_0.UpdateTask(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.UpdateTask(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_2:Find("go_btn")
	local var_3_1 = arg_3_2:Find("get_btn")
	local var_3_2 = arg_3_2:Find("got_btn")

	setText(arg_3_2:Find("go_btn/Text"), i18n("island_word_go"))
	setText(arg_3_2:Find("get_btn/Text"), i18n("handbook_research_final_task_btn_claim"))
	setText(arg_3_2:Find("got_btn/Text"), i18n("handbook_research_final_task_btn_finished"))

	return
end

return var_0_0
