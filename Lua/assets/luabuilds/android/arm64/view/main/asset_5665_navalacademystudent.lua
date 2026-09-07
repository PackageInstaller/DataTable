local NavalAcademyStudent = class("NavalAcademyStudent")

NavalAcademyStudent.ShipState = {
	Touch = "Touch",
	Idle = "Idle",
	Walk = "Walk"
}
NavalAcademyStudent.normalSpeed = 15

function NavalAcademyStudent:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform

	self:init()

	return
end

function NavalAcademyStudent:init()
	self.chat = self._tf:Find("chat")
	self.chatFace = self.chat:Find("face")
	self.chatTask = self.chat:Find("task")
	self.chatFight = self.chat:Find("fight")
	self.clickArea = self._tf:Find("click")

	setActive(self.chat, true)
	setActive(self.clickArea, true)

	return
end

function NavalAcademyStudent:attach()
	self.exited = false

	setActive(self._go, true)
	pg.DelegateInfo.New(self)

	return
end

function NavalAcademyStudent:setPathFinder(arg_4_1)
	self.pathFinder = arg_4_1

	return
end

function NavalAcademyStudent:setCallBack(arg_5_1, arg_5_2)
	self.onStateChange = arg_5_1
	self.onTask = arg_5_2

	return
end

function NavalAcademyStudent:updateStudent(arg_6_1, arg_6_2)
	if arg_6_1.hide then
		setActive(self._go, false)

		return
	end

	setActive(self._go, true)

	if self.shipVO == nil or self.shipVO.configId ~= arg_6_1.configId then
		if self.model then
			self.model:Dispose()
		end

		self.prefab = arg_6_1:getPrefab()
		self.currentPoint = self.pathFinder:getRandomPoint()
		self.targetPoint = self.pathFinder:getPoint(self.currentPoint.nexts[math.random(1, #self.currentPoint.nexts)])
		self._tf.anchoredPosition = Vector2.New(self.currentPoint.x, self.currentPoint.y)

		local var_6_0 = self.prefab

		self.model = SpineAnimChar.New()

		self.model:SetPaint(self.prefab)
		self.model:Load(true, function(arg_7_0)
			if var_6_0 ~= self.prefab then
				arg_7_0:Dispose()

				return
			end

			self.model:SetLocalScale(Vector3(0.5, 0.5, 1))
			self.model:SetLocalPosition(Vector3.zero)
			self.model:SetParent(self._tf)
			self.model:SetSiblingIndex(1)
			self:updateState(NavalAcademyStudent.ShipState.Idle)
			onButton(self, self.chat, function()
				self:onClickShip()

				return
			end)

			return
		end)
	end

	onButton(self, self.clickArea, function()
		if self.model then
			self:updateState(NavalAcademyStudent.ShipState.Touch)
		end

		return
	end)

	self.shipVO = arg_6_1
	self.args = arg_6_2

	setActive(self.chatFace, false)
	setActive(self.chatTask, false)
	setActive(self.chatFight, false)

	if self.shipVO.withShipFace then
		if arg_6_2.showTips then
			setActive(self.chatTask, true)
		elseif arg_6_2.currentTask and not arg_6_2.currentTask:isFinish() and arg_6_2.currentTask:getConfig("sub_type") == 29 then
			setActive(self.chatFight, true)
		else
			setActive(self.chatFace, true)
		end
	end

	return
end

function NavalAcademyStudent:updateState(arg_10_1)
	if self.state ~= arg_10_1 then
		self.state = arg_10_1

		self:updateAction()
		self:updateLogic()

		if self.onStateChange then
			self.onStateChange(self.state)
		end
	end

	return
end

function NavalAcademyStudent:updateAction()
	if self.model then
		if self.state == NavalAcademyStudent.ShipState.Walk then
			self.model:SetAction("walk", 0)
		elseif self.state == NavalAcademyStudent.ShipState.Idle then
			self.model:SetAction("stand2", 0)
		elseif self.state == NavalAcademyStudent.ShipState.Touch then
			self.model:SetAction("touch", 0)
			self.model:SetActionCallBack(function(arg_12_0)
				self:updateState(NavalAcademyStudent.ShipState.Idle)

				return
			end)
		end
	end

	return
end

function NavalAcademyStudent:updateLogic()
	self:clearLogic()

	if self.state == NavalAcademyStudent.ShipState.Walk then
		local var_13_0 = Vector3(self._tf.anchoredPosition.x, self._tf.anchoredPosition.y, 0)
		local var_13_1 = Vector3(self.targetPoint.x, self.targetPoint.y, 0)

		LeanTween.value(self._go, 0, 1, Vector3.Distance(var_13_0, var_13_1) / self.normalSpeed):setOnUpdate(System.Action_float(function(arg_14_0)
			self._tf.anchoredPosition3D = Vector3.Lerp(var_13_0, var_13_1, arg_14_0)

			local var_14_0 = self._tf.localScale
			local var_14_1 = self.targetPoint.x > self.currentPoint.x and 1 or -1

			var_14_0.x = self.targetPoint.x > self.currentPoint.x and 1 or -1
			self._tf.localScale = var_14_0
			self.chat.localScale.x = var_14_1
			self.chat.localScale = self.chat.localScale
			self.chat.anchoredPosition.x = var_14_1 * math.abs(self.chat.anchoredPosition.x)
			self.chat.anchoredPosition = self.chat.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			self.currentPoint = self.targetPoint
			self.targetPoint = self.pathFinder:getPoint(self.currentPoint.nexts[math.random(1, #self.currentPoint.nexts)])

			self:updateState(NavalAcademyStudent.ShipState.Idle)

			return
		end))
	elseif self.state == NavalAcademyStudent.ShipState.Idle then
		self.idleTimer = Timer.New(function()
			self:updateState(NavalAcademyStudent.ShipState.Walk)

			return
		end, math.random(10, 20), 1)

		self.idleTimer:Start()
	elseif self.state == NavalAcademyStudent.ShipState.Touch then
		self:onClickShip()
	end

	return
end

function NavalAcademyStudent:onClickShip()
	if self.onTask then
		self.onTask(self.acceptTaskId, self.currentTask)
	end

	return
end

function NavalAcademyStudent:clearLogic()
	LeanTween.cancel(self._go)

	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end

	return
end

function NavalAcademyStudent:clear()
	self:clearLogic()

	if self.model then
		self.model:SetActionCallBack(nil)
		self.model:SetLocalScale(Vector3.one)
		self.model:Dispose()
	end

	self.shipVO = nil
	self.prefab = nil
	self.model = nil
	self.position = nil
	self.currentPoint = nil
	self.targetPoint = nil
	self.state = nil

	return
end

function NavalAcademyStudent:detach()
	if not self.exited then
		setActive(self._go, false)
		pg.DelegateInfo.Dispose(self)
		self:clear()

		self.exited = true
	end

	return
end

return NavalAcademyStudent
