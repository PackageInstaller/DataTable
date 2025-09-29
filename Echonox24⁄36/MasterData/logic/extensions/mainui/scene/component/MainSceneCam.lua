-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneCam.lua

module("logic.extensions.mainui.scene.component.MainSceneCam", package.seeall)

local M = class("MainSceneCam", SceneCamera)
local Gyro_CAM_DURATION = 1

function M:onInit()
	M.super.onInit(self)

	self._camPos = Vector3.New()
	self._camAngle = Vector3.New()
	self._camAngleGyros = Vector3.New()
	self._tmpAngle = Vector3.New()
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	local defaultCam = 0
	local cfgCam = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, defaultCam)
	local posData = cfgCam and cfgCam.posData or {}

	if posData then
		self:setLocalPos(posData[1] or 0, posData[2] or 0, posData[3] or 0)
		self:setLocalEulerAngles(posData[4] or 0, posData[5] or 0, posData[6] or 0)
		self:setFieldOfView(posData[7] or MainPerformEnum.DefaultFov)
	end
end

function M:onExitScene()
	self:releaseCamTween()
	self:_setEvent(false)
end

function M:onLeaveScene(needUnloadRes)
	self:releaseCamTween()
	self:_setEvent(false)
end

function M:onReturnScene(needUnloadRes)
	self:_setEvent(true)
end

function M:onReturnSceneFinished(needUnloadRes)
	self:onEnterSceneFinished(self._scene:getSceneId(), self._scene:getBornX(), self._scene:getBornZ())
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CAM_INIT, self._handleMainSceneCamInit, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, self._handleUpdateGyroAngle, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CAM_INIT, self._handleMainSceneCamInit, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, self._handleUpdateGyroAngle, self)
	end
end

function M:_handleUpdateGyroAngle(e, x, y, z)
	self:updateGyroCam(x, y, z)
end

function M:_handleMainSceneCamInit(e)
	if self._dirtyTweenCommand then
		local com = self._dirtyTweenCommand

		self:tweenCam(com.camCode, com.duration, com.ease, com.resetGyro)

		self._dirtyTweenCommand = nil
	end
end

function M:getCamUnit()
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow and sceneFlow.cam then
		return sceneFlow.cam:getCamUnit()
	end

	return nil
end

function M:getCamGo()
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow and sceneFlow.cam then
		return sceneFlow.cam:getCamGo()
	end

	return nil
end

function M:getCamOffset(showLog)
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow and sceneFlow.cam then
		return sceneFlow.cam:getCamOffset(showLog)
	end

	return nil
end

function M:getRuntimeTransGizmo()
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow and sceneFlow.cam then
		return sceneFlow.cam:getRuntimeTransGizmo()
	end

	return nil
end

function M:releaseCamTween()
	local camGo = self:getCamGo()

	if camGo then
		camGo.transform:DOKill(false)
	end

	if self._camTweenerPos then
		self._camTweenerPos:Kill(false)
	end

	if self._camTweenerAngle then
		self._camTweenerAngle:Kill(false)
	end

	if self._camTweenerFov then
		self._camTweenerFov:Kill(false)
	end

	self._camTweenerPos = nil
	self._camTweenerAngle = nil
	self._camTweenerFov = nil
	self._isLerpingPos = false
	self._isLerpingAngle = false
end

function M:setLocalPos(x, y, z)
	self:releaseCamTween()
	self:setBasePos(x, y, z)

	local camGo = self:getCamGo()

	if camGo then
		TransformUtils.SetLocalPosition(camGo.transform, x, y, z)
	end
end

function M:setLocalEulerAngles(x, y, z)
	self:releaseCamTween()
	self:setBaseAngle(x, y, z)

	local camGo = self:getCamGo()

	if camGo then
		local _x, _y, _z = self:getRealAngleSplit()

		TransformUtils.SetLocalEulerAngles(camGo.transform, _x, _y, _z)
	end
end

function M:tweenCam(camCode, duration, ease, resetGyro)
	local camGo = self:getCamGo()

	if not camGo or goutil.isNil(camGo) then
		self._dirtyTweenCommand = {
			camCode = camCode,
			duration = duration,
			ease = ease,
			resetGyro = resetGyro
		}

		return
	end

	duration = duration or 0
	camCode = tonumber(camCode)
	duration = tonumber(duration)

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, camCode)

	if cfg then
		local posData = cfg and cfg.posData or {}
		local pX = posData[1] or 0
		local pY = posData[2] or 0
		local pX, pY, pZ = pX, pY, posData[3] or 0
		local rX = posData[4] or 0
		local rY = posData[5] or 0
		local rX, rY, rZ = rX, rY, posData[6] or 0
		local fov = posData[7] or MainPerformEnum.DefaultFov

		self:releaseCamTween()
		self:_setBaseFieldOfView(fov)

		if resetGyro then
			self:updateGyroCam(0, 0, 0)
		end

		if duration == 0 then
			self:setLocalPos(pX, pY, pZ)
			self:setLocalEulerAngles(rX, rY, rZ)
			self:setFieldOfView(fov + self:getOffsetFov())
		else
			ease = ease or DG.Tweening.Ease.InOutSine

			self:DOLocalMove(pX, pY, pZ, ease, duration)
			self:DOLocalRotate(rX, rY, rZ, ease, duration)
			self:DOFov(fov + self:getOffsetFov(), ease, duration)
		end
	end
