local var_0_0 = class("AgoraMap")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_0:GenMap(arg_1_1)

	return
end

function var_0_0.GenMap(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((AgoraCalc.GetArea(Vector2.zero, arg_2_1))) do
		if not ({})[iter_2_1.x] then
			({})[iter_2_1.x] = {}
		end

		;({})[iter_2_1.x][iter_2_1.y] = true
	end

	return {}
end

function var_0_0.UpdateSize(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:GenMap(arg_3_1)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if arg_3_0.map[iter_3_0] ~= nil and arg_3_0.map[iter_3_0][iter_3_2] ~= nil then
				var_3_0[iter_3_0][iter_3_2] = arg_3_0.map[iter_3_0][iter_3_2]
			end
		end
	end

	arg_3_0.map = var_3_0

	return
end

function var_0_0.UpdateMapState(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	assert(arg_4_0.map[arg_4_1], " position x is illegal " .. arg_4_1)

	arg_4_0.map[arg_4_1][arg_4_2] = arg_4_3

	return
end

function var_0_0.GetMapState(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.map[arg_5_1][arg_5_2]
end

function var_0_0.IsEmptyPoint(arg_6_0, arg_6_1)
	return arg_6_0.map[arg_6_1.x] and arg_6_0.map[arg_6_1.x][arg_6_1.y] == true
end

return var_0_0
