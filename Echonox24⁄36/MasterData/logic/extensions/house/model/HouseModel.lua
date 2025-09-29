-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/HouseModel.lua

module("logic.extensions.house.model.HouseModel", package.seeall)

local M = class("HouseModel", BaseModel)

function M:ctor()
	self._defualtScaleNormal = 0
end

function M:onInit()
	self:_resetData()
end

function M:onReset()
	self:_resetData()
end

function M:_resetData()
	self._gravitySwitch = false
	self._onceEnterRoomId = nil
	self._lastHouseMainTabIndex = nil
	self._lastHouseCamContrastAngle = nil
	self._lastRoomMapPosX = nil
	self._lastRoomMapPosY = nil
	self._lastRoomMapScale = nil
	self._lastRoomNormalScale = nil
	self._ringType = nil
	self._clickedBackLogBtn = false
end

function M:getDefaultScaleNormal()
	return self._defualtScaleNormal
end

function M:getScaleNormal()
	if self._lastRoomNormalScale == nil then
		return self:getDefaultScaleNormal()
	end

	return self._lastRoomNormalScale
end

function M:setScaleNormal(scale)
	self._lastRoomNormalScale = scale
end

function M:getDefaultRoomId()
	return 1211
end

function M:getDefaultRingType()
	return 2
end

function M:setGravitySwitch(switch)
	self._gravitySwitch = switch
end

function M:getGravitySwitch()
	return self._gravitySwitch
end

function M:setOnceEnterRoomId(roomId)
	self._onceEnterRoomId = roomId
end

function M:getOnceEnterRoomId()
	return self._onceEnterRoomId
end

function M:getLastHouseModeTabIndex()
	if self._lastHouseMainTabIndex == nil then
		self._lastHouseMainTabIndex = Astral.LocalStorage.Instance:GetInt("lastHouseMainTabIndex", 1)
	end

	return self._lastHouseMainTabIndex
end

function M:setLastHouseModeTabIndex(tabIndex)
	self._lastHouseMainTabIndex = tonumber(tabIndex)

	Astral.LocalStorage.Instance:SetInt("lastHouseMainTabIndex", tabIndex)
	Astral.LocalStorage.Instance:Save()
end

function M:setLastHouseCamContrastAngle(angle)
	self._lastHouseCamContrastAngle = angle
end

function M:getLastHouseCamContrastAngle()
	return self._lastHouseCamContrastAngle
end

function M:getLastRingType()
	return self._ringType or self:getDefaultRingType()
end

function M:setLastRingType(ringTyp)
	self._ringType = ringTyp
end

function M:getLastRoomMapPos()
	if not self._lastRoomMapPosX then
		self._lastRoomMapPosX = 362
		self._lastRoomMapPosY = 230
	end

	return self._lastRoomMapPosX, self._lastRoomMapPosY
end

function M:setLastRoomMapPos(posX, posY)
	self._lastRoomMapPosX = posX
	self._lastRoomMapPosY = posY
end

function M:setLastRoomMapScale(scale)
	self._lastRoomMapScale = scale
end

function M:getLastRoomMapScale(scale)
	return self._lastRoomMapScale
end

function M:_getHousePosStoreKey()
	return string.format("HousePlayerPos#%s", PlayerModel.instance:getId())
end

function M:getCacheMainPlayerPos()
	local resetDefaultPos = true
	local value = Astral.LocalStorage.Instance:GetString(self:_getHousePosStoreKey(), "")

	if not string.nilorempty(value) then
		local arr = string.split(value, "#")
		local arrLength = arr and #arr or 0

		if arrLength == 4 and arr[1] == os.date("%Y-%m-%d") then
			resetDefaultPos = false

			self:recordMainPlayerPos(tonumber(arr[2]), tonumber(arr[3]), tonumber(arr[4]), false)
		end
	end

	if resetDefaultPos then
		local pos = HouseConfig.instance:getHouseConst("MainPlayerInitPos").numValues

		self:recordMainPlayerPos(pos[1], pos[2], pos[3], true)
	end

	return self._cacheMainPlayerPos
end

function M:recordMainPlayerPos(x, y, z, save)
	if self._cacheMainPlayerPos then
		self._cacheMainPlayerPos.x = x
		self._cacheMainPlayerPos.y = y
		self._cacheMainPlayerPos.z = z
	else
		self._cacheMainPlayerPos = Vector3.New(x, y, z)
	end

	if save then
		local key = self:_getHousePosStoreKey()
		local valStr = string.format("%s#%s#%s#%s", os.date("%Y-%m-%d"), x, y, z)

		Astral.LocalStorage.Instance:SetString(key, valStr)
	end
end

function M:setClickedBackLog(isClicked)
	self._clickedBackLogBtn = isClicked
end

function M:getClickedBackLog()
	return self._clickedBackLogBtn
end

M.instance = M.New()

return M
