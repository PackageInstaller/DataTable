local var_0_0 = class("AnniversaryNineLoginPage", import("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.itemGroup = arg_1_0.bg:Find("bg_item")
	arg_1_0.item = arg_1_0.itemGroup:Find("item")
	arg_1_0.items = arg_1_0.itemGroup:Find("items")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.btnMore = arg_1_0.bg:Find("btn_more")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.item, false)
	arg_2_0.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			updateDrop(arg_3_2:Find("item"), {
				type = arg_2_0.config.front_drops[arg_3_1 + 1][1],
				id = arg_2_0.config.front_drops[arg_3_1 + 1][2],
				count = arg_2_0.config.front_drops[arg_3_1 + 1][3]
			})
			onButton(arg_2_0, arg_3_2, function()
				arg_2_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_3_2:Find("got"), arg_3_1 < arg_2_0.nday)
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.btnMore, function()
		Application.OpenURL(arg_2_0.activity:getConfig("config_client")[1])

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	var_0_0.super.OnUpdateFlush(arg_6_0)
	setText(arg_6_0.itemGroup:Find("Text"), arg_6_0.nday .. "/" .. arg_6_0.Day)

	return
end

return var_0_0
