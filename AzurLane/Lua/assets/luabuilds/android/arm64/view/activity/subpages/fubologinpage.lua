local var_0_0 = class("FuboLoginPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.item, false)
	arg_1_0.itemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			updateDrop(arg_2_2:Find("container/item"), (Drop.Create(arg_1_0.config.front_drops[arg_2_1 + 1])))
			onButton(arg_1_0, arg_2_2, function()
				arg_1_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_2_0 = arg_2_2:Find("got")
			local var_2_1 = arg_2_2:Find("container")

			var_2_1:GetComponent(typeof(CanvasGroup)).alpha = arg_2_1 < arg_1_0.nday and 0.5 or 1

			setActive(var_2_0, arg_2_1 < arg_1_0.nday)
		end

		return
	end)

	return
end

return var_0_0
