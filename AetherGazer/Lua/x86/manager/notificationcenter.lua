local var_0_0 = singletonClass("NotificationCenter")

var_0_0.AllListener = {}

function var_0_0.RegistListener(arg_1_0, arg_1_1, arg_1_2)
	if not var_0_0.AllListener[arg_1_1] then
		var_0_0.AllListener[arg_1_1] = {}
	end

	table.insert(var_0_0.AllListener[arg_1_1], arg_1_2)
end

function var_0_0.RemoveListener(arg_2_0, arg_2_1, arg_2_2)
	if var_0_0.AllListener[arg_2_1] then
		local var_2_0 = table.keyof(var_0_0.AllListener[arg_2_1], arg_2_2)

		if var_2_0 then
			table.remove(var_0_0.AllListener[arg_2_1], var_2_0)
		end
	end
end

function var_0_0.Invoke(arg_3_0, arg_3_1, ...)
	if var_0_0.AllListener[arg_3_1] then
		for iter_3_0, iter_3_1 in pairs(var_0_0.AllListener[arg_3_1]) do
			iter_3_1(...)
		end
	end
end

function var_0_0.GenerateNotifyString(...)
	local var_4_0 = {
		...
	}

	return (table.concat(var_4_0, "_"))
end

function var_0_0.CallUpdateFunc(arg_5_0, arg_5_1, ...)
	local var_5_0 = gameContext:GetAllOpenPage()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1[arg_5_1] then
			iter_5_1[arg_5_1](iter_5_1, ...)
		end
	end
end

function var_0_0.CallFirstUpdateFunc(arg_6_0, arg_6_1, ...)
	local var_6_0 = gameContext:GetAllOpenPage()

	for iter_6_0 = #var_6_0, 1, -1 do
		local var_6_1 = var_6_0[iter_6_0]

		if var_6_1[arg_6_1] then
			return var_6_1[arg_6_1](var_6_1, ...)
		end
	end
end

return var_0_0
