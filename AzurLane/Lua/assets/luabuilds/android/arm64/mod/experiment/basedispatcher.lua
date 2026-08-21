local var_0_0 = class("BaseDispatcher")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.__callbacks = {}
	arg_1_0.__list = {}

	return
end

function var_0_0.AddListener(arg_2_0, arg_2_1, arg_2_2)
	assert(type(arg_2_1) == "string" and type(arg_2_2) == "function")

	arg_2_0.__callbacks[arg_2_1] = arg_2_0.__callbacks[arg_2_1] or {}

	table.insert(arg_2_0.__callbacks[arg_2_1], arg_2_2)

	return
end

function var_0_0.RemoveListener(arg_3_0, arg_3_1, arg_3_2)
	assert(type(arg_3_1) == "string" and type(arg_3_2) == "function")

	if arg_3_0.__callbacks[arg_3_1] then
		for iter_3_0 = #arg_3_0.__callbacks[arg_3_1], 1, -1 do
			if arg_3_0.__callbacks[arg_3_1][iter_3_0] == arg_3_2 then
				table.remove(arg_3_0.__callbacks[arg_3_1], iter_3_0)
			end
		end
	end

	return
end

function var_0_0.ClearListener(arg_4_0, arg_4_1)
	assert(type(arg_4_1) == "string")

	arg_4_0.__callbacks[arg_4_1] = nil

	return
end

function var_0_0.DispatchEvent(arg_5_0, arg_5_1, ...)
	assert(type(arg_5_1) == "string")

	if arg_5_0.__callbacks[arg_5_1] then
		for iter_5_0 = 1, #arg_5_0.__callbacks[arg_5_1] do
			arg_5_0.__list[iter_5_0] = arg_5_0.__callbacks[arg_5_1][iter_5_0]
		end

		for iter_5_1 = 1, #arg_5_0.__callbacks[arg_5_1] do
			arg_5_0.__list[iter_5_1](arg_5_1, arg_5_0, ...)
		end
	end

	return
end

function var_0_0.ClearListeners(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.__callbacks) do
		arg_6_0.__callbacks[iter_6_0] = nil
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.__list) do
		arg_6_0.__list[iter_6_2] = nil
	end

	return
end

return var_0_0
