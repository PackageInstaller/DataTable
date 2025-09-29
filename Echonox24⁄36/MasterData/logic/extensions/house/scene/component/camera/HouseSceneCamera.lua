-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/camera/HouseSceneCamera.lua

module("logic.extensions.house.scene.component.camera.HouseSceneCamera", package.seeall)

local M = class("HouseSceneCamera", SceneCamera)

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	M.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
	self:_initCaptureCam()
	self:_setEvent(true)
end

function M:onExitScene()
	M.super.onExitScene(self)
	self:_setEvent(false)

	if self._photoProducer then
		local camera = self._photoProducer.rtCamera

		camera.orthographic = false
		camera.fieldOfView = 60
		camera.cullingMask = Astral.PhotoProducerCache.Instance:GetCullingLayer()

		URPCameraUtils.SetBackgroundTypeColor(camera, "#000000")
		URPCameraUtils.SetRenderPostProcessing(camera, false)
		TransformUtils.SetLocalPosition(camera.transform, 0, 0, 0)
		TransformUtils.SetLocalEulerAngles(camera.transform, 0, 0, 0)
		Astral.PhotoProducerCache.Instance:Return(self._photoProducer)
	end

	self._captureRect = nil
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self.handleOnFocusRoomEnter, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_SAVE_FURNITURES_REPLY, self.handleOnSaveFurnituresReply, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_ENTER, self.handleOnFocusRoomEnter, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_SAVE_FURNITURES_REPLY, self.handleOnSaveFurnituresReply, self)
	end
end

function M:_initCaptureCam()
	self._photoProducer = Astral.PhotoProducerCache.Instance:Fetch(960, 540)

	if self._photoProducer then
		goutil.setActive(self._photoProducer.producerContainer, false)

		local camera = self._photoProducer.rtCamera

		camera.orthographic = false
		camera.fieldOfView = HouseEnum.DEFAULT_FOV
		camera.cullingMask = Astral.LayerUtil.GetLayerMask("Default", "Unit", "stone", "Sence_lightculing")

		URPCameraUtils.SetBackgroundTypeColor(camera, "#000000")
		URPCameraUtils.SetRenderPostProcessing(camera, true)
	end
end

function M:handleOnSaveFurnituresReply(e, roomId)
	self:captureRoomPic(roomId)
end

function M:handleOnFocusRoomEnter(e, roomId)
	local path = HouseController.instance:getRoomPicPath(roomId)
	local fileExist = SpaceXFileUtil.IsFileExists(path)

	if not fileExist then
		self:captureRoomPic(roomId)
	end
end

function M:captureRoomPic(roomId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	if not roomCO then
		return
	end

	local camera = self._photoProducer and self._photoProducer.rtCamera or nil

	if camera then
		if not self._captureRect then
			self._captureRect = UnityEngine.Rect.New(0, 0, LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH, LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT)
		end

		local fileName = HouseController.instance:getRoomPicPath(roomId)
		local pos = string.split(roomCO.focusPos, "#")
		local _offsetX, _, _ = TransformUtils.GetLocalPosition(self._photoProducer.producerContainer.transform, 0, 0, 0)

		TransformUtils.SetLocalPosition(camera.transform, tonumber(pos[1]) - _offsetX, tonumber(pos[2]), tonumber(pos[3]))
		TransformUtils.SetLocalEulerAngles(camera.transform, 0, 0, roomCO.angle)
		goutil.setActive(self._photoProducer.producerContainer, true)
		URPCameraUtils.CaptureScreenShotToFile(camera, self._captureRect, fileName, self._captureFinish, self)
	end
end

function M:_captureFinish(texture2D)
	goutil.destroy(texture2D)
	goutil.setActive(self._photoProducer.producerContainer, false)
end

return M
