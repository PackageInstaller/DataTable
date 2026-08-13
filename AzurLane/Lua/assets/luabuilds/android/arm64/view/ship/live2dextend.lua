class = var_0_10000

local var_0_0 = var_0_10000("Live2DExtend")
local var_0_1 = {
	{
		1,
		2,
		3
	},
	{
		4,
		5,
		6
	},
	{
		7,
		8,
		9
	},
	{
		1,
		4,
		7
	},
	{
		2,
		5,
		8
	},
	{
		3,
		6,
		9
	},
	{
		1,
		5,
		9
	},
	{
		3,
		5,
		7
	}
}

function var_0_0.CheckXiaQiFirst(arg_1_0)
	Live2DExtend = var_1_10001

	if #var_1_10001.GetXiaQiDrags(arg_1_0) > 0 then
		Live2DExtend = var_2

		local var_1_0, var_1_1 = var_2.GetXiaQiState(var_1)

		if var_1_0 == var_1_1 or var_1_0 < var_1_1 then
			return true
		end
	end

	return false
end

function var_0_0.CheckXiaQiLast(arg_2_0)
	Live2DExtend = var_1_10001

	if #var_1_10001.GetXiaQiDrags(arg_2_0) > 0 then
		Live2DExtend = var_2

		local var_2_0, var_2_1 = var_2.GetXiaQiState(var_1)

		if var_2_1 < var_2_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetXiaQiDrags(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, #arg_3_0.drags do
		if arg_3_0.drags[iter_3_0] and var_7.actionTrigger then
			local var_3_1 = var_7.actionTrigger.type

			Live2DPainting = var_1_10009

			if var_3_1 == var_1_10009.DRAG_GAME_XIAQI then
				if arg_3_1 then
					table = var_3_1

					if var_3_1.contains(arg_3_1, var_7:getParameterTarget()) then
						table = var_3_1

						var_3_1.insert(var_3_0, var_7)
					end
				else
					table = var_3_1

					var_3_1.insert(var_3_0, var_7)
				end
			end
		end
	end

	return var_3_0
end

function var_0_0.GetXiaQiState(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0 = 1, #arg_4_0 do
		local var_4_2 = arg_4_0[iter_4_0]

		if var_7.getParameterTarget(var_4_2) < 0 then
			var_4_1 = var_4_1 + 1
		elseif var_8 > 0 then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.GetXiaQiLastDrag(arg_5_0)
	Live2DExtend = var_1_10001

	if var_1_10001.GetXiaQiDrags(arg_5_0, {
		0
	}) and #var_1 then
		math = var_2

		return var_1[var_2.random(1, #var_1)]
	end

	return nil
end

function var_0_0.CheckXiaQiFinish(arg_6_0)
	Live2DExtend = var_1_10001

	local var_6_0 = var_1_10001.GetXiaQiMatchsIndex(arg_6_0, {
		1
	})

	Live2DExtend = var_1_10002

	local var_6_1 = var_1_10002.GetXiaQiMatchsIndex(arg_6_0, {
		-1
	})

	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(var_0_1) do
		local var_6_2 = true
		local var_6_3 = true

		ipairs = var_1_10010

		for iter_6_2, iter_6_3 in var_1_10010(iter_6_1) do
			table = var_1_10015

			if not var_1_10015.contains(var_6_0, iter_6_3) then
				var_6_2 = false
			end

			table = var_1_10015

			if not var_1_10015.contains(var_6_1, iter_6_3) then
				var_6_3 = false
			end
		end

		if var_6_2 or var_6_3 then
			return true, var_6_2
		end
	end

	if #var_6_0 + #var_6_1 >= 9 then
		return true, true
	end

	return false, false
end

function var_0_0.GetXiaQiMatchsIndex(arg_7_0, arg_7_1)
	Live2DExtend = var_1_10002

	local var_7_0 = var_1_10002.GetXiaQiDrags(arg_7_0, arg_7_1)
	local var_7_1 = {}

	ipairs = var_4

	for iter_7_0, iter_7_1 in var_4(var_7_0) do
		local var_7_2 = iter_7_1.actionTrigger.index

		table = var_1_10010

		var_1_10010.insert(var_7_1, var_7_2)
	end

	return var_7_1
end

function var_0_0.CustomSmoothValue(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_2 == nil or arg_8_2 <= 0 then
		return arg_8_1, 0
	end

	arg_8_3 = arg_8_3 or 0

	if not arg_8_4 then
		Time = var_1_10005
		arg_8_4 = var_1_10005.deltaTime
	end

	math = var_1_10005

	local var_8_0 = var_1_10005.min

	math = var_1_10007

	local var_8_1 = var_8_0(var_1_10007.max(arg_8_3 + arg_8_4, 0), arg_8_2) / arg_8_2

	return arg_8_0 + (arg_8_1 - arg_8_0) * var_8_1, arg_8_3
end

return var_0_0
