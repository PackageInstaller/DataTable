local var_0_0 = class("AnniversaryUSFiveLoginPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.item, false)
	arg_1_0.itemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			updateDrop(arg_2_2:Find("item"), {
				type = arg_1_0.config.front_drops[arg_2_1 + 1][1],
				id = arg_1_0.config.front_drops[arg_2_1 + 1][2],
				count = arg_1_0.config.front_drops[arg_2_1 + 1][3]
			})
			onButton(arg_1_0, arg_2_2, function()
				arg_1_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_2_2:Find("got"), arg_2_1 < arg_1_0.nday)

			local var_2_0 = arg_2_2:Find("day/Text")

			if not IsNil(var_2_0) then
				local var_2_1 = arg_2_1 < arg_1_0.nday and i18n("word_status_inEventFinished") or i18n("which_day_2", arg_2_1 + 1)

				setText(var_2_0, var_2_1)
			end
		end

		return
	end)

	return
end

return var_0_0
