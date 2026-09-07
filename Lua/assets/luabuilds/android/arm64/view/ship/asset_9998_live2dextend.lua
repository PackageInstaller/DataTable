local Live2DExtend = class("Live2DExtend")
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

function Live2DExtend:CheckXiaQiFirst()
	local var_1_0 = Live2DExtend.GetXiaQiDrags(self)

	if #var_1_0 > 0 then
		local var_1_1, var_1_2 = Live2DExtend.GetXiaQiState(var_1_0)

		if var_1_1 == var_1_2 or var_1_1 < var_1_2 then
			return true
		end
	end

	return false
end

function Live2DExtend:CheckXiaQiLast()
	local var_2_0 = Live2DExtend.GetXiaQiDrags(self)

	if #var_2_0 > 0 then
		local var_2_1, var_2_2 = Live2DExtend.GetXiaQiState(var_2_0)

		if var_2_2 < var_2_1 then
			return true
		end
	end

	return false
end

function Live2DExtend:GetXiaQiDrags(arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, #self.drags do
		if self.drags[iter_3_0] and self.drags[iter_3_0].actionTrigger and self.drags[iter_3_0].actionTrigger.type == Live2DPainting.DRAG_GAME_XIAQI then
			if arg_3_1 then
				if table.contains(arg_3_1, self.drags[iter_3_0]:getParameterTarget()) then
					table.insert(var_3_0, self.drags[iter_3_0])
				end
			else
				table.insert(var_3_0, self.drags[iter_3_0])
			end
		end
	end

	return var_3_0
end

function Live2DExtend:GetXiaQiState()
	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0 = 1, #self do
		local var_4_2 = self[iter_4_0]:getParameterTarget()

		if var_4_2 < 0 then
			var_4_1 = var_4_1 + 1
		elseif var_4_2 > 0 then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0, var_4_1
end

function Live2DExtend:GetXiaQiLastDrag()
	local var_5_0 = Live2DExtend.GetXiaQiDrags(self, {
		0
	})

	if var_5_0 and #var_5_0 then
		return var_5_0[math.random(1, #var_5_0)]
	end

	return nil
end

function Live2DExtend:CheckXiaQiFinish()
	local var_6_0 = Live2DExtend.GetXiaQiMatchsIndex(self, {
		1
	})
	local var_6_1 = Live2DExtend.GetXiaQiMatchsIndex(self, {
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

function Live2DExtend:GetXiaQiMatchsIndex(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs((Live2DExtend.GetXiaQiDrags(self, arg_7_1))) do
		table.insert(var_7_0, iter_7_1.actionTrigger.index)
	end

	return var_7_0
end

function Live2DExtend:CustomSmoothValue(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_2 == nil or arg_8_2 <= 0 then
		return arg_8_1, 0
	end

	arg_8_3 = arg_8_3 or 0
	arg_8_4 = arg_8_4 or Time.deltaTime
	arg_8_3 = math.min(math.max(arg_8_3 + arg_8_4, 0), arg_8_2)

	return self + (arg_8_1 - self) * (arg_8_3 / arg_8_2), arg_8_3
end

return Live2DExtend
