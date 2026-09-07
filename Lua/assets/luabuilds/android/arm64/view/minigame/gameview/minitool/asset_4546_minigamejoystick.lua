local MiniGameJoyStick = class("MiniGameJoyStick")

function MiniGameJoyStick:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.smoothX = 0.01
	self.smoothY = 0.01
	self.maxDistance = 120
	self.minDeadNum = 0.05
	self.maxDeadNum = 1
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
		self.dragActive = true
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
		self:setTargetPos(Vector2(0, 0))

		self.dragActive = false
		self.active = false

		if self.activeCallback then
			self.activeCallback(false)
		end

		return
	end)
	self:setTargetPos(Vector2(0, 0))

	return
end

function MiniGameJoyStick:setTargetPos(arg_5_1)
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

function MiniGameJoyStick:getOffset(arg_6_1, arg_6_2)
	return Vector2(arg_6_1.x - arg_6_2.x, arg_6_1.y - arg_6_2.y)
end

function MiniGameJoyStick:setting(arg_7_1)
	self.smoothX = arg_7_1.smoothX
	self.smoothY = arg_7_1.smoothY
	self.maxDistance = arg_7_1.maxDistance
	self.minDeadNum = arg_7_1.minDeadNum
	self.maxDeadNum = arg_7_1.maxDeadNum

	return
end

function MiniGameJoyStick:show(arg_8_1)
	setActive(self._tf, arg_8_1)

	return
end

function MiniGameJoyStick:step()
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

	if math.abs(self.offsetX) > self.minDeadNum then
		if self.offsetX > 0 then
			self.directX = 1
		elseif self.offsetX < 0 then
			self.directX = -1
		end
	else
		self.directX = 0
		self.offsetX = 0
	end

	if math.abs(self.offsetY) > self.minDeadNum then
		if self.offsetY > 0 then
			self.directY = 1
		elseif self.offsetY < 0 then
			self.directY = -1
		end
	else
		self.directY = 0
		self.offsetY = 0
	end

	if self.valueCallback then
		self.valueCallback(self:getValue())
	end

	return
end

function MiniGameJoyStick:setDirectTarget(arg_10_1)
	if self.dragActive then
		return
	end

	if arg_10_1.x ~= 0 or arg_10_1.y ~= 0 then
		if not self.active then
			self.active = true

			if self.activeCallback then
				self.activeCallback(true)
			end
		end

		self:setTargetPos(Vector2(arg_10_1.x * 1000, arg_10_1.y * 1000))
	elseif self.active then
		self.active = false

		self:setTargetPos(Vector2(0, 0))
	end

	return
end

function MiniGameJoyStick:setValueCallback(arg_11_1)
	self.valueCallback = arg_11_1

	return
end

function MiniGameJoyStick:setActiveCallback(arg_12_1)
	self.activeCallback = arg_12_1

	return
end

function MiniGameJoyStick:getValue()
	return {
		angle = self.angle,
		rad = self.rad,
		rate = self.distanceRate,
		x = self.offsetX,
		y = self.offsetY,
		active = self.active,
		directX = self.directX,
		directY = self.directY
	}
end

return MiniGameJoyStick
