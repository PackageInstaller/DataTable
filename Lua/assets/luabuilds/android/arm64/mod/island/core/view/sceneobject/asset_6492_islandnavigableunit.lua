local IslandNavigableUnit = class("IslandNavigableUnit", import(".IslandSceneUnit"))

function IslandNavigableUnit:WarpAgent()
	self.agent:Warp(self._tf.position)

	;(self.agent.steeringTarget - self._tf.position).y = 0

	if (self.agent.steeringTarget - self._tf.position).sqrMagnitude > 0.001 then
		self._tf.rotation = Quaternion.LookRotation(self.agent.steeringTarget - self._tf.position)
	end

	return
end

function IslandNavigableUnit:OnLaterAttach(arg_2_1)
	self.agent = GetOrAddComponent(arg_2_1, typeof(UnityEngine.AI.NavMeshAgent))
	self.agent.updatePosition = false
	self.agent.updateRotation = false
	self._tf = self._go.transform
	self._degreeSpeedDamping = 10
	self._targetSpeed = 0
	self._speed = 0
	self._speedDamping = 1
	self._walkingMaxSpeed = 1.5
	self._runMaxSpeed = 5
	self._targetPosition = Vector3.zero
	self.verticalVelocity = 0
	self.smoothVelocity = Vector3.zero
	self.elapsedTime = 0
	self._animator = self._tf:GetChild(0):GetComponent(typeof(Animator))
	self._characterController = self._go:GetComponent(typeof(UnityEngine.CharacterController))

	self:SetNavAgentStopDistance(2)

	self.isNavigating = false

	return
end

function IslandNavigableUnit:SetDestination(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.agent.radius = defaultValue(arg_3_3, 0.6)
	self._characterController.radius = defaultValue(arg_3_4, 0.25)
	self.isNavigating = true

	self:SetNavAgentDestination(arg_3_1)

	arg_3_2 = Mathf.Clamp(arg_3_2 or 0, self._walkingMaxSpeed, self._runMaxSpeed)

	self:SetNavAgentSpeed(arg_3_2)

	self._targetPosition = arg_3_1
	self.lastAvoidancePriority = self.agent.avoidancePriority
	self.agent.avoidancePriority = 0

	IslandHelper.SetLowQualityObstacle(self.agent)

	return
end

function IslandNavigableUnit:StopMove()
	self.agent.avoidancePriority = defaultValue(self.lastAvoidancePriority, 10)
	self.isNavigating = false

	self:StopNavAgent()

	self._targetSpeed = 0
	self._characterController.radius = 0.5

	self:WarpAgent()

	self._targetPosition = Vector3.zero

	if self._animator then
		self._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	end

	self.agent.radius = 0.5

	IslandHelper.SetHighQualityObstacle(self.agent)

	return
end

function IslandNavigableUnit:Update()
	if not self:IsLoaded() then
		return
	end

	self.elapsedTime = self.elapsedTime + Time.deltaTime

	if self.stateCallback then
		self:CheckAnimationState()
	end

	if not self.active then
		return
	end

	if self.isNavigating then
		self:NavUpdate()
	else
		IslandNavigableUnit.super.Update(self)
	end

	return
end

function IslandNavigableUnit:GetElapsedTime()
	return self.elapsedTime
end

function IslandNavigableUnit:NavUpdate()
	if not self.agent then
		return
	end

	if not self.agent.pathPending and self.agent.remainingDistance <= self.agent.stoppingDistance then
		if not self.agent.hasPath or self.agent.velocity.sqrMagnitude < 0.01 then
			self.reached = true
		end
	else
		self.reached = false
	end

	local var_7_0 = Vector3.zero

	if not self.reached then
		self.smoothVelocity = Vector3.Lerp(self.smoothVelocity or Vector3.zero, Vector3(self.agent.velocity.x, 0, self.agent.velocity.z) * ((self.agent.stoppingDistance * 2 > self.agent.remainingDistance or nil) and self.agent.remainingDistance / (self.agent.stoppingDistance * 2)), Time.deltaTime * 10)
		var_7_0 = self.smoothVelocity
	end

	local var_7_2 = Vector3(var_7_0.x, 0, var_7_0.z)

	if not self.reached and var_7_2.sqrMagnitude > 0.05 then
		self._tf.rotation = Quaternion.Slerp(self._tf.rotation, Quaternion.LookRotation(var_7_2), Time.deltaTime * 10)
	end

	self.verticalVelocity = self._characterController.isGrounded and -0.1 or self.verticalVelocity + -9.81 * Time.deltaTime
	var_7_0.y = self.verticalVelocity

	self._characterController:Move(var_7_0 * Time.deltaTime)

	self.agent.nextPosition = Vector3.Lerp(self.agent.nextPosition, self._tf.position, Time.deltaTime * 20)

	if self._animator then
		self._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, var_7_2.magnitude * 1.5)
	end

	return
