class = var_0_10000

local var_0_0 = "IslandItemMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithItems"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "items")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "items/tpl"))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)
	arg_3_0:FlushItems(arg_3_0.settings)

	return
end

function var_0_1.FlushItems(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.drops

	assert = var_1_10003

	var_1_10003(var_4_0)

	local var_4_1 = arg_4_0.uiItemList

	var_3.make(var_4_1, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = var_4_0[arg_5_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_5_2, var_5_0)
		end

		return
	end)

	local var_4_2 = arg_4_0.uiItemList

	var_3.align(var_4_2, #var_4_0)

	return
end

return var_0_1
