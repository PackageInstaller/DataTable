-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/util/LivingRoomFurnitureUtil.lua

module("logic.extensions.livingfacilities.util.LivingRoomFurnitureUtil", package.seeall)

local M = class("LivingRoomFurnitureUtil")
local kWaitingKey = "ReloadAllTemplateIcon"

function M:ctor()
	return
end

function M:reset()
	self:_removeAllDatas()
end

function M:interrupt()
	self:_removeAllDatas()
end

function M:tryReloadAllTemplateIcon()
	self._zoneMO = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	local livingType = self._zoneMO:getType()
	local templateList = LivingFacilitiesZoneController.instance:getTemplatesNeedReload(livingType)

	if #templateList > 0 then
		self:startReloadAllTemplateIcon(templateList)
	end
end

function M:startReloadAllTemplateIcon(templateList)
	LoadingFacade.instance:showWaiting(kWaitingKey)

	self._templateList = templateList
	self._reloadIndex = 0

	local roomMgr = SceneMgr.instance:getCurScene().roomMgr

	self._originRoomUnit = roomMgr:getUnitById(self._zoneMO:getId())
	self._targetRoomUnit = roomMgr:getExtraSmallLivingRoom()

	if self._zoneMO:getSize() == HouseEnum.RoomSize.Big then
		self._targetRoomUnit = roomMgr:getExtraBigLivingRoom()
	end

	self:_initRoomAndCamera()
	self:_reloadNextTemplateIcon()
end

function M:_initRoomAndCamera()
	self._targetRoomUnit.model._subRoomType = 1

	self._targetRoomUnit.resLoader:setResData(false)
	self._targetRoomUnit.resLoader:removeAllListener()
	self._targetRoomUnit.resLoader:_addRoomGo()

	local photoCache = Astral.PhotoProducerCache.Instance
	local width = LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH
	local height = LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT

	self._producer = photoCache:Fetch(width, height)

	local layers = MainCameraMaskMode.Layers[HouseEnum.EDIT_FURNITURE_CAMERA_MASK_MODE]
	local cullingMask = Astral.LayerUtil.GetLayerMask(unpack(layers))
	local camera = self._producer.rtCamera

	camera.cullingMask = cullingMask
	camera.orthographic = false
	camera.fieldOfView = HouseEnum.DEFAULT_FOV

	local cameraData = goutil.addComponentOnce(camera.gameObject, typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))

	cameraData.renderPostProcessing = true

	local paramCfg = self._zoneMO:getSize() == HouseEnum.RoomSize.Big and HouseEnum.FurnitureOperaType2CameraParamBig or HouseEnum.FurnitureOperaType2CameraParam
	local param = paramCfg[0]
	local posX, posY, posZ = self._targetRoomUnit:getWorldPosByOffset(param.posX, param.posY, param.posZ)

	Astral.TransformUtil.SetPos(camera.gameObject.transform, posX, posY, posZ)
	Astral.TransformUtil.SetLocalRotation(camera.gameObject.transform, param.rotaX, param.rotaY, param.rotaZ)
end

function M:_reloadNextTemplateIcon()
	self._reloadIndex = self._reloadIndex + 1
	self._currTemplate = self._templateList[self._reloadIndex]

	if self._currTemplate then
		self._isReloading = true

		HouseDispatcher:addEventListener(HouseEventType.ROOM_FURNITURES_RES_LOADED, self._onAllFurnitureLoaded, self)
		self._targetRoomUnit.furnitureMgr:clearAllAndCreateFurnitures(self._currTemplate:getFurnitureList(), true)
	elseif self._reloadIndex > #self._templateList then
		self:finishReloadAllTemplateIcon()
	end
end

function M:_onAllFurnitureLoaded(e, roomId)
	if self._targetRoomUnit then
		if self._targetRoomUnit.model:getRoomId() == roomId then
			HouseDispatcher:removeEventListener(HouseEventType.ROOM_FURNITURES_RES_LOADED, self._onAllFurnitureLoaded, self)
			self:_capturePhoto()
		end
	else
		self:_removeAllDatas()
	end
end

function M:_capturePhoto()
	local root = ViewMgr.instance:getRoot(ViewRootType.Popup)
	local rectTransform = root:GetComponent(UIComponentType.RectTransform)
	local rect = Astral.GeometryUtil.GetNativePixelRect(rectTransform, CameraTargetMgr.instance:getUICameraTarget():getCamera())

	rect.x = 0
	rect.y = 0
	rect.width = LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH
	rect.height = LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT

	local camera = self._producer.rtCamera
	local fileName = LivingFacilitiesZoneController.instance:getTemplateIconFullPath(self._zoneMO:getType(), self._currTemplate:getId())

	settimer(0, function()
		Astral.SnapshotTaker.Instance:CaptureCamera(camera, rect, self._captureCallBack, self, fileName)
	end, nil, false)
end

function M:_captureCallBack()
	if self._isReloading then
		LivingFacilitiesZoneController.instance:setStorageTemplateHash(self._zoneMO:getType(), self._currTemplate:getId())
		self:_reloadNextTemplateIcon()
	end
end

function M:finishReloadAllTemplateIcon()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_ICON_RELOAD_FINISH)
	self:_removeAllDatas()
end

function M:_removeAllDatas()
	LoadingFacade.instance:hideWaiting(kWaitingKey)
	HouseDispatcher:removeEventListener(HouseEventType.ROOM_FURNITURES_RES_LOADED, self._onAllFurnitureLoaded, self)

	self._isReloading = false
	self._zoneMO = nil
	self._templateList = {}
	self._reloadIndex = -99
	self._originRoomUnit = nil

	if self._targetRoomUnit then
		self._targetRoomUnit.resLoader:unloadRes()
	end

	self._targetRoomUnit = nil

	if self._producer then
		local photoCache = Astral.PhotoProducerCache.Instance

		photoCache:Return(self._producer)
	end

	self._producer = nil
	self._currTemplate = nil
end

M.instance = M.New()

return M
