-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/mgr/HouseSceneExploreModeMgr.lua

module("logic.extensions.house.scene.component.mgr.HouseSceneExploreModeMgr", package.seeall)

local M = class("HouseSceneExploreModeMgr", SceneComponentBase)
local ID_EXPLORE_CAMERA = 13

function M:onInit()
	self._playerUnit = nil
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self._cameraUnit = VirtualCameraMgr.instance:createTemporaryCamera(ID_EXPLORE_CAMERA)

	self._cameraUnit:setLoadedCallback(self._onCameraLoad, self)
	self:setCameraActive(false)
	self:_setEvent(true)
end

function M:onExitScene()
	self:_setEvent(false)

	self._cameraUnit = nil

	VirtualCameraMgr.instance:releaseTemporaryCamera(ID_EXPLORE_CAMERA)
end

function M:_onCameraLoad()
	return
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_EXPLORE_MODE_ENTER, self._handleExploreModeEnter, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_EXPLORE_MODE_ENTER, self._handleExploreModeEnter, self)
	end
end

function M:_handleExploreModeEnter(e, enter)
	self:setCameraActive(enter)
end

function M:setCameraActive(active)
	VirtualCameraMgr.instance:setTemporaryCameraActive(ID_EXPLORE_CAMERA, active)

	if active then
		self._cameraUnit._relativeComponent.enabled = false
	end

	local curScene = SceneMgr.instance:getCurScene()
	local mainPlayer = curScene:getMainPlayer()

	if mainPlayer then
		if not active then
			mainPlayer.controller:interruptElevator()
		else
			mainPlayer.controller:_updateMoveData()
		end

		goutil.setActive(mainPlayer:getGameObject(), active)

		if active then
			settimer(0.1, function()
				local roomId, ringType = NavMeshUtil.surfaceGoNameToZoneId(mainPlayer.navMesh:getCurAreaName())
				local posX, posY, posZ = mainPlayer.navMesh:getNavMeshGoPos()
				local angle = NavMeshUtil.calculateMoveAngle(posX, posY, mainPlayer.navMesh:getCurAreaType(), mainPlayer.navMesh:getCurZoneId())

				HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, ringType)
				HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, ringType, angle)
			end, self, false)
		end
	end
end

return M
