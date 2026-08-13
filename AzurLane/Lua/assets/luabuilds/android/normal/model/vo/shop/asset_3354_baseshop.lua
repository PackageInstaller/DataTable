class = var_0_10000

local var_0_0 = "BaseShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.IsSameKind(arg_1_0, arg_1_1)
	assert = var_1_10002

	var_1_10002(false)

	return
end

function var_0_1.GetCommodityById(arg_2_0, arg_2_1)
	assert = var_1_10002

	var_1_10002(false)

	return
end

function var_0_1.GetCommodities(arg_3_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.IsPurchaseAll(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetCommodities(var_4_0)

	pairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
		if iter_4_1:canPurchase() then
			return false
		end
	end

	return true
end

return var_0_1
