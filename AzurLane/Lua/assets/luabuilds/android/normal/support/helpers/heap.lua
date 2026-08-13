class = var_0_10000

local var_0_0 = var_0_10000("Heap")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.array = arg_1_1
	arg_1_0.func = arg_1_2

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	underscore = var_1_10001
	arg_2_0.values = var_1_10001.map(arg_2_0.array, function(arg_3_0)
		return arg_2_0.func(arg_3_0)
	end)
	arg_2_0.length = #arg_2_0.array
	math = var_1

	for iter_2_0 = var_1.floor(arg_2_0.length / 2), 1, -1 do
		arg_2_0:Dive(iter_2_0)
	end

	return
end

function var_0_0.Float(arg_4_0, arg_4_1)
	math = var_1_10002

	local var_4_0 = var_1_10002.floor(arg_4_1 / 2)

	while var_4_0 > 0 and arg_4_0.values[arg_4_1] < arg_4_0.values[var_4_0] do
		arg_4_0.array[var_4_0], arg_4_0.array[arg_4_1] = arg_4_0.array[arg_4_1], arg_4_0.array[var_4_0]

		local var_4_1 = arg_4_0.values
		local var_4_2 = arg_4_0.values

		var_4_1[var_4_0], var_4_2[arg_4_1] = arg_4_0.values[arg_4_1], arg_4_0.values[var_4_0]

		local var_4_3 = var_4_0

		math = var_4_2
		var_4_0 = var_4_2.floor(var_4_0 / 2)
		arg_4_1 = var_4_3
	end

	return arg_4_1
end

function var_0_0.Dive(arg_5_0, arg_5_1)
	local var_5_0 = var_2 + (arg_5_1 + arg_5_1 < arg_5_0.length and arg_5_0.values[var_2 + 1] < arg_5_0.values[var_2] and 1 or 0)

	while var_5_0 <= arg_5_0.length and arg_5_0.values[var_5_0] < arg_5_0.values[arg_5_1] do
		arg_5_0.array[var_5_0], arg_5_0.array[arg_5_1] = arg_5_0.array[arg_5_1], arg_5_0.array[var_5_0]
		arg_5_0.values[var_5_0], arg_5_0.values[arg_5_1] = arg_5_0.values[arg_5_1], arg_5_0.values[var_5_0]
		arg_5_1, var_5_0 = var_5_0, var_5_0 + var_5_0
		var_5_0 = var_5_0 + (var_5_0 < arg_5_0.length and arg_5_0.values[var_5_0 + 1] < arg_5_0.values[var_5_0] and 1 or 0)
	end

	return arg_5_1
end

function var_0_0.UpdateValue(arg_6_0, arg_6_1)
	if not arg_6_0:GetInedex(arg_6_1) then
		return
	end

	arg_6_0.values[var_2] = arg_6_0.func(arg_6_0.array[var_2])

	local var_6_0 = arg_6_0:Float(var_2)
	local var_6_1 = arg_6_0:Dive(var_6_0)

	return
end

function var_0_0.POP(arg_7_0, arg_7_1)
	if arg_7_1 then
		var_1_10003 = arg_7_0

		local var_7_0

		if not arg_7_0.GetInedex(var_1_10003, arg_7_1) then
			var_7_0 = 1
		end

		assert = var_1_10003

		var_1_10003(arg_7_0.length == #arg_7_0.values)

		local var_7_1

		if var_7_0 == arg_7_0.length then
			arg_7_0.length = arg_7_0.length - 1
		else
			var_7_1 = arg_7_0.array
			var_7_1[var_7_0], arg_7_0.array[arg_7_0.length] = arg_7_0.array[arg_7_0.length], arg_7_0.array[var_7_0]
			var_7_1 = arg_7_0.values
			var_7_1[var_7_0], arg_7_0.values[arg_7_0.length] = arg_7_0.values[arg_7_0.length], arg_7_0.values[var_7_0]
			arg_7_0.length = arg_7_0.length - 1

			arg_7_0:Dive(var_7_0)
		end

		table = var_7_1

		local var_7_2 = var_7_1.remove(arg_7_0.array)

		table = var_4

		local var_7_3 = var_4.remove(arg_7_0.values)
	end
end

function var_0_0.PUSH(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.insert(arg_8_0.array, arg_8_1)

	table = var_2

	var_2.insert(arg_8_0.values, arg_8_0.func(arg_8_1))

	arg_8_0.length = arg_8_0.length + 1

	arg_8_0:Float(arg_8_0.length)

	return
end

function var_0_0.GetLength(arg_9_0)
	return arg_9_0.length
end

function var_0_0.GetInedex(arg_10_0, arg_10_1)
	table = var_1_10002

	return var_1_10002.indexof(arg_10_0.array, arg_10_1)
end

function var_0_0.GetTop(arg_11_0)
	return {
		element = arg_11_0.array[1],
		value = arg_11_0.values[1]
	}
end

return var_0_0
