local RollingCircleItem = class("RollingCircleItem")
local var_0_1 = 73

function RollingCircleItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.tr = arg_1_1
	self._tr = arg_1_1
	self.id = arg_1_3

	self:SetIndex(arg_1_2)

	return
end

function RollingCircleItem:GetID()
	return self.id
end

function RollingCircleItem:GetIndex()
	return self.index
end

function RollingCircleItem:SetIndex(arg_4_1)
	self.index = arg_4_1
	self.tr.gameObject.name = arg_4_1

	return
end

function RollingCircleItem:IsCenter(arg_5_1)
	return self.index == arg_5_1
end

function RollingCircleItem:SetPrev(arg_6_1)
	self.prev = arg_6_1

	return
end

function RollingCircleItem:SetNext(arg_7_1)
	self.nex = arg_7_1

	return
end

function RollingCircleItem:Init()
	if not self.prev then
		return
	end

	local var_8_0 = self.prev:GetLocalposition()

	self:UpdateLocalPosition(Vector3(var_8_0.x, var_8_0.y - self.prev:GetSpace(), 0))

	return
end

function RollingCircleItem:GetSpace()
	return var_0_1
end

function RollingCircleItem:GetLocalposition()
	return self.tr.localPosition
end

function RollingCircleItem:UpdateLocalPosition(arg_11_1)
	self.tr.localPosition = arg_11_1

	return
end

function RollingCircleItem:Record()
	self.lastIndex = self.index
	self.lastLocalPosition = self:GetLocalposition()

	return
end

function RollingCircleItem:GetLastPositionAndIndex()
	return self.lastLocalPosition, self.lastIndex
end

function RollingCircleItem:GoForward()
	if self.nex then
		local var_14_0, var_14_1 = self.nex:GetLastPositionAndIndex()

		self:SetIndex(var_14_1)
		self:UpdateLocalPosition(var_14_0)
	end

	return
end

function RollingCircleItem:GoBack()
	if self.prev then
		local var_15_0, var_15_1 = self.prev:GetLastPositionAndIndex()

		self:SetIndex(var_15_1)
		self:UpdateLocalPosition(var_15_0)
	end

	return
end

function RollingCircleItem:Dispose()
	Object.Destroy(self.tr.gameObject)

	self.prev = nil
	self.nex = nil

	return
end

return RollingCircleItem
