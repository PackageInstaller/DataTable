local var_0_0 = class("Heap")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.array = arg_1_1
	arg_1_0.func = arg_1_2

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.values = underscore.map(arg_2_0.array, function(arg_3_0)
		return arg_2_0.func(arg_3_0)
	end)
	arg_2_0.length = #arg_2_0.array

	for iter_2_0 = math.floor(arg_2_0.length / 2), 1, -1 do
		arg_2_0:Dive(iter_2_0)
	end

	return
end

function var_0_0.Float(arg_4_0, arg_4_1)
	local var_4_0 = math.floor(arg_4_1 / 2)

	while var_4_0 > 0 and arg_4_0.values[arg_4_1] < arg_4_0.values[var_4_0] do
		arg_4_0.array[var_4_0], arg_4_0.array[arg_4_1] = arg_4_0.array[arg_4_1], arg_4_0.array[var_4_0]
		arg_4_0.values[var_4_0], arg_4_0.values[arg_4_1] = arg_4_0.values[arg_4_1], arg_4_0.values[var_4_0]
		var_4_0 = math.floor(var_4_0 / 2)
		arg_4_1 = var_4_0
	end

	return arg_4_1
end

function var_0_0.Dive(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 + arg_5_1 < arg_5_0.length and arg_5_0.values[arg_5_1 + arg_5_1 + 1] < arg_5_0.values[arg_5_1 + arg_5_1] and 1 or 0
	local var_5_1 = arg_5_1 + arg_5_1 + var_5_0

	while var_5_1 <= arg_5_0.length and arg_5_0.values[var_5_1] < arg_5_0.values[arg_5_1] do
		arg_5_0.array[var_5_1], arg_5_0.array[arg_5_1] = arg_5_0.array[arg_5_1], arg_5_0.array[var_5_1]
		arg_5_0.values[var_5_1], arg_5_0.values[arg_5_1] = arg_5_0.values[arg_5_1], arg_5_0.values[var_5_1]
		var_5_1 = var_5_1 + var_5_1
		arg_5_1 = var_5_1

		local var_5_2 = var_5_1 < arg_5_0.length and arg_5_0.values[var_5_1 + 1] < arg_5_0.values[var_5_1] and 1 or 0

		var_5_1 = var_5_1 + var_5_2
	end

	return arg_5_1
end

function var_0_0.UpdateValue(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetInedex(arg_6_1)

	if not var_6_0 then
		return
	end

	arg_6_0.values[var_6_0] = arg_6_0.func(arg_6_0.array[var_6_0])

	local var_6_1 = arg_6_0:Dive((arg_6_0:Float(var_6_0)))

	return
end

function var_0_0.POP(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and arg_7_0:GetInedex(arg_7_1) or 1

	assert(arg_7_0.length == #arg_7_0.values)

	if var_7_0 == arg_7_0.length then
		arg_7_0.length = arg_7_0.length - 1
	else
		local var_7_1 = arg_7_0.array

		arg_7_0.array[arg_7_0.length] = arg_7_0.array[var_7_0]
		var_7_1[var_7_0] = arg_7_0.array[arg_7_0.length]
		arg_7_0.values[arg_7_0.length] = arg_7_0.values[var_7_0]
		arg_7_0.values[var_7_0] = arg_7_0.values[arg_7_0.length]
		arg_7_0.length = arg_7_0.length - 1

		arg_7_0:Dive(var_7_0)
	end

	local var_7_2 = table.remove(arg_7_0.array)
	local var_7_3 = table.remove(arg_7_0.values)
end

function var_0_0.PUSH(arg_8_0, arg_8_1)
	table.insert(arg_8_0.array, arg_8_1)
	table.insert(arg_8_0.values, arg_8_0.func(arg_8_1))

	arg_8_0.length = arg_8_0.length + 1

	arg_8_0:Float(arg_8_0.length)

	return
end

function var_0_0.GetLength(arg_9_0)
	return arg_9_0.length
end

function var_0_0.GetInedex(arg_10_0, arg_10_1)
	return table.indexof(arg_10_0.array, arg_10_1)
end

function var_0_0.GetTop(arg_11_0)
	return {
		element = arg_11_0.array[1],
		value = arg_11_0.values[1]
	}
end

return var_0_0
