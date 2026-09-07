local IslandCheaterTavernTableUnit = class("IslandCheaterTavernTableUnit", import(".IslandSceneUnit"))

function IslandCheaterTavernTableUnit:OnAttach(arg_1_1)
	IslandCheaterTavernTableUnit.super.OnAttach(self, arg_1_1)

	self.tf = tf(arg_1_1)
	self.animator = self.tf:GetComponent(typeof(UnityEngine.Animator))

	bindComponent(self, arg_1_1)

	self.decorationAnimator = self.decorationtf:GetComponent(typeof(UnityEngine.Animator))

	setActive(self.trunTalbeTip, false)
	setActive(self.boomShoot, false)

	return
end

function IslandCheaterTavernTableUnit:OnDetach()
	bindComponent(self, self.tf, true)
	IslandCheaterTavernTableUnit.super.OnDetach(self)

	return
end

function IslandCheaterTavernTableUnit:OnFirstTakeShootTip(arg_3_1)
	setActive(self.trunTalbeTip, true)
	self.animator:SetTrigger("open")
	self.decorationAnimator:SetTrigger("open")
	self:InitRotationBySeat(arg_3_1)
	self:InitBombId({})

	return
end

function IslandCheaterTavernTableUnit:InitBombId(arg_4_1)
	local function var_4_0(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_4_1) do
			if iter_5_1 == arg_5_0 then
				return true
			end
		end

		return false
	end

	for iter_4_0 = 1, 6 do
		setActive(self["bombId" .. tostring(iter_4_0)], (var_4_0(iter_4_0)))
	end

	return
end

function IslandCheaterTavernTableUnit:GetPrevIds(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_3 do
		var_6_0[#var_6_0 + 1] = (arg_6_2 - iter_6_0 - 1) % arg_6_1 + 1
	end

	return var_6_0
end

function IslandCheaterTavernTableUnit:InitRotationBySeat(arg_7_1)
	self.tableRoot.transform.localEulerAngles = Vector3(0, IslandCheaterTavernConst.seatRotatonY[arg_7_1] - 90, 0)
	self.centerRoot.localEulerAngles = Vector3(0, IslandCheaterTavernConst.seatRotatonY[arg_7_1], 0)

	return
end

function IslandCheaterTavernTableUnit:OnShoot(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_1 and arg_8_4 == 1 then
		setActive(self.trunTalbeTip, false)

		self.firstTakeShoot = true
	else
		self.animator:SetTrigger("open")
		self.decorationAnimator:SetTrigger("open")

		self.shootOpenTime = 0

		self:InitRotationBySeat(arg_8_2)
		self:InitBombId((self:GetPrevIds(6, arg_8_3, arg_8_4 - 1)))
	end

	self.curBombId = arg_8_3
	self.hasBombCount = arg_8_4
	self.gotShoot = arg_8_5

	if self.hasBombCount == 1 then
		self.rotateDuration = IslandCheaterTavernConst.firstTurnTime
		self.turntabletf.localEulerAngles = Vector3(0, 0, 0)
		self.endRotationY = -60 * (self.curBombId - 1)
		self.rotateTotalAngle = IslandCheaterTavernConst.turnCircleCount * 360 + self.endRotationY
		self.rotateStartEuler = self.turntabletf.localEulerAngles
	else
		self.turntabletf.localEulerAngles = Vector3(0, -60 * (((self.curBombId - 1 == 0 or nil) and 6) - 1), 0)
		self.rotateDuration = IslandCheaterTavernConst.afterTurnTime
		self.stepStartY = self.turntabletf.localEulerAngles.y
		self.stepTargetY = self.stepStartY - 60
	end

	return
end

function IslandCheaterTavernTableUnit:OnUpdate()
	local var_9_0 = false

	if self.shootOpenTime ~= nil then
		self.shootOpenTime = self.shootOpenTime + Time.deltaTime

		if self.shootOpenTime >= 0.2 then
			var_9_0 = true
			self.shootOpenTime = nil
		end
	end

	if self.firstTakeShoot then
		var_9_0 = true
		self.firstTakeShoot = false
	end

	if var_9_0 then
		self.rotateTime = 0

		if self.hasBombCount == 1 then
			self.isRotating = true
		else
			self.trunToNextBomb = true
		end
	end

	if self.isRotating then
		self.rotateTime = self.rotateTime + Time.deltaTime

		local var_9_1 = Mathf.Clamp01(self.rotateTime / self.rotateDuration)

		self.turntabletf.localEulerAngles = Vector3(self.rotateStartEuler.x, self.rotateStartEuler.y + self.rotateTotalAngle * Mathf.SmoothStep(0, 1, var_9_1), self.rotateStartEuler.z)

		if var_9_1 >= 1 then
			self.isRotating = false
			self.turntabletf.localEulerAngles = Vector3(self.rotateStartEuler.x, self.rotateStartEuler.y + self.endRotationY, self.rotateStartEuler.z)

			if self.gotShoot then
				setActive(self.boomShoot, true)
				onDelayTick(function()
					if IsNil(self.boomShoot) then
						return
					end

					setActive(self.boomShoot, false)
					self.animator:SetTrigger("close")
					self.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			else
				setActive(self.noGotShoot, true)
				setActive(self["bombId" .. tostring(self.curBombId)], true)
				onDelayTick(function()
					if IsNil(self.noGotShoot) then
						return
					end

					setActive(self.noGotShoot, false)
					self.animator:SetTrigger("close")
					self.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			end
		end
	end

	if self.trunToNextBomb then
		self.rotateTime = self.rotateTime + Time.deltaTime

		local var_9_2 = Mathf.Clamp01(self.rotateTime / self.rotateDuration)

		self.turntabletf.localEulerAngles = Vector3(0, Mathf.LerpAngle(self.stepStartY, self.stepTargetY, (Mathf.SmoothStep(0, 1, var_9_2))), 0)

		if var_9_2 >= 1 then
			self.turntabletf.localEulerAngles = Vector3(0, self.stepTargetY, 0)

			if self.gotShoot then
				setActive(self.boomShoot, true)
				onDelayTick(function()
					if IsNil(self.boomShoot) then
						return
					end

					setActive(self.boomShoot, false)
					self.animator:SetTrigger("close")
					self.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			else
				setActive(self.noGotShoot, true)
				setActive(self["bombId" .. tostring(self.curBombId)], true)
				onDelayTick(function()
					if IsNil(self.noGotShoot) then
						return
					end

					setActive(self.noGotShoot, false)
					self.animator:SetTrigger("close")
					self.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			end

			self.trunToNextBomb = false
		end
	end

	return
end

return IslandCheaterTavernTableUnit
