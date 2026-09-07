local HamanIITaskSkinPage = class("HamanIITaskSkinPage", import(".TemplatePage.DayDoubleTaskTemplatePage"))

function HamanIITaskSkinPage:UpdateProgress()
	self:setChildVisible(self.dayTF, false)
	setActive(findTF(self.dayTF, tostring(self.nday)), true)

	return
end

function HamanIITaskSkinPage:setChildVisible(arg_2_1, arg_2_2)
	for iter_2_0 = 1, arg_2_1.childCount do
		setActive(arg_2_1:GetChild(iter_2_0 - 1), arg_2_2)
	end

	return
end

function HamanIITaskSkinPage:UpdateTask(arg_3_1, arg_3_2)
	HamanIITaskSkinPage.super.UpdateTask(self, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_2:Find("go_btn")
	local var_3_1 = arg_3_2:Find("get_btn")
	local var_3_2 = arg_3_2:Find("got_btn")

	setText(arg_3_2:Find("go_btn/Text"), i18n("island_word_go"))
	setText(arg_3_2:Find("get_btn/Text"), i18n("handbook_research_final_task_btn_claim"))
	setText(arg_3_2:Find("got_btn/Text"), i18n("handbook_research_final_task_btn_finished"))

	return
end

return HamanIITaskSkinPage
