local function var_0_0(arg_1_0, arg_1_1)
	return function(...)
		return arg_1_1(arg_1_0(unpack({
			...
		})))
	end
end

return function(arg_3_0, arg_3_1)
	if type(arg_3_0) == "function" then
		return var_0_0(arg_3_0, arg_3_1)
	end

	if type(arg_3_0) ~= "table" then
		error("        bindActionCreators expected a table or a function.")
	end

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if type(iter_3_1) == "function" then
			var_3_0[iter_3_0] = var_0_0(iter_3_1, arg_3_1)
		end
	end

	return var_3_0
end