end

function IslandNavigableUnit:SetNavAgentStopDistance(arg_8_1)
	self.agent.stoppingDistance = arg_8_1

	return
end

function IslandNavigableUnit:SetNavAgentDestination(arg_9_1)
	self:CheckMovement()

	self.agent.isStopped = false
	self.agent.destination = arg_9_1

	return
end

function IslandNavigableUnit:SetNavPosition(arg_10_1)
	self.agent.nextPosition = arg_10_1

	return
end

function IslandNavigableUnit:CalculateNavPath(arg_11_1)
	local var_11_0 = UnityEngine.AI.NavMeshPath.New()

	self.agent:CalculatePath(arg_11_1, var_11_0)

	return (var_11_0.corners:ToTable())
end

function IslandNavigableUnit:SetNavAgentSpeed(arg_12_1)
	self.agent.speed = arg_12_1

	return
end

function IslandNavigableUnit:GetNavAgentSpeed(arg_13_1)
	return self.agent.speed
end

function IslandNavigableUnit:SetNavAgentVelocity(arg_14_1)
	self.agent.velocity = arg_14_1

	return
end

function IslandNavigableUnit:GetNavAgentVelocity()
	return self.agent.desiredVelocity * self.agent.speed
end

function IslandNavigableUnit:GetDesiredVelocity()
	return self.agent.desiredVelocity
end

function IslandNavigableUnit:StopNavAgent()
	self.agent.isStopped = true

	return
end

function IslandNavigableUnit:GetAnimator()
	return self._animator
end

function IslandNavigableUnit:CheckMovement()
	local var_19_0 = self:GetAnimator():GetCurrentAnimatorStateInfo(0)

	if self.cantMove then
		return false
	end

	if _.any(IslandConst.CANT_SWITCH_TO_MOVEMENT_STATES, function(arg_20_0)
		return var_19_0:IsName(arg_20_0)
	end) then
		return false
	end

	if not var_19_0:IsName(IslandConst.ANIMATION_MOVEMENT) then
		self:PlayAnimation(IslandConst.ANIMATION_MOVEMENT, 0)

		return true
	end

	self:ClearSatetCallback()

	return false
end

function IslandNavigableUnit:PlayAnimation(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = defaultValue(arg_21_2, 0.25)

	if arg_21_1 == IslandConst.ANIMATION_HEROCOMING then
		var_21_0 = 0
	end

	local var_21_1 = self:GetAnimator()
	local var_21_2 = Animator.StringToHash(arg_21_1)

	for iter_21_0 = 1, var_21_1.layerCount do
		var_21_1:CrossFadeInFixedTime(var_21_2, var_21_0, iter_21_0 - 1)
	end

	if arg_21_3 then
		self:ClearSatetCallback()

		self.stateCallback = {
			state = arg_21_1,
			callback = arg_21_3
		}
	end

	return
end

function IslandNavigableUnit:CheckAnimationState()
	local var_22_0 = self:GetAnimator()
	local var_22_1 = var_22_0:GetCurrentAnimatorStateInfo(0)

	if var_22_1:IsName(self.stateCallback.state) and not self.endTime then
		self.endTime = self:GetElapsedTime() + var_22_1.length / var_22_0.speed
	end

	if self.endTime and self:GetElapsedTime() >= self.endTime then
		self:ClearSatetCallback()
		self.stateCallback.callback()
	end

	return
end

function IslandNavigableUnit:ClearSatetCallback()
	if self.stateCallback then
		self.stateCallback = nil
	end

	self.endTime = nil

	return
end

function IslandNavigableUnit:Enable()
	IslandNavigableUnit.super.Enable(self)

	if not self:IsLoaded() then
		return
	end

	self.agent.enabled = true

	return
end

function IslandNavigableUnit:Disable()
	IslandNavigableUnit.super.Disable(self)

	if not self:IsLoaded() then
		return
	end

	self.agent.enabled = false

	return
end

function IslandNavigableUnit:Dispose()
	IslandNavigableUnit.super.Dispose(self)
	self:ClearSatetCallback()

	return
end

return IslandNavigableUnit
