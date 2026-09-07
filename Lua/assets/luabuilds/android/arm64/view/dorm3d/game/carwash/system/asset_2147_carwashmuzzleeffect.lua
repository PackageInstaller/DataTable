local CarWashMuzzleEffect = class("CarWashMuzzleEffect", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashMuzzleEffect.GUN_LOOK_LERP_TIME = 0.2
CarWashMuzzleEffect.GUN_ROTATION_EPSILON = 0.1
CarWashMuzzleEffect.AIM_TARGET_ENABLE_LERP_TIME = 0.25
CarWashMuzzleEffect.GUN_ROTATION_STATE_LOOK = 1
CarWashMuzzleEffect.GUN_ROTATION_STATE_RETURN = 2

function CarWashMuzzleEffect:OnInit()
	self:InitSceneRefs()

	self.isShooting = false
	self.gunLookLerpTime = 0
	self.gunLookLerpDuration = CarWashMuzzleEffect.GUN_LOOK_LERP_TIME
	self.aimTargetLerpTime = 0
	self.muzzleRaycastResult = nil

	return
end

function CarWashMuzzleEffect:RegisterEvents()
	self:Bind(CarWashGameFlowSystem.UPDATE_IS_SHOOTING, function(arg_3_0, arg_3_1)
		self:OnShootingChanged(arg_3_1.newValue)

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		self:OnSwitchGun(arg_4_1.newValue)

		return
	end)
	self:Bind(CarWashRaycastSystem.UPDATE_COMMON_RAYCAST, function(arg_5_0, arg_5_1)
		self.muzzleRaycastResult = arg_5_1

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_6_0, arg_6_1)
		if arg_6_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			setActive(self.gunTF, true)
		elseif arg_6_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			setActive(self.gunTF, false)
		end

		return
	end)

	return
end

function CarWashMuzzleEffect:OnDispose()
	self:ResetGunRotation()

	self.gunTF = nil
	self.originalRotation = nil
	self.vfxRoot = nil
	self.hitVFX = nil
	self.gunLookFromRotation = nil
	self.gunLookToRotation = nil
	self.gunLookLerpTime = nil
	self.gunLookLerpDuration = nil
	self.gunLookUseLocalRotation = nil
	self.gunRotationState = nil
	self.muzzle = nil
	self.aimTarget = nil
	self.aimTargetLerpFromPosition = nil
	self.aimTargetLerpTime = nil
	self.isAimTargetEntering = nil
	self.muzzleRaycastResult = nil

	return
end

function CarWashMuzzleEffect:OnUpdate(arg_8_1)
	self:UpdateMuzzleEffect(arg_8_1)
	self:UpdateGunRotation(arg_8_1)

	return
end

function CarWashMuzzleEffect:InitSceneRefs()
	local var_9_0 = self:GetMainCameraTF()

	self.gunTF = var_9_0:Find("[GUNROOT]/gun")

	assert(self.gunTF, "CarWash gun node not found: gun")

	self.originalRotation = self.gunTF.localRotation
	self.aimTarget = var_9_0:Find("[GUNROOT]/AimTarget")

	assert(self.aimTarget, "CarWash AimTarget node not found: AimTarget")

	return
end

function CarWashMuzzleEffect:OnShootingChanged(arg_10_1)
	self.isShooting = arg_10_1
	self.muzzleRaycastResult = nil

	if self.isShooting then
		self:StartAimTargetEnterTransition()
		setActive(self.vfxRoot, true)
	else
		self:KeepAimTargetAtMuzzle()
		setActive(self.vfxRoot, false)
		setActive(self.hitVFX, false)
		self:ReturnGunRotation()
	end

	return
end

