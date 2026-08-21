local var_0_0 = class("CarWashMuzzleEffect", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.GUN_LOOK_LERP_TIME = 0.2
var_0_0.GUN_ROTATION_EPSILON = 0.1
var_0_0.AIM_TARGET_ENABLE_LERP_TIME = 0.25
var_0_0.GUN_ROTATION_STATE_LOOK = 1
var_0_0.GUN_ROTATION_STATE_RETURN = 2

function var_0_0.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()

	arg_1_0.isShooting = false
	arg_1_0.gunLookLerpTime = 0
	arg_1_0.gunLookLerpDuration = var_0_0.GUN_LOOK_LERP_TIME
	arg_1_0.aimTargetLerpTime = 0
	arg_1_0.muzzleRaycastResult = nil

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_IS_SHOOTING, function(arg_3_0, arg_3_1)
		arg_2_0:OnShootingChanged(arg_3_1.newValue)

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		arg_2_0:OnSwitchGun(arg_4_1.newValue)

		return
	end)
	arg_2_0:Bind(CarWashRaycastSystem.UPDATE_COMMON_RAYCAST, function(arg_5_0, arg_5_1)
		arg_2_0.muzzleRaycastResult = arg_5_1

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_6_0, arg_6_1)
		if arg_6_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			setActive(arg_2_0.gunTF, true)
		elseif arg_6_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			setActive(arg_2_0.gunTF, false)
		end

		return
	end)

	return
end

function var_0_0.OnDispose(arg_7_0)
	arg_7_0:ResetGunRotation()

	arg_7_0.gunTF = nil
	arg_7_0.originalRotation = nil
	arg_7_0.vfxRoot = nil
	arg_7_0.hitVFX = nil
	arg_7_0.gunLookFromRotation = nil
	arg_7_0.gunLookToRotation = nil
	arg_7_0.gunLookLerpTime = nil
	arg_7_0.gunLookLerpDuration = nil
	arg_7_0.gunLookUseLocalRotation = nil
	arg_7_0.gunRotationState = nil
	arg_7_0.muzzle = nil
	arg_7_0.aimTarget = nil
	arg_7_0.aimTargetLerpFromPosition = nil
	arg_7_0.aimTargetLerpTime = nil
	arg_7_0.isAimTargetEntering = nil
	arg_7_0.muzzleRaycastResult = nil

	return
end

function var_0_0.OnUpdate(arg_8_0, arg_8_1)
	arg_8_0:UpdateMuzzleEffect(arg_8_1)
	arg_8_0:UpdateGunRotation(arg_8_1)

	return
end

function var_0_0.InitSceneRefs(arg_9_0)
	local var_9_0 = arg_9_0:GetMainCameraTF()

	arg_9_0.gunTF = var_9_0:Find("[GUNROOT]/gun")

	assert(arg_9_0.gunTF, "CarWash gun node not found: gun")

	arg_9_0.originalRotation = arg_9_0.gunTF.localRotation
	arg_9_0.aimTarget = var_9_0:Find("[GUNROOT]/AimTarget")

	assert(arg_9_0.aimTarget, "CarWash AimTarget node not found: AimTarget")

	return
end

function var_0_0.OnShootingChanged(arg_10_0, arg_10_1)
	arg_10_0.isShooting = arg_10_1
	arg_10_0.muzzleRaycastResult = nil

	if arg_10_0.isShooting then
		arg_10_0:StartAimTargetEnterTransition()
		setActive(arg_10_0.vfxRoot, true)
	else
		arg_10_0:KeepAimTargetAtMuzzle()
		setActive(arg_10_0.vfxRoot, false)
		setActive(arg_10_0.hitVFX, false)
		arg_10_0:ReturnGunRotation()
	end

	return
end

