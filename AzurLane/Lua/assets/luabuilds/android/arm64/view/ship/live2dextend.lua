local var_0_0 = class("Live2DExtend")
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
	local var_1_0 = Live2DExtend.GetXiaQiDrags(arg_1_0)

	if #var_1_0 > 0 then
		local var_1_1, var_1_2 = Live2DExtend.GetXiaQiState(var_1_0)

		if var_1_1 == var_1_2 or var_1_1 < var_1_2 then
			return true
		end
	end

	return false
end

function var_0_0.CheckXiaQiLast(arg_2_0)
	local var_2_0 = Live2DExtend.GetXiaQiDrags(arg_2_0)

	if #var_2_0 > 0 then
		local var_2_1, var_2_2 = Live2DExtend.GetXiaQiState(var_2_0)

		if var_2_2 < var_2_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetXiaQiDrags(arg_3_0, arg_3_1)
	for iter_3_0 = 1, #arg_3_0.drags do
		if arg_3_0.drags[iter_3_0] and arg_3_0.drags[iter_3_0].actionTrigger and arg_3_0.drags[iter_3_0].actionTrigger.type == Live2DPainting.DRAG_GAME_XIAQI then
			if arg_3_1 then
				if table.contains(arg_3_1, arg_3_0.drags[iter_3_0]:getParameterTarget()) then
					table.insert({}, arg_3_0.drags[iter_3_0])
				end
			else
				table.insert({}, arg_3_0.drags[iter_3_0])
			end
		end
	end

	return {}
end

function var_0_0.GetXiaQiState(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0 = 1, #arg_4_0 do
		local var_4_2 = arg_4_0[iter_4_0]:getParameterTarget()

		if var_4_2 < 0 then
			var_4_1 = var_4_1 + 1
		elseif var_4_2 > 0 then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.GetXiaQiLastDrag(arg_5_0)
	local var_5_0 = Live2DExtend.GetXiaQiDrags(arg_5_0, {
		0
	})

	if var_5_0 and #var_5_0 then
		return var_5_0[math.random(1, #var_5_0)]
	end

	return nil
end

function var_0_0.CheckXiaQiFinish(arg_6_0)
	local var_6_0 = Live2DExtend.GetXiaQiMatchsIndex(arg_6_0, {
		1
	})
	local var_6_1 = Live2DExtend.GetXiaQiMatchsIndex(arg_6_0, {
		-1
	})

	for iter_6_0, iter_6_1 in ipairs(var_0_1) do
		local var_6_2 = true
		local var_6_3 = true

		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if not table.contains(var_6_0, iter_6_3) then
				var_6_2 = false
			end

			if not table.contains(var_6_1, iter_6_3) then
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
	for iter_7_0, iter_7_1 in ipairs((Live2DExtend.GetXiaQiDrags(arg_7_0, arg_7_1))) do
		table.insert({}, iter_7_1.actionTrigger.index)
	end

	return {}
end

function var_0_0.CustomSmoothValue(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_2 == nil or arg_8_2 <= 0 then
		return arg_8_1, 0
	end

	arg_8_3 = arg_8_3 or 0
	arg_8_4 = arg_8_4 or Time.deltaTime
	arg_8_3 = math.min(math.max(arg_8_3 + arg_8_4, 0), arg_8_2)

	return arg_8_0 + (arg_8_1 - arg_8_0) * (arg_8_3 / arg_8_2), arg_8_3
end

return var_0_0