function CarWashMuzzleEffect:OnSwitchGun(arg_11_1)
	local var_11_0 = CarWashConst.GetGunConfig(arg_11_1)

	assert(var_11_0, "CarWash gun config not found: " .. tostring(arg_11_1))
	assert(var_11_0.name, "CarWash gun name not found: " .. tostring(arg_11_1))

	if self.hitVFX then
		setActive(self.hitVFX, false)
	end

	if self.vfxRoot then
		setActive(self.vfxRoot, false)
	end

	if self.gunModel then
		setActive(self.gunModel, false)
	end

	local var_11_1 = self.gunTF:Find(var_11_0.name)

	assert(var_11_1, "CarWash gun model not found: " .. var_11_0.name)

	local var_11_2 = var_11_1:Find("vfx")

	assert(var_11_2, "CarWash gun VFX root not found: " .. var_11_0.name .. "/vfx")

	local var_11_3 = var_11_2:Find("hit")

	assert(var_11_3, "CarWash gun hit VFX not found: " .. var_11_0.name .. "/vfx/hit")

	local var_11_4 = var_11_1:Find("muzzle")

	assert(var_11_4, "CarWash gun muzzle not found: " .. var_11_0.name .. "/muzzle")

	self.currentGunType = arg_11_1
	self.gunModel = var_11_1
	self.vfxRoot = var_11_2
	self.hitVFX = var_11_3
	self.muzzle = var_11_4

	setActive(self.gunModel, true)
	setActive(self.vfxRoot, self.isShooting)
	setActive(self.hitVFX, false)

	if self.isShooting then
		self:StartAimTargetEnterTransition()
	else
		self:KeepAimTargetAtMuzzle()
	end

	return
end

function CarWashMuzzleEffect:UpdateMuzzleEffect(arg_12_1)
	if not self.isShooting then
		return
	end

	if not self.muzzleRaycastResult then
		return
	end

	if self.muzzleRaycastResult.hit then
		setActive(self.hitVFX, not self.isAimTargetEntering)

		self.hitVFX.position = self:UpdateAimTarget(self.muzzleRaycastResult.hitInfo.point, arg_12_1)

		self:LookAtTarget(self.muzzleRaycastResult.hitInfo.point)
	else
		setActive(self.hitVFX, false)
		self:UpdateAimTarget(self:GetMuzzleForwardPosition(), arg_12_1)
		self:ReturnGunRotation()
	end

	return
end

function CarWashMuzzleEffect:LookAtTarget(arg_13_1)
	if (arg_13_1 - self.gunTF.position):SqrMagnitude() <= 1e-06 then
		return
	end

	self:StartGunRotation(Quaternion.LookRotation((arg_13_1 - self.gunTF.position).normalized, Vector3.up), CarWashMuzzleEffect.GUN_LOOK_LERP_TIME, false, CarWashMuzzleEffect.GUN_ROTATION_STATE_LOOK)

	return
end

function CarWashMuzzleEffect:UpdateGunRotation(arg_14_1)
	if not self.gunLookToRotation then
		return
	end

	self.gunLookLerpTime = self.gunLookLerpTime + arg_14_1

	local var_14_0 = math.min(self.gunLookLerpTime / self.gunLookLerpDuration, 1)
	local var_14_1 = Quaternion.Slerp(self.gunLookFromRotation, self.gunLookToRotation, var_14_0)

	if self.gunLookUseLocalRotation then
		self.gunTF.localRotation = var_14_1
	else
		self.gunTF.rotation = var_14_1
	end

	if var_14_0 >= 1 then
		if self.gunRotationState == CarWashMuzzleEffect.GUN_ROTATION_STATE_RETURN then
			self.gunTF.localRotation = self.originalRotation
		end

		self.gunLookFromRotation = nil
		self.gunLookToRotation = nil
		self.gunLookLerpTime = 0
		self.gunLookLerpDuration = CarWashMuzzleEffect.GUN_LOOK_LERP_TIME
		self.gunLookUseLocalRotation = nil
		self.gunRotationState = nil
	end

	return
end

