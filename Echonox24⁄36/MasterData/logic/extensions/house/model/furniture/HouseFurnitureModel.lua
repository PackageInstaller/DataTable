-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/furniture/HouseFurnitureModel.lua

module("logic.extensions.house.model.furniture.HouseFurnitureModel", package.seeall)

local M = class("HouseFurnitureModel", BaseModel)

function M:ctor()
	self._isEdit = nil
	self._editRoomId = nil
	self._dictRoomFurnitures = nil
	self._dictFurnitures = nil
	self._dictBunkFurniture = nil
	self._canSaveFurniture = nil
end

function M:onInit()
	self._dictRoomFurnitures = {}
	self._dictFurnitures = {}
	self._dictBunkFurniture = {}

	self:_resetData()
end

function M:onReset()
	self:_resetData()
end

function M:_resetData()
	self._isEdit = false
	self._editRoomId = false
	self._canSaveFurniture = false

	table.clear(self._dictRoomFurnitures)
	table.clear(self._dictFurnitures)
	table.clear(self._dictBunkFurniture)
end

function M:setEdit(isEdit)
	self._isEdit = isEdit

	self:setCanSaveFurniture(false)
end

function M:isEdit()
	return self._isEdit
end

function M:setEditRoomId(roomId)
	self._editRoomId = roomId
end

function M:getEditRoomId()
	return self._editRoomId
end

function M:setCanSaveFurniture(canSave)
	self._canSaveFurniture = canSave

	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_SAVE_STATE_CHANGE)
end

function M:canSaveFurniture()
	return self._canSaveFurniture
end

function M:updateFurnituresByAgent(NOs)
	local bunkChange = false

	for _, NO in ipairs(NOs or {}) do
		local bunkFurnChange = self:updateFurnitureByAgent(NO)

		bunkChange = bunkChange or bunkFurnChange
	end

	return bunkChange
end

function M:updateFurnitureByAgent(NO)
	local bunkFurnChange = false

	if checknumber(NO.zoneId) > 0 then
		bunkFurnChange = self:updateFurniture(NO)
	else
		bunkFurnChange = self:removeFurniture(tonumber(NO.uuid))
	end

	return bunkFurnChange
end

function M:updateFurniture(NO)
	local uuid = tonumber(NO.uuid)
	local roomId = NO.zoneId
	local mo = self._dictFurnitures[uuid]

	if not mo then
		mo = HouseFurnitureMO.New()
		self._dictFurnitures[uuid] = mo

		if not self._dictRoomFurnitures[roomId] then
			self._dictRoomFurnitures[roomId] = {}
		end

		table.insert(self._dictRoomFurnitures[roomId], mo)
	end

	mo:setDataByAgent(NO)

	local bunkFurnChange = false

	if mo:hasBunk() then
		self._dictBunkFurniture[mo:getUUId()] = mo
		bunkFurnChange = true
	else
		if self._dictBunkFurniture[mo:getUUId()] then
			bunkFurnChange = true
		end

		self._dictBunkFurniture[mo:getUUId()] = nil
	end

	return bunkFurnChange
end

function M:removeFurniture(uuid)
	uuid = tonumber(uuid)

	local bunkFurnChange = false
	local removeMO = self._dictFurnitures[uuid]

	if removeMO then
		if self._dictBunkFurniture[uuid] then
			bunkFurnChange = true
		end

		self._dictFurnitures[uuid] = nil
		self._dictBunkFurniture[uuid] = nil

		local roomId = removeMO:getRoomId()
		local removeIdx = table.indexof(self._dictRoomFurnitures[roomId], removeMO)

		table.remove(self._dictRoomFurnitures[roomId], removeIdx)
	end

	return bunkFurnChange
end

function M:getRoomFurnitures(roomId)
	local list = self._dictRoomFurnitures[roomId]

	return list or {}
end

function M:getFurniture(uuid)
	uuid = tonumber(uuid)

	return self._dictFurnitures[uuid]
end

function M:getIsFurnitureInUse(uuid)
	uuid = tonumber(uuid)

	local furnitureMO = self._dictFurnitures[uuid]

	if not furnitureMO then
		return false
	else
		local roomId = furnitureMO:getRoomId()

		return roomId > 0, roomId
	end
end

function M:getAllBunkInfo(roomId)
	local bunkList = {}
	local list = self:getRoomFurnitures(roomId)

	for _, furnitureMO in ipairs(list) do
		if furnitureMO:hasBunk() then
			table.insertto(bunkList, furnitureMO:getBunks())
		end
	end

	return bunkList
end

function M:getHerosWithBunk()
	local heroList = {}

	for _, furnitureMO in pairs(self._dictBunkFurniture) do
		local bunkList = furnitureMO:getBunks()

		for _, bunk in ipairs(bunkList) do
			if bunk.heroId > 0 then
				table.insert(heroList, bunk.heroId)
			end
		end
	end

	return heroList
end

M.instance = M.New()

return M
