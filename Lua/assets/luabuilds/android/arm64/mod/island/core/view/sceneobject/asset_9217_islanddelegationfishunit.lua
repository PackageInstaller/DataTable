local Vector3 = require("Framework.toLua.UnityEngine.Vector3")
local Quaternion = require("Framework.toLua.UnityEngine.Quaternion")
local IslandDelegationFishUnit = class("IslandDelegationFishUnit", import(".IslandSceneUnit"))
local var_0_3 = bit.bnot(bit.lshift(1, (LayerMask.NameToLayer("IgnoreIslandCharacter"))))
local var_0_4 = {
	changeTargetInterval = 4,
	noiseAmplitude = 0.8,
	noiseScale = 0.5,
	avoidBoost = 1.5,
	avoidTurnAngle = 45,
	baseSpeed = 2,
	speedChangeRate = 0.5,
	turnDetectionThreshold = 0.4,
	turnSpeed = 2,
	maxSpeedFactor = 2,
	turnSlowdownFactor = 0.6,
	avoidBoostDuration = 1,
	minSpeedFactor = 0.5,
	avoidDistance = 2
}

function IslandDelegationFishUnit:Ctor(arg_1_1, arg_1_2)
	IslandDelegationFishUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self.speed = arg_1_2.speed or var_0_4.baseSpeed

	return
end

function IslandDelegationFishUnit:OnAttach(arg_2_1)
	self._go = arg_2_1
	self._tf = arg_2_1.transform
	self.baseSpeed = self.speed or var_0_4.baseSpeed
	self.turnSpeed = self.turnSpeed or var_0_4.turnSpeed
	self.avoidDistance = self.avoidDistance or var_0_4.avoidDistance
	self.avoidTurnAngle = self.avoidTurnAngle or var_0_4.avoidTurnAngle
	self.obstacleMask = self.obstacleMask or var_0_4.obstacleMask
	self.avoidBoost = self.avoidBoost or var_0_4.avoidBoost
	self.avoidBoostDuration = self.avoidBoostDuration or var_0_4.avoidBoostDuration
	self.minSpeed = self.baseSpeed * var_0_4.minSpeedFactor
	self.maxSpeed = self.baseSpeed or var_0_4.maxSpeedFactor
	self.speedChangeRate = self.speedChangeRate or var_0_4.speedChangeRate
	self.noiseScale = self.noiseScale or var_0_4.noiseScale
	self.noiseAmplitude = self.noiseAmplitude or var_0_4.noiseAmplitude
	self.turnSlowdownFactor = self.turnSlowdownFactor or var_0_4.turnSlowdownFactor
	self.turnDetectionThreshold = self.turnDetectionThreshold or var_0_4.turnDetectionThreshold
	self.changeTargetInterval = var_0_4.changeTargetInterval
	self.targetPos = Vector3.zero
	self.timer = 0
	self.currentSpeed = self.baseSpeed
	self.noiseSeed = math.random() * 100
	self.avoidBoostTimer = 0
	self.lastRotation = self._tf.rotation or Quaternion.identity
	self.animator = self._tf:GetChild(0):GetComponent(typeof(Animator))

	return
end

function IslandDelegationFishUnit:SetFishPonds(arg_3_1)
	self.pond = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_3_1)._go.transform:GetComponent(typeof(FishPond)):GetBounds()

	return
end

function IslandDelegationFishUnit:GetRandomPoint()
	local var_4_0 = self.pond:GetMin()
	local var_4_1 = self.pond:GetMax()

	return Vector3.New(math.random() * (var_4_1.x - var_4_0.x) + var_4_0.x, math.random() * (var_4_1.y - var_4_0.y) + var_4_0.y, math.random() * (var_4_1.z - var_4_0.z) + var_4_0.z)
end

function IslandDelegationFishUnit:StartFishing()
	self.startFishing = true
	self._tf.position = self:GetRandomPoint()

	self.animator:Play("walk")

	return
end

