local var_0_0 = {}
local SegmentUtil = import(".SegmentUtil")
local var_0_3 = 1e-06

local function var_0_4(arg_1_0, arg_1_1)
	return (arg_1_0 - 1) % arg_1_1 + 1
end

local function var_0_5(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = 0, #arg_2_1 do
		local var_2_1 = arg_2_1[var_0_4(iter_2_0)]
		local var_2_2 = arg_2_1[var_0_4(iter_2_0 + 1)]

		if (var_2_1.y <= arg_2_0.y and var_2_2.y - var_0_3 > arg_2_0.y or var_2_2.y <= arg_2_0.y and var_2_1.y - var_0_3 > arg_2_0.y) and (var_2_1.x >= arg_2_0.x or var_2_2.x >= arg_2_0.x) and arg_2_0.x + var_0_3 < var_2_1.x + (arg_2_0.y - var_2_1.y) / (var_2_2.y - var_2_1.y) * (var_2_2.x - var_2_1.x) then
			var_2_0 = var_2_0 + 1
		end
	end

	return var_2_0
end

local function var_0_6(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = arg_5_4

	while arg_5_4 ~= arg_5_5 do
		local var_5_1 = var_0_4(arg_5_4 + 1, #arg_5_3)

		if SegmentUtil.IsSegamentCross(arg_5_0, arg_5_1, arg_5_2[arg_5_3[arg_5_4]], arg_5_2[arg_5_3[var_5_1]]) then
			return true
		end

		var_5_0 = var_5_1
	end

	return false
end

local function var_0_7(arg_8_0)
	if #arg_8_0 < 3 then
		return 0
	end

	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0 = 1, #arg_8_0 do
		local var_8_2 = arg_8_0[var_0_4(iter_8_0 + 1, #arg_8_0)]

		var_8_0 = var_8_0 + arg_8_0[iter_8_0].x * var_8_2.y
		var_8_1 = var_8_1 + arg_8_0[iter_8_0].y * var_8_2.x
	end

	return (var_8_0 - var_8_1) / 2
end

var_0_0.CycleIndex = var_0_4
var_0_0.RayCross = var_0_5

function var_0_0.Contains(arg_3_0, arg_3_1)
	return bit.band(var_0_5(arg_3_0, arg_3_1), 1) > 0
end

function var_0_0.IsPointInAngle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = SegmentUtil.VectorCross(arg_4_0, arg_4_2, arg_4_1)
	local var_4_1 = SegmentUtil.VectorCross(arg_4_0, arg_4_1, arg_4_3)

	if SegmentUtil.IsZero((SegmentUtil.VectorCross(arg_4_0, arg_4_2, arg_4_3))) then
		return var_4_0 <= SegmentUtil.eps or var_4_1 <= SegmentUtil.eps
	else
		return var_4_0 <= SegmentUtil.eps and var_4_1 <= SegmentUtil.eps
	end

	return
end

var_0_0.IsCrossAnyEdge = var_0_6

function var_0_0:Triangulated()
	if #self < 4 then
		return {
			0,
			1,
			2
		}
	end

	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0 = 1, #self do
		local var_6_3 = SegmentUtil.CycleIndex(iter_6_0 + 2)

		table.insert(var_6_1, iter_6_0)
		table.insert(var_6_2, {
			iter_6_0,
			Vector2.Distance(self[iter_6_0], self[var_6_3])
		})
	end

	local function var_6_4(arg_7_0, arg_7_1)
		return arg_7_0[2] < arg_7_1[2]
	end

	table.sort(var_6_2, var_6_4)

	while #var_6_1 > 2 and #var_6_2 > 0 do
		local var_6_5 = table.indexof(var_6_1, var_6_2[1][1])
		local var_6_6 = var_0_4(var_6_5 + 2, #var_6_1)
		local var_6_7 = var_6_1[var_0_4(var_6_5 + 1, #var_6_1)]

		if SegmentUtil.VectorCross(self[var_6_2[1][1]], self[var_6_1[var_6_6]], self[var_6_7]) > 0 and not var_0_6(self[var_6_2[1][1]], self[var_6_1[var_6_6]], self, var_6_1, var_6_6, var_6_5) then
			table.insert(var_6_0, var_6_2[1][1])
			table.insert(var_6_0, var_6_7)
			table.insert(var_6_0, var_6_1[var_6_6])

			local var_6_8 = var_6_1[var_0_4(var_6_5 - 1, #var_6_1)]
			local var_6_9 = var_6_1[var_0_4(var_6_6 + 1, #var_6_1)]

			for iter_6_1 = #var_6_2, 1, -1 do
				if var_6_2[iter_6_1][1] == var_6_7 or var_6_2[iter_6_1][1] == var_6_8 then
					table.remove(var_6_2, iter_6_1)
				end
			end

			table.insert(var_6_2, {
				var_6_8,
				Vector2.Distance(self[var_6_8], self[var_6_1[var_6_6]])
			})
			table.insert(var_6_2, {
				var_6_2[1][1],
				Vector2.Distance(self[var_6_2[1][1]], self[var_6_9])
			})
			table.remove(var_6_1, var_6_7)
			table.sort(var_6_2, var_6_4)
		end

		table.remove(var_6_2, 1)
	end

	return var_6_0
end

var_0_0.CalculateArea = var_0_7

function var_0_0.IsPolygonClockwise(arg_9_0)
	return SegmentUtil.Sign((var_0_7(arg_9_0)))
end

return var_0_0