function var_0_0.OnSwitchGun(arg_11_0, arg_11_1)
	local var_11_0 = CarWashConst.GetGunConfig(arg_11_1)

	assert(var_11_0, "CarWash gun config not found: " .. tostring(arg_11_1))
	assert(var_11_0.name, "CarWash gun name not found: " .. tostring(arg_11_1))

	if arg_11_0.hitVFX then
		setActive(arg_11_0.hitVFX, false)
	end

	if arg_11_0.vfxRoot then
		setActive(arg_11_0.vfxRoot, false)
	end

	if arg_11_0.gunModel then
		setActive(arg_11_0.gunModel, false)
	end

	local var_11_1 = arg_11_0.gunTF:Find(var_11_0.name)

	assert(var_11_1, "CarWash gun model not found: " .. var_11_0.name)

	local var_11_2 = var_11_1:Find("vfx")

	assert(var_11_2, "CarWash gun VFX root not found: " .. var_11_0.name .. "/vfx")

	local var_11_3 = var_11_2:Find("hit")

	assert(var_11_3, "CarWash gun hit VFX not found: " .. var_11_0.name .. "/vfx/hit")

	local var_11_4 = var_11_1:Find("muzzle")

	assert(var_11_4, "CarWash gun muzzle not found: " .. var_11_0.name .. "/muzzle")

	arg_11_0.currentGunType = arg_11_1
	arg_11_0.gunModel = var_11_1
	arg_11_0.vfxRoot = var_11_2
	arg_11_0.hitVFX = var_11_3
	arg_11_0.muzzle = var_11_4

	setActive(arg_11_0.gunModel, true)
	setActive(arg_11_0.vfxRoot, arg_11_0.isShooting)
	setActive(arg_11_0.hitVFX, false)

	if arg_11_0.isShooting then
		arg_11_0:StartAimTargetEnterTransition()
	else
		arg_11_0:KeepAimTargetAtMuzzle()
	end

	return
end

function var_0_0.UpdateMuzzleEffect(arg_12_0, arg_12_1)
	if not arg_12_0.isShooting then
		return
	end

	if not arg_12_0.muzzleRaycastResult then
		return
	end

	if arg_12_0.muzzleRaycastResult.hit then
		setActive(arg_12_0.hitVFX, not arg_12_0.isAimTargetEntering)

		arg_12_0.hitVFX.position = arg_12_0:UpdateAimTarget(arg_12_0.muzzleRaycastResult.hitInfo.point, arg_12_1)

		arg_12_0:LookAtTarget(arg_12_0.muzzleRaycastResult.hitInfo.point)
	else
		setActive(arg_12_0.hitVFX, false)
		arg_12_0:UpdateAimTarget(arg_12_0:GetMuzzleForwardPosition(), arg_12_1)
		arg_12_0:ReturnGunRotation()
	end

	return
end

function var_0_0.LookAtTarget(arg_13_0, arg_13_1)
	if (arg_13_1 - arg_13_0.gunTF.position):SqrMagnitude() <= 1e-06 then
		return
	end

	arg_13_0:StartGunRotation(Quaternion.LookRotation((arg_13_1 - arg_13_0.gunTF.position).normalized, Vector3.up), var_0_0.GUN_LOOK_LERP_TIME, false, var_0_0.GUN_ROTATION_STATE_LOOK)

	return
end

function var_0_0.UpdateGunRotation(arg_14_0, arg_14_1)
	if not arg_14_0.gunLookToRotation then
		return
	end

	arg_14_0.gunLookLerpTime = arg_14_0.gunLookLerpTime + arg_14_1

	local var_14_0 = math.min(arg_14_0.gunLookLerpTime / arg_14_0.gunLookLerpDuration, 1)
	local var_14_1 = Quaternion.Slerp(arg_14_0.gunLookFromRotation, arg_14_0.gunLookToRotation, var_14_0)

	if arg_14_0.gunLookUseLocalRotation then
		arg_14_0.gunTF.localRotation = var_14_1
	else
		arg_14_0.gunTF.rotation = var_14_1
	end

	if var_14_0 >= 1 then
		if arg_14_0.gunRotationState == var_0_0.GUN_ROTATION_STATE_RETURN then
			arg_14_0.gunTF.localRotation = arg_14_0.originalRotation
		end

		arg_14_0.gunLookFromRotation = nil
		arg_14_0.gunLookToRotation = nil
		arg_14_0.gunLookLerpTime = 0
		arg_14_0.gunLookLerpDuration = var_0_0.GUN_LOOK_LERP_TIME
		arg_14_0.gunLookUseLocalRotation = nil
		arg_14_0.gunRotationState = nil
	end

	return
end

