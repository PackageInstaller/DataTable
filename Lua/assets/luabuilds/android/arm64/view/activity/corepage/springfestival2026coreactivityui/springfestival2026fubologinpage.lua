local var_0_0 = class("SpringFestival2026FuboLoginPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.item = arg_1_0.bg:GetChild(0)
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = pg.activity_7_day_sign[arg_2_0.activity:getConfig("config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			updateDrop(arg_4_2:Find("container/item"), (Drop.Create(arg_3_0.config.front_drops[arg_4_1 + 1])))
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_4_0 = arg_4_2:Find("got")
			local var_4_1 = arg_4_2:Find("container")

			var_4_1:GetComponent(typeof(CanvasGroup)).alpha = arg_4_1 < arg_3_0.nday and 0.5 or 1

			setActive(var_4_0, arg_4_1 < arg_3_0.nday)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0.nday = arg_6_0.activity.data1

	arg_6_0.itemList:align(arg_6_0.Day)

	return
end

return var_0_0
