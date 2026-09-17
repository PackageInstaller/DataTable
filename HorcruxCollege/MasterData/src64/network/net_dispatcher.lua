local var_0_0 = {}
local var_0_1 = {}

function var_0_0.dispatch_request(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0

	if var_0_1[arg_1_1] then
		for iter_1_0, iter_1_1 in pairs(var_0_1[arg_1_1]) do
			var_1_0 = iter_1_1(arg_1_2)
		end
	end

	return var_1_0
end

function var_0_0.registerListener(arg_2_0, arg_2_1, arg_2_2)
	var_0_1[arg_2_2] = var_0_1[arg_2_2] or {}

	table.insert(var_0_1[arg_2_2], arg_2_1)

	return #var_0_1[arg_2_2]
end

function var_0_0.unregisterListener(arg_3_0, arg_3_1, arg_3_2)
	var_0_1[arg_3_1][arg_3_2] = nil
end

function var_0_0.unregisterAllListeners(arg_4_0)
	local var_4_0 = {
		logout_order = true,
		offline_alert = true,
		heartbeat = true
	}

	for iter_4_0, iter_4_1 in pairs(var_0_1) do
		if not var_4_0[iter_4_0] then
			var_0_1[iter_4_0] = nil
		end
	end
end

return var_0_0