function IslandDelegationFishUnit:OnUpdate()
	if not self.startFishing then
		return
	end

	self.timer = self.timer + Time.deltaTime

	if self.timer > self.changeTargetInterval then
		self:SetNewTarget()
	end

	self:UpdateSpeed()
	self:Move()
	self:KeepInsideBounds()

	return
end

function IslandDelegationFishUnit:Move()
	if (self.targetPos - self._tf.position).sqrMagnitude < 0.01 then
		return
	end

	if (self.targetPos - self._tf.position).normalized ~= Vector3.zero then
		self._tf.rotation = Quaternion.Slerp(self._tf.rotation, Quaternion.LookRotation((self.targetPos - self._tf.position).normalized), self.turnSpeed * Time.deltaTime)
	end

	self.lastRotation = self._tf.rotation

	local var_7_0 = 1

	if Quaternion.Angle(self._tf.rotation, self.lastRotation) * Mathf.Deg2Rad > self.turnDetectionThreshold then
		var_7_0 = var_7_0 * self.turnSlowdownFactor
	end

	if self.avoidBoostTimer > 0 then
		self.avoidBoostTimer = self.avoidBoostTimer - Time.deltaTime
		var_7_0 = var_7_0 * self.avoidBoost
	end

	self._tf.position = self._tf.position + self._tf.forward * (self.currentSpeed * var_7_0) * Time.deltaTime

	return
end

function IslandDelegationFishUnit:UpdateSpeed()
	self.currentSpeed = Mathf.Lerp(self.currentSpeed, Mathf.Lerp(self.minSpeed, self.maxSpeed, Mathf.PerlinNoise(self.noiseSeed, Time.time * self.noiseScale) * self.noiseAmplitude), Time.deltaTime * self.speedChangeRate)

	return
end

function IslandDelegationFishUnit:SetNewTarget()
	self.timer = 0
	self.targetPos = Vector3.New(Mathf.Lerp(self.pond.min.x, self.pond.max.x, math.random()), Mathf.Lerp(self.pond.min.y, self.pond.max.y, math.random()), (Mathf.Lerp(self.pond.min.z, self.pond.max.z, math.random())))
	self.changeTargetInterval = (self.targetPos - self._tf.position).magnitude / self.speed

	return
end

function IslandDelegationFishUnit:AvoidCollision()
	local var_10_1, var_10_2 = Physics.SphereCast(self._tf.position, 0.5, self._tf.forward, nil, self.avoidDistance or var_0_4.avoidDistance, var_0_3)

	if var_10_1 and var_10_2 and var_10_2.collider then
		self._tf.rotation = Quaternion.Slerp(self._tf.rotation, Quaternion.LookRotation(Quaternion.Euler(0, (math.random() - 0.5) * 2 * self.avoidTurnAngle, 0) * self._tf.forward), self.turnSpeed * Time.deltaTime)

		self:SetNewTarget()

		self.avoidBoostTimer = self.avoidBoostDuration
	end

	return
end

function IslandDelegationFishUnit:KeepInsideBounds()
	local var_11_0 = self._tf.position

	if not (self.pond.Contains and self.pond:Contains(var_11_0) or var_11_0.x >= self.pond.min.x and var_11_0.x <= self.pond.max.x and var_11_0.y >= self.pond.min.y and var_11_0.y <= self.pond.max.y and var_11_0.z >= self.pond.min.z and var_11_0.z <= self.pond.max.z) then
		if (self.pond.center - var_11_0).normalized ~= Vector3.zero then
			self._tf.rotation = Quaternion.Slerp(self._tf.rotation, Quaternion.LookRotation((self.pond.center - var_11_0).normalized), self.turnSpeed * Time.deltaTime)
		end

		self._tf.position = self.pond.ClosestPoint and Vector3.Lerp(var_11_0, self.pond:ClosestPoint(var_11_0), 0.5) or Vector3.Lerp(var_11_0, self.pond.center, 0.5)

		self:SetNewTarget()
	end

	return
end

return IslandDelegationFishUnit
