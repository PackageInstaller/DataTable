-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/model/ChamberSlotMO.lua

module("logic.extensions.chamber.model.ChamberSlotMO", package.seeall)

local M = class("ChamberSlotMO")

function M:ctor(idx)
	self._idx = idx
	self._itemUUID = nil
	self._count = nil
	self._entrys = nil
end

function M:clear()
	self._itemUUID = nil
end

function M:getIdx()
	return self._idx
end

function M:getItemUUID()
	return self._itemUUID
end

function M:setItemUUID(uuid)
	self._itemUUID = tonumber(uuid)

	if self._itemUUID then
		self._entrys = ChamberConfig.instance:getItemEntrysByUuid(self._itemUUID, true, self._count)
	else
		self._entrys = nil
		self._count = 0
	end
end

function M:isLock()
	local lv = ChamberConfig.instance:getSlotUnlockLv(self._idx)

	return lv > PlayerModel.instance:getLevel()
end

function M:setCount(count)
	self._count = count

	if self._entrys then
		for _, CO in ipairs(self._entrys) do
			CO:setCount(count)
		end
	end
end

function M:getCount()
	return checknumber(self._count)
end

function M:getEntrys()
	return self._entrys
end

return M
