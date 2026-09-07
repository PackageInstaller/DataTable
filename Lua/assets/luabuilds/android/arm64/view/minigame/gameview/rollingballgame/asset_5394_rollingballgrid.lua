local RollingBallGrid = class("RollingBallGrid")

function RollingBallGrid:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.type = nil
	self.pos = nil
	self.eventActive = false
	self.gridTf = findTF(self._tf, "grid")

	return
end

function RollingBallGrid:changeImage()
	GetSpriteFromAtlasAsync(RollingBallConst.ui_atlas, "grid_" .. self.type, function(arg_3_0)
		setImageSprite(self.gridTf, arg_3_0, true)

		return
	end)

	return
end

function RollingBallGrid:setType(arg_4_1)
	self.type = arg_4_1

	self:changeImage()

	return
end

function RollingBallGrid:getType()
	return self.type
end

function RollingBallGrid:setPosData(arg_6_1, arg_6_2)
	self.x = arg_6_1
	self.y = arg_6_2

	if self.gridTf then
		self.gridTf.name = self:printData()
	end

	return
end

function RollingBallGrid:addDownCallback(arg_7_1)
	self.dragDelegate = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragDelegate:AddPointDownFunc(function()
		if self.eventActive then
			arg_7_1()
		end

		return
	end)

	return
end

function RollingBallGrid:addUpCallback(arg_9_1)
	self.dragDelegate = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragDelegate:AddPointUpFunc(function()
		if self.eventActive then
			arg_9_1()
		end

		return
	end)

	return
end

function RollingBallGrid:addBeginDragCallback(arg_11_1)
	self.dragDelegate = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragDelegate:AddBeginDragFunc(function(arg_12_0, arg_12_1)
		if self.eventActive then
			arg_11_1(arg_12_0, arg_12_1)
		end

		return
	end)

	return
end

function RollingBallGrid:addDragCallback(arg_13_1)
	self.dragDelegate = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragDelegate:AddDragFunc(function(arg_14_0, arg_14_1)
		if self.eventActive then
			arg_13_1(arg_14_0, arg_14_1)
		end

		return
	end)

	return
end

function RollingBallGrid:onEndDrag()
	self.dragDelegate:RemoveDragFunc()
	self.dragDelegate:RemovePointUpFunc()

	return
end

function RollingBallGrid:getPosData()
	return self.x, self.y
end

function RollingBallGrid:getPosition()
	return self._tf.localPosition
end

function RollingBallGrid:setPosition(arg_18_1, arg_18_2)
	self._tf.localPosition = Vector3(arg_18_1, arg_18_2, 0)

	return
end

function RollingBallGrid:changePosition(arg_19_1, arg_19_2)
	self._tf.localPosition = Vector3(arg_19_1, arg_19_2, 0)

	return
end

function RollingBallGrid:getRealPosition()
	return (self.x - 1) * RollingBallConst.grid_width, (self.y - 1) * RollingBallConst.grid_height
end

function RollingBallGrid:setRemoveFlagV(arg_21_1, arg_21_2)
	self.removeFlagV = arg_21_1
	self.removeKey = arg_21_2

	return
end

function RollingBallGrid:getRemoveFlagV()
	return self.removeFlagV
end

function RollingBallGrid:setRemoveFlagH(arg_23_1, arg_23_2)
	self.removeFlagH = arg_23_1
	self.removeKey = arg_23_2

	return
end

function RollingBallGrid:getRemoveFlagH()
	return self.removeFlagH
end

function RollingBallGrid:getRemoveId()
	return self.removeKey
end

function RollingBallGrid:setParent(arg_26_1)
	setParent(self._tf, arg_26_1, false)

	return
end

function RollingBallGrid:setSelect(arg_27_1)
	setActive(findTF(self._tf, "select"), arg_27_1)

	return
end

function RollingBallGrid:setDirect(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	setActive(findTF(self._tf, "direct/up"), arg_28_1)
	setActive(findTF(self._tf, "direct/bottom"), arg_28_2)
	setActive(findTF(self._tf, "direct/left"), arg_28_3)
	setActive(findTF(self._tf, "direct/right"), arg_28_4)

	return
end

function RollingBallGrid:clearDirect()
	self:setDirect(false, false, false, false)

	return
end

function RollingBallGrid:getTf()
	return self._tf
end

function RollingBallGrid:setEventActive(arg_31_1)
	self.eventActive = arg_31_1

	return
end

function RollingBallGrid:printData()
	return "x:" .. self.x .. " , y:" .. self.y .. " , type:" .. self.type
end

function RollingBallGrid:getWolrdVec3()
	return self._tf:TransformPoint(RollingBallConst.grid_width / 2, RollingBallConst.grid_height / 2, 0)
end

function RollingBallGrid:clearData()
	self.removeFlagH = false
	self.removeFlagV = false
	self.removeKey = nil

	return
end

function RollingBallGrid:dispose()
	if self.dragDelegate then
		ClearEventTrigger(self.dragDelegate)
	end

	return
end

return RollingBallGrid
