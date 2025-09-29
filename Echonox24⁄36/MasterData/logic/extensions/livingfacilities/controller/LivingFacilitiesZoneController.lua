-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/controller/LivingFacilitiesZoneController.lua

module("logic.extensions.livingfacilities.controller.LivingFacilitiesZoneController", package.seeall)

local M = class("LivingFacilitiesZoneController", BaseController)

M.SNAPSHOT_RT_WIDTH = 960
M.SNAPSHOT_RT_HEIGHT = 540

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_resetAll()
end

function M:onReset()
	LivingRoomFurnitureUtil.instance:reset()
	self:_resetAll()
end

function M:_resetAll()
	self._currentZoneId = false
	self._isHideAllUI = false
	self._isInEdit = false
	self._inPlaceTemple = false
	self._isInManageView = false
	self._cacheFurnitureList = nil
	self._cacheFurnitureDatas = nil

	HouseDispatcher:addEventListener(HouseEventType.LIVE_CLOTH_OPEN, self._enterClothEdit, self)
	HouseDispatcher:addEventListener(HouseEventType.LIVE_CLOTH_CLOSE, self._exitClothEdit, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OP_VIEW_OPEN, self._editViewOpen, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_HAVE_RECYCLE, self._recycleFurniture, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_START, self.InitCache, self)
end

function M:getCurrentZoneId()
	return self._currentZoneId
end

function M:setCurrentZoneId(currentZoneId)
	self._currentZoneId = currentZoneId
end

function M:getCurrentZoneMo()
	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(self._currentZoneId)

	return zoneMo
end

function M:getGenderMark()
	return LivingFacilitiesZoneModel.instance:getGenderMarkCO(self._currentZoneId)
end

function M:getCampMark()
	return LivingFacilitiesZoneModel.instance:getCampMarkCO(self._currentZoneId)
end

function M:getGenderMarkByHeros(heros, zoneId)
	local gender = -1
	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(zoneId)

	if #heros < #zoneMo:getBunkList() then
		return nil
	end

	for _, heroId in pairs(heros) do
		local heroCfg = CharacterConfig.instance:getCfgInfoByID(heroId)

		if gender ~= -1 and heroCfg.gender ~= gender then
			return nil
		else
			gender = heroCfg.gender
		end
	end

	return HouseConfig.instance:getLivingFacilitiesGenderMarkCO(gender)
end

function M:getCampMarkByHeros(heros, zoneId)
	local camp = -1
	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(zoneId)

	if #heros < #zoneMo:getBunkList() then
		return nil
	end

	for _, heroId in pairs(heros) do
		local heroCfg = CharacterConfig.instance:getCfgInfoByID(heroId)

		if camp ~= -1 and heroCfg.camp ~= camp then
			return nil
		else
			camp = heroCfg.camp
		end
	end

	return HouseConfig.instance:getLivingFacilitiesCampMarkCO(camp)
end

function M:refreshUnlockZones(unlockZones)
	LivingFacilitiesZoneModel.instance:refreshUnlockZones(unlockZones)
end

function M:refreshByAgent(unlockZones, activeLiveZones)
	LivingFacilitiesZoneModel.instance:refreshByAgent(unlockZones, activeLiveZones)
end

function M:refreshAtmospheres(atmospheres)
	LivingFacilitiesZoneModel.instance:setAtmospheres(atmospheres)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_ATMOSPHERE_CHANGE)
end

function M:refreshActiveStatusByZoneId(zoneId)
	LivingFacilitiesZoneModel.instance:refreshActiveStatusByZoneId(zoneId)
end

function M:refreshAgentDataByZoneId(zoneId, zoneInfo)
	LivingFacilitiesZoneModel.instance:refreshDataById(zoneId, zoneInfo)
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_ZONE_INFO_REFRESH, zoneId)
end

function M:findZoneByHeroId(heroId)
	local zoneList = LivingFacilitiesZoneModel.instance:getZoneList()

	for i, zone in ipairs(zoneList) do
		local bunkList = zone:getBunkList()

		for k, bunkInfo in ipairs(bunkList) do
			if heroId == bunkInfo.heroId then
				return zone, bunkInfo
			end
		end
	end
end

function M:hideAllUI(status)
	self._isHideAllUI = status

	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_HIDE_ALL_UI, self._isHideAllUI, self._isInEdit)
end

function M:getAllFacilitiesBySize(size)
	local facilitiesList = {}
	local dataList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseLiveRoom)

	for k, data in pairs(dataList) do
		if data.size == size and data.type ~= 0 and data.type ~= HouseEnum.LivingRoomType.SpecialDormitory then
			table.insert(facilitiesList, data)
		end
	end

	table.sort(facilitiesList, function(cfgA, cfgB)
		return cfgA.priority > cfgB.priority
	end)

	return facilitiesList
