local BackyardThemeFurniture = class("BackyardThemeFurniture")

function BackyardThemeFurniture:Ctor(arg_1_1)
	self.id = tonumber(arg_1_1.id)
	self.configId = arg_1_1.configId or tonumber(arg_1_1.id)
	self.position = arg_1_1.position
	self.dir = arg_1_1.dir or 1
	self.parent = tonumber(arg_1_1.parent) or 0
	self.child = arg_1_1.child or {}
	self.date = arg_1_1.date or 0
	self.floor = arg_1_1.floor
	self.isNewStyle = arg_1_1.isNewStyle

	return
end

function BackyardThemeFurniture:GetUniqueId(arg_2_1)
	return self * 100 + arg_2_1
end

function BackyardThemeFurniture:GetAllUniqueId()
	local var_3_0 = {}

	for iter_3_0 = 0, pg.furniture_data_template[self.configId].count - 1 do
		table.insert(var_3_0, BackyardThemeFurniture.GetUniqueId(self.configId, iter_3_0))
	end

	return var_3_0
end

function BackyardThemeFurniture:SetUniqueId(arg_4_1)
	self.id = arg_4_1

	return
end

function BackyardThemeFurniture:SetParent(arg_5_1)
	self.parent = arg_5_1

	return
end

function BackyardThemeFurniture:SetChildList(arg_6_1)
	self.child = arg_6_1

	return
end

function BackyardThemeFurniture:HasParent()
	return self.parent ~= 0
end

function BackyardThemeFurniture:AnyChild()
	return table.getCount(self.child) > 0
end

function BackyardThemeFurniture:GetChildIdList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.child) do
		table.insert(var_9_0, ids)
	end

	return var_9_0
end

function BackyardThemeFurniture:GetChildList()
	return self.child
end

function BackyardThemeFurniture:GetPosition()
	return self.position
end

function BackyardThemeFurniture:SameParent(arg_12_1)
	return self.parent == arg_12_1
end

function BackyardThemeFurniture:GetDir()
	return self.dir
end

function BackyardThemeFurniture:UpdateParent(arg_14_1)
	self.parent = arg_14_1

	return
end

function BackyardThemeFurniture:UpdateChildList(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		var_15_0[iter_15_0] = iter_15_1
	end

	self:SetChildList(var_15_0)

	return
end

function BackyardThemeFurniture:UpdateFloor(arg_16_1)
	self.floor = arg_16_1

	return
end

function BackyardThemeFurniture:SameChildPosition(arg_17_1, arg_17_2)
	return self:GetPosition() == arg_17_1 + arg_17_2
end

function BackyardThemeFurniture:isPaper()
	local var_18_0 = self:getConfig("type")

	if var_18_0 == Furniture.TYPE_WALLPAPER or var_18_0 == Furniture.TYPE_FLOORPAPER then
		return true
	end

	return false
end

function BackyardThemeFurniture:getConfig(arg_19_1)
	if pg.furniture_data_template[self.configId][arg_19_1] then
		return pg.furniture_data_template[self.configId][arg_19_1]
	elseif pg.furniture_shop_template[self.configId] then
		return pg.furniture_shop_template[self.configId][arg_19_1]
	end

	return
end

function BackyardThemeFurniture:IsWall()
	local var_20_0 = self:getConfig("type")

	return var_20_0 == Furniture.TYPE_WALL or var_20_0 == Furniture.TYPE_WALL_MAT
end

function BackyardThemeFurniture:isSame(arg_21_1)
	if self.position.x == arg_21_1.position.x and self.position.y == arg_21_1.position.y and (self.dir == arg_21_1.dir or self:IsWall()) and self.parent == arg_21_1.parent then
		return true
	end

	return false
end

function BackyardThemeFurniture:IsSameConfig(arg_22_1)
	return self.configId == arg_22_1
end

function BackyardThemeFurniture:UpdatePosition(arg_23_1)
	self.position = arg_23_1

	return
end

function BackyardThemeFurniture:UpdateDir(arg_24_1)
	self.dir = arg_24_1

	return
end

function BackyardThemeFurniture:_GetWeight()
	local var_25_0 = 3

	if pg.furniture_data_template[self.configId].type == Furniture.TYPE_FLOORPAPER then
		var_25_0 = 0
	elseif pg.furniture_data_template[self.configId].type == Furniture.TYPE_WALLPAPER then
		var_25_0 = 1
	elseif self.parent ~= 0 and table.getCount(self.child) > 0 then
		var_25_0 = 4
	elseif self.parent ~= 0 then
		var_25_0 = 5
	elseif pg.furniture_data_template[self.configId].type == Furniture.TYPE_STAGE then
		var_25_0 = 2
	end

	return var_25_0
end

function BackyardThemeFurniture:_LoadWeight(arg_26_1)
	local var_26_0 = BackyardThemeFurniture._GetWeight(self)
	local var_26_1 = BackyardThemeFurniture._GetWeight(arg_26_1)

	if var_26_0 == var_26_1 then
		return self.id < arg_26_1.id
	else
		return var_26_0 < var_26_1
	end

	return
end

function BackyardThemeFurniture:ToSaveData()
	return {
		id = self.id,
		configId = self.configId,
		position = self.position,
		x = self.position.x,
		y = self.position.y,
		dir = self.dir,
		child = self.child,
		parent = self.parent,
		floor = self.floor
	}
end

return BackyardThemeFurniture
