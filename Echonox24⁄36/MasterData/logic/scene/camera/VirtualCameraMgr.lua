-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/camera/VirtualCameraMgr.lua

module("logic.scene.camera.VirtualCameraMgr", package.seeall)

local VirtualCameraMgr = class("VirtualCameraMgr")
local MAX_COUNT = 5
local kDisablePriority = -1
local kActivePriority = 1
local kActivePriority2 = 2
local kDefaultBlendDuration = 0.5

function VirtualCameraMgr:ctor()
	VirtualCameraUnit:preparePool(MAX_COUNT)

	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()

	self._cineBrain = goutil.addComponentOnce(mainCameraTarget:getGO(), ComponentType.CinemachineBrain)
	self._cameraFollow = VirtualCameraFollow.New()
	self._cacheCameraTable = {}
	self._activeCameraUnit = false

	CineCameraUtils.SetBlendStyle(self._cineBrain, Cinemachine.CinemachineBlendDefinition.Style.HardOut)
	CineCameraUtils.SetBlendDuration(self._cineBrain, kDefaultBlendDuration)
end

function VirtualCameraMgr:getCinemachineBrain()
	return self._cineBrain
end

function VirtualCameraMgr:resetCameraSettings()
	self:setFollowPosition(0, 0, 0)
	self:setCameraRotation(0, 0, 0)
	self:setLookAtPosition(0, 0, 0)
end

function VirtualCameraMgr:setActiveCamera(cameraCode)
	self:_releaseActiveCamera()

	local cameraCO = CameraConfig.instance:getCameraCO(cameraCode)

	self._activeCameraUnit = self:_createCamera(cameraCO.resPath)

	self._activeCameraUnit:setPriority(kActivePriority)
end

function VirtualCameraMgr:getActiveCamera()
	return self._activeCameraUnit
end

function VirtualCameraMgr:setBlendStyle(style)
	CineCameraUtils.SetBlendStyle(self._cineBrain, style)
end

function VirtualCameraMgr:getBlendStyle()
	return CineCameraUtils.GetBlendStyle(self._cineBrain)
end

function VirtualCameraMgr:setBlendCurve(animationCurve, duration)
	CineCameraUtils.SetBlendAnimationCurve(self._cineBrain, animationCurve, duration or kDefaultBlendDuration)
end

function VirtualCameraMgr:clearBlendCurve()
	CineCameraUtils.ClearBlendAnimationCurve(self._cineBrain)
end

function VirtualCameraMgr:setBlendDuration(duration)
	CineCameraUtils.SetBlendDuration(self._cineBrain, duration or kDefaultBlendDuration)
end

function VirtualCameraMgr:resetBlendDuration()
	CineCameraUtils.SetBlendDuration(self._cineBrain, kDefaultBlendDuration)
end

function VirtualCameraMgr:setFieldOfView(pov)
	self._activeCameraUnit:setFieldOfView(pov)
end

function VirtualCameraMgr:getFieldOfView()
	return self._activeCameraUnit:getFieldOfView()
end

function VirtualCameraMgr:setDampingX(damping)
	self._activeCameraUnit:setDampingX(damping)
end

function VirtualCameraMgr:setDampingY(damping)
	self._activeCameraUnit:setDampingY(damping)
end

function VirtualCameraMgr:setDampingZ(damping)
	self._activeCameraUnit:setDampingZ(damping)
end

function VirtualCameraMgr:doUnitRotation(x, y, z, duration)
	Astral.TransformUtil.DOLocalRotate(self._activeCameraUnit:getGo().transform, x, y, z, duration)
end

function VirtualCameraMgr:setTemporaryCameraActive(cameraCode, active)
	local cameraUnit = self:createTemporaryCamera(cameraCode)

	cameraUnit:setPriority(active and kActivePriority2 or kDisablePriority)
	cameraUnit:setEnable(active)
end

function VirtualCameraMgr:getTemporaryCamera(cameraCode)
	local cameraCO = CameraConfig.instance:getCameraCO(cameraCode)
	local name = cameraCO.resPath

	return self._cacheCameraTable[name]
end

function VirtualCameraMgr:createTemporaryCamera(cameraCode)
	local cameraCO = CameraConfig.instance:getCameraCO(cameraCode)
	local name = cameraCO.resPath
	local cameraUnit = self._cacheCameraTable[name]

	if not cameraUnit then
		cameraUnit = self:_createCamera(name)
		self._cacheCameraTable[name] = cameraUnit
	end

	cameraUnit:setPriority(kDisablePriority)

	return cameraUnit
