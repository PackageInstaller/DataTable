local var_0_0 = class("ColorGroup", import(".BaseVO"))

var_0_0.StateLock = 0
var_0_0.StateColoring = 1
var_0_0.StateFinish = 2
var_0_0.StateAchieved = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.drops = {}
	arg_1_0.fills = {}
	arg_1_0.cells = {}

	_.each(arg_1_0:getConfig("cells"), function(arg_2_0)
		arg_1_0:setCell(arg_2_0[1], arg_2_0[2], arg_2_0[3])

		return
	end)

	arg_1_0.colors = _.map(arg_1_0:getConfig("colors"), function(arg_3_0)
		return Color.New(arg_3_0[1], arg_3_0[2], arg_3_0[3], arg_3_0[4])
	end)

	return
end

function var_0_0.bindConfigTable(arg_4_0)
	return pg.activity_coloring_template
end

function var_0_0.getState(arg_5_0)
	return arg_5_0.state
end

function var_0_0.setState(arg_6_0, arg_6_1)
	arg_6_0.state = arg_6_1

	return
end

function var_0_0.getHasAward(arg_7_0)
	return arg_7_0.hasAward
end

function var_0_0.setHasAward(arg_8_0, arg_8_1)
	arg_8_0.hasAward = arg_8_1

	return
end

function var_0_0.getDrops(arg_9_0)
	return arg_9_0.drops
end

function var_0_0.setDrops(arg_10_0, arg_10_1)
	arg_10_0.drops = arg_10_1

	return
end

function var_0_0.getFill(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.fills[arg_11_1 .. "_" .. arg_11_2]
end

function var_0_0.setFill(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == 0 then
		arg_12_0.fills[arg_12_1 .. "_" .. arg_12_2] = nil
	else
		arg_12_0.fills[arg_12_1 .. "_" .. arg_12_2] = ColorCell.New(arg_12_1, arg_12_2, arg_12_3)
	end

	return
end

function var_0_0.hasFill(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:getFill(arg_13_1, arg_13_2) ~= nil
end

function var_0_0.clearFill(arg_14_0)
	arg_14_0.fills = {}

	return
end

function var_0_0.isAllFill(arg_15_0, arg_15_1)
	if arg_15_0:canBeCustomised() then
		return false
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.cells) do
		if not arg_15_0.fills[iter_15_0] and (not arg_15_1 or iter_15_1.type == arg_15_1) then
			return false
		end
	end

	return true
end

function var_0_0.getCell(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0.cells[arg_16_1 .. "_" .. arg_16_2]
end

function var_0_0.setCell(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0.cells[arg_17_1 .. "_" .. arg_17_2] = ColorCell.New(arg_17_1, arg_17_2, arg_17_3)

	return
end

function var_0_0.hasCell(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0:getCell(arg_18_1, arg_18_2) ~= nil
end

function var_0_0.canBeCustomised(arg_19_0)
	return arg_19_0:getConfig("blank") == 1
end

function var_0_0.GetAABB(arg_20_0)
	local var_20_0 = 1000
	local var_20_1 = 1000
	local var_20_2 = 0
	local var_20_3 = 0

	assert(next(arg_20_0.cells), "Get AABB from empty List")

	for iter_20_0, iter_20_1 in pairs(arg_20_0.cells) do
		var_20_0 = math.min(var_20_0, iter_20_1.column)
		var_20_1 = math.min(var_20_1, iter_20_1.row)
		var_20_2 = math.max(var_20_2, iter_20_1.column)
		var_20_3 = math.max(var_20_3, iter_20_1.row)
	end

	local var_20_4 = Vector2(var_20_0, var_20_1)
	local var_20_5 = Vector2(var_20_2, var_20_3)
end

function var_0_0.HasItem2Fill(arg_21_0, arg_21_1)
	local var_21_0 = _.map(arg_21_0:getConfig("color_id_list"), function(arg_22_0)
		return arg_21_1[arg_22_0] or 0
	end)
	local var_21_1, var_21_2 = arg_21_0:GetAABB()

	for iter_21_0 = 0, var_21_2.x - var_21_1.x do
		for iter_21_1 = 0, var_21_2.y - var_21_1.y do
			local var_21_3 = arg_21_0:getCell(iter_21_0 + var_21_1.x, iter_21_1 + var_21_1.y)

			if var_21_3 and not arg_21_0:getFill(iter_21_0 + var_21_1.x, iter_21_1 + var_21_1.y) then
				local var_21_4 = var_21_0[var_21_3.type] or 0

				return var_21_4 > 0
			end
		end
	end

	return false
end

function var_0_0.HasEnoughItem2FillAll(arg_23_0, arg_23_1)
	local var_23_0 = _.map(arg_23_0:getConfig("color_id_list"), function(arg_24_0)
		return arg_23_1[arg_24_0] or 0
	end)
	local var_23_1 = {}

	_.each(arg_23_0:getConfig("cells"), function(arg_25_0)
		if not arg_23_0:getFill(arg_25_0[1], arg_25_0[2]) then
			local var_25_0 = var_23_1[arg_25_0[3]] or 0

			var_23_1[arg_25_0[3]] = var_25_0 + 1
		end

		return
	end)

	local var_23_2 = true

	for iter_23_0, iter_23_1 in pairs({}) do
		local var_23_3 = var_23_0[iter_23_0] or 0

		if var_23_3 < iter_23_1 then
			var_23_2 = false

			break
		end
	end

	return var_23_2
end

return var_0_0
