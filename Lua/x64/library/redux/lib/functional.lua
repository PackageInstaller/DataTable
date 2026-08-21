function head(arg_1_0)
	return arg_1_0[1]
end

function tail(arg_2_0)
	if table.getn(arg_2_0) < 1 then
		return nil
	else
		local var_2_0 = {}
		local var_2_1 = table.getn(arg_2_0)
		local var_2_2 = 2

		while var_2_2 <= var_2_1 do
			table.insert(var_2_0, var_2_2 - 1, arg_2_0[var_2_2])

			var_2_2 = var_2_2 + 1
		end

		return var_2_0
	end
end

function foldr(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(arg_3_2) do
		arg_3_1 = arg_3_0(arg_3_1, iter_3_1)
	end

	return arg_3_1
end

function reduce(arg_4_0, arg_4_1)
	return foldr(arg_4_0, head(arg_4_1), tail(arg_4_1))
end

function map(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(var_5_0, arg_5_0(iter_5_1))
	end

	return var_5_0
end
