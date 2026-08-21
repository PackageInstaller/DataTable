local var_0_0 = class("CourtYardDispatcher")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.host = arg_1_1
	arg_1_0.__callbacks = {}
	arg_1_0.__list = {}

	return
end

function var_0_0.GetHost(arg_2_0)
	return arg_2_0.host
end

function var_0_0.AddListener(arg_3_0, arg_3_1, arg_3_2)
	assert(type(arg_3_1) == "string" and type(arg_3_2) == "function")

	arg_3_0.__callbacks[arg_3_1] = arg_3_0.__callbacks[arg_3_1] or {}

	table.insert(arg_3_0.__callbacks[arg_3_1], arg_3_2)

	return
end

function var_0_0.RemoveListener(arg_4_0, arg_4_1, arg_4_2)
	assert(type(arg_4_1) == "string" and type(arg_4_2) == "function")

	if arg_4_0.__callbacks[arg_4_1] then
		for iter_4_0 = #arg_4_0.__callbacks[arg_4_1], 1, -1 do
			if arg_4_0.__callbacks[arg_4_1][iter_4_0] == arg_4_2 then
				table.remove(arg_4_0.__callbacks[arg_4_1], iter_4_0)
			end
		end
	end

	return
end

function var_0_0.ClearListener(arg_5_0, arg_5_1)
	assert(type(arg_5_1) == "string")

	arg_5_0.__callbacks[arg_5_1] = nil

	return
end

function var_0_0.DispatchEvent(arg_6_0, arg_6_1, ...)
	assert(type(arg_6_1) == "string")

	if arg_6_0.__callbacks[arg_6_1] then
		for iter_6_0 = 1, #arg_6_0.__callbacks[arg_6_1] do
			arg_6_0.__list[iter_6_0] = arg_6_0.__callbacks[arg_6_1][iter_6_0]
		end

		for iter_6_1 = 1, #arg_6_0.__callbacks[arg_6_1] do
			arg_6_0.__list[iter_6_1](arg_6_1, arg_6_0, ...)
		end
	end

	return
end

function var_0_0.ClearListeners(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.__callbacks) do
		arg_7_0.__callbacks[iter_7_0] = nil
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.__list) do
		arg_7_0.__list[iter_7_2] = nil
	end

	return
end

return var_0_0
