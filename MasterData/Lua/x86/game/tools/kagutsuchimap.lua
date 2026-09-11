local KagutsuchiMapGrid = class("KagutsuchiMapGrid")

function KagutsuchiMapGrid:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.x = arg_1_1
	self.y = arg_1_2
	self.index = arg_1_3
	self.value = nil
end

function KagutsuchiMapGrid:SetValue(arg_2_1)
	self.value = arg_2_1
end

local KagutsuchiMap = class("KagutsuchiMap")
local var_0_2 = {
	null_grid = true
}

function KagutsuchiMap:Ctor(arg_3_1, arg_3_2)
	self.length = 0
	self.list = {}

	self:InitMap(arg_3_1, arg_3_2)
end

function KagutsuchiMap:Clear()
	self.length = 0
	self.list = {}
	self.grids = {}
end

function KagutsuchiMap:InitMap(arg_5_1, arg_5_2)
	self.width = arg_5_1
	self.height = arg_5_2
	self.grids = {}

	for iter_5_0 = 1, arg_5_1 do
		self.grids[iter_5_0] = {}

		for iter_5_1 = 1, arg_5_2 do
			self.grids[iter_5_0][iter_5_1] = var_0_2
		end
	end
end

function KagutsuchiMap:GetGrid(arg_6_1, arg_6_2)
	if self:IsOverbound(arg_6_1, arg_6_2) then
		return var_0_2
	end

	local var_6_0 = self.grids[arg_6_1][arg_6_2]

	if self.grids[arg_6_1][arg_6_2] == var_0_2 then
		return nil
	end

	return var_6_0.value
end

function KagutsuchiMap:GetGridByIndex(arg_7_1)
	if self.list[arg_7_1] == var_0_2 then
		return nil
	end

	return self.list[arg_7_1].value
end

function KagutsuchiMap:GetGridXY(arg_8_1)
	if self.list[arg_8_1] == var_0_2 then
		return nil, nil
	end

	return self.list[arg_8_1].x, self.list[arg_8_1].y
end

function KagutsuchiMap:GetGridIndex(arg_9_1, arg_9_2)
	if self:IsOverbound(arg_9_1, arg_9_2) then
		return nil
	end

	local var_9_0 = self.grids[arg_9_1][arg_9_2]

	if self.grids[arg_9_1][arg_9_2] == var_0_2 then
		return nil
	end

	return var_9_0.index
end

function KagutsuchiMap:GetGridCount()
	return self.length
end

function KagutsuchiMap:PutGrid(arg_11_1, arg_11_2, arg_11_3)
	if self:IsOverbound(arg_11_1, arg_11_2) then
		return nil
	end

	local var_11_0 = self.grids[arg_11_1][arg_11_2]

	if self.grids[arg_11_1][arg_11_2] == var_0_2 then
		var_11_0 = KagutsuchiMapGrid.New(arg_11_1, arg_11_2, self.length + 1)
		self.grids[arg_11_1][arg_11_2] = var_11_0
		self.list[var_11_0.index] = var_11_0
		self.length = self.length + 1
	end

	local var_11_1 = var_11_0.value

	var_11_0:SetValue(arg_11_3)

	return var_11_1
end

function KagutsuchiMap:HasGrid(arg_12_1, arg_12_2)
	return self:GetGrid(arg_12_1, arg_12_2) ~= var_0_2
end

function KagutsuchiMap:IsOverbound(arg_13_1, arg_13_2)
	return arg_13_1 <= 0 or arg_13_1 > self.width or arg_13_2 <= 0 or arg_13_2 > self.height
end

return KagutsuchiMap
