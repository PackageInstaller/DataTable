local CastleGameJoyStick = class("CastleGameJoyStick")

function CastleGameJoyStick:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.smoothX = 0.02
	self.smoothY = 0.02
	self.maxDistance = 120
	self.minDeadNum = 0.1
	self.maxDeadNum = 0.9
	self.currentPos = Vector2(0, 0)
	self.targetPos = Vector2(0, 0)
	self.currentX = 0
	self.currentY = 0
	self.currentXSmooth = 0
	self.currentYSmooth = 0
	self.active = false
	self.startPos = Vector2(0, 0)
	self.dragPos = Vector2(0, 0)
	self.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
	self._controlTf = findTF(self._tf, "control")
	self._joyTf = findTF(self._tf, "control/joy")
	self._eventTriggerListener = GetComponent(self._controlTf, typeof(EventTriggerListener))

	self._eventTriggerListener:AddPointDownFunc(function(arg_2_0, arg_2_1)
		self.active = true
		self.startPos = Vector2(0, 0)

		return
	end)
	self._eventTriggerListener:AddDragFunc(function(arg_3_0, arg_3_1)
		self.dragPos = self._controlTf:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_3_1.position)))

		self:setTargetPos(self:getOffset(self.dragPos, self.startPos))

		return
	end)
	self._eventTriggerListener:AddPointUpFunc(function(arg_4_0, arg_4_1)
		self.active = false

		self:setTargetPos(Vector2(0, 0))

		return
	end)
	self:setTargetPos(Vector2(0, 0))

	return
end

function CastleGameJoyStick:setTargetPos(arg_5_1)
	if math.sqrt(math.pow(arg_5_1.x - self.startPos.x, 2) + math.pow(arg_5_1.y - self.startPos.y, 2)) > self.maxDistance then
		local var_5_0 = math.atan(math.abs(arg_5_1.y - self.startPos.y) / math.abs(arg_5_1.x - self.startPos.x))
		local var_5_1 = math.sin(var_5_0) * (arg_5_1.y > self.startPos.y and 1 or -1) * self.maxDistance

		self.targetPos.x = math.cos(var_5_0) * (arg_5_1.x > self.startPos.x and 1 or -1) * self.maxDistance
		self.targetPos.y = var_5_1
	else
		self.targetPos = arg_5_1
	end

	return
end

function CastleGameJoyStick:getOffset(arg_6_1, arg_6_2)
	return Vector2(arg_6_1.x - arg_6_2.x, arg_6_1.y - arg_6_2.y)
end

function CastleGameJoyStick:show(arg_7_1)
	setActive(self._tf, arg_7_1)

	return
end

function CastleGameJoyStick:step()
	self.currentPos = self._joyTf.anchoredPosition
	self.currentX, self.currentXSmooth = Mathf.SmoothDamp(self.currentPos.x, self.targetPos.x, self.currentXSmooth, self.smoothX)
	self.currentY, self.currentYSmooth = Mathf.SmoothDamp(self.currentPos.y, self.targetPos.y, self.currentYSmooth, self.smoothY)
	self.currentPos.x = self.currentX
	self.currentPos.y = self.currentY
	self._joyTf.anchoredPosition = self.currentPos
	self.distanceRate = math.sqrt(math.pow(self.currentX - self.startPos.x, 2) + math.pow(self.currentY - self.startPos.y, 2)) / self.maxDistance
	self.angle = math.atan(math.abs(self.currentY - self.startPos.y) / math.abs(self.currentX - self.startPos.x))
	self.offsetX = self.currentPos.x / self.maxDistance
	self.offsetY = self.currentPos.y / self.maxDistance

	if self.callback then
		self.callback(self:getValue())
	end

	return
end

function CastleGameJoyStick:setDirectTarget(arg_9_1)
	if not self.active then
		self:setTargetPos(Vector2(arg_9_1.x * 1000, arg_9_1.y * 1000))
	end

	return
end

function CastleGameJoyStick:setValueCallback(arg_10_1)
	self.callback = arg_10_1

	return
end

function CastleGameJoyStick:getValue()
	return {
		angle = self.angle,
		rate = self.distanceRate,
		x = self.offsetX,
		y = self.offsetY
	}
end

return CastleGameJoyStick
