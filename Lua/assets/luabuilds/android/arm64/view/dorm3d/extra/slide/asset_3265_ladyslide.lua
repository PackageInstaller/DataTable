local LadySlide = class("LadySlide")

function LadySlide:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.id = arg_1_1
	self.ladyEnv = arg_1_2
	self._tf = arg_1_2.lady
	self.animator = self._tf:GetComponent(typeof(Animator))
	self.commandConfig = arg_1_3
	self.defaultPoint = arg_1_4
	self.ladderTime = pg.dorm3d_minigame_slide[arg_1_1].ladder_time
	self.moveSpeed = pg.dorm3d_minigame_slide[arg_1_1].move_speed
	self.onPlayVFX = arg_1_5

	return
end

function LadySlide:Reset()
	self._tf.localPosition = self.defaultPoint.position
	self._tf.localRotation = self.defaultPoint.rotation

	self.ladyEnv:PlaySingleAction(SlideConst.IDLE_ANIM)

	return
end

function LadySlide:StartMove()
	self:Cancel()

	self.curIndex = 1
	self.curState = nil
	self.inProgress = true

	self.ladyEnv:SetCollisible(false)
	self.ladyEnv:EnableCharacterTransparency(true)
	self.ladyEnv:BlockCanWatch(true)

	return
end

function LadySlide:EndMove()
	self.curIndex = nil
	self.curState = nil
	self.inProgress = false

	self.ladyEnv:SetCollisible(true)
	self.ladyEnv:EnableCharacterTransparency(false)
	self.ladyEnv:BlockCanWatch(false)
	self:Reset()

	return
end

function LadySlide:OnUpdate()
	if not self.inProgress or self.curIndex > #self.commandConfig then
		return
	end

	local var_5_0 = self.commandConfig[self.curIndex]

	if not self.curState then
		self:EnterState(var_5_0.type, var_5_0)
	elseif self:Check(var_5_0) then
		self.curIndex = self.curIndex + 1

		if self.curIndex > #self.commandConfig then
			self:ExitState(self.curState)
			self:EndMove()

			return
		end

		var_5_0 = self.commandConfig[self.curIndex]

		if self.commandConfig[self.curIndex].type ~= self.curState then
			self:ExitState(self.curState)
		end

		self:EnterState(var_5_0.type, var_5_0)
	end

	self:UpdateState(var_5_0)

	return
end

function LadySlide:Check(arg_6_1)
	local function var_6_0(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.position - arg_7_1.position

		var_7_0.y = 0

		return var_7_0.magnitude <= 0.1
	end

	return switch(self.curState, {
		[SlideConst.COMMAND_TYPE.WALK] = function()
			return var_6_0(arg_6_1.target, self._tf)
		end,
		[SlideConst.COMMAND_TYPE.LADDER] = function()
			return var_6_0(arg_6_1.target, self._tf)
		end,
		[SlideConst.COMMAND_TYPE.SLIDE] = function()
			return arg_6_1.target.position.y >= self._tf.position.y
		end,
		[SlideConst.COMMAND_TYPE.TELEPORT] = function()
			return true
		end,
		[SlideConst.COMMAND_TYPE.ANIM] = function()
			if self.animator:IsInTransition(self.ladyEnv.ladyAnimBaseLayerIndex) then
				return false
			end

			return self.animator:GetCurrentAnimatorStateInfo(self.ladyEnv.ladyAnimBaseLayerIndex).normalizedTime >= 1
		end,
		[SlideConst.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
			return self.walkWithRotateTime >= arg_6_1.time
		end
	})
end

function LadySlide:UpdateState(arg_14_1)
	local var_14_0 = arg_14_1.target

	switch(self.curState, {
		[SlideConst.COMMAND_TYPE.WALK] = function()
			self.ladyEnv:MoveToTarget(var_14_0.position, self.moveSpeed)

			return
		end,
		[SlideConst.COMMAND_TYPE.LADDER] = function()
			self.ladderMoveTime = self.ladderMoveTime + Time.deltaTime

			local var_16_0 = math.min(self.ladderMoveTime / self.ladderTime, 1)

			self._tf.localPosition = self.ladderStartPos + self.ladderForward * (SlideConst.LADDER_DISPLACEMENT.z * var_16_0) + Vector3.up * (SlideConst.LADDER_DISPLACEMENT.y * var_16_0)

			if var_16_0 >= 1 then
				self.ladderMoveTime = 0
				self.ladderStartPos = self._tf.localPosition
			end

			return
		end,
		[SlideConst.COMMAND_TYPE.SLIDE] = function()
			self.slideMoveTime = self.slideMoveTime + Time.deltaTime

			self.ladyEnv.characterController:Move(self.slideTotalDelta.normalized * (self.slideMoveTime * SlideConst.SLIDE_GRAVITY) * Time.deltaTime)

			return
		end,
		[SlideConst.COMMAND_TYPE.TELEPORT] = function()
			self._tf.localPosition = var_14_0.position
			self._tf.localRotation = var_14_0.rotation

			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM] = function()
			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
			self.walkWithRotateTime = self.walkWithRotateTime + Time.deltaTime

			local var_20_0 = math.min(self.walkWithRotateTime / arg_14_1.time, 1)

			self._tf.localRotation = Quaternion.Slerp(self.cacheRotation, arg_14_1.target.rotation, var_20_0)
			self._tf.localPosition = Vector3.Lerp(self.cachePosition, arg_14_1.target.position, var_20_0)

			return
		end
	})

	return
end

function LadySlide:EnterState(arg_21_1, arg_21_2)
	if arg_21_2:HasEffect() then
		local var_21_0, var_21_1 = arg_21_2:GetEffect()

		self.vfxLTId = LeanTween.delayedCall(var_21_0, System.Action(function()
			self.onPlayVFX(var_21_1)

			return
		end)).uniqueId
	end

	if arg_21_2:HasWet() then
		local var_21_2, var_21_3 = arg_21_2:GetWet()

		self.wetLTId = LeanTween.delayedCall(var_21_2, System.Action(function()
			self:ShowWetness(var_21_3)

			return
		end)).uniqueId
	end

	switch(arg_21_1, {
		[SlideConst.COMMAND_TYPE.WALK] = function()
			self.ladyEnv:PlaySingleAction(SlideConst.WALK_ANIM, nil, arg_21_2:GetFadeInTime())

			self.ladyEnv.characterController.enabled = true

			return
		end,
		[SlideConst.COMMAND_TYPE.LADDER] = function()
			self.ladyEnv:PlaySingleAction(SlideConst.LADDER_ANIM, nil, arg_21_2:GetFadeInTime())

			;(arg_21_2.target.position - self._tf.position).y = 0

			if (arg_21_2.target.position - self._tf.position).sqrMagnitude > 0 then
				self._tf.rotation = Quaternion.LookRotation((arg_21_2.target.position - self._tf.position).normalized, Vector3.up)
			end

			self.ladderMoveTime = 0
			self.ladderStartPos = self._tf.localPosition
			self.ladderForward = self._tf.forward

			return
		end,
		[SlideConst.COMMAND_TYPE.SLIDE] = function()
			self.ladyEnv.characterController.enabled = true

			self.ladyEnv:PlaySingleAction(SlideConst.SLIDE_ANIM, nil, arg_21_2:GetFadeInTime())

			if (arg_21_2.target.position - self._tf.position).sqrMagnitude > 0 then
				self._tf.rotation = Quaternion.LookRotation((arg_21_2.target.position - self._tf.position).normalized, Vector3.up)
			end

			self.slideMoveTime = 0
			self.slideTotalDelta = arg_21_2.target.position - self._tf.localPosition

			return
		end,
		[SlideConst.COMMAND_TYPE.TELEPORT] = function()
			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM] = function()
			self.ladyEnv:PlaySingleAction(arg_21_2.anim, nil, arg_21_2:GetFadeInTime())

			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
			self.ladyEnv:PlaySingleAction(arg_21_2.anim, nil, arg_21_2:GetFadeInTime())

			self.cacheRotation = self._tf.localRotation
			self.cachePosition = self._tf.localPosition
			self.walkWithRotateTime = 0

			return
		end
	})

	self.curState = arg_21_1

	return
