-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesStatisticsTipsView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesStatisticsTipsView", package.seeall)

local M = class("LivingFacilitiesStatisticsTipsView", ViewComponent)

function M:buildUI()
	self._btnCancel = self:getBtn("health_tips_990624757")
	self._btnUsing = self:getBtn("health_tips_1992688632")
	self._btnClose = self:getBtn("health_tips_-1683292806")
	self._nameText = self:getText("live_furniture_statistics_tips_1976131189")
	self._numText = self:getText("live_furniture_statistics_tips_-2015270986")
	self._furnitureScrollGo = self:getGo("live_furniture_statistics_tips_13024005")
	self._furnitureLoopList = LoopGridViewHelper.New(self._furnitureScrollGo)

	self._furnitureLoopList:InitGridView(0, self._updateFurnitureCell, self)

	self._goWindow = self:getGo("live_furniture_statistics_tips_-1032056276")
	self._photoWindow = Astral.PhotoBase.Add(self._goWindow)
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._clickCancel, self)
	self._btnUsing:AddClickListener(self._clickUsing, self)
	self._btnClose:AddClickListener(self._clickClose, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnUsing:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_PRODUCT_FINISH, self._onFurnitureProduct, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_PRODUCT_FINISH, self._onFurnitureProduct, self)
	end
end

function M:onEnter()
	self._tempInfo = self:getFirstParam()
	self._usefulFurnitureList = self:_createUsefulFurnitures(self._tempInfo:getFurnitureList())

	LivingFacilitiesZoneController.instance:replaceEditByMoList(self._usefulFurnitureList)

	self._furnitureShowerList = {}

	self:initWindow()
	self:refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
	self._photoWindow:TurnOff()

	for i, shower in ipairs(self._furnitureShowerList) do
		shower:onExit()
	end

	self._furnitureLoopList:ClearCells()
	HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self._onFurnitureApply, self)

	self._tempInfo = nil
	self._usefulFurnitureList = nil
end

function M:refreshView()
	self._furnitureList = self._tempInfo:getCollectCountList()
	self._nameText.text = self._tempInfo:getName()

	local totalMyCount, totalCount = self._tempInfo:getCollectProgress()

	if totalMyCount < totalCount then
		self._numText.text = string.format("<color=#fa3e48>%d</color>/%d", totalMyCount, totalCount)
	else
		self._numText.text = string.format("%d/%d", totalMyCount, totalCount)
	end

	self._furnitureLoopList:SetListItemCount(#self._furnitureList, true)
	self._furnitureLoopList:RefreshAllShownItem()
	self._furnitureLoopList:MoveToItemIndex(0)
end

function M:initWindow()
	self._photoWindow:TurnOn()

	local photoProducer = self._photoWindow.producer

	Astral.TransformUtil.SetLocalPos(photoProducer.producerContainer.transform, 0, 0, 0)

	local layers = MainCameraMaskMode.Layers[HouseEnum.EDIT_FURNITURE_CAMERA_MASK_MODE]
	local cullingMask = Astral.LayerUtil.GetLayerMask(unpack(layers))
	local camera = PhotoBaseExtension.GetCamera(self._photoWindow)

	camera.cullingMask = cullingMask

	PhotoBaseExtension.SetCameraPostProcessing(self._photoWindow, true, 0)
	PhotoBaseExtension.SetCameraPerspective(self._photoWindow, HouseEnum.DEFAULT_FOV)

	local roomId = LivingFacilitiesZoneController.instance:getCurrentZoneId()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
	local pos = string.split(roomCO.focusPos, "#")

	self._photoWindow:SetCameraPosition(pos[1], pos[2], pos[3])
	self._photoWindow:SetCameraRotation(0, 0, roomCO.angle)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._furnitureLoopList:Dispose()

	self._furnitureLoopList = nil
	self._btnCancel = nil
	self._btnUsing = nil
	self._btnClose = nil
	self._nameText = nil
	self._numText = nil
	self._furnitureScrollGo = nil
	self._furnitureList = nil
	self._photoWindow = nil
end

function M:_updateFurnitureCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._furnitureLoopList:NewListViewItem("live_furniture_item")
	local furnitureInfo = self._furnitureList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LivingFurnitureNormalItemCell)

	if furnitureInfo.myNum < furnitureInfo.count then
		shower:setPreviewStatus(true, string.format("<color=#fa3e48>%d</color>/%d", furnitureInfo.myNum, furnitureInfo.count))
	else
		shower:setPreviewStatus(true, string.format("%d/%d", furnitureInfo.myNum, furnitureInfo.count))
	end

	local id = furnitureInfo.id
	local furnitureMo = FurnitureData.New({
		count = furnitureInfo.myNum,
		itemId = id
	})

	shower:setCellData(furnitureMo, curIndex)
	table.insert(self._furnitureShowerList, shower)

	return item
end

function M:_createUsefulFurnitures(moList)
	local furniutreMOs = clone(moList)

	RoomFurnitureEditModel.instance:recycleAllRoomFurniture()

	local removeIdxs = {}

	for idx, mo in ipairs(furniutreMOs) do
		local id = mo:getId()
		local data = RoomFurnitureEditModel.instance:getBagData(id)

		if data then
			local uuid = data:getOneFurniture()

			if uuid then
				RoomFurnitureEditModel.instance:decorateToRoom(id, uuid)
			else
				table.insert(removeIdxs, idx)
			end
		else
			table.insert(removeIdxs, idx)
		end
	end

	for i = #removeIdxs, 1, -1 do
		local idx = removeIdxs[i]

		table.remove(furniutreMOs, idx)
	end

	RoomFurnitureEditModel.instance:recycleAllRoomFurniture()

	return furniutreMOs
end

function M:_cancelApply()
	LivingFacilitiesZoneController.instance:replaceEditByMoList(self._tempInfo:getFurnitureList())
end

function M:_clickCancel()
	self:_cancelApply()
	self:close()
end

function M:_clickUsing()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_APPLY)
	HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self._onFurnitureApply, self)
	LivingFacilitiesZoneController.instance:applyTemplate(self._usefulFurnitureList)
end

function M:_clickClose()
	self:_cancelApply()
	self:close()
end

function M:_onFurnitureApply()
	HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_CREATE_ALL, self._onFurnitureApply, self)
	LivingFacilitiesFurnitureController.instance:saveFurnituresRequest()
	self:close()
end

function M:_onFurnitureProduct()
	self:refreshView()
end

return M
