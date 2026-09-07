local RawFurnitureData = class("RawFurnitureData")

function RawFurnitureData:Ctor(arg_1_1)
	self.config = pg.furniture_data_template[arg_1_1.configId]
	self.name = self.config.name
	self.id = arg_1_1.id
	self.floor = arg_1_1.floor
	self.parent = arg_1_1.parent
	self.dir = arg_1_1.dir
	self.child = arg_1_1.child
	self.position = arg_1_1.position

	if self.position then
		self.x = self.position.x or arg_1_1.x
	end

	if self.position then
		self.y = self.position.y or arg_1_1.y
	end

	if self.dir == 1 then
		self.sizeX = self.config.size[1]
		self.sizeY = self.config.size[2]
	else
		self.sizeX = self.config.size[2]
		self.sizeY = self.config.size[1]
	end

	return
end

function RawFurnitureData:IsCompletion()
	if not self.floor then
		return false
	end

	if not self.parent then
		return false
	end

	if not self.dir or self.dir < 0 or self.dir > 2 then
		return false
	end

	if not self.child then
		return false
	end

	if not self.x or not self.y then
		return false
	end

	return true
end

function RawFurnitureData:ExistParnet()
	return self.parent and self.parent ~= 0
end

function RawFurnitureData:LegalParent(arg_4_1)
	if not arg_4_1 then
		return false
	end

	if not arg_4_1:LegalChild(self) then
		return false
	end

	return true
end

function RawFurnitureData:LegalChild(arg_5_1)
	if not arg_5_1 then
		return false
	end

	if arg_5_1.parent ~= self.id then
		return false
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.child or {}) do
		table.insert(var_5_0, iter_5_0)
	end

	if not table.contains(var_5_0, arg_5_1.id) then
		return false
	end

	return true
end

function RawFurnitureData:InSide(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if self.config.belong == 1 and self.config.type ~= 1 and self.config.type ~= 4 and not self:ExistParnet() then
		return _.all(self:GetAreaByPosition(), function(arg_7_0)
			return arg_7_0.x >= arg_6_1 and arg_7_0.y >= arg_6_2 and arg_7_0.x <= arg_6_3 and arg_7_0.y <= arg_6_4
		end)
	end

	if self.config.belong == 3 and self.x >= arg_6_3 + 1 then
		return false
	end

	if self.config.belong == 4 and self.y >= arg_6_4 + 1 then
		return false
	end

	return true
end

function RawFurnitureData:GetAreaByPosition()
	local var_8_0 = {}

	for iter_8_0 = self.x, self.x + self.sizeX - 1 do
		for iter_8_1 = self.y, self.y + self.sizeY - 1 do
			table.insert(var_8_0, Vector2(iter_8_0, iter_8_1))
		end
	end

	return var_8_0
end

function RawFurnitureData:MatOrPaper()
	return self.config.type == 5 or self.config.type == 10 or self.config.type == 1 or self.config.type == 4
end

return RawFurnitureData
