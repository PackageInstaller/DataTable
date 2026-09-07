local IslandFurniture = class("IslandFurniture")

function IslandFurniture:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.count = arg_1_1.count or 1
	self.time = arg_1_1.time or arg_1_1.id
	self.isNew = defaultValue(arg_1_1.isNew, false)

	return
end

function IslandFurniture:SetNew(arg_2_1)
	self.isNew = arg_2_1

	return
end

function IslandFurniture:SetTime(arg_3_1)
	self.time = arg_3_1

	return
end

return IslandFurniture
