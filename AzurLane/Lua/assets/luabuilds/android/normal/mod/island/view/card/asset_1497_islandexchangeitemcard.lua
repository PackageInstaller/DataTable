class = var_0_10000

local var_0_0 = "IslandExchangeItemCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandItemCard"))

function var_0_1.Update(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.item = arg_1_1

	local var_1_0 = arg_1_0.nameTxt
	local var_1_1 = arg_1_0

	var_1_0.text = arg_1_0.ShortenString(var_1_1, arg_1_1:GetName(), 6)
	updateCustomDrop = var_1_0

	local var_1_2 = arg_1_0._tf

	Drop = var_1_1

	local var_1_3 = var_1_1.New
	local var_1_4 = {}

	DROP_TYPE_ISLAND_ITEM = var_7
	var_1_4.type = var_7
	var_1_4.id = arg_1_1.id
	var_1_4.count = arg_1_1:GetCount()

	var_1_0(var_1_2, var_1_3(var_1_4))
	arg_1_0:UpdateValue(arg_1_2)

	return
end

return var_0_1
