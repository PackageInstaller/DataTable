local CourtYardDepthItem = class("CourtYardDepthItem", import("...CourtYardDispatcher"))

function CourtYardDepthItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	CourtYardDepthItem.super.Ctor(self, arg_1_1)

	self.ob = {
		id = arg_1_2,
		type = self:GetDeathType()
	}
	self.initSizeX = arg_1_3 or 0
	self.initSizeY = arg_1_4 or 0
	self.sizeX = self.initSizeX
	self.sizeY = self.initSizeY

	assert(self.sizeX > 0 and self.sizeY > 0, "size 必须大于0============>" .. arg_1_2)

	self.posX = 0
	self.posY = 0
	self.maxX = 0
	self.maxY = 0
	self.posZ = 0
	self.dir = 1
	self.sortedFlag = true
	self.dirty = false
	self.parent = nil
	self.opFlag = false
	self.area = {}

	return
end

function CourtYardDepthItem:GetInitSize()
	return {
		{
			self.sizeX,
			self.sizeY
		}
	}
end

function CourtYardDepthItem:GetInitSizeCnt()
	local var_3_0 = self:GetInitSize()[1]

	return var_3_0[1] * var_3_0[2]
end

function CourtYardDepthItem:GetObjType()
	assert(false)

	return
end

function CourtYardDepthItem:GetOffset()
	assert(false)

	return
end

function CourtYardDepthItem:UpdateOpFlag(arg_6_1)
	self.opFlag = arg_6_1

	return
end

function CourtYardDepthItem:GetOpFlag()
	return self.opFlag
end

function CourtYardDepthItem:InActivityRange(arg_8_1)
	return true
end

function CourtYardDepthItem:GetDeathType()
	assert(false)

	return
end

function CourtYardDepthItem:SetPosition(arg_10_1)
	self:SetDirty()
	self:SetPos(arg_10_1.x + 1, arg_10_1.y + 1)
	self:ReGenArea()

	return
end

function CourtYardDepthItem:SetDir(arg_11_1)
	self:SetDirty()

	if arg_11_1 == 2 then
		self.sizeX = self.initSizeY
		self.sizeY = self.initSizeX
	else
		self.sizeX = self.initSizeX
		self.sizeY = self.initSizeY
	end

	self.dir = arg_11_1

	self:SetPosition(self:GetPosition())

	return
end

function CourtYardDepthItem:GetDirection()
	return self.dir
end

function CourtYardDepthItem:GetNormalDirection()
	if self.dir == 1 then
		return 1
	end

	if self.dir == 2 then
		return -1
	end

	return
end

function CourtYardDepthItem:ReGenArea()
	table.clear(self.area)

	self.area = self:GetAreaByPosition((self:GetPosition()))

	return
end

function CourtYardDepthItem:GetPosition()
	return Vector2(self.posX - 1, self.posY - 1)
end

function CourtYardDepthItem:SetPos(arg_16_1, arg_16_2)
	self.posX = arg_16_1
	self.posY = arg_16_2
	self.maxX = arg_16_1 + self.sizeX - 1
	self.maxY = arg_16_2 + self.sizeY - 1

	return
end

function CourtYardDepthItem:SetDepth(arg_17_1)
	self.posZ = arg_17_1

	return
end

function CourtYardDepthItem:GetArea()
	return self.area
end

function CourtYardDepthItem:GetAreaByPosition(arg_19_1)
	local var_19_0 = {}

	for iter_19_0 = arg_19_1.x, arg_19_1.x + self.sizeX - 1 do
		for iter_19_1 = arg_19_1.y, arg_19_1.y + self.sizeY - 1 do
			table.insert(var_19_0, Vector2(iter_19_0, iter_19_1))
		end
	end

	return var_19_0
end

function CourtYardDepthItem:_GetRotatePositions(arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = arg_20_1.x, arg_20_1.x + self.sizeY - 1 do
		for iter_20_1 = arg_20_1.y, arg_20_1.y + self.sizeX - 1 do
			table.insert(var_20_0, Vector2(iter_20_0, iter_20_1))
		end
	end

	return var_20_0
end

function CourtYardDepthItem:GetRotatePositions()
	return self:_GetRotatePositions((self:GetPosition()))
end

function CourtYardDepthItem:SetDirty()
	self.dirty = true

	return
end

function CourtYardDepthItem:UnDirty()
	self.dirty = false

	return
end

function CourtYardDepthItem:IsDirty()
	return self.dirty
end

function CourtYardDepthItem:Interaction(arg_25_1)
	return
end

function CourtYardDepthItem:ClearInteraction(arg_26_1)
	return
end

function CourtYardDepthItem:SetParent(arg_27_1)
	self:SetDirty()

	self.parent = arg_27_1

	return
end

function CourtYardDepthItem:HasParent()
	return self.parent ~= nil
end

function CourtYardDepthItem:GetParent()
	return self.parent
end

function CourtYardDepthItem:GetAroundPositions()
	local var_30_0 = self:GetPosition()

	return {
		Vector2(var_30_0.x + 1, var_30_0.y),
		Vector2(var_30_0.x, var_30_0.y + 1),
		Vector2(var_30_0.x - 1, var_30_0.y),
		Vector2(var_30_0.x, var_30_0.y - 1)
	}
end

function CourtYardDepthItem:MarkPosition(arg_31_1)
	self.markPosition = arg_31_1

	return
end

function CourtYardDepthItem:GetMarkPosition()
	return self.markPosition
end

function CourtYardDepthItem:ClearMarkPosition()
	self.markPosition = nil

	return
end

function CourtYardDepthItem:GetOffset()
	if self:HasParent() then
		return self.parent:RawGetOffset()
	else
		return Vector3.zero
	end

	return
end

function CourtYardDepthItem:UnClear(arg_35_1)
	self.unClear = arg_35_1

	return
end

function CourtYardDepthItem:IsUnClear()
	return self.unClear
end

function CourtYardDepthItem:RawGetOffset()
	return Vector3.zero
end

function CourtYardDepthItem:IsDifferentDirection(arg_38_1)
	local var_38_0 = self:GetPosition()

	return self.dir ~= ((arg_38_1.x < var_38_0.x and arg_38_1.y == var_38_0.y or arg_38_1.x == var_38_0.x and arg_38_1.y > var_38_0.y) and 2 or 1)
end

function CourtYardDepthItem:Dispose()
	self:ClearListeners()

	return
end

return CourtYardDepthItem
