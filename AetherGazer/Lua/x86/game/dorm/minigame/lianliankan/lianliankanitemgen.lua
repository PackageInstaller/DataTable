local var_0_0 = class("LianLianKanItemGen")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.weights = {}
	arg_1_0.total = arg_1_1
	arg_1_0.offset = 0

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		var_1_0 = var_1_0 + iter_1_1[2]
		arg_1_0.weights[iter_1_1[1]] = arg_1_1 * iter_1_1[2]
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_0.weights) do
		arg_1_0.weights[iter_1_2] = iter_1_3 / var_1_0
	end
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = math.random() * (arg_2_1 + arg_2_2)

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_1 > 0 then
			var_2_0 = var_2_0 - iter_2_1

			if var_2_0 < 0 then
				return iter_2_0
			end
		end
	end

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0) do
		table.insert(var_2_1, iter_2_2)
	end

	return var_2_1[math.random(#var_2_1)]
end

function var_0_0.Take(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1(arg_3_0.weights, arg_3_0.total, arg_3_0.offset)
	local var_3_1 = arg_3_0.weights[var_3_0]

	arg_3_0:Pop(var_3_0, arg_3_1)

	return var_3_0
end

function var_0_0.Peek(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = clone(arg_4_0.weights)
	local var_4_1 = arg_4_0.total
	local var_4_2 = arg_4_0.offset
	local var_4_3 = {}

	for iter_4_0 = 1, arg_4_1 do
		local var_4_4 = var_0_1(var_4_0, var_4_1, var_4_2)
		local var_4_5 = var_4_0[var_4_4]

		var_4_1 = var_4_1 - arg_4_2
		var_4_0[var_4_4] = var_4_5 - arg_4_2

		if var_4_0[var_4_4] < 0 then
			var_4_2 = var_4_2 - var_4_0[var_4_4]
		end

		table.insert(var_4_3, var_4_4)
	end

	return var_4_3
end

function var_0_0.Pop(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.total = arg_5_0.total - arg_5_2

	local var_5_0 = (arg_5_0.weights[arg_5_1] or 0) - arg_5_2

	arg_5_0.weights[arg_5_1] = var_5_0

	if var_5_0 < 0 then
		arg_5_0.offset = arg_5_0.offset + math.min(-var_5_0, arg_5_2)
	end
end

function var_0_0.Return(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.weights[arg_6_1] or 0

	arg_6_0.weights[arg_6_1] = var_6_0 + arg_6_2
	arg_6_0.total = arg_6_0.total + arg_6_2

	if var_6_0 < 0 then
		arg_6_0.offset = arg_6_0.offset - math.min(-var_6_0, arg_6_2)
	end
end

return var_0_0
