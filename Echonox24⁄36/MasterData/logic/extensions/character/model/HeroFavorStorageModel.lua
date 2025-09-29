-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/model/HeroFavorStorageModel.lua

module("logic.extensions.character.model.HeroFavorStorageModel", package.seeall)

local M = class("HeroFavorStorageModel", BaseModel)
local DefaultHeroIds = "2000013#2000020#2000021#2000022"
local DefaultHeroFavors = "0#0#0#0"
local DefaultHeroLevels = "0#0#0#0"
local PlayerIdKey = "HeroFavorStorageModel_PlayerIdKey"

function M:onInit()
	self._arrayFavorData = {}
	self._dictFavorData = {}

	GlobalDispatcher:addEventListener(EventType.ENTER_GAME_REQUEST_OVER_EVENT, self._onEnterGameRequestOver, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_PLAYER_INFO_EVENT, self._onUpdatePlayerInfo, self)
end

function M:onReset()
	table.clear(self._arrayFavorData)
	table.clear(self._dictFavorData)
end

function M:getHeroIdList()
	self:_tryInitData()

	local idList = {}

	for i, data in ipairs(self._arrayFavorData) do
		table.insert(idList, data.id)
	end

	return idList
end

function M:updateHeroFavor(heroData)
	local heroId = heroData:getId()
	local heroFavor = heroData:getTacitExp()
	local heroLevel = heroData:getLevel()

	self:_tryInitData()

	local hasChange = false
	local targetData = self._dictFavorData[heroId]

	if targetData then
		if targetData.favor ~= heroFavor or targetData.level ~= heroLevel then
			targetData.favor = heroFavor
			targetData.level = heroLevel

			table.sort(self._arrayFavorData, function(data1, data2)
				if data1.favor <= 0 and data2.favor <= 0 then
					return data1.level > data2.level
				end

				return data1.favor > data2.favor
			end)

			hasChange = true
		end
	else
		for idx, data in ipairs(self._arrayFavorData) do
			if heroFavor <= 0 and data.favor <= 0 and heroLevel > data.level or heroFavor > data.favor then
				local addData = {}

				addData.id = heroId
				addData.favor = heroFavor
				addData.level = heroLevel

				table.insert(self._arrayFavorData, idx, addData)

				self._dictFavorData[addData.id] = addData
				hasChange = true

				break
			end
		end

		if hasChange then
			local removeData = self._arrayFavorData[#self._arrayFavorData]

			self._dictFavorData[removeData.id] = nil

			table.remove(self._arrayFavorData, #self._arrayFavorData)
		end
	end

	if hasChange then
		self:storageData()
	end
end

function M:storageData()
	local idList = {}
	local favorList = {}
	local levelList = {}

	for i, data in ipairs(self._arrayFavorData) do
		table.insert(idList, data.id)
		table.insert(favorList, data.favor)
		table.insert(levelList, data.level)
	end

	local idStr = table.concat(idList, "#")
	local favorStr = table.concat(favorList, "#")
	local levelStr = table.concat(levelList, "#")

	Astral.LocalStorage.Instance:SetString(self:_getHeroIdStorageKey(), idStr)
	Astral.LocalStorage.Instance:SetString(self:_getHeroFavorStorageKey(), favorStr)
	Astral.LocalStorage.Instance:SetString(self:_getHeroLevelStorageKey(), levelStr)
end

function M:_tryInitData(force)
	if #self._arrayFavorData > 0 and not force then
		return
	end

	table.clear(self._arrayFavorData)
	table.clear(self._dictFavorData)

	local ids = Astral.LocalStorage.Instance:GetString(self:_getHeroIdStorageKey(), "")
	local favors = Astral.LocalStorage.Instance:GetString(self:_getHeroFavorStorageKey(), "")
	local levels = Astral.LocalStorage.Instance:GetString(self:_getHeroLevelStorageKey(), "")

	if string.nilorempty(ids) then
		ids = DefaultHeroIds
		favors = DefaultHeroFavors
		levels = DefaultHeroLevels
	end

	local idList = string.split(ids, "#")
	local favorList = string.split(favors, "#")
	local levelList = string.split(levels, "#")

	for i, id in ipairs(idList) do
		local data = {}

		data.id = tonumber(id)
		data.favor = tonumber(favorList[i])
		data.level = tonumber(levelList[i])

		table.insert(self._arrayFavorData, data)

		self._dictFavorData[data.id] = data
	end
end

function M:_getHeroIdStorageKey()
	return string.format("HeroFavorStorage_HeroIdList_%s", self:getLocalPlayerId())
end

function M:_getHeroFavorStorageKey()
	return string.format("HeroFavorStorage_HeroFavorList_%s", self:getLocalPlayerId())
end

function M:_getHeroLevelStorageKey()
	return string.format("HeroFavorStorage_HeroLevelList_%s", self:getLocalPlayerId())
end

function M:setLocalPlayerId()
	local id = tostring(PlayerModel.instance:getId())

	if self:getLocalPlayerId() == id then
		return
	end

	Astral.LocalStorage.Instance:SetString(PlayerIdKey, id)
	self:_tryInitData(true)
	self:storageData()
end

function M:getLocalPlayerId()
	return Astral.LocalStorage.Instance:GetString(PlayerIdKey, "0")
end

function M:_onEnterGameRequestOver(e)
	self:setLocalPlayerId()
end

function M:_onUpdatePlayerInfo(e)
	self:setLocalPlayerId()
end

M.instance = M.New()

return M
