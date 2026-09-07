local IslandSystemDelegationUnit = class("IslandSystemDelegationUnit", import(".IslandNpcUnit"))

function IslandSystemDelegationUnit:OnLaterAttach(arg_1_1)
	self.agent = GetOrAddComponent(arg_1_1, typeof(UnityEngine.AI.NavMeshAgent))
	self.agent.updatePosition = true
	self.agent.updateRotation = true
	self._tf = self._go.transform
	self._degreeSpeedDamping = 10
	self._targetSpeed = 0
	self._speed = 0
	self._speedDamping = 1
	self._walkingMaxSpeed = 1.5
	self._runMaxSpeed = 5
	self._targetPosition = Vector3.zero
	self._velocity = Vector3.zero
	self._extraVelocity = Vector3.zero
	self._animator = self._tf:GetChild(0):GetComponent(typeof(Animator))
	self.elapsedTime = 0
	self.isNavigating = false
	self._characterController = self._go:GetComponent(typeof(UnityEngine.CharacterController))

	if pg.island_unit_character[self.modelId].CollisionParam ~= "" then
		self._characterController.enabled = false

		local var_1_0 = GetOrAddComponent(self._go, typeof("UnityEngine.CapsuleCollider"))

		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "center", var_1_0, Vector3(0, pg.island_unit_character[self.modelId].CollisionParam[1], 0))
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "radius", var_1_0, pg.island_unit_character[self.modelId].CollisionParam[2])
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "height", var_1_0, pg.island_unit_character[self.modelId].CollisionParam[3])

		self.agent.radius = pg.island_unit_character[self.modelId].CollisionParam[2]
	else
		self._characterController.enabled = false

		local var_1_1 = GetOrAddComponent(self._go, typeof("UnityEngine.CapsuleCollider"))

		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "center", var_1_1, Vector3(0, 0.96, 0))
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "radius", var_1_1, 0.5)
		ReflectionHelp.RefSetProperty(typeof("UnityEngine.CapsuleCollider"), "height", var_1_1, 1.76)

		self.agent.radius = 0.5
	end

	self:SetNavAgentStopDistance(2.1)

	self.isNavigating = false

	return
end

function IslandSystemDelegationUnit:SetDestination(arg_2_1, arg_2_2)
	self.isNavigating = true

	self:SetNavAgentDestination(arg_2_1)

	self._targetSpeed = Mathf.Clamp(arg_2_2 or 0, self._walkingMaxSpeed, self._runMaxSpeed)
	self._targetPosition = arg_2_1

	return
end

function IslandSystemDelegationUnit:StopMove()
	self.isNavigating = false

	self:StopNavAgent()

	self._targetSpeed = 0
	self._targetPosition = Vector3.zero

	if not self.isLoading then
		self._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	end

	return
end

function IslandSystemDelegationUnit:Update()
	if not self:IsLoaded() then
		return
	end

	if not self.active then
		return
	end

	if self.isNavigating then
		self:NavUpdate()
	else
		IslandSystemDelegationUnit.super.Update(self)
	end

	return
end

function IslandSystemDelegationUnit:NavUpdate()
	self._speed = Mathf.Lerp(self._speed, self._targetSpeed, self._speedDamping)

	self:SetNavAgentSpeed(self._speed * 0.5)

	if not self.isLoading then
		self._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, self._speed)
	end

	return
end

function IslandSystemDelegationUnit:SetNavAgentStopDistance(arg_6_1)
	self.agent.stoppingDistance = arg_6_1

	return
end

function IslandSystemDelegationUnit:SetNavAgentDestination(arg_7_1)
	self.agent.isStopped = false
	self.agent.destination = arg_7_1

	return
end

function IslandSystemDelegationUnit:SetNavPosition(arg_8_1)
	self.agent.nextPosition = arg_8_1

	return
end

function IslandSystemDelegationUnit:CalculateNavPath(arg_9_1)
	local var_9_0 = UnityEngine.AI.NavMeshPath.New()

	self.agent:CalculatePath(arg_9_1, var_9_0)

	return (var_9_0.corners:ToTable())
end

function IslandSystemDelegationUnit:SetNavAgentSpeed(arg_10_1)
	self.agent.speed = arg_10_1

	return
end

function IslandSystemDelegationUnit:GetNavAgentSpeed(arg_11_1)
	return self.agent.speed
end

function IslandSystemDelegationUnit:SetNavAgentVelocity(arg_12_1)
	self.agent.velocity = arg_12_1

	return
end

function IslandSystemDelegationUnit:GetNavAgentVelocity()
	return self.agent.desiredVelocity * self.agent.speed
end

function IslandSystemDelegationUnit:GetDesiredVelocity()
	return self.agent.desiredVelocity
end

function IslandSystemDelegationUnit:StopNavAgent()
	self.agent.isStopped = true

	return
end

function IslandSystemDelegationUnit:GetAnimator()
	return self._animator
end

function IslandSystemDelegationUnit:SetShipDressHelper(arg_17_1)
	self.shipDressHelper = arg_17_1

	return
end

function IslandSystemDelegationUnit:OnDetach()
	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandSystemDelegationUnit:OnCharacterChangeDress(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 then
		local var_19_0 = {}

		local function var_19_1()
			self._animator = self._tf:GetChild(0):GetComponent(typeof(Animator))

			for iter_20_0, iter_20_1 in ipairs(var_19_0) do
				self._animator:Play(iter_20_1.shortNameHash, iter_20_0 - 1, iter_20_1.normalizedTime)
			end

			self.isLoading = false

			self._tf:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)):StartBehaviour()

			return
		end

		self.isLoading = true

		self._tf:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner)):PauseBehaviour()

		normalizedTime = self._animator:GetCurrentAnimatorStateInfo(0).normalizedTime % 1

		for iter_19_0 = 1, self._animator.layerCount do
			local var_19_2 = self._animator:GetCurrentAnimatorStateInfo(iter_19_0 - 1)

			table.insert(var_19_0, {
				shortNameHash = var_19_2.shortNameHash,
				normalizedTime = var_19_2.normalizedTime
			})
		end

		self:DestroyInteractiveTools()

		if #arg_19_2 == 0 and #arg_19_3 == 0 then
			self.shipDressHelper:ChangeModelTransfromByUnitId(arg_19_1, var_19_1)
		else
			self.shipDressHelper:ChangeModelTransfromByUnitIdAndChangeDress(arg_19_1, arg_19_2, arg_19_3, var_19_1)
		end
	else
		for iter_19_1, iter_19_2 in ipairs(arg_19_2) do
			self.shipDressHelper:ChangeDressByType(pg.island_dress_template[iter_19_2].type, {
				id = 0,
				colorId = 0
			})
		end

		for iter_19_3, iter_19_4 in ipairs(arg_19_3) do
			self.shipDressHelper:ChangeDressByType(pg.island_dress_template[iter_19_4].type, {
				colorId = 0,
				id = iter_19_4
			})
		end
	end

	return
end

return IslandSystemDelegationUnit