end

function LadySlide:ExitState(arg_30_1)
	switch(self.curState, {
		[SlideConst.COMMAND_TYPE.WALK] = function()
			self.ladyEnv.characterController.enabled = false

			return
		end,
		[SlideConst.COMMAND_TYPE.LADDER] = function()
			self.ladderMoveTime = nil
			self.ladderStartPos = nil
			self.ladderForward = nil

			return
		end,
		[SlideConst.COMMAND_TYPE.SLIDE] = function()
			self.ladyEnv.characterController.enabled = false
			self._tf.rotation = Quaternion.Euler(0, self._tf.rotation.eulerAngles.y, self._tf.rotation.eulerAngles.z)
			self.slideMoveTime = nil
			self.slideTotalDelta = nil

			return
		end,
		[SlideConst.COMMAND_TYPE.TELEPORT] = function()
			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM] = function()
			return
		end,
		[SlideConst.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
			return
		end
	})

	self.curState = nil

	return
end

function LadySlide:ShowWetness(arg_37_1)
	if self.wetTimer then
		self.wetTimer:Stop()
	end

	local var_37_0 = 0

	self.wetTimer = Timer.New(function()
		if var_37_0 >= SlideConst.WET_FADE_IN_TIME then
			self.wetTimer:Stop()

			self.wetTimer = nil

			return
		end

		var_37_0 = var_37_0 + 0.016666666666666666

		local var_38_0 = var_37_0 / SlideConst.WET_FADE_IN_TIME

		if not arg_37_1 then
			var_38_0 = 1 - var_38_0
		end

		GraphicsInterface.Instance:SetWetness(go(self._tf), (math.max(math.min(var_38_0, 1), 0)))

		return
	end, 0.016666666666666666, -1)

	self.wetTimer:Start()

	return
end

function LadySlide:Cancel()
	if self.vfxLTId then
		LeanTween.cancel(self.vfxLTId)

		self.vfxLTId = nil
	end

	if self.wetLTId then
		LeanTween.cancel(self.wetLTId)

		self.wetLTId = nil
	end

	if self.wetTimer then
		self.wetTimer:Stop()

		self.wetTimer = nil
	end

	GraphicsInterface.Instance:SetWetness(go(self._tf), 0)

	return
end

function LadySlide:Dispose()
	self:Cancel()
	self.ladyEnv:SetCollisible(true)
	self.ladyEnv:EnableCharacterTransparency(false)
	self.ladyEnv:BlockCanWatch(false)

	return
end

return LadySlide
