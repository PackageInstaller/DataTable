class = var_0_10000

local var_0_0 = "AnniversaryLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "mask/items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	eachChild = var_1

	var_1(arg_2_0.items, function(arg_3_0)
		local var_3_0 = arg_3_0:Find("day/Text")

		setText = var_2_10002

		var_2_10002(var_3_0, arg_3_0:GetSiblingIndex() + 1)

		return
	end)

	return
end

return var_0_1
