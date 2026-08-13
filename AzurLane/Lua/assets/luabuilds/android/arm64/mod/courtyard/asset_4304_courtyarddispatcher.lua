class = var_0_10000

local var_0_0 = var_0_10000("CourtYardDispatcher")

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
	assert = var_1_10003
	type = var_1_10005

	if var_1_10005(arg_3_1) == "string" then
		type = var_5

		local var_3_0

		if var_5(arg_3_2) ~= "function" then
			var_3_0 = false
		else
			var_3_0 = true
		end

		var_1_10003(var_3_0)

		local var_3_1

		if not arg_3_0.__callbacks[arg_3_1] then
			var_3_1 = arg_3_0.__callbacks
			var_3_1[arg_3_1] = {}
		end

		table = var_3_1

		var_3_1.insert(arg_3_0.__callbacks[arg_3_1], arg_3_2)

		return
	end
end

function var_0_0.RemoveListener(arg_4_0, arg_4_1, arg_4_2)
	assert = var_1_10003
	type = var_1_10005

	if var_1_10005(arg_4_1) == "string" then
		type = var_5

		local var_4_0

		if var_5(arg_4_2) ~= "function" then
			var_4_0 = false
		else
			var_4_0 = true
		end

		var_1_10003(var_4_0)

		if arg_4_0.__callbacks[arg_4_1] then
			for iter_4_0 = #var_3, 1, -1 do
				if var_3[iter_4_0] == arg_4_2 then
					table = var_8

					var_8.remove(var_3, iter_4_0)
				end
			end
		end

		return
	end
end

function var_0_0.ClearListener(arg_5_0, arg_5_1)
	assert = var_1_10002
	type = var_1_10004

	var_1_10002(var_1_10004(arg_5_1) == "string")

	arg_5_0.__callbacks[arg_5_1] = nil

	return
end

function var_0_0.DispatchEvent(arg_6_0, arg_6_1, ...)
	assert = var_1_10002
	type = var_1_10004

	var_1_10002(var_1_10004(arg_6_1) == "string")

	if arg_6_0.__callbacks[arg_6_1] then
		local var_6_0 = #var_2

		for iter_6_0 = 1, var_6_0 do
			arg_6_0.__list[iter_6_0] = var_2[iter_6_0]
		end

		for iter_6_1 = 1, var_6_0 do
			arg_6_0.__list[iter_6_1](arg_6_1, arg_6_0, ...)
		end
	end

	return
end

function var_0_0.ClearListeners(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.__callbacks) do
		arg_7_0.__callbacks[iter_7_0] = nil
	end

	ipairs = var_1

	for iter_7_2, iter_7_3 in var_1(arg_7_0.__list) do
		arg_7_0.__list[iter_7_2] = nil
	end

	return
end

return var_0_0
