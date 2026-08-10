local var_0_0 = {
	PROXY_STATE = "__$immer_state",
	NOTHING = {
		["__$immer-nothing"] = true
	}
}

function var_0_0.isProxy(arg_1_0)
	return type(arg_1_0) == "table" and arg_1_0[var_0_0.PROXY_STATE]
end

function var_0_0.isProxyable(arg_2_0)
	return type(arg_2_0) == "table"
end

function var_0_0.original(arg_3_0)
	if arg_3_0 and arg_3_0[var_0_0.PROXY_STATE] then
		return arg_3_0[var_0_0.PROXY_STATE].base
	end
end

function var_0_0.each(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		arg_4_1(iter_4_0, iter_4_1)
	end
end

function var_0_0.shallowCopy(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		var_5_0[iter_5_0] = iter_5_1
	end

	return var_5_0
end

return var_0_0
