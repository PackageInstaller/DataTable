class = var_0_10000

local var_0_0 = "ColorGroup"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.StateLock = 0
var_0_1.StateColoring = 1
var_0_1.StateFinish = 2
var_0_1.StateAchieved = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.drops = {}
	arg_1_0.fills = {}
	arg_1_0.cells = {}
	_ = var_2

	var_2.each(arg_1_0:getConfig("cells"), function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.setCell(var_2_0, arg_2_0[1], arg_2_0[2], arg_2_0[3])

		return
	end)

	_ = var_2
	arg_1_0.colors = var_2.map(arg_1_0:getConfig("colors"), function(arg_3_0)
		Color = var_2_10001

		return var_2_10001.New(arg_3_0[1], arg_3_0[2], arg_3_0[3], arg_3_0[4])
	end)

	return
end

function var_0_1.bindConfigTable(arg_4_0)
	pg = var_1_10001

	return var_1_10001.activity_coloring_template
end

function var_0_1.getState(arg_5_0)
	return arg_5_0.state
end

function var_0_1.setState(arg_6_0, arg_6_1)
	arg_6_0.state = arg_6_1

	return
end

function var_0_1.getHasAward(arg_7_0)
	return arg_7_0.hasAward
end

function var_0_1.setHasAward(arg_8_0, arg_8_1)
	arg_8_0.hasAward = arg_8_1

	return
end

function var_0_1.getDrops(arg_9_0)
	return arg_9_0.drops
end

function var_0_1.setDrops(arg_10_0, arg_10_1)
	arg_10_0.drops = arg_10_1

	return
end

function var_0_1.getFill(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.fills[arg_11_1 .. "_" .. arg_11_2]
end

function var_0_1.setFill(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1 .. "_" .. arg_12_2

	if arg_12_3 == 0 then
		arg_12_0.fills[var_12_0] = nil
	else
		local var_12_1 = arg_12_0.fills

		ColorCell = var_6
		var_12_1[var_12_0] = var_6.New(arg_12_1, arg_12_2, arg_12_3)
	end

	return
end

function var_0_1.hasFill(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:getFill(arg_13_1, arg_13_2) ~= nil
end

function var_0_1.clearFill(arg_14_0)
	arg_14_0.fills = {}

	return
end

function var_0_1.isAllFill(arg_15_0, arg_15_1)
	if arg_15_0:canBeCustomised() then
		return false
	end

	pairs = var_2

	for iter_15_0, iter_15_1 in var_2(arg_15_0.cells) do
		if not arg_15_0.fills[iter_15_0] and (not arg_15_1 or iter_15_1.type == arg_15_1) then
			return false
		end
	end

	return true
end

function var_0_1.getCell(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0.cells[arg_16_1 .. "_" .. arg_16_2]
end

function var_0_1.setCell(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.cells
	local var_17_1 = arg_17_1 .. "_" .. arg_17_2

	ColorCell = var_6
	var_17_0[var_17_1] = var_6.New(arg_17_1, arg_17_2, arg_17_3)

	return
end

function var_0_1.hasCell(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0:getCell(arg_18_1, arg_18_2) ~= nil
end

function var_0_1.canBeCustomised(arg_19_0)
	return arg_19_0:getConfig("blank") == 1
end

function var_0_1.GetAABB(arg_20_0)
	local var_20_0 = 1000
	local var_20_1 = 1000
	local var_20_2 = 0
	local var_20_3 = 0

	assert = var_1_10005
	next = var_1_10007

	var_1_10005(var_1_10007(arg_20_0.cells), "Get AABB from empty List")

	pairs = var_1_10005

	for iter_20_0, iter_20_1 in var_1_10005(arg_20_0.cells) do
		math = var_1_10010
		var_20_0 = var_1_10010.min(var_20_0, iter_20_1.column)
		math = var_1_10010
		var_20_1 = var_1_10010.min(var_20_1, iter_20_1.row)
		math = var_1_10010
		var_20_2 = var_1_10010.max(var_20_2, iter_20_1.column)
		math = var_1_10010
		var_20_3 = var_1_10010.max(var_20_3, iter_20_1.row)
	end

	Vector2 = var_5

	local var_20_4 = var_5(var_20_0, var_20_1)

	Vector2 = var_6

	local var_20_5 = var_6(var_20_2, var_20_3)
end

function var_0_1.HasItem2Fill(arg_21_0, arg_21_1)
	_ = var_1_10002

	local var_21_0 = var_1_10002.map(arg_21_0:getConfig("color_id_list"), function(arg_22_0)
		local var_22_0

		if not arg_21_1[arg_22_0] then
			var_22_0 = 0
		end

		return var_22_0
	end)
	local var_21_1, var_21_2 = arg_21_0:GetAABB()
	local var_21_3 = var_21_2.x - var_21_1.x
	local var_21_4 = var_21_2.y - var_21_1.y

	for iter_21_0 = 0, var_21_3 do
		for iter_21_1 = 0, var_21_4 do
			local var_21_5 = iter_21_0 + var_21_1.x
			local var_21_6 = iter_21_1 + var_21_1.y

			if arg_21_0:getCell(var_21_5, var_21_6) and not arg_21_0:getFill(var_21_5, var_21_6) then
				local var_21_7

				if not var_21_0[var_17.type] then
					var_21_7 = 0
				end

				return var_21_7 > 0
			end
		end
	end

	return false
end

function var_0_1.HasEnoughItem2FillAll(arg_23_0, arg_23_1)
	_ = var_1_10002

	local var_23_0 = var_1_10002.map(arg_23_0:getConfig("color_id_list"), function(arg_24_0)
		local var_24_0

		if not arg_23_1[arg_24_0] then
			var_24_0 = 0
		end

		return var_24_0
	end)
	local var_23_1 = {}

	_ = var_4

	var_4.each(arg_23_0:getConfig("cells"), function(arg_25_0)
		local var_25_0 = arg_25_0[1]
		local var_25_1 = arg_25_0[2]
		local var_25_2 = arg_25_0[3]
		local var_25_3 = arg_23_0

		if not var_4.getFill(var_25_3, var_25_0, var_25_1) then
			local var_25_4

			if not var_23_1[var_25_2] then
				var_25_4 = 0
			end

			var_23_1[var_25_2] = var_25_4 + 1
		end

		return
	end)

	local var_23_2 = true

	pairs = var_5

	for iter_23_0, iter_23_1 in var_5(var_23_1) do
		local var_23_3

		if not var_23_0[iter_23_0] then
			var_23_3 = 0
		end

		if var_23_3 < iter_23_1 then
			var_23_2 = false

			break
		end
	end

	return var_23_2
end

return var_0_1