function var_0_0.StartGunRotation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_0.gunLookToRotation and arg_15_0.gunRotationState == arg_15_4 and Quaternion.Angle(arg_15_0.gunLookToRotation, arg_15_1) <= var_0_0.GUN_ROTATION_EPSILON then
		return
	end

	if arg_15_3 then
		local var_15_0 = arg_15_0.gunTF.localRotation or arg_15_0.gunTF.rotation

		if Quaternion.Angle(var_15_0, arg_15_1) <= var_0_0.GUN_ROTATION_EPSILON then
			if arg_15_3 then
				arg_15_0.gunTF.localRotation = arg_15_1
			else
				arg_15_0.gunTF.rotation = arg_15_1
			end

			arg_15_0.gunLookFromRotation = nil
			arg_15_0.gunLookToRotation = nil
			arg_15_0.gunLookLerpTime = 0
			arg_15_0.gunLookLerpDuration = var_0_0.GUN_LOOK_LERP_TIME
			arg_15_0.gunLookUseLocalRotation = nil
			arg_15_0.gunRotationState = nil

			return
		end

		arg_15_0.gunLookLerpTime = 0
		arg_15_0.gunLookLerpDuration = arg_15_2 or var_0_0.GUN_LOOK_LERP_TIME
		arg_15_0.gunLookUseLocalRotation = arg_15_3
		arg_15_0.gunLookFromRotation = var_15_0
		arg_15_0.gunLookToRotation = arg_15_1
		arg_15_0.gunRotationState = arg_15_4

		return
	end
end

function var_0_0.ReturnGunRotation(arg_16_0)
	if not arg_16_0.gunTF then
		return
	end

	arg_16_0:StartGunRotation(arg_16_0.originalRotation, var_0_0.GUN_LOOK_LERP_TIME, true, var_0_0.GUN_ROTATION_STATE_RETURN)

	return
end

function var_0_0.StartAimTargetEnterTransition(arg_17_0)
	if not arg_17_0.aimTarget or not arg_17_0.muzzle then
		return
	end

	arg_17_0.aimTarget.position = arg_17_0.muzzle.position
	arg_17_0.aimTargetLerpFromPosition = arg_17_0.muzzle.position
	arg_17_0.aimTargetLerpTime = 0
	arg_17_0.isAimTargetEntering = true

	return
end

function var_0_0.KeepAimTargetAtMuzzle(arg_18_0)
	arg_18_0.aimTarget.position = arg_18_0.muzzle.position
	arg_18_0.aimTargetLerpFromPosition = arg_18_0.muzzle.position
	arg_18_0.aimTargetLerpTime = 0
	arg_18_0.isAimTargetEntering = true

	return
end

function var_0_0.GetMuzzleForwardPosition(arg_19_0)
	return arg_19_0.muzzle.position + arg_19_0.muzzle.forward * CarWashConst.DEFAULT_RAY_DISTANCE
end

function var_0_0.UpdateAimTarget(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.isAimTargetEntering then
		arg_20_0.aimTarget.position = arg_20_1

		return arg_20_1
	end

	arg_20_0.aimTargetLerpTime = arg_20_0.aimTargetLerpTime + arg_20_2

	local var_20_0 = math.min(arg_20_0.aimTargetLerpTime / var_0_0.AIM_TARGET_ENABLE_LERP_TIME, 1)
	local var_20_1 = Vector3.Lerp(arg_20_0.aimTargetLerpFromPosition, arg_20_1, var_20_0)

	arg_20_0.aimTarget.position = var_20_1

	if var_20_0 >= 1 then
		arg_20_0.isAimTargetEntering = false
		arg_20_0.aimTarget.position = arg_20_1

		return arg_20_1
	end

	return var_20_1
end

function var_0_0.ResetGunRotation(arg_21_0)
	if not arg_21_0.gunTF then
		return
	end

	arg_21_0.gunTF.localRotation = arg_21_0.originalRotation
	arg_21_0.gunLookFromRotation = nil
	arg_21_0.gunLookToRotation = nil
	arg_21_0.gunLookLerpTime = 0
	arg_21_0.gunLookLerpDuration = var_0_0.GUN_LOOK_LERP_TIME
	arg_21_0.gunLookUseLocalRotation = nil
	arg_21_0.gunRotationState = nil

	return
end

return var_0_0
