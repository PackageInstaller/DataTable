-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/camera/MainCameraMgr.lua

module("logic.scene.camera.MainCameraMgr", package.seeall)

local M = class("MainCameraMgr")

function M:ctor()
	self._mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	self._mainCameraComp = self._mainCameraTarget:getCamera()
	self._isShowCamera = true
	self._cullingMask = 0
	self._recordFog = false
	self._featureWhiteList = {
		"UIBlur",
		"UIGlassBlurBg",
		"UI3DPlanarReflectionRendererFeature",
		"Outline",
		"HighQualityShadow"
	}

	GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
end

function M:getMainCamera()
	return self._mainCameraComp
end

function M:_setCameraMask(mask, isRecord)
	self._cullingMask = isRecord and mask or self._cullingMask

	if self._isShowCamera then
		self._mainCameraComp.cullingMask = mask
	end
end

function M:_setSceneFog(fog)
	local curFog = SpaceX.SceneRenderingUtils.GetFog()

	if curFog ~= fog then
		self._recordFog = curFog

		SpaceX.SceneRenderingUtils.SetFog(fog)
	end
end

function M:setCameraMaskMode(mode)
	mode = mode or 0

	self:_setCameraMask(Astral.LayerUtil.GetLayerMask(unpack(MainCameraMaskMode.Layers[mode])), true)
end

function M:setDefaultCameraMask()
	self:_setCameraMask(Astral.LayerUtil.GetLayerMask(unpack(MainCameraMaskMode.Layers[0])), true)
end

function M:setCameraVisible(visible)
	if self._isShowCamera ~= visible then
		if visible then
			self._isShowCamera = true

			self:_setCameraMask(self._cullingMask)
			URPCameraUtils.SetRenderPostProcessing(self._mainCameraComp, true)
			self:setViewRenderFeatures(true)
			self:resetCameraClearFlag()
			self:_setSceneFog(self._recordFog)
		else
			self:_setCameraMask(0)

			self._isShowCamera = false

			URPCameraUtils.SetRenderPostProcessing(self._mainCameraComp, false)
			URPCameraUtils.SetBackgroundTypeColor(self._mainCameraComp, "#000000")
			self:setViewRenderFeatures(false)
			self:_setSceneFog(false)
		end
	end
end

function M:setStoryCameraVisible(visible)
	if self._isShowCamera ~= visible then
		if visible then
			self._isShowCamera = true

			self:_setCameraMask(self._cullingMask)
			self:_setSceneFog(self._recordFog)
			self:setViewRenderFeatures(true)
		else
			self:_setCameraMask(0)
			self:setViewRenderFeatures(false)

			self._isShowCamera = false

			self:_setSceneFog(false)
		end
	end
end

function M:resetCameraClearFlag()
	return
end

function M:setViewRenderFeatures(enable, extraWhiteList)
	if extraWhiteList and #extraWhiteList > 0 then
		for i = 1, #self._featureWhiteList do
			table.insert(extraWhiteList, self._featureWhiteList[i])
		end

		URPCameraUtils.SetRenderFeatures(extraWhiteList, enable)
	else
		URPCameraUtils.SetRenderFeatures(self._featureWhiteList, enable)
	end
end

function M:_handleSceneFlowEnterFinish(e, info)
	if not info or not info.sceneType or not DeviceUtil.isEmulator() then
		return
	end
end

M.instance = M.New()

return M