end

function M:getMoodAddByBasicsNum(num)
	local moodRecover = 0
	local dataList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)

	for i, data in ipairs(dataList) do
		if num >= data.rankNum then
			moodRecover = data.moodRecover
		end
	end

	return moodRecover
end

function M:getMoodAddByDormNum(num)
	local moodRecover = 0
	local dataList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosDorm)

	for i, data in ipairs(dataList) do
		if num >= data.rankNum then
			moodRecover = data.moodRecover
		end
	end

	return moodRecover
end

function M:_enterClothEdit()
	HouseFacade.instance:startEditRoomFurniture(self._currentZoneId)
end

function M:_exitClothEdit()
	HouseFacade.instance:endEditRoomFurniture()
end

function M:revokeAllClothEdit()
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_ask_adjust_furniture"))

	dialog:setConfirmListener(function()
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REVOKE_ALL)
	end, self)
end

function M:removeAllClothEdit()
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_ask_unload_furniture"))

	dialog:setConfirmListener(function()
		self:recycleAllRoomFurniture()
		HouseFurnitureModel.instance:setCanSaveFurniture(true)
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REMOVE_ALL)
	end, self)
end

function M:showTemplate(moList)
	if not self:getInPlaceTemple() then
		self:cacheEditFurniture()
	end

	self:replaceEditByMoList(moList)
end

function M:replaceEditByMoList(moList)
	self:recycleAllRoomFurniture()
	self:setInPlaceTemple(true)
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REPLACE_ALL_BY_DATA, moList)
end

function M:applyTemplate(moList)
	local furniutreMOs = clone(moList)

	self:setInPlaceTemple(false)
	RoomFurnitureEditModel.instance:recycleAllRoomFurniture()

	local removeIdxs = {}

	for idx, mo in ipairs(furniutreMOs) do
		local id = mo:getId()
		local data = RoomFurnitureEditModel.instance:getBagData(id)

		if data then
			local uuid = data:getOneFurniture()

			if uuid then
				mo:setUUId(uuid)
				self:reduceCurrentFurniture(id, uuid)
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

	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REPLACE_ALL_BY_DATA, furniutreMOs)
end

function M:setInPlaceTemple(status)
	self._inPlaceTemple = status
end

function M:getInPlaceTemple()
	return self._inPlaceTemple
end

function M:resetWhenInPlaceTemple()
	if self:getInPlaceTemple() then
		self:setInPlaceTemple(false)
		self:applyCacheEditFurniture()
	end
end

function M:getCacheFurnitureDatas()
	return self._cacheFurnitureDatas
end

function M:cacheEditFurniture()
	self._cacheFurnitureDatas = HouseFacade.instance:getCurrFurnitureDatas(self._currentZoneId)

	local moList = {}

	for i, data in ipairs(self._cacheFurnitureDatas) do
		local NO = {
			id = data.furnitureId,
			pos = {
				x = data.coordX,
				y = data.coordY
			},
			angle = data.angle,
			uuid = data.uuid
		}
		local mo = HouseFurnitureMO.New()

		mo:setDataByAgent(NO)
		table.insert(moList, mo)
	end

	self._cacheFurnitureList = moList
end

function M:applyCacheEditFurniture()
	for _, mo in ipairs(self._cacheFurnitureList) do
		self:reduceCurrentFurniture(mo:getId(), mo:getUUId())
	end

	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_REPLACE_ALL_BY_DATA, self._cacheFurnitureList)
end

function M:placeOneEditById(furnitureId)
	if self:getInPlaceTemple() then
		self:setInPlaceTemple(false)
		self:revokeAllClothEdit()
	end

	local floorId, wallId = RoomFurnitureEditModel.instance:getCurrEditingPaper()
	local isEquip = furnitureId == floorId or furnitureId == wallId
	local uuid
	local bagFurniture = RoomFurnitureEditModel.instance:getBagData(furnitureId)

	if bagFurniture then
		uuid = bagFurniture:getOneFurniture()
	end

	if not isEquip then
		self:reduceCurrentFurniture(furnitureId, uuid)

		if checknumber(uuid) <= 0 then
			printError("家具摆放错误，没有uuid，家具id：", furnitureId)
		end
	end

	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_EDIT_NEW_BY_ID, furnitureId, uuid)
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_FURNITURE_REFRESH)
end

function M:InitCache()
	self:setInPlaceTemple(false)
	RoomFurnitureEditModel.instance:initDatas(self._currentZoneId)
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_FURNITURE_REFRESH, true)
end

