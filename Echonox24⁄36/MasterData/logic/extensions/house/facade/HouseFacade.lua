-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/facade/HouseFacade.lua

module("logic.extensions.house.facade.HouseFacade", package.seeall)

local M = class("HouseFacade")
local vec3Temp1 = Vector3.New()
local vec3Temp2 = Vector3.New()

function M:showRecordShelterRoomInvalid(luaTable)
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.shelterRecorder then
		currScene.shelterRecorder:showRecordShelterRoomInvalid(luaTable)
	end
end

function M:endRecordShelterRoomInvalid()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.shelterRecorder then
		currScene.shelterRecorder:endRecordShelterRoomInvalid()
	end
end

function M:openHeroTipsView(heroUnit)
	ViewMgr.instance:open(ViewName.HouseHeroTips, heroUnit)
end

function M:isEditingFurniture()
	return HouseFurnitureModel.instance:isEdit()
end

function M:startEditRoomFurniture(roomId)
	HouseMainStateModel.instance:changeState(HouseMainEnum.State.EditFurniture)
	HouseFurnitureModel.instance:setEdit(true)
	HouseFurnitureModel.instance:setEditRoomId(roomId)
	MainCameraMgr.instance:setCameraMaskMode(HouseEnum.EDIT_FURNITURE_CAMERA_MASK_MODE)
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_START)
end

function M:endEditRoomFurniture()
	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()

	if houseCameraUnit then
		houseCameraUnit:setFieldOfView(HouseSceneUtil.getCamFOV())

		local camGO = houseCameraUnit:getMainGO()
		local roomId = HouseFurnitureModel.instance:getEditRoomId()
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
		local pos = string.split(roomCO.focusPos, "#")

		vec3Temp1:Set(pos[1], pos[2], pos[3])
		vec3Temp2:Set(0, 0, roomCO.angle)

		local duration = 0.3

		camGO.transform:DOKill()
		camGO.transform:DOLocalMove(vec3Temp1, duration)
		camGO.transform:DORotate(vec3Temp2, duration)
	end

	HouseMainStateModel.instance:changeState(HouseMainEnum.State.FocusRoom)
	HouseFurnitureModel.instance:setEdit(false)
	MainCameraMgr.instance:setCameraMaskMode(HouseEnum.DEFAULT_CAMERA_MASK_MODE)
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_END)
end

function M:exportFurnitureCfgFile()
	local roomId = LivingFacilitiesZoneController.instance:getCurrentZoneId()

	if roomId and roomId > 0 then
		local roomUnit = HouseSceneUtil.getHouseRoomUnit(roomId)
		local furnitureUnit = roomUnit.furnitureHandler:getSelectedFurniture()

		if furnitureUnit then
			FloatWordMgr.instance:show("请先摆放编辑中的家具")

			return
		end

		local datas = self:getCurrFurnitureDatas(roomId)
		local cfgStr = ""

		for i, data in ipairs(datas) do
			local dataStr = string.format("%s#%s#%s#%s", data.furnitureId, data.coordX, data.coordY, data.angle)

			if i == 1 then
				cfgStr = dataStr
			else
				cfgStr = string.format("%s|%s", cfgStr, dataStr)
			end
		end

		TextUtils.CopyText(cfgStr)
		printWarn(string.format("家具配置：%s", cfgStr))
		FloatWordMgr.instance:show("配置已复制到剪贴板")
	else
		FloatWordMgr.instance:show(lang("tip_enter_room"))
	end
end

function M:productFurnitureByPaperId(paperId)
	ViewMgr.instance:open(ViewName.FurnitureProduct, {
		paperId = paperId
	})
end

function M:productFurnitureByFurnitureId(furnitureId)
	local paperId = HouseSceneUtil.getPaperIdByFurniture(furnitureId)

	if paperId then
		self:productFurnitureByPaperId(paperId)
	else
		FloatWordMgr.instance:show(lang("tip_product_furniture_lang_2"))
	end
end

function M:getCurrFurnitureDatas(roomId)
	local function _createData(id, x, y, angle, uuid)
		local data = {}

		data.furnitureId = id
		data.coordX = x
		data.coordY = y
		data.angle = angle
		data.uuid = uuid

		return data
	end

	local dataList = {}
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.roomMgr then
		local roomUnit = currScene.roomMgr:getUnitById(roomId)
		local dictFurniture = roomUnit.furnitureMgr:getDictFurnitureUnit()

		for unitId, unit in pairs(dictFurniture) do
			local data = _createData(unit.model:getFurnitureId(), unit.model:getCoordX(), unit.model:getCoordY(), unit.model:getAngle(), unit.model:getUUId())

			table.insert(dataList, data)
		end

		local floorId, floorUUId = roomUnit.furniturePaper:getFloorPaperId()

		if floorId then
			local data = _createData(floorId, 0, 0, 0, floorUUId)

			table.insert(dataList, data)
		end

		local wallId, wallUUId = roomUnit.furniturePaper:getWallPaperId()

		if wallId then
			local data = _createData(wallId, 0, 0, 0, wallUUId)

			table.insert(dataList, data)
		end
	end

	return dataList
end

M.instance = M.New()

return M
