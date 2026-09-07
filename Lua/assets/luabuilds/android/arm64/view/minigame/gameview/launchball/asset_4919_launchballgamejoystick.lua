local LaunchBallGameJoyStick = class("LaunchBallGameJoyStick")

function LaunchBallGameJoyStick:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.smoothX = 0.01
	self.smoothY = 0.01
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
		self.dragPos = self._controlTf:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_2_1.position)))

		self:setTargetPos(self:getOffset(self.dragPos, self.startPos))

		if self.activeCallback then
			self.activeCallback(true)
		end

		return
	end)
	self._eventTriggerListener:AddDragFunc(function(arg_3_0, arg_3_1)
		self.dragPos = self._controlTf:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_3_1.position)))

		self:setTargetPos(self:getOffset(self.dragPos, self.startPos))

		return
	end)
	self._eventTriggerListener:AddPointUpFunc(function(arg_4_0, arg_4_1)
		self.active = false

		if self.activeCallback then
			self.activeCallback(false)
		end

		return
	end)
	self:setTargetPos(Vector2(0, 0))

	return
end

function LaunchBallGameJoyStick:setTargetPos(arg_5_1)
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

function LaunchBallGameJoyStick:getOffset(arg_6_1, arg_6_2)
	return Vector2(arg_6_1.x - arg_6_2.x, arg_6_1.y - arg_6_2.y)
end

function LaunchBallGameJoyStick:show(arg_7_1)
	setActive(self._tf, arg_7_1)

	return
end

function LaunchBallGameJoyStick:step()
	self.currentPos = self._joyTf.anchoredPosition
	self.currentX, self.currentXSmooth = Mathf.SmoothDamp(self.currentPos.x, self.targetPos.x, self.currentXSmooth, self.smoothX)
	self.currentY, self.currentYSmooth = Mathf.SmoothDamp(self.currentPos.y, self.targetPos.y, self.currentYSmooth, self.smoothY)
	self.currentPos.x = self.currentX
	self.currentPos.y = self.currentY
	self._joyTf.anchoredPosition = self.currentPos
	self.distanceRate = math.sqrt(math.pow(self.currentX - self.startPos.x, 2) + math.pow(self.currentY - self.startPos.y, 2)) / self.maxDistance

	if math.abs(self.currentY - self.startPos.y) <= 1 and math.abs(self.currentX - self.startPos.x) <= 1 then
		self.angle = nil
		self.rad = nil
	else
		self.rad = math.atan2(self.currentY - self.startPos.y, self.currentX - self.startPos.x)
		self.angle = self.rad * math.rad2Deg
	end

	self.offsetX = self.currentPos.x / self.maxDistance
	self.offsetY = self.currentPos.y / self.maxDistance

	if self.valueCallback then
		self.valueCallback(self:getValue())
	end

	return
end

function LaunchBallGameJoyStick:setDirectTarget(arg_9_1)
	if not self.active then
		self:setTargetPos(Vector2(arg_9_1.x * 1000, arg_9_1.y * 1000))
	end

	return
end

function LaunchBallGameJoyStick:setValueCallback(arg_10_1)
	self.valueCallback = arg_10_1

	return
end

function LaunchBallGameJoyStick:setActiveCallback(arg_11_1)
	self.activeCallback = arg_11_1

	return
end

function LaunchBallGameJoyStick:getValue()
	return {
		angle = self.angle,
		rad = self.rad,
		rate = self.distanceRate,
		x = self.offsetX,
		y = self.offsetY,
		active = self.active
	}
end

return LaunchBallGameJoyStick
