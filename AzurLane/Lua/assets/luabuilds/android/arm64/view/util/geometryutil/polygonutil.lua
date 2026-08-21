local var_0_0 = import(".SegmentUtil")
local var_0_2 = 1e-06

local function var_0_3(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = 0, #arg_2_1 do
		local var_2_1 = arg_2_1[var_0(iter_2_0)]
		local var_2_2 = arg_2_1[var_0(iter_2_0 + 1)]

		if (var_2_1.y <= arg_2_0.y and var_2_2.y - var_0_2 > arg_2_0.y or var_2_2.y <= arg_2_0.y and var_2_1.y - var_0_2 > arg_2_0.y) and (var_2_1.x >= arg_2_0.x or var_2_2.x >= arg_2_0.x) and arg_2_0.x + var_0_2 < var_2_1.x + (arg_2_0.y - var_2_1.y) / (var_2_2.y - var_2_1.y) * (var_2_2.x - var_2_1.x) then
			var_2_0 = var_2_0 + 1
		end
	end

	return var_2_0
end

local function var_0_4(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = arg_5_4

	while arg_5_4 ~= arg_5_5 do
		local var_5_1 = var_0(arg_5_4 + 1, #arg_5_3)

		if var_0_0.IsSegamentCross(arg_5_0, arg_5_1, arg_5_2[arg_5_3[arg_5_4]], arg_5_2[arg_5_3[var_5_1]]) then
			return true
		end

		var_5_0 = var_5_1
	end

	return false
end

local function var_0_5(arg_8_0)
	if #arg_8_0 < 3 then
		return 0
	end

	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0 = 1, #arg_8_0 do
		local var_8_2 = arg_8_0[var_0(iter_8_0 + 1, #arg_8_0)]

		var_8_0 = var_8_0 + arg_8_0[iter_8_0].x * var_8_2.y
		var_8_1 = var_8_1 + arg_8_0[iter_8_0].y * var_8_2.x
	end

	return (var_8_0 - var_8_1) / 2
end

;({}).CycleIndex = function(arg_1_0, arg_1_1)
	return (arg_1_0 - 1) % arg_1_1 + 1
end
;({}).RayCross = function(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = 0, #arg_2_1 do
		local var_2_1 = arg_2_1[var_0(iter_2_0)]
		local var_2_2 = arg_2_1[var_0(iter_2_0 + 1)]

		if (var_2_1.y <= arg_2_0.y and var_2_2.y - var_0_2 > arg_2_0.y or var_2_2.y <= arg_2_0.y and var_2_1.y - var_0_2 > arg_2_0.y) and (var_2_1.x >= arg_2_0.x or var_2_2.x >= arg_2_0.x) and arg_2_0.x + var_0_2 < var_2_1.x + (arg_2_0.y - var_2_1.y) / (var_2_2.y - var_2_1.y) * (var_2_2.x - var_2_1.x) then
			var_2_0 = var_2_0 + 1
		end
	end

	return var_2_0
end
;({}).Contains = function(arg_3_0, arg_3_1)
	return bit.band(var_0_3(arg_3_0, arg_3_1), 1) > 0
end
;({}).IsPointInAngle = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = var_0_0.VectorCross(arg_4_0, arg_4_2, arg_4_1)
	local var_4_1 = var_0_0.VectorCross(arg_4_0, arg_4_1, arg_4_3)

	if var_0_0.IsZero((var_0_0.VectorCross(arg_4_0, arg_4_2, arg_4_3))) then
		return var_4_0 <= var_0_0.eps or var_4_1 <= var_0_0.eps
	else
		return var_4_0 <= var_0_0.eps and var_4_1 <= var_0_0.eps
	end

	return
end
;({}).IsCrossAnyEdge = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = arg_5_4

	while arg_5_4 ~= arg_5_5 do
		local var_5_1 = var_0(arg_5_4 + 1, #arg_5_3)

		if var_0_0.IsSegamentCross(arg_5_0, arg_5_1, arg_5_2[arg_5_3[arg_5_4]], arg_5_2[arg_5_3[var_5_1]]) then
			return true
		end

		var_5_0 = var_5_1
	end

	return false
end
;({}).Triangulated = function(arg_6_0)
	if #arg_6_0 < 4 then
		return {
			0,
			1,
			2
		}
	end

	local var_6_0 = {}

	for iter_6_0 = 1, #arg_6_0 do
		local var_6_1 = var_0_0.CycleIndex(iter_6_0 + 2)

		table.insert({}, iter_6_0)
		table.insert({}, {
			iter_6_0,
			Vector2.Distance(arg_6_0[iter_6_0], arg_6_0[var_6_1])
		})
	end

	table.sort({}, function(arg_7_0, arg_7_1)
		return arg_7_0[2] < arg_7_1[2]
	end)

	while #{} > 2 and #{} > 0 do
		local var_6_2 = table.indexof({}, ({})[1][1])
		local var_6_3 = var_0(var_6_2 + 2, #{})
		local var_6_4 = ({})[var_0(var_6_2 + 1, #{})]

		if var_0_0.VectorCross(arg_6_0[({})[1][1]], arg_6_0[({})[var_6_3]], arg_6_0[var_6_4]) > 0 and not var_0_4(arg_6_0[({})[1][1]], arg_6_0[({})[var_6_3]], arg_6_0, {}, var_6_3, var_6_2) then
			table.insert(var_6_0, ({})[1][1])
			table.insert(var_6_0, var_6_4)
			table.insert(var_6_0, ({})[var_6_3])

			local var_6_5 = ({})[var_0(var_6_2 - 1, #{})]
			local var_6_6 = ({})[var_0(var_6_3 + 1, #{})]

			for iter_6_1 = #{}, 1, -1 do
				if ({})[iter_6_1][1] == var_6_4 or ({})[iter_6_1][1] == var_6_5 then
					table.remove({}, iter_6_1)
				end
			end

			table.insert({}, {
				var_6_5,
				Vector2.Distance(arg_6_0[var_6_5], arg_6_0[({})[var_6_3]])
			})
			table.insert({}, {
				({})[1][1],
				Vector2.Distance(arg_6_0[({})[1][1]], arg_6_0[var_6_6])
			})
			table.remove({}, var_6_4)
			table.sort({}, function(arg_7_0, arg_7_1)
				return arg_7_0[2] < arg_7_1[2]
			end)
		end

		table.remove({}, 1)
	end

	return var_6_0
end
;({}).CalculateArea = function(arg_8_0)
	if #arg_8_0 < 3 then
		return 0
	end

	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0 = 1, #arg_8_0 do
		local var_8_2 = arg_8_0[var_0(iter_8_0 + 1, #arg_8_0)]

		var_8_0 = var_8_0 + arg_8_0[iter_8_0].x * var_8_2.y
		var_8_1 = var_8_1 + arg_8_0[iter_8_0].y * var_8_2.x
	end

	return (var_8_0 - var_8_1) / 2
end
;({}).IsPolygonClockwise = function(arg_9_0)
	return var_0_0.Sign((var_0_5(arg_9_0)))
end

return {}
