class = var_0_10000

local var_0_0 = var_0_10000("BaseDispatcher")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.__callbacks = {}
	arg_1_0.__list = {}

	return
end

function var_0_0.AddListener(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003
	type = var_1_10004

	if var_1_10004(arg_2_1) == "string" then
		type = var_4

		local var_2_0

		if var_4(arg_2_2) ~= "function" then
			var_2_0 = false
		else
			var_2_0 = true
		end

		var_1_10003(var_2_0)

		local var_2_1

		if not arg_2_0.__callbacks[arg_2_1] then
			var_2_1 = arg_2_0.__callbacks
			var_2_1[arg_2_1] = {}
		end

		table = var_2_1

		var_2_1.insert(arg_2_0.__callbacks[arg_2_1], arg_2_2)

		return
	end
end

function var_0_0.RemoveListener(arg_3_0, arg_3_1, arg_3_2)
	assert = var_1_10003
	type = var_1_10004

	if var_1_10004(arg_3_1) == "string" then
		type = var_4

		local var_3_0

		if var_4(arg_3_2) ~= "function" then
			var_3_0 = false
		else
			var_3_0 = true
		end

		var_1_10003(var_3_0)

		if arg_3_0.__callbacks[arg_3_1] then
			for iter_3_0 = #var_3, 1, -1 do
				if var_3[iter_3_0] == arg_3_2 then
					table = var_8

					var_8.remove(var_3, iter_3_0)
				end
			end
		end

		return
	end
end

function var_0_0.ClearListener(arg_4_0, arg_4_1)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_4_1) == "string")

	arg_4_0.__callbacks[arg_4_1] = nil

	return
end

function var_0_0.DispatchEvent(arg_5_0, arg_5_1, ...)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_5_1) == "string")

	if arg_5_0.__callbacks[arg_5_1] then
		local var_5_0 = #var_2

		for iter_5_0 = 1, var_5_0 do
			arg_5_0.__list[iter_5_0] = var_2[iter_5_0]
		end

		for iter_5_1 = 1, var_5_0 do
			arg_5_0.__list[iter_5_1](arg_5_1, arg_5_0, ...)
		end
	end

	return
end

function var_0_0.ClearListeners(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.__callbacks) do
		arg_6_0.__callbacks[iter_6_0] = nil
	end

	ipairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0.__list) do
		arg_6_0.__list[iter_6_2] = nil
	end

	return
end

return var_0_0
