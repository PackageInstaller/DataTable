function deepClone(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		if type(arg_2_0) ~= "table" then
			return arg_2_0
		elseif var_1_0[arg_2_0] then
			return var_1_0[arg_2_0]
		end

		local var_2_0 = {}

		var_1_0[arg_2_0] = var_2_0

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_2_0[var_1_1(iter_2_0)] = var_1_1(iter_2_1)
		end

		return setmetatable(var_2_0, getmetatable(arg_2_0))
	end

	return var_1_1(arg_1_0)
end
