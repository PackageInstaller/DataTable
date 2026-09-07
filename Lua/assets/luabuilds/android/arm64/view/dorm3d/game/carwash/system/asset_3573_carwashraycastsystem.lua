local CarWashRaycastSystem = class("CarWashRaycastSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashRaycastSystem.UPDATE_COMMON_RAYCAST = "CarWashRaycastSystem.UPDATE_COMMON_RAYCAST"
CarWashRaycastSystem.UPDATE_DECAL_RAYCAST = "CarWashRaycastSystem.UPDATE_DECAL_RAYCAST"

function CarWashRaycastSystem:OnInit()
	self:InitSceneRefs()

	self.isShooting = false
	self.onShootTime = 0

	return
end

function CarWashRaycastSystem:RegisterEvents()
	self:Bind(CarWashGameFlowSystem.UPDATE_IS_SHOOTING, function(arg_3_0, arg_3_1)
		self.isShooting = arg_3_1.newValue
		self.onShootTime = 0

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		self:OnSwitchGun(arg_4_1.newValue)

		return
	end)

	return
end

function CarWashRaycastSystem:OnDispose()
	self.mainCamera = nil
	self.sceneRaycaster = nil
	self.gunTF = nil
	self.muzzle = nil
	self.isShooting = nil
	self.onShootTime = nil

	return
end

function CarWashRaycastSystem:OnUpdate(arg_6_1)
	if not self.isShooting then
		return
	end

	self:UpdateCommonRaycast(arg_6_1)
	self:UpdateDecalRaycast(arg_6_1)

	return
end

function CarWashRaycastSystem:InitSceneRefs()
	self.mainCamera = self:GetMainCamera()
	self.sceneRaycaster = self:GetRaycaster()
	self.gunTF = self:GetMainCameraTF():Find("[GUNROOT]/gun")

	assert(self.gunTF, "CarWash gun node not found: gun")

	return
end

function CarWashRaycastSystem:OnSwitchGun(arg_8_1)
	local var_8_0 = CarWashConst.GetGunConfig(arg_8_1)

	assert(var_8_0, "CarWash gun config not found: " .. tostring(arg_8_1))
	assert(var_8_0.name, "CarWash gun name not found: " .. tostring(arg_8_1))

	local var_8_1 = self.gunTF:Find(var_8_0.name)

	assert(var_8_1, "CarWash gun model not found: " .. var_8_0.name)

	self.muzzle = var_8_1:Find("muzzle")

	assert(self.muzzle, "CarWash gun muzzle not found: " .. var_8_0.name .. "/muzzle")

	return
end

function CarWashRaycastSystem:UpdateCommonRaycast(arg_9_1)
	local var_9_0, var_9_1 = self:RaycastScreenCenter(CarWashConst.EFFECT_LAYER_MASK, CarWashConst.DEFAULT_RAY_DISTANCE)

	self:EmitRaycastResult(CarWashRaycastSystem.UPDATE_COMMON_RAYCAST, var_9_0, var_9_1, {}, arg_9_1)

	return
end

function CarWashRaycastSystem:UpdateDecalRaycast(arg_10_1)
	self.onShootTime = self.onShootTime + arg_10_1

	if self.onShootTime < CarWashDecalSystem.ON_SHOOT_INTERVAL then
		return
	end

	self.onShootTime = self.onShootTime - CarWashDecalSystem.ON_SHOOT_INTERVAL

	local var_10_0, var_10_1 = self:RaycastScreenCenter(CarWashConst.LAYER_MASK, CarWashConst.DEFAULT_RAY_DISTANCE)

	self:EmitRaycastResult(CarWashRaycastSystem.UPDATE_DECAL_RAYCAST, var_10_0, var_10_1, self:RaycastSceneRaycasterScreenCenter(), CarWashDecalSystem.ON_SHOOT_INTERVAL)

	return
end

function CarWashRaycastSystem:EmitRaycastResult(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self:Emit(arg_11_1, {
		hit = arg_11_2,
		hitInfo = arg_11_3,
		targets = arg_11_4,
		ray = self:GetScreenCenterRay(),
		muzzleRay = self:GetMuzzleRay(arg_11_2, arg_11_3),
		deltaTime = arg_11_5
	})

	return
end

function CarWashRaycastSystem:GetScreenCenterPoint()
	return Vector3.New(Screen.width * 0.5, Screen.height * 0.5, 0)
end

function CarWashRaycastSystem:GetScreenCenterRay()
	return self.mainCamera:ScreenPointToRay((self:GetScreenCenterPoint()))
end

function CarWashRaycastSystem:GetMuzzleRay(arg_14_1, arg_14_2)
	if not self.muzzle then
		return nil
	end

	local var_14_0 = self.muzzle.position
	local var_14_1 = ((arg_14_1 and arg_14_2 or nil) and (arg_14_2.point or var_14_0 + self.muzzle.forward * CarWashConst.DEFAULT_RAY_DISTANCE)) - var_14_0

	var_14_1 = (((arg_14_1 and arg_14_2 or nil) and (arg_14_2.point or var_14_0 + self.muzzle.forward * CarWashConst.DEFAULT_RAY_DISTANCE)) - var_14_0):SqrMagnitude() <= 1e-06 and self.muzzle.forward or var_14_1:Normalize()

	return Ray.New(var_14_1, var_14_0)
end

function CarWashRaycastSystem:RaycastScreenCenter(arg_15_1, arg_15_2)
	local var_15_0 = self:GetScreenCenterRay()

	arg_15_2 = arg_15_2 or CarWashConst.DEFAULT_RAY_DISTANCE

	return Physics.Raycast(var_15_0.origin, var_15_0.direction, nil, arg_15_2, arg_15_1)
end

function CarWashRaycastSystem:RaycastSceneRaycasterScreenCenter()
	return CameraMgr.instance:Raycast(self.sceneRaycaster, self:GetScreenCenterPoint()):ToTable()
end

return CarWashRaycastSystem
