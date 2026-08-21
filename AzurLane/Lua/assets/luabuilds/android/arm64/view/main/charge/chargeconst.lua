ChargeConst = {}

function ChargeConst.getBuyCount(arg_1_0, arg_1_1)
	if not arg_1_0 then
		return 0
	end

	local var_1_0 = arg_1_0[arg_1_1]

	if arg_1_0[arg_1_1] then
		return var_1_0.buyCount or 0
	end
end

function ChargeConst.getGroupLimit(arg_2_0, arg_2_1)
	if not arg_2_0 then
		return 0
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if iter_2_1.shop_id == arg_2_1 then
			return iter_2_1.pay_count
		end
	end

	return 0
end

function ChargeConst.getGoodsLimitInfo(arg_3_0)
	local var_3_0
	local var_3_1
	local var_3_2

	if pg.shop_template[arg_3_0] then
		if type(pg.shop_template[arg_3_0].limit_args[1]) == "table" then
			for iter_3_0, iter_3_1 in ipairs(pg.shop_template[arg_3_0].limit_args) do
				if iter_3_1[1] == "level" then
					var_3_0 = iter_3_1[2]
				elseif iter_3_1[1] == "count" then
					var_3_1 = iter_3_1[2]
					var_3_2 = iter_3_1[3]
				end
			end
		elseif type(pg.shop_template[arg_3_0].limit_args[1]) == "string" then
			if pg.shop_template[arg_3_0].limit_args[1] == "level" then
				var_3_0 = pg.shop_template[arg_3_0].limit_args[2]
			elseif pg.shop_template[arg_3_0].limit_args[1] == "count" then
				var_3_1 = pg.shop_template[arg_3_0].limit_args[2]
				var_3_2 = pg.shop_template[arg_3_0].limit_args[3]
			end
		end
	end

	return var_3_0, var_3_1, var_3_2
end

function ChargeConst.isNeedSetBirth()
	return false
end

return ChargeConst
