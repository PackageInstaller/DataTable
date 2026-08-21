local var_0_0 = class("ThirdAnniversarySignPageKR", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("mask/items")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.initItems = {}

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.item, false)
	arg_2_0.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0

			if not table.contains(arg_2_0.initItems, arg_3_1) then
				updateDrop(arg_3_2:Find("item"), {
					type = arg_2_0.config.front_drops[arg_3_1 + 1][1],
					id = arg_2_0.config.front_drops[arg_3_1 + 1][2],
					count = arg_2_0.config.front_drops[arg_3_1 + 1][3]
				})
				onButton(arg_2_0, arg_3_2, function()
					arg_2_0:emit(BaseUI.ON_DROP, var_0)

					return
				end, SFX_PANEL)
				table.insert(arg_2_0.initItems, arg_3_1)

				var_3_0 = setActive
			end

			var_3_0(arg_3_2:Find("got"), arg_3_1 < arg_2_0.nday)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)
	eachChild(arg_5_0.items, function(arg_6_0)
		return
	end)

	return
end

return var_0_0
