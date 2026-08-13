local var_0_0 = {}

ChargeConst = ChargeConst

function var_0.getBuyCount(arg_1_0, arg_1_1)
	if not arg_1_0 then
		return 0
	end

	local var_1_0

	if not arg_1_0[arg_1_1] or not var_2.buyCount then
		var_1_0 = 0
	end

	return var_1_0
end

function var_0.getGroupLimit(arg_2_0, arg_2_1)
	if not arg_2_0 then
		return 0
	end

	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0) do
		if iter_2_1.shop_id == arg_2_1 then
			return iter_2_1.pay_count
		end
	end

	return 0
end

function var_0.getGoodsLimitInfo(arg_3_0)
	local var_3_0
	local var_3_1
	local var_3_2

	pg = var_1_10004

	if var_1_10004.shop_template[arg_3_0] then
		local var_3_3 = var_5.limit_args[1]

		type = var_1_10007

		if var_1_10007(var_3_3) == "table" then
			ipairs = var_7

			for iter_3_0, iter_3_1 in var_7(var_5.limit_args) do
				if iter_3_1[1] == "level" then
					var_3_0 = iter_3_1[2]
				elseif var_12 == "count" then
					var_3_1 = iter_3_1[2]
					var_3_2 = iter_3_1[3]
				end
			end
		else
			type = var_7

			if var_7(var_3_3) == "string" then
				if var_3_3 == "level" then
					var_3_0 = var_5.limit_args[2]
				elseif var_3_3 == "count" then
					var_3_1 = var_5.limit_args[2]
					var_3_2 = var_5.limit_args[3]
				end
			end
		end
	end

	return var_3_0, var_3_1, var_3_2
end

function var_0.isNeedSetBirth()
	return false
end

return var_0
