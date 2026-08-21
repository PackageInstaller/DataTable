local var_0_0 = class("GridMap")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.map = {}
	arg_1_0.width = arg_1_1
	arg_1_0.height = arg_1_2
	arg_1_0.available = arg_1_0:GetAllGridIdxList()
end

function var_0_0.GetAllGridIdxList(arg_2_0)
	local var_2_0 = arg_2_0.width
	local var_2_1 = arg_2_0.height
	local var_2_2 = {}

	for iter_2_0 = 0, var_2_0 - 1 do
		for iter_2_1 = 0, var_2_1 - 1 do
			table.insert(var_2_2, arg_2_0:ToIdx(iter_2_0, iter_2_1))
		end
	end

	return var_2_2
end

function var_0_0.ToIdx(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 < 0 or arg_3_1 >= arg_3_0.width or arg_3_2 < 0 or arg_3_2 >= arg_3_0.height then
		return nil
	end

	arg_3_1 = arg_3_1 + var_0_1
	arg_3_2 = arg_3_2 + var_0_1

	return arg_3_2 * (arg_3_0.width + 2 * var_0_1) + arg_3_1
end

function var_0_0.ToCoord(arg_4_0, arg_4_1)
	return arg_4_1 % (arg_4_0.width + 2 * var_0_1) - var_0_1, math.floor(arg_4_1 / (arg_4_0.width + 2 * var_0_1)) - var_0_1
end

function var_0_0.Get(arg_5_0, arg_5_1, arg_5_2)
	return nullable(arg_5_0.map, arg_5_0:ToIdx(arg_5_1, arg_5_2))
end

function var_0_0.IsGridInMap(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_1 >= 0 and arg_6_1 < arg_6_0.width and arg_6_2 >= 0 and arg_6_2 < arg_6_0.height
end

function var_0_0.IsGridEmpty(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0:Get(arg_7_1, arg_7_2) == nil and arg_7_1 >= -1 and arg_7_1 <= arg_7_0.width and arg_7_2 >= -1 and arg_7_2 <= arg_7_0.height
end

function var_0_0.HasGridEmpty(arg_8_0, arg_8_1)
	if arg_8_1 > #arg_8_0.available then
		return nil
	end

	return unpack(arg_8_0.available, 1, arg_8_1)
end

function var_0_0.Put(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:ToIdx(arg_9_1, arg_9_2)

	if var_9_0 then
		local var_9_1 = arg_9_0.map[var_9_0]

		if var_9_1 == nil and arg_9_3 ~= nil then
			table.removebyvalue(arg_9_0.available, var_9_0)
		elseif var_9_1 ~= nil and arg_9_3 == nil then
			table.insert(arg_9_0.available, var_9_0)
		end

		arg_9_0.map[var_9_0] = arg_9_3
	end

	return var_9_0
end

function var_0_0.RndPut(arg_10_0, arg_10_1)
	if next(arg_10_0.available) == nil then
		return nil
	end

	local var_10_0 = math.random(#arg_10_0.available)

	arg_10_0.available[#arg_10_0.available], arg_10_0.available[var_10_0] = arg_10_0.available[var_10_0], arg_10_0.available[#arg_10_0.available]

	local var_10_1 = table.remove(arg_10_0.available)

	arg_10_0.map[var_10_1] = arg_10_1

	return var_10_1
end

function var_0_0.RemoveByIdx(arg_11_0, arg_11_1)
	if arg_11_0.map[arg_11_1] ~= nil then
		table.insert(arg_11_0.available, arg_11_1)

		arg_11_0.map[arg_11_1] = nil
	end
end

return var_0_0
