-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/LivingFacilitiesZoneModel.lua

module("logic.extensions.livingfacilities.model.LivingFacilitiesZoneModel", package.seeall)

local M = class("LivingFacilitiesZoneModel", BaseModel)

function M:ctor()
	self._zoneList = nil
	self._zoneDict = {}
	self._templateList = nil
	self._cacheTemplate = nil
	self._mouldList = nil
	self._dictAtmosphere = nil
	self._atmosphereTotalLevel = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._zoneList = {}

	table.clear(self._zoneDict)

	self._templateList = {}
	self._mouldList = {}
	self._dictAtmosphere = {}
	self._atmosphereTotalLevel = 1

	self:initMould()
end

function M:initMould()
	local coList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseFurnitureTemplate)

	for i, co in ipairs(coList) do
		local mouldMo = LivingFacilitiesMouldMo.New(co)

		mouldMo:initByCo(co)
		table.insert(self._mouldList, mouldMo)
	end
end

function M:getMouldList(type)
	local list = {}

	for i, mouldMo in ipairs(self._mouldList) do
		if mouldMo:matchType(type) then
			table.insert(list, mouldMo)
		end
	end

	return list
end

function M:getZoneList()
	return self._zoneList
end

function M:getAllEffectiveZone()
	local moList = {}

	for _, zoneMO in ipairs(self._zoneList) do
		if zoneMO:getIsActive() and zoneMO:getType() > 0 then
			table.insert(moList, zoneMO)
		end
	end

	return moList
end

function M:getZoneById(zoneId)
	return self._zoneDict[zoneId]
end

function M:refreshByAgent(unlockZones, activeLiveZones)
	for i, zoneId in ipairs(unlockZones or {}) do
		local zoneMo = self:getZoneById(zoneId)

		if not zoneMo then
			local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

			if roomCO.roomType == HouseEnum.RoomType.Living then
				zoneMo = LivingFacilitiesZoneMo.New(zoneId)

				zoneMo:setZoneStatus(false, true)
				table.insert(self._zoneList, zoneMo)

				self._zoneDict[zoneId] = zoneMo
			end
		else
			zoneMo:setZoneStatus(false, true)
		end
	end

	for i, zoneInfo in ipairs(activeLiveZones or {}) do
		local zoneMo = self:getZoneById(zoneInfo.zoneId)

		if not zoneMo then
			zoneMo = LivingFacilitiesZoneMo.New(zoneInfo.zoneId)

			zoneMo:setZoneStatus(true, true)
			zoneMo:refreshByData(zoneInfo)
			table.insert(self._zoneList, zoneMo)

			self._zoneDict[zoneInfo.zoneId] = zoneMo
		else
			zoneMo:setZoneStatus(true, true)
		end
	end
end

function M:refreshUnlockZones(unlockZones)
	for i, zoneId in ipairs(unlockZones or {}) do
		local zoneMo = self:getZoneById(zoneId)

		if not zoneMo then
			local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

			if roomCO.roomType == HouseEnum.RoomType.Living then
				zoneMo = LivingFacilitiesZoneMo.New(zoneId)

				zoneMo:setZoneStatus(false, true)
				table.insert(self._zoneList, zoneMo)

				self._zoneDict[zoneId] = zoneMo
			end
		else
			zoneMo:setIsUnlock(true)
		end
	end
end

function M:setAtmospheres(atmospheres)
	self._atmospheres = atmospheres

	for _, AtmosphereNO in ipairs(atmospheres or {}) do
		local typ = AtmosphereNO.atmosphereType
		local val = AtmosphereNO.value

		self._dictAtmosphere[typ] = val
	end

	local dataList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)

	for i, data in ipairs(dataList) do
		if self:getNormalAtmosphereValue() >= data.rankNum then
			self._atmosphereTotalLevel = i
		end
	end
end

function M:getAtmospheres()
	return self._atmospheres
end

function M:getAtmosphereValue(typ)
	return self._dictAtmosphere[typ] or 0
end

function M:getNormalAtmosphereValue()
	return self:getAtmosphereValue(HouseExtension_pb.Atmosphere.NORMAL)
end

function M:getNormalAtmosphereLevel()
	return self._atmosphereTotalLevel
end

function M:refreshActiveStatusByZoneId(zoneId)
	local zoneMo = self:getZoneById(zoneId)

	if zoneMo then
		zoneMo:setZoneStatus(true, true)
	else
		printError("当前房间设施信息不存在,id为:", zoneId)
	end
end

function M:refreshDataById(zoneId, data)
	local zoneMo = self:getZoneById(zoneId)

	if zoneMo then
		zoneMo:refreshByData(data)
	else
		printError("当前房间设施信息不存在,id为:", zoneId)
	end
end

function M:refreshTemple(type, templates)
	self._templateList[type] = self._templateList[type] or {}

	for i, template in ipairs(templates) do
		local mouldMo = LivingFacilitiesMouldMo.New()

		mouldMo:initByAgent(template)

		mouldMo.id = template.id
		self._templateList[type][template.id] = mouldMo
	end
end

function M:getTempleByType(type)
	return self._templateList and self._templateList[type] or {}
end

function M:getTempleById(type, id)
	return self._templateList[type][id]
end

function M:deleteTemple(type, id)
	if self._templateList[type] then
		self._templateList[type][id] = nil
	end
end

function M:setCacheTemple(name, furnitureList)
	local mouldMo = LivingFacilitiesMouldMo.New()

	mouldMo:initByFurniture(name, furnitureList)

	self._cacheTemplate = mouldMo
end

function M:refreshTempleById(type, id)
	self._cacheTemplate.id = id

	if not self._templateList[type] then
		self._templateList[type] = {}
	end

	self._templateList[type][id] = self._cacheTemplate
end

function M:getSpRoomCount()
	local count = 0

	for i, zone in ipairs(self._zoneList) do
		if zone:getType() == HouseEnum.LivingRoomType.SpecialDormitory then
			count = count + 1
		end
	end

	return count
end

function M:getSpRoomsWithoutMember()
	local roomList = {}

	for i, zone in ipairs(self._zoneList) do
		if zone:getType() == HouseEnum.LivingRoomType.SpecialDormitory and zone:getInRoomHeroCount() <= 0 then
			table.insert(roomList, zone)
		end
	end

	return roomList
end

function M:getGenderMarkCO(zoneId)
	local zoneMo = self:getZoneById(zoneId)
	local bunkList = zoneMo:getBunkList()
	local gender = -1

	for _, bunkInfo in pairs(bunkList) do
		if bunkInfo.heroId > 0 then
			local heroCfg = CharacterConfig.instance:getCfgInfoByID(bunkInfo.heroId)

			if gender ~= -1 and heroCfg.gender ~= gender then
				return nil
			else
				gender = heroCfg.gender
			end
		else
			return nil
		end
	end

	return HouseConfig.instance:getLivingFacilitiesGenderMarkCO(gender)
end

function M:getCampMarkCO(zoneId)
	local zoneMo = self:getZoneById(zoneId)
	local bunkList = zoneMo:getBunkList()
	local camp = -1

	for _, bunkInfo in pairs(bunkList) do
		if bunkInfo.heroId > 0 then
			local heroCfg = CharacterConfig.instance:getCfgInfoByID(bunkInfo.heroId)

			if camp ~= -1 and heroCfg.camp ~= camp then
				return nil
			else
				camp = heroCfg.camp
			end
		else
			return nil
		end
	end

	return HouseConfig.instance:getLivingFacilitiesCampMarkCO(camp)
end

M.instance = M.New()

return M