function CarWashMuzzleEffect:StartGunRotation(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if self.gunLookToRotation and self.gunRotationState == arg_15_4 and Quaternion.Angle(self.gunLookToRotation, arg_15_1) <= CarWashMuzzleEffect.GUN_ROTATION_EPSILON then
		return
	end

	local var_15_0

	if arg_15_3 then
		var_15_0 = self.gunTF.localRotation or self.gunTF.rotation

		if Quaternion.Angle(var_15_0, arg_15_1) <= CarWashMuzzleEffect.GUN_ROTATION_EPSILON then
			if arg_15_3 then
				self.gunTF.localRotation = arg_15_1
			else
				self.gunTF.rotation = arg_15_1
			end

			self.gunLookFromRotation = nil
			self.gunLookToRotation = nil
			self.gunLookLerpTime = 0
			self.gunLookLerpDuration = CarWashMuzzleEffect.GUN_LOOK_LERP_TIME
			self.gunLookUseLocalRotation = nil
			self.gunRotationState = nil

			return
		end
	end

	self.gunLookLerpTime = 0
	self.gunLookLerpDuration = arg_15_2 or CarWashMuzzleEffect.GUN_LOOK_LERP_TIME
	self.gunLookUseLocalRotation = arg_15_3
	self.gunLookFromRotation = var_15_0
	self.gunLookToRotation = arg_15_1
	self.gunRotationState = arg_15_4

	return
end

function CarWashMuzzleEffect:ReturnGunRotation()
	if not self.gunTF then
		return
	end

	self:StartGunRotation(self.originalRotation, CarWashMuzzleEffect.GUN_LOOK_LERP_TIME, true, CarWashMuzzleEffect.GUN_ROTATION_STATE_RETURN)

	return
end

function CarWashMuzzleEffect:StartAimTargetEnterTransition()
	if not self.aimTarget or not self.muzzle then
		return
	end

	self.aimTarget.position = self.muzzle.position
	self.aimTargetLerpFromPosition = self.muzzle.position
	self.aimTargetLerpTime = 0
	self.isAimTargetEntering = true

	return
end

function CarWashMuzzleEffect:KeepAimTargetAtMuzzle()
	self.aimTarget.position = self.muzzle.position
	self.aimTargetLerpFromPosition = self.muzzle.position
	self.aimTargetLerpTime = 0
	self.isAimTargetEntering = true

	return
end

function CarWashMuzzleEffect:GetMuzzleForwardPosition()
	return self.muzzle.position + self.muzzle.forward * CarWashConst.DEFAULT_RAY_DISTANCE
end

function CarWashMuzzleEffect:UpdateAimTarget(arg_20_1, arg_20_2)
	if not self.isAimTargetEntering then
		self.aimTarget.position = arg_20_1

		return arg_20_1
	end

	self.aimTargetLerpTime = self.aimTargetLerpTime + arg_20_2

	local var_20_0 = math.min(self.aimTargetLerpTime / CarWashMuzzleEffect.AIM_TARGET_ENABLE_LERP_TIME, 1)
	local var_20_1 = Vector3.Lerp(self.aimTargetLerpFromPosition, arg_20_1, var_20_0)

	self.aimTarget.position = var_20_1

	if var_20_0 >= 1 then
		self.isAimTargetEntering = false
		self.aimTarget.position = arg_20_1

		return arg_20_1
	end

	return var_20_1
end

function CarWashMuzzleEffect:ResetGunRotation()
	if not self.gunTF then
		return
	end

	self.gunTF.localRotation = self.originalRotation
	self.gunLookFromRotation = nil
	self.gunLookToRotation = nil
	self.gunLookLerpTime = 0
	self.gunLookLerpDuration = CarWashMuzzleEffect.GUN_LOOK_LERP_TIME
	self.gunLookUseLocalRotation = nil
	self.gunRotationState = nil

	return
end

return CarWashMuzzleEffect
