local var_0_0 = class("JapanFifthLoginPage", import(".TemplatePage.LoginTemplatePage"))

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
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)
	setText(arg_4_0.bg:Find("Text"), arg_4_0.nday .. "/" .. arg_4_0.Day)

	return
end

return var_0_0
