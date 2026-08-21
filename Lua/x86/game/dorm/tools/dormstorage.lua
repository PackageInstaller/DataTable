local var_0_0 = singletonClass("DormStorage")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Reset(arg_2_0)
	if arg_2_0.storage == nil or next(arg_2_0.storage) ~= nil then
		arg_2_0.storage = {}
	end
end

function var_0_0.ClearData(arg_3_0, arg_3_1)
	arg_3_0.storage[arg_3_1] = nil
end

function var_0_0.RecordData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0.storage[arg_4_1] or {}

	var_4_0[arg_4_2] = arg_4_3
	arg_4_0.storage[arg_4_1] = var_4_0
end

function var_0_0.PickData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.storage[arg_5_1]

	if var_5_0 then
		local var_5_1, var_5_2 = next(var_5_0)

		return var_5_2
	end
end

local function var_0_1(arg_6_0)
	local var_6_0 = #arg_6_0

	return arg_6_0[math.random(1, var_6_0)]
end

function var_0_0.RndPickData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.storage[arg_7_1]

	if var_7_0 then
		local var_7_1

		if arg_7_2 then
			local var_7_2 = var_7_0

			return var_0_1(var_7_2)
		else
			local var_7_3 = {}

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				table.insert(var_7_3, iter_7_0)
			end

			return var_7_0[var_0_1(var_7_3)]
		end
	end
end

function var_0_0.PushBackData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.storage[arg_8_1] or {}

	table.insert(var_8_0, arg_8_2)

	arg_8_0.storage[arg_8_1] = var_8_0
end

function var_0_0.PopFrontData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.storage[arg_9_1]

	if var_9_0 then
		local var_9_1 = var_9_0[1]

		table.remove(var_9_0, 1)

		arg_9_0.storage[arg_9_1] = var_9_0

		return var_9_1
	end
end

function var_0_0.ForeachData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.storage[arg_10_1]

	if var_10_0 then
		return arg_10_2(var_10_0)
	else
		return function()
			return
		end, nil, nil
	end
end

function var_0_0.MapToData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.storage[arg_12_1], arg_12_2 = arg_12_2, arg_12_0.storage[arg_12_1]

	return arg_12_2
end

function var_0_0.GetData(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == "#" then
		local var_13_0 = arg_13_0.storage[arg_13_1]

		if var_13_0 then
			return #var_13_0, next(var_13_0)
		else
			return nil, nil
		end
	end

	return nullable(arg_13_0.storage, arg_13_1, arg_13_2)
end

return var_0_0
