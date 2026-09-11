local GridMap = class("GridMap")
local var_0_1 = 1

function GridMap:Ctor(arg_1_1, arg_1_2)
	self.map = {}
	self.width = arg_1_1
	self.height = arg_1_2
	self.available = self:GetAllGridIdxList()
end

function GridMap:GetAllGridIdxList()
	local var_2_0 = {}

	for iter_2_0 = 0, self.width - 1 do
		for iter_2_1 = 0, self.height - 1 do
			table.insert(var_2_0, self:ToIdx(iter_2_0, iter_2_1))
		end
	end

	return var_2_0
end

function GridMap:ToIdx(arg_3_1, arg_3_2)
	if arg_3_1 < 0 or arg_3_1 >= self.width or arg_3_2 < 0 or arg_3_2 >= self.height then
		return nil
	end

	arg_3_1 = arg_3_1 + var_0_1
	arg_3_2 = arg_3_2 + var_0_1

	return arg_3_2 * (self.width + 2 * var_0_1) + arg_3_1
end

function GridMap:ToCoord(arg_4_1)
	return arg_4_1 % (self.width + 2 * var_0_1) - var_0_1, math.floor(arg_4_1 / (self.width + 2 * var_0_1)) - var_0_1
end

function GridMap:Get(arg_5_1, arg_5_2)
	return nullable(self.map, self:ToIdx(arg_5_1, arg_5_2))
end

function GridMap:IsGridInMap(arg_6_1, arg_6_2)
	return arg_6_1 >= 0 and arg_6_1 < self.width and arg_6_2 >= 0 and arg_6_2 < self.height
end

function GridMap:IsGridEmpty(arg_7_1, arg_7_2)
	return self:Get(arg_7_1, arg_7_2) == nil and arg_7_1 >= -1 and arg_7_1 <= self.width and arg_7_2 >= -1 and arg_7_2 <= self.height
end

function GridMap:HasGridEmpty(arg_8_1)
	if arg_8_1 > #self.available then
		return nil
	end

	return unpack(self.available, 1, arg_8_1)
end

function GridMap:Put(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = self:ToIdx(arg_9_1, arg_9_2)

	if var_9_0 then
		if self.map[var_9_0] == nil and arg_9_3 ~= nil then
			table.removebyvalue(self.available, var_9_0)
		elseif self.map[var_9_0] ~= nil and arg_9_3 == nil then
			table.insert(self.available, var_9_0)
		end

		self.map[var_9_0] = arg_9_3
	end

	return var_9_0
end

function GridMap:RndPut(arg_10_1)
	if next(self.available) == nil then
		return nil
	end

	local var_10_0 = math.random(#self.available)

	self.available[#self.available], self.available[var_10_0] = self.available[var_10_0], self.available[#self.available]

	local var_10_1 = table.remove(self.available)

	self.map[var_10_1] = arg_10_1

	return var_10_1
end

function GridMap:RemoveByIdx(arg_11_1)
	if self.map[arg_11_1] ~= nil then
		table.insert(self.available, arg_11_1)

		self.map[arg_11_1] = nil
	end
end

return GridMap
