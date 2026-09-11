return {
	Sort = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			table.insert(var_1_0, iter_1_1)
		end

		table.sort(var_1_0, function(arg_2_0, arg_2_1)
			return arg_2_0.id < arg_2_1.id
		end)

		return var_1_0
	end,
	materialGiveBack = function(arg_3_0, arg_3_1)
		if arg_3_0 <= 0 then
			return {}
		end

		local var_3_0 = {}

		for iter_3_0 = #ItemCfg.get_id_list_by_sub_type[arg_3_1], 1, -1 do
			var_3_0[iter_3_0] = math.modf(arg_3_0 / ItemCfg[ItemCfg.get_id_list_by_sub_type[arg_3_1][iter_3_0]].param[1])
			arg_3_0 = arg_3_0 - var_3_0[iter_3_0] * ItemCfg[ItemCfg.get_id_list_by_sub_type[arg_3_1][iter_3_0]].param[1]
		end

		local var_3_1 = {}

		for iter_3_1 = 1, 3 do
			if var_3_0[iter_3_1] ~= 0 then
				var_3_1[#var_3_1 + 1] = {
					ItemCfg.get_id_list_by_sub_type[arg_3_1][iter_3_1],
					var_3_0[iter_3_1]
				}
			end
		end

		return var_3_1
	end
}
