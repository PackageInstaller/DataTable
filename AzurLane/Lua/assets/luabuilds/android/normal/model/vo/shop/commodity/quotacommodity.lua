class = var_0_10000

local var_0_0 = "QuotaCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_shop_template
end

function var_0_1.canPurchase(arg_2_0)
	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_1.GetPurchasableCnt(arg_3_0)
	math = var_1_10001

	return var_1_10001.max(arg_3_0:GetLimitGoodCount() - arg_3_0:GetOwnedGoodCount(), 0)
end

function var_0_1.GetOwnedGoodCount(arg_4_0)
	Drop = var_1_10001

	local var_4_0 = var_1_10001.New({
		id = arg_4_0:getConfig("commodity_id"),
		type = arg_4_0:getConfig("commodity_type"),
		count = arg_4_0:getConfig("num")
	})

	return var_1.getOwnedCount(var_4_0)
end

function var_0_1.GetLimitGoodCount(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "limit_args")

	type = var_5_0

	if var_5_0(var_5_1) == "table" then
		ipairs = var_2

		for iter_5_0, iter_5_1 in var_2(var_5_1) do
			if iter_5_1[1] == "quota" then
				return iter_5_1[2]
			end
		end
	end

	assert = var_2

	var_2(false, "good not limit_args 'quota' with id: " .. arg_5_0.id)

	return
end

return var_0_1