end

function VirtualCameraMgr:releaseTemporaryCamera(cameraCode)
	local cameraCO = CameraConfig.instance:getCameraCO(cameraCode)
	local name = cameraCO.resPath
	local cameraUnit = self._cacheCameraTable[name]

	if not cameraUnit then
		return
	end

	cameraUnit:returnSelf()

	self._cacheCameraTable[name] = nil
end

function VirtualCameraMgr:getCameraUrl(cameraCode)
	local cameraCO = CameraConfig.instance:getCameraCO(cameraCode)

	return GameUrl.getVirtualCamera(cameraCO.resPath)
end

function VirtualCameraMgr:setFollowPosition(x, y, z)
	return self._cameraFollow:setPosition(x, y, z)
end

function VirtualCameraMgr:forceSetFollowPosition(x, y, z)
	self._cameraFollow:forceSetPosition(x, y, z)
end

function VirtualCameraMgr:doFollowPosition(x, y, z, duration)
	return self._cameraFollow:doMovePosition(x, y, z, duration)
end

function VirtualCameraMgr:setPositionTweenSetterHandler(callback, callbackSelf)
	return self._cameraFollow:setPositionTweenSetterHandler(callback, callbackSelf)
end

function VirtualCameraMgr:forceDoFollowPosition(x, y, z, duration)
	return self._cameraFollow:forceDoMovePosition(x, y, z, duration)
end

function VirtualCameraMgr:getFollowPosition()
	return self._cameraFollow:getPosition()
end

function VirtualCameraMgr:setLookAtPosition(x, y, z)
	self._cameraFollow:setLookAtPosition(x, y, z)
end

function VirtualCameraMgr:setFollowConfiner(resPath)
	if not string.nilorempty(resPath) then
		self._cameraFollow:setConfinerPosition(0, 0, 0)
		self._cameraFollow:setConfinerUrl(GameUrl.getFollowConfiner(resPath))
	else
		self:clearFollowConfiner()
	end
end

function VirtualCameraMgr:useEmptyConfiner()
	self._cameraFollow:useEmptyConfiner()
end

function VirtualCameraMgr:setConfinerPosition(x, y, z)
	self._cameraFollow:setConfinerPosition(x, y, z)
end

function VirtualCameraMgr:setCameraRotation(x, y, z)
	self._cameraFollow:setRotation(x, y, z)
end

function VirtualCameraMgr:doCameraRotation(x, y, z, duration)
	self._cameraFollow:doRotation(x, y, z, duration)
end

function VirtualCameraMgr:doCameraRotationZ(z, duration)
	self._cameraFollow:doRotationZ(z, duration)
end

function VirtualCameraMgr:clearFollowConfiner()
	self._cameraFollow:clearConfiner()
end

function VirtualCameraMgr:shake(lifeTime, magnitude, shakeModeValue, hakeMagnitudeDecreaseRate, cycleTime)
	if not self._activeCameraUnit and enableErrorLog then
		printError(string.format("震动失败,没有相机初始化失败"))

		return
	end

	self._activeCameraUnit:shake(lifeTime, magnitude, shakeModeValue, hakeMagnitudeDecreaseRate, cycleTime)
end

function VirtualCameraMgr:stopShake()
	if self._activeCameraUnit then
		self._activeCameraUnit:stopShake()
	end
end

function VirtualCameraMgr:isCameraFollowColliderValid()
	if self._cameraFollow then
		return self._cameraFollow:isColliderValid()
	end
end

function VirtualCameraMgr:getPolygonColliderPolygon()
	if self._cameraFollow then
		return self._cameraFollow:getPolygonColliderPolygon()
	end
end

function VirtualCameraMgr:internal_getCameraFollow()
	return self._cameraFollow
end

function VirtualCameraMgr:_createCamera(name)
	local cameraUnit = VirtualCameraUnit:createInstance(name)

	cameraUnit:load(GameUrl.getVirtualCamera(name))

	return cameraUnit
end

function VirtualCameraMgr:_releaseActiveCamera()
	local cameraUnit = self._activeCameraUnit

	if cameraUnit then
		cameraUnit:returnSelf()
	end
end

VirtualCameraMgr.instance = VirtualCameraMgr.New()

return VirtualCameraMgr
