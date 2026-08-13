class = var_0_10000

local var_0_0 = var_0_10000("AgoraMap")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_0:GenMap(arg_1_1)

	return
end

function var_0_0.GenMap(arg_2_0, arg_2_1)
	local var_2_0 = {}

	AgoraCalc = var_1_10003

	local var_2_1 = var_1_10003.GetArea

	Vector2 = var_1_10005

	local var_2_2 = var_2_1(var_1_10005.zero, arg_2_1)

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(var_2_2) do
		local var_2_3 = iter_2_1.x
		local var_2_4 = iter_2_1.y

		if not var_2_0[var_2_3] then
			var_2_0[var_2_3] = {}
		end

		var_2_0[var_2_3][var_2_4] = true
	end

	return var_2_0
end

function var_0_0.UpdateSize(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GenMap(var_3_0, arg_3_1)
	local var_3_2 = arg_3_0.map

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1) do
		pairs = var_1_10009

		for iter_3_2, iter_3_3 in var_1_10009(iter_3_1) do
			if var_3_2[iter_3_0] ~= nil and var_3_2[iter_3_0][iter_3_2] ~= nil then
				var_3_1[iter_3_0][iter_3_2] = var_3_2[iter_3_0][iter_3_2]
			end
		end
	end

	arg_3_0.map = var_3_1

	return
end

function var_0_0.UpdateMapState(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	assert = var_1_10004

	var_1_10004(arg_4_0.map[arg_4_1], " position x is illegal " .. arg_4_1)

	arg_4_0.map[arg_4_1][arg_4_2] = arg_4_3

	return
end

function var_0_0.GetMapState(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.map[arg_5_1][arg_5_2]
end

function var_0_0.IsEmptyPoint(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_0.map[arg_6_1.x] then
		var_6_0 = arg_6_0.map[arg_6_1.x][arg_6_1.y] == true
	end

	return var_6_0
end

return var_0_0