end

function M:setFieldOfView(fov)
	local camUnit = self:getCamUnit()

	if camUnit then
		camUnit:setFieldOfView(fov)
	end
end

function M:getFieldOfView()
	local camUnit = self:getCamUnit()

	if camUnit then
		return camUnit:getFieldOfView()
	end

	return MainPerformEnum.DefaultFov
end

function M:_setBaseFieldOfView(fov)
	self._baseFOV = fov
end

function M:_getBaseFieldOfView()
	return self._baseFOV or MainPerformEnum.DefaultFov
end

function M:setOffsetFov(fov, duration)
	fov = tonumber(fov)

	local last = self:getOffsetFov()
	local isChange = last ~= fov

	self._offsetFOV = fov

	if isChange then
		local base = self:_getBaseFieldOfView()
		local tagetFov = base + fov

		if duration and duration > 0 then
			self:DOFov(tagetFov, DG.Tweening.Ease.InOutSine, duration)
		else
			self:setFieldOfView(tagetFov)
		end
	end
end

function M:getOffsetFov()
	return self._offsetFOV or 0
end

function M:DOFov(fov, ease, duration)
	if self._camTweenerFov then
		self._camTweenerFov:Kill(false)
	end

	self._camTweenerFov = TweenNumberUtils.FloatToWithGetter(fov, duration, self.getFieldOfView, function(handler, val)
		self:setFieldOfView(val)
	end, self):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamFovFinish, self):OnKill(self._lerpCamFovFinish, self)
end

function M:_lerpCamFovFinish()
	self._camTweenerFov = nil
end

function M:DOLocalMove(x, y, z, ease, duration)
	local camGo = self:getCamGo()

	if self._isLerpingPos then
		self:setBasePos(x, y, z)

		self._camTweenerPos = self._camTweenerPos:ChangeEndValue(self._camPos, -1, true):SetEase(ease):SetAutoKill(true)
	else
		self._isLerpingPos = true

		self:setBasePos(x, y, z)

		self._camTweenerPos = camGo.transform:DOLocalMove(self._camPos, duration):SetEase(ease):SetAutoKill(true)
	end
end

function M:setBasePos(x, y, z)
	self._camPos:Set(x, y, z)
end

function M:getBasePosSplit()
	return self._camPos:Get()
end

function M:DOLocalRotate(x, y, z, ease, duration)
	self:setBaseAngle(x, y, z)
	self:_tweenAngle(ease, duration)
end

function M:_tweenAngle(ease, duration)
	local endAngle = self:getRealAngle()

	if self._isLerpingAngle then
		self._camTweenerAngle = self._camTweenerAngle:ChangeEndValue(endAngle, -1, true):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamAngleFinish, self):OnKill(self._lerpCamAngleKill, self)
	else
		local camGo = self:getCamGo()

		self._camTweenerAngle = camGo.transform:DOLocalRotate(endAngle, duration, DG.Tweening.RotateMode.Fast):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamAngleFinish, self):OnKill(self._lerpCamAngleKill, self)
		self._isLerpingAngle = true
	end
end

function M:_lerpCamAngleKill()
	self._isLerpingAngle = false
end

function M:_lerpCamAngleFinish()
	self._isLerpingAngle = false

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_VIEW_CAM_FINISH)
end

function M:getCurAngle()
	local camGo = self:getCamGo()

	if camGo then
		self._tmpAngle:Set(TransformUtils.GetLocalEulerAngles(camGo.transform, 0, 0, 0))
	else
		self._tmpAngle:Set(0, 0, 0)
	end

	return self._tmpAngle
end

function M:getRealAngleSplit()
	local x = self._camAngleGyros.x + self._camAngle.x
	local y = self._camAngleGyros.y + self._camAngle.y
	local z = self._camAngleGyros.z + self._camAngle.z

	return x, y, z
end

function M:getRealAngle()
	self._tmpAngle:Set(self:getRealAngleSplit())

	return self._tmpAngle
end

function M:setBaseAngle(x, y, z)
	self._camAngle:Set(x, y, z)
end

function M:getBaseAngleSplit()
	return self._camAngle:Get()
end

function M:setAngleGyros(x, y, z)
	self._camAngleGyros:Set(x, y, z)

	if self._isLerpingAngle then
		return
	end

	local duration = self:getGyroCamTweenDuration()
	local camGo = self:getCamGo()

	if camGo then
		self._camTweenerAngle = camGo.transform:DOLocalRotate(self:getRealAngle(), duration, DG.Tweening.RotateMode.Fast):SetAutoKill(true)
	end
end

function M:getGyrosAngleSplit()
	return self._camAngleGyros:Get()
end

function M:updateGyroCam(valX, valY, valZ)
	self:setAngleGyros(valX, valY, valZ)
end

function M:getGyroCamTweenDuration()
	return Gyro_CAM_DURATION
end

function M:setGyroCamTweenDuration(duration)
	duration = duration or 0

	if duration < 0 then
		duration = 0
	end

	Gyro_CAM_DURATION = duration
end

return M
