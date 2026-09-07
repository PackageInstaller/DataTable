local ColorGroup = class("ColorGroup", import(".BaseVO"))

ColorGroup.StateLock = 0
ColorGroup.StateColoring = 1
ColorGroup.StateFinish = 2
ColorGroup.StateAchieved = 3

function ColorGroup:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id
	self.drops = {}
	self.fills = {}
	self.cells = {}

	_.each(self:getConfig("cells"), function(arg_2_0)
		self:setCell(arg_2_0[1], arg_2_0[2], arg_2_0[3])

		return
	end)

	self.colors = _.map(self:getConfig("colors"), function(arg_3_0)
		return Color.New(arg_3_0[1], arg_3_0[2], arg_3_0[3], arg_3_0[4])
	end)

	return
end

function ColorGroup:bindConfigTable()
	return pg.activity_coloring_template
end

function ColorGroup:getState()
	return self.state
end

function ColorGroup:setState(arg_6_1)
	self.state = arg_6_1

	return
end

function ColorGroup:getHasAward()
	return self.hasAward
end

function ColorGroup:setHasAward(arg_8_1)
	self.hasAward = arg_8_1

	return
end

function ColorGroup:getDrops()
	return self.drops
end

function ColorGroup:setDrops(arg_10_1)
	self.drops = arg_10_1

	return
end

function ColorGroup:getFill(arg_11_1, arg_11_2)
	return self.fills[arg_11_1 .. "_" .. arg_11_2]
end

function ColorGroup:setFill(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == 0 then
		self.fills[arg_12_1 .. "_" .. arg_12_2] = nil
	else
		self.fills[arg_12_1 .. "_" .. arg_12_2] = ColorCell.New(arg_12_1, arg_12_2, arg_12_3)
	end

	return
end

function ColorGroup:hasFill(arg_13_1, arg_13_2)
	return self:getFill(arg_13_1, arg_13_2) ~= nil
end

function ColorGroup:clearFill()
	self.fills = {}

	return
end

function ColorGroup:isAllFill(arg_15_1)
	if self:canBeCustomised() then
		return false
	end

	for iter_15_0, iter_15_1 in pairs(self.cells) do
		if not self.fills[iter_15_0] and (not arg_15_1 or iter_15_1.type == arg_15_1) then
			return false
		end
	end

	return true
end

function ColorGroup:getCell(arg_16_1, arg_16_2)
	return self.cells[arg_16_1 .. "_" .. arg_16_2]
end

function ColorGroup:setCell(arg_17_1, arg_17_2, arg_17_3)
	self.cells[arg_17_1 .. "_" .. arg_17_2] = ColorCell.New(arg_17_1, arg_17_2, arg_17_3)

	return
end

function ColorGroup:hasCell(arg_18_1, arg_18_2)
	return self:getCell(arg_18_1, arg_18_2) ~= nil
end

function ColorGroup:canBeCustomised()
	return self:getConfig("blank") == 1
end

function ColorGroup:GetAABB()
	local var_20_0 = 1000
	local var_20_1 = 1000
	local var_20_2 = 0
	local var_20_3 = 0

	assert(next(self.cells), "Get AABB from empty List")

	for iter_20_0, iter_20_1 in pairs(self.cells) do
		var_20_0 = math.min(var_20_0, iter_20_1.column)
		var_20_1 = math.min(var_20_1, iter_20_1.row)
		var_20_2 = math.max(var_20_2, iter_20_1.column)
		var_20_3 = math.max(var_20_3, iter_20_1.row)
	end

	local var_20_4 = Vector2(var_20_0, var_20_1)
	local var_20_5 = Vector2(var_20_2, var_20_3)
end

function ColorGroup:HasItem2Fill(arg_21_1)
	local var_21_0 = _.map(self:getConfig("color_id_list"), function(arg_22_0)
		return arg_21_1[arg_22_0] or 0
	end)
	local var_21_1, var_21_2 = self:GetAABB()

	for iter_21_0 = 0, var_21_2.x - var_21_1.x do
		for iter_21_1 = 0, var_21_2.y - var_21_1.y do
			local var_21_3 = self:getCell(iter_21_0 + var_21_1.x, iter_21_1 + var_21_1.y)

			if var_21_3 and not self:getFill(iter_21_0 + var_21_1.x, iter_21_1 + var_21_1.y) then
				return (var_21_0[var_21_3.type] or 0) > 0
			end
		end
	end

	return false
end

function ColorGroup:HasEnoughItem2FillAll(arg_23_1)
	local var_23_0 = _.map(self:getConfig("color_id_list"), function(arg_24_0)
		return arg_23_1[arg_24_0] or 0
	end)
	local var_23_1 = {}

	_.each(self:getConfig("cells"), function(arg_25_0)
		if not self:getFill(arg_25_0[1], arg_25_0[2]) then
			var_23_1[arg_25_0[3]] = (var_23_1[arg_25_0[3]] or 0) + 1
		end

		return
	end)

	local var_23_2 = true

	for iter_23_0, iter_23_1 in pairs(var_23_1) do
		if (var_23_0[iter_23_0] or 0) < iter_23_1 then
			var_23_2 = false

			break
		end
	end

	return var_23_2
end

return ColorGroup
