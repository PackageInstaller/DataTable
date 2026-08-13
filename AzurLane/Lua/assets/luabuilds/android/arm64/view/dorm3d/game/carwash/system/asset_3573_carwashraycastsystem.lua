class = var_0_10000

local var_0_0 = "CarWashRaycastSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.UPDATE_COMMON_RAYCAST = "CarWashRaycastSystem.UPDATE_COMMON_RAYCAST"
var_0_1.UPDATE_DECAL_RAYCAST = "CarWashRaycastSystem.UPDATE_DECAL_RAYCAST"

function var_0_1.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()

	arg_1_0.isShooting = false
	arg_1_0.onShootTime = 0

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashGameFlowSystem = var_1_10004

	var_2_1(var_2_0, var_1_10004.UPDATE_IS_SHOOTING, function(arg_3_0, arg_3_1)
		arg_2_0.isShooting = arg_3_1.newValue
		arg_2_0.onShootTime = 0

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_3(var_2_2, var_4.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnSwitchGun(var_4_0, arg_4_1.newValue)

		return
	end)

	return
end

function var_0_1.OnDispose(arg_5_0)
	arg_5_0.mainCamera = nil
	arg_5_0.sceneRaycaster = nil
	arg_5_0.gunTF = nil
	arg_5_0.muzzle = nil
	arg_5_0.isShooting = nil
	arg_5_0.onShootTime = nil

	return
end

function var_0_1.OnUpdate(arg_6_0, arg_6_1)
	if not arg_6_0.isShooting then
		return
	end

	arg_6_0:UpdateCommonRaycast(arg_6_1)
	arg_6_0:UpdateDecalRaycast(arg_6_1)

	return
end

function var_0_1.InitSceneRefs(arg_7_0)
	arg_7_0.mainCamera = arg_7_0:GetMainCamera()
	arg_7_0.sceneRaycaster = arg_7_0:GetRaycaster()

	local var_7_0 = arg_7_0:GetMainCameraTF()

	arg_7_0.gunTF = var_1.Find(var_7_0, "[GUNROOT]/gun")
	assert = var_1

	var_1(arg_7_0.gunTF, "CarWash gun node not found: gun")

	return
end

function var_0_1.OnSwitchGun(arg_8_0, arg_8_1)
	CarWashConst = var_1_10002

	local var_8_0 = var_1_10002.GetGunConfig(arg_8_1)

	assert = var_1_10003

	local var_8_1 = var_8_0
	local var_8_2 = "CarWash gun config not found: "

	tostring = var_1_10007

	var_1_10003(var_8_1, var_8_2 .. var_1_10007(arg_8_1))

	assert = var_1_10003

	local var_8_3 = var_8_0.name
	local var_8_4 = "CarWash gun name not found: "

	tostring = var_7

	var_1_10003(var_8_3, var_8_4 .. var_7(arg_8_1))

	local var_8_5 = arg_8_0.gunTF
	local var_8_6 = var_3.Find(var_8_5, var_8_0.name)

	assert = var_4

	var_4(var_8_6, "CarWash gun model not found: " .. var_8_0.name)

	arg_8_0.muzzle = var_8_6:Find("muzzle")
	assert = var_4

	var_4(arg_8_0.muzzle, "CarWash gun muzzle not found: " .. var_8_0.name .. "/muzzle")

	return
end

function var_0_1.UpdateCommonRaycast(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.RaycastScreenCenter

	CarWashConst = var_1_10005

	local var_9_2 = var_1_10005.EFFECT_LAYER_MASK

	CarWashConst = var_1_10006

	local var_9_3, var_9_4 = var_9_1(var_9_0, var_9_2, var_1_10006.DEFAULT_RAY_DISTANCE)

	arg_9_0:EmitRaycastResult(var_0_1.UPDATE_COMMON_RAYCAST, var_9_3, var_9_4, {}, arg_9_1)

	return
end

function var_0_1.UpdateDecalRaycast(arg_10_0, arg_10_1)
	arg_10_0.onShootTime = arg_10_0.onShootTime + arg_10_1

	local var_10_0 = arg_10_0.onShootTime

	CarWashDecalSystem = var_1_10003

	if var_10_0 < var_1_10003.ON_SHOOT_INTERVAL then
		return
	end

	local var_10_1 = arg_10_0.onShootTime

	CarWashDecalSystem = var_3
	arg_10_0.onShootTime = var_10_1 - var_3.ON_SHOOT_INTERVAL

	local var_10_2 = arg_10_0:RaycastSceneRaycasterScreenCenter()
	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.RaycastScreenCenter

	CarWashConst = var_1_10006

	local var_10_5 = var_1_10006.LAYER_MASK

	CarWashConst = var_1_10007

	local var_10_6, var_10_7 = var_10_4(var_10_3, var_10_5, var_1_10007.DEFAULT_RAY_DISTANCE)
	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0.EmitRaycastResult
	local var_10_10 = var_0_1.UPDATE_DECAL_RAYCAST
	local var_10_11 = var_10_6
	local var_10_12 = var_10_7
	local var_10_13 = var_10_2

	CarWashDecalSystem = var_1_10012

	var_10_9(var_10_8, var_10_10, var_10_11, var_10_12, var_10_13, var_1_10012.ON_SHOOT_INTERVAL)

	return
end

function var_0_1.EmitRaycastResult(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0:Emit(arg_11_1, {
		hit = arg_11_2,
		hitInfo = arg_11_3,
		targets = arg_11_4,
		ray = arg_11_0:GetScreenCenterRay(),
		muzzleRay = arg_11_0:GetMuzzleRay(arg_11_2, arg_11_3),
		deltaTime = arg_11_5
	})

	return
end

function var_0_1.GetScreenCenterPoint(arg_12_0)
	Vector3 = var_1_10001

	local var_12_0 = var_1_10001.New

	Screen = var_1_10003

	local var_12_1 = var_1_10003.width * 0.5

	Screen = var_1_10004

	return var_12_0(var_12_1, var_1_10004.height * 0.5, 0)
end

function var_0_1.GetScreenCenterRay(arg_13_0)
	local var_13_0 = arg_13_0:GetScreenCenterPoint()
	local var_13_1 = arg_13_0.mainCamera

	return var_2.ScreenPointToRay(var_13_1, var_13_0)
end

function var_0_1.GetMuzzleRay(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.muzzle then
		return nil
	end

	local var_14_0 = arg_14_0.muzzle.position

	if not arg_14_1 or not arg_14_2 or not arg_14_2.point then
		var_1_10004 = arg_14_0.muzzle.forward
		CarWashConst = var_1_10005
		var_1_10004 = var_14_0 + var_1_10004 * var_1_10005.DEFAULT_RAY_DISTANCE
	end

	local var_14_1 = var_1_10004 - var_14_0
	local var_14_2

	if var_14_2.SqrMagnitude(var_14_1) <= 1e-06 then
		var_14_2 = arg_14_0.muzzle.forward
	else
		var_14_2 = var_14_2:Normalize()
	end

	Ray = var_6

	return var_6.New(var_14_2, var_14_0)
end

function var_0_1.RaycastScreenCenter(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetScreenCenterRay()

	if not arg_15_2 then
		CarWashConst = var_1_10004
		arg_15_2 = var_1_10004.DEFAULT_RAY_DISTANCE
	end

	Physics = var_1_10004

	return var_1_10004.Raycast(var_15_0.origin, var_15_0.direction, nil, arg_15_2, arg_15_1)
end

function var_0_1.RaycastSceneRaycasterScreenCenter(arg_16_0)
	CameraMgr = var_1_10001

	local var_16_0 = var_1_10001.instance
	local var_16_1 = var_1.Raycast(var_16_0, arg_16_0.sceneRaycaster, arg_16_0:GetScreenCenterPoint())

	return var_1.ToTable(var_16_1)
end

return var_0_1
