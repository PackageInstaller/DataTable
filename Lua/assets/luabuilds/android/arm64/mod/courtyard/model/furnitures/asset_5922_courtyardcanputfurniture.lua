local CourtYardCanPutFurniture = class("CourtYardCanPutFurniture", import(".CourtYardFurniture"))

function CourtYardCanPutFurniture:Ctor(arg_1_1, arg_1_2)
	CourtYardCanPutFurniture.super.Ctor(self, arg_1_1, arg_1_2)

	self.childs = {}
	self.placeableArea = CourtYardFurniturePlaceableArea.New(arg_1_1, self, Vector4(35, 35, 0, 0))

	return
end

function CourtYardCanPutFurniture:GetPlaceableArea()
	return self.placeableArea
end

function CourtYardCanPutFurniture:GetChilds()
	return self.childs
end

function CourtYardCanPutFurniture:AnyNotRotateChilds()
	if #self.childs > 0 then
		return _.any(self.childs, function(arg_5_0)
			return isa(arg_5_0, CourtYardFurniture) and arg_5_0:DisableRotation()
		end)
	end

	return false
end

function CourtYardCanPutFurniture:GetCanputonPosition()
	local var_6_0 = self:GetPosition()

	if self:GetDirection() == 1 then
		return _.map(self.config.canputonGrid, function(arg_7_0)
			return Vector2(arg_7_0[1], arg_7_0[2]) + var_6_0
		end)
	else
		return _.map(self.config.canputonGrid, function(arg_8_0)
			return Vector2(arg_8_0[2], arg_8_0[1]) + var_6_0
		end)
	end

	return
end

function CourtYardCanPutFurniture:CanPutChildInPosition(arg_9_1, arg_9_2)
	return table.contains(self:AllowDepthType(), arg_9_1:GetDeathType()) and self:GetLevel() < arg_9_1:GetLevel() and _.all(arg_9_1:GetAreaByPosition(arg_9_2), function(arg_10_0)
		return self.placeableArea:LegalPosition(arg_10_0)
	end)
end

function CourtYardCanPutFurniture:AllowDepthType()
	return {
		CourtYardConst.DEPTH_TYPE_MAT,
		CourtYardConst.DEPTH_TYPE_FURNITURE
	}
end

function CourtYardCanPutFurniture:AddChild(arg_12_1)
	self:SetDirty()
	arg_12_1:SetParent(self)
	table.insert(self.childs, arg_12_1)
	self.placeableArea:AddItem(arg_12_1)
	arg_12_1:SetPosition(arg_12_1:GetPosition())

	return
end

function CourtYardCanPutFurniture:RemoveChild(arg_13_1)
	self:SetDirty()
	arg_13_1:SetParent(nil)
	table.removebyvalue(self.childs, arg_13_1)
	self.placeableArea:RemoveItem(arg_13_1)

	return
end

function CourtYardCanPutFurniture:AreaWithInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	return self.placeableArea:AreaWithInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function CourtYardCanPutFurniture:SetPosition(arg_15_1)
	local var_15_0 = self:GetPosition()

	CourtYardCanPutFurniture.super.SetPosition(self, arg_15_1)

	local var_15_1 = {}

	for iter_15_0 = #self.childs, 1, -1 do
		local var_15_2 = self.childs[iter_15_0]:GetPosition() - var_15_0

		self:RemoveChild(self.childs[iter_15_0])
		table.insert(var_15_1, {
			self.childs[iter_15_0],
			arg_15_1 + var_15_2
		})
	end

	for iter_15_1, iter_15_2 in ipairs(var_15_1) do
		iter_15_2[1]:SetPosition(iter_15_2[2])
		self:AddChild(iter_15_2[1])
	end

	return
end

function CourtYardCanPutFurniture:Rotate()
	local var_16_0 = self:GetPosition()

	CourtYardCanPutFurniture.super.Rotate(self)

	local var_16_1 = self:GetPosition()
	local var_16_2 = {}

	for iter_16_0 = #self.childs, 1, -1 do
		local var_16_3 = self.childs[iter_16_0]:GetPosition() - var_16_0

		self:RemoveChild(self.childs[iter_16_0])
		table.insert(var_16_2, {
			self.childs[iter_16_0],
			var_16_1 + Vector2(var_16_3.y, var_16_3.x)
		})
	end

	for iter_16_1, iter_16_2 in ipairs(var_16_2) do
		iter_16_2[1]:SetPosition(iter_16_2[2])
		iter_16_2[1]:Rotate()
		self:AddChild(iter_16_2[1])
	end

	return
end

function CourtYardCanPutFurniture:CanRotateChild(arg_17_1)
	local var_17_0 = false

	self:RemoveChild(arg_17_1)

	if _.all(arg_17_1:GetRotatePositions(), function(arg_18_0)
		return self.placeableArea:LegalPosition(arg_18_0)
	end) then
		var_17_0 = true
	end

	self:AddChild(arg_17_1)

	return var_17_0
end

function CourtYardCanPutFurniture:ToTable()
	local var_19_0 = CourtYardCanPutFurniture.super.ToTable(self)
	local var_19_1 = {}
	local var_19_2 = self:GetPosition()

	for iter_19_0, iter_19_1 in ipairs(self.childs) do
		var_19_1[iter_19_1.id] = iter_19_1:GetPosition() - var_19_2
	end

	var_19_0.child = var_19_1

	return var_19_0
end

return CourtYardCanPutFurniture