function M:recycleAllRoomFurniture()
	RoomFurnitureEditModel.instance:recycleAllRoomFurniture()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_FURNITURE_REFRESH, true)
end

function M:addCurrentFurniture(furnitureId, uuid)
	RoomFurnitureEditModel.instance:recycleFromRoom(furnitureId, uuid)
end

function M:reduceCurrentFurniture(furnitureId, uuid)
	RoomFurnitureEditModel.instance:decorateToRoom(furnitureId, uuid)
end

function M:getCacheCurrentFurniture()
	return RoomFurnitureEditModel.instance:getAllBagDatas()
end

function M:_editViewOpen(e, isOpen)
	self._isHideAllUI = not isOpen
	self._isInEdit = isOpen

	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_HIDE_ALL_UI, self._isHideAllUI, self._isInEdit)
end

function M:_recycleFurniture(e, recycleFurnitureId, uuid)
	self:addCurrentFurniture(recycleFurnitureId, uuid)
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_FURNITURE_REFRESH)
end

function M:getTempleListByType(type)
	HouseAgent.instance:sendGetFurnitureTemplateRequest(type)
end

function M:getAllDorm()
	local list = {}
	local zoneList = LivingFacilitiesZoneModel.instance:getZoneList()

	for i, zone in ipairs(zoneList) do
		if zone:getCanLive() and zone:getHeroCount() > 0 then
			table.insert(list, zone)
		end
	end

	return list
end

function M:getScheduleTimeList(schedule)
	schedule = schedule or {}

	local list = {}

	for i, type in ipairs(schedule) do
		list[type] = list[type] and list[type] + 1 or 1
	end

	return list
end

function M:judgeRestScheduleMinHours(schedule, showLog)
	local list = self:getScheduleTimeList(schedule)

	for _, type in pairs(HouseEnum.WorkStatus) do
		local realHour = list[type] or 0
		local needHour = HouseConfig.instance:getMinScheduleHours(type)

		if realHour < needHour then
			if showLog then
				local typeStr = HouseEnum.WorkStatus2Text[type]

				FloatWordMgr.instance:show(langF("tip_schedule_min_hour", typeStr, needHour))
			end

			return false
		end
	end

	return true
end

function M:setIsInManageView(inView)
	self._isInManageView = inView
end

function M:isInManageView()
	return self._isInManageView
end

function M:formatAtmosphereValue(val, numDigits)
	local finalVal = val
	local _, _decimals = math.modf(val)

	if _decimals ~= 0 then
		numDigits = 10^numDigits
		finalVal = MathUtil.roundingBy456(val * numDigits)
		finalVal = finalVal ~= 0 and finalVal / numDigits or finalVal / numDigits
	end

	return finalVal
end

local kTemplateStoreKey = "__Furniture_Template_%s_%s_%s__"

function M:getTemplateIconFullPath(type, id)
	return string.format("%s/furniture_template/%s_%s.png", PlayerModel.instance:getPersonalPath(), type, id)
end

function M:isTemplateIconNewest(type, id)
	local storageCodeStr = self:getStorageTemplateHash(type, id)
	local mouldMO = LivingFacilitiesZoneModel.instance:getTempleById(type, id)

	if not string.nilorempty(storageCodeStr) and mouldMO then
		return storageCodeStr == mouldMO:getHashCodeStr()
	end

	return false
end

function M:getTemplatesNeedReload(type)
	local templateList = {}
	local allTemplate = LivingFacilitiesZoneModel.instance:getTempleByType(type)

	for id, template in pairs(allTemplate) do
		local furnList = template:getFurnitureList()

		if #furnList > 0 then
			local storageCodeStr = self:getStorageTemplateHash(type, id)

			if string.nilorempty(storageCodeStr) or storageCodeStr ~= template:getHashCodeStr() then
				table.insert(templateList, template)
			else
				local path = self:getTemplateIconFullPath(type, id)

				if not SpaceXFileUtil.IsFileExists(path) then
					table.insert(templateList, template)
				end
			end
		end
	end

	return templateList
end

function M:setStorageTemplateHash(type, id)
	local mouldMO = LivingFacilitiesZoneModel.instance:getTempleById(type, id)

	if mouldMO then
		local key = string.format(kTemplateStoreKey, PlayerModel.instance:getId(), type, id)

		Astral.LocalStorage.Instance:SetString(key, mouldMO:getHashCodeStr())
	end
end

function M:getStorageTemplateHash(type, id)
	local key = string.format(kTemplateStoreKey, PlayerModel.instance:getId(), type, id)

	return Astral.LocalStorage.Instance:GetString(key)
end

M.instance = M.New()

return M
