local var_0_0 = class("AnniversaryLoginPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("mask/items")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	var_0_0.super.OnUpdateFlush(arg_2_0)
	eachChild(arg_2_0.items, function(arg_3_0)
		setText(arg_3_0:Find("day/Text"), arg_3_0:GetSiblingIndex() + 1)

		return
	end)

	return
end

return var_0_0
