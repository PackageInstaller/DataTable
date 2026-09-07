local SummerFeastNavigationAgent = class("SummerFeastNavigationAgent", require("view.main.NavalAcademyStudent"))

function SummerFeastNavigationAgent:Ctor(arg_1_1, arg_1_2)
	self.onTransEdge = nil
	self.needOneScale = arg_1_2

	SummerFeastNavigationAgent.super.Ctor(self, arg_1_1)

	return
end

function SummerFeastNavigationAgent:init()
	return
end

SummerFeastNavigationAgent.normalSpeed = 15
SummerFeastNavigationAgent.normalScale = 0.5
SummerFeastNavigationAgent.oneScale = 1

function SummerFeastNavigationAgent:SetOnTransEdge(arg_3_1)
	self.onTransEdge = arg_3_1

	return
end

function SummerFeastNavigationAgent:setCurrentIndex(arg_4_1)
	if not arg_4_1 then
		return
	end

	self.currentPoint = self.pathFinder:getPoint(arg_4_1)

	return
end

function SummerFeastNavigationAgent:SetPositionTable(arg_5_1)
	self.posTable = arg_5_1

	return
end

function SummerFeastNavigationAgent:updateStudent(arg_6_1)
	if arg_6_1 == nil or arg_6_1 == "" then
		setActive(self._go, false)

		return
	end

	setActive(self._go, true)

	if self.prefabName ~= arg_6_1 then
		if self.model then
			self.model:Dispose()
		end

		self.prefab = arg_6_1
		self.currentPoint = self.currentPoint or self.pathFinder:getRandomPoint()
		self.targetPoint = self.currentPoint
		self._tf.anchoredPosition = self.currentPoint

		if self.onTransEdge then
			self:onTransEdge(self.currentPoint.id, self.currentPoint.id)
		end

		local var_6_0 = self.prefab

		self.model = SpineAnimChar.New()

		self.model:SetPaint(var_6_0)
		self.model:Load(true, function(arg_7_0)
			if var_6_0 ~= self.prefab then
				arg_7_0:Dispose()

				return
			end

			self.model:SetLocalScale(Vector3(0.5, 0.5, 1))
			self.model:SetLocalPosition(Vector3.zero)
			self.model:SetParent(self._tf)
			self:updateState(SummerFeastNavigationAgent.ShipState.Idle)

			return
		end)
	end

	self.prefabName = arg_6_1

	return
end

function SummerFeastNavigationAgent:updateLogic()
	self:clearLogic()

	if self.state == SummerFeastNavigationAgent.ShipState.Walk then
		local var_8_0 = self.currentPoint
		local var_8_1 = self.targetPoint

		if self.posTable[self.currentPoint.id] == self then
			self.posTable[self.currentPoint.id] = nil
		end

		self._tf.localScale = ((self.needOneScale or nil) and self.oneScale) * Vector2.one

		local var_8_3 = self.pathFinder:getEdge(self.currentPoint, self.targetPoint)

		LeanTween.value(self._go, 0, 1, Vector2.Distance(self.currentPoint, self.targetPoint) / self.normalSpeed):setOnUpdate(System.Action_float(function(arg_9_0)
			self._tf.anchoredPosition = var_8_3 and var_8_3.bezier_control_point and SummerFeastNavigationAgent.GetBeziersPoints(var_8_0, var_8_1, self.pathFinder:getPoint(var_8_3.bezier_control_point), arg_9_0) or Vector2.Lerp(var_8_0, var_8_1, arg_9_0)

			local var_9_1 = math.lerp(var_8_0.scale or SummerFeastNavigationAgent.normalScale, var_8_1.scale or SummerFeastNavigationAgent.normalScale, arg_9_0) * Vector2.one
			local var_9_2 = var_8_1.x > var_8_0.x and 1 or -1

			if var_8_0.id == var_8_1.id then
				var_9_2 = math.random(0, 1) == 1 and 1 or -1
			end

			if var_8_0.fixedDirection then
				var_9_2 = math.sign(var_8_0.fixedDirection)
			end

			if self.needOneScale then
				var_9_1 = self.oneScale * Vector2.one
			end

			var_9_1.x = math.abs(var_9_1.x) * var_9_2
			self._tf.localScale = var_9_1

			return
		end)):setOnComplete(System.Action(function()
			self.currentPoint = self.targetPoint

			local var_10_0 = self.currentPoint.nexts[math.random(1, #self.currentPoint.nexts)]

			if self.onTransEdge and var_10_0 then
				self.targetPoint = self.pathFinder:getPoint(var_10_0)

				self:onTransEdge(self.currentPoint.id, var_10_0)
			end

			self:updateState(SummerFeastNavigationAgent.ShipState.Idle)

			return
		end))
	elseif self.state == SummerFeastNavigationAgent.ShipState.Idle then
		if self.posTable[self.currentPoint.id] == nil then
			self.posTable[self.currentPoint.id] = self
		else
			self:updateState(SummerFeastNavigationAgent.ShipState.Walk)

			return
		end

		if self.currentPoint.isBan then
			self:updateState(SummerFeastNavigationAgent.ShipState.Walk)

			return
		end

		self.idleTimer = Timer.New(function()
			self:updateState(SummerFeastNavigationAgent.ShipState.Walk)

			return
		end, math.random(10, 20), 1)

		self.idleTimer:Start()
	elseif self.state == SummerFeastNavigationAgent.ShipState.Touch then
		self:onClickShip()
	end

	return
end

function SummerFeastNavigationAgent:GetBeziersPoints(arg_12_1, arg_12_2, arg_12_3)
	local var_12_1 = self:Clone():Mul((1 - arg_12_3) * (1 - arg_12_3)):Add((arg_12_2:Clone():Mul(2 * arg_12_3 * (1 - arg_12_3)))).Add

	return self:Clone():Mul((1 - arg_12_3) * (1 - arg_12_3)):Add((arg_12_2:Clone():Mul(2 * arg_12_3 * (1 - arg_12_3)))):Add((arg_12_1:Clone():Mul(arg_12_3 * arg_12_3)))
end

return SummerFeastNavigationAgent
