-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/camera/SceneCamera.lua

module("logic.scene.component.camera.SceneCamera", package.seeall)

local SceneCamera = class("SceneCamera", SceneComponentBase)

function SceneCamera:onInit()
	self._sceneId = false
end

function SceneCamera:onEnterScene(sceneId, bornX, bornZ)
	self._sceneId = sceneId

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	VirtualCameraMgr.instance:resetCameraSettings()
	VirtualCameraMgr.instance:setActiveCamera(sceneCO.cameraCode)
	VirtualCameraMgr.instance:setFollowConfiner(sceneCO.confinerResPath)

	local cameraCO = CameraConfig.instance:getCameraCO(sceneCO.cameraCode)

	MainCameraMgr.instance:setCameraMaskMode(cameraCO.cameraMaskMode)
	VolumeMgr.instance:turnOn(sceneCO.volumeResPath)
end

function SceneCamera:onExitScene()
	local sceneCO = SceneConfig.instance:getSceneCO(self._sceneId or 0)

	if sceneCO then
		VolumeMgr.instance:turnOff(sceneCO.volumeResPath)
	end

	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()
end

return SceneCamera
