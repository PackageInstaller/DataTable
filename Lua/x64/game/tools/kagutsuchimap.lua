local var_0_0 = class("KagutsuchiMapGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.x = arg_1_1
	arg_1_0.y = arg_1_2
	arg_1_0.index = arg_1_3
	arg_1_0.value = nil
end

function var_0_0.SetValue(arg_2_0, arg_2_1)
	arg_2_0.value = arg_2_1
end

local var_0_1 = class("KagutsuchiMap")
local var_0_2 = {
	null_grid = true
}

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.length = 0
	arg_3_0.list = {}

	arg_3_0:InitMap(arg_3_1, arg_3_2)
end

function var_0_1.Clear(arg_4_0)
	arg_4_0.length = 0
	arg_4_0.list = {}
	arg_4_0.grids = {}
end

function var_0_1.InitMap(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.width = arg_5_1
	arg_5_0.height = arg_5_2
	arg_5_0.grids = {}

	for iter_5_0 = 1, arg_5_1 do
		arg_5_0.grids[iter_5_0] = {}

		for iter_5_1 = 1, arg_5_2 do
			arg_5_0.grids[iter_5_0][iter_5_1] = var_0_2
		end
	end
end

function var_0_1.GetGrid(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:IsOverbound(arg_6_1, arg_6_2) then
		return var_0_2
	end

	local var_6_0 = arg_6_0.grids[arg_6_1][arg_6_2]

	if var_6_0 == var_0_2 then
		return nil
	end

	return var_6_0.value
end

function var_0_1.GetGridByIndex(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.list[arg_7_1]

	if var_7_0 == var_0_2 then
		return nil
	end

	return var_7_0.value
end

function var_0_1.GetGridXY(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.list[arg_8_1]

	if var_8_0 == var_0_2 then
		return nil, nil
	end

	return var_8_0.x, var_8_0.y
end

function var_0_1.GetGridIndex(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0:IsOverbound(arg_9_1, arg_9_2) then
		return nil
	end

	local var_9_0 = arg_9_0.grids[arg_9_1][arg_9_2]

	if var_9_0 == var_0_2 then
		return nil
	end

	return var_9_0.index
end

function var_0_1.GetGridCount(arg_10_0)
	return arg_10_0.length
end

function var_0_1.PutGrid(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0:IsOverbound(arg_11_1, arg_11_2) then
		return nil
	end

	local var_11_0 = arg_11_0.grids[arg_11_1][arg_11_2]

	if var_11_0 == var_0_2 then
		var_11_0 = var_0_0.New(arg_11_1, arg_11_2, arg_11_0.length + 1)
		arg_11_0.grids[arg_11_1][arg_11_2] = var_11_0
		arg_11_0.list[var_11_0.index] = var_11_0
		arg_11_0.length = arg_11_0.length + 1
	end

	local var_11_1 = var_11_0.value

	var_11_0:SetValue(arg_11_3)

	return var_11_1
end

function var_0_1.HasGrid(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:GetGrid(arg_12_1, arg_12_2) ~= var_0_2
end

function var_0_1.IsOverbound(arg_13_0, arg_13_1, arg_13_2)
	return not (arg_13_1 > 0) or not (arg_13_1 <= arg_13_0.width) or not (arg_13_2 > 0) or not (arg_13_2 <= arg_13_0.height)
end

return var_0_1
