local Vector3 = require("Framework.toLua.UnityEngine.Vector3")
local Vector2 = require("Framework.toLua.UnityEngine.Vector2")
local var_0_2 = Vector3.zero
local IslandThirdTakePhotoUnit = class("IslandThirdTakePhotoUnit", import(".IslandSceneUnit"))
local var_0_4 = bit.bnot(bit.lshift(1, (LayerMask.NameToLayer("IgnoreIslandCharacter"))))

function IslandThirdTakePhotoUnit:OnAttach(arg_1_1)
	IslandThirdTakePhotoUnit.super.OnAttach(self, arg_1_1)

	self._tf = self._go.transform
	self.characterController = self._go:GetComponent(typeof(CharacterController))
	self.targetSpeed = 0
	self.speed = 0
	self.degreeSpeed = 720
	self.maxSpeed = pg.island_set.player_movement_parameters.key_value_varchar[1]
	self.sprintSpeed = pg.island_set.player_movement_parameters.key_value_varchar[2]
	self.upSpeedDamping = 3
	self.downSpeedDamping = 6
	self.jumpHeight = pg.island_set.player_movement_parameters.key_value_varchar[3]
	self.targetDir = Vector3.zero
	self.velocity = Vector3.zero
	self.extraVelocity = Vector3.zero
	self.gravitySpeed = 0
	self.orginTargetDir = var_0_2

	setActive(self._go, false)
	self:ActiveOrDisactive(false)

	return
end

function IslandThirdTakePhotoUnit:OnLateUpdate()
	return
end

function IslandThirdTakePhotoUnit:OnUpdate()
	self:RefreshTemp()
	self:Rotation(Time.deltaTime)
	self:Move(Time.deltaTime)

	return
end

function IslandThirdTakePhotoUnit:RefreshTemp()
	self.ignoreStepdown = false
	self.gravityAcc = IslandConst.GRAVITYACC

	if self.orginTargetDir.x ~= 0 or self.orginTargetDir.z ~= 0 then
		local var_4_0 = IslandCameraMgr.instance._mainCamera.transform:TransformVector(self.orginTargetDir)

		self.targetDir = Vector3(var_4_0.x, 0, var_4_0.z).normalized
		self.targetRotation = Quaternion.LookRotation(self.targetDir)
	end

	return
end

function IslandThirdTakePhotoUnit:Rotation(arg_5_1)
	if self.targetRotation then
		self._tf.rotation = Quaternion.RotateTowards(self._tf.rotation, self.targetRotation, self.degreeSpeed * arg_5_1)
	end

	return
end

function IslandThirdTakePhotoUnit:SetTargetRotation(arg_6_1)
	self.targetRotation = arg_6_1

	return
end

function IslandThirdTakePhotoUnit:Move(arg_7_1)
	self.speed = Mathf.Approximately(self.speed, self.targetSpeed) and self.targetSpeed or self.targetSpeed > self.speed and Mathf.Lerp(self.speed, self.targetSpeed, self.upSpeedDamping * arg_7_1) or Mathf.Lerp(self.speed, self.targetSpeed, self.downSpeedDamping * arg_7_1)
	self.velocity = self.targetDir * self.speed
	self.onGroud = true

	local var_7_0 = 0

	if self.gravitySpeed >= 0 then
		local var_7_1, var_7_2 = self:CalcGrounded()

		if var_7_1 then
			self.gravitySpeed = 0
			var_7_0 = var_7_2
		else
			local var_7_3, var_7_4 = self:CalcNotFalling()

			if var_7_3 then
				self.gravitySpeed = 0
				var_7_0 = var_7_4
			else
				self.onGroud = false
			end
		end
	else
		self.onGroud = false
	end

	local var_7_5 = Vector3(0, IslandConst.GRAVITYDIR.y * var_7_0, 0)

	self.characterController:Move(self.velocity * Time.deltaTime + ((self.ignoreStepdown or nil) and var_0_2))

	return
end

function IslandThirdTakePhotoUnit:CalcGrounded()
	local var_8_0, var_8_1 = Physics.SphereCast(self._tf.position + self.characterController.center, self.characterController.radius, Vector3.down, nil, 2 * self.characterController.skinWidth + (0.5 * self.characterController.height - self.characterController.radius), var_0_4)

	if var_8_0 then
		return true, self._tf.position.y + self.characterController.skinWidth - var_8_1.point.y
	end

	return false
end

function IslandThirdTakePhotoUnit:CalcNotFalling()
	local var_9_0, var_9_1 = Physics.SphereCast(self._tf.position + self.characterController.center, self.characterController.radius, Vector3.down, nil, 0.3 + 2 * self.characterController.skinWidth + (0.5 * self.characterController.height - self.characterController.radius), var_0_4)

	if var_9_0 then
		return true, self._tf.position.y + self.characterController.skinWidth - var_9_1.point.y
	end

	return false
end

function IslandThirdTakePhotoUnit:OnPlayerPlayerSprint()
	if self.targetSpeed ~= 0 then
		self.isSprint = true
		self.lastTargetSpeed = self.targetSpeed
		self.targetSpeed = self.sprintSpeed
		self.speed = self.targetSpeed
	end

	return
end

function IslandThirdTakePhotoUnit:ChangeHeight(arg_11_1)
	self.characterController.center = Vector3(0, arg_11_1, 0)

	return
end

function IslandThirdTakePhotoUnit:OnStopPlayerSprint()
	if self.isSprint and self.targetSpeed ~= 0 then
		self.targetSpeed = self.lastTargetSpeed
		self.speed = self.lastTargetSpeed
		self.isSprint = false
	end

	return
end

function IslandThirdTakePhotoUnit:MoveHandle(arg_13_1, arg_13_2)
	self.orginTargetDir = arg_13_1
	self.lastTargetSpeed = arg_13_2 * self.maxSpeed

	if self.isSprint then
		self.targetSpeed = self.sprintSpeed or self.lastTargetSpeed
	end

	return
end

function IslandThirdTakePhotoUnit:StopMoveHandle()
	self.targetSpeed = 0
	self.speed = 0
	self.orginTargetDir = var_0_2
	self.isSprint = false

	return
end

return IslandThirdTakePhotoUnit
