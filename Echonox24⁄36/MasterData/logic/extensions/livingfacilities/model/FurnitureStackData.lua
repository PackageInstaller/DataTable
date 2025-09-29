-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/FurnitureStackData.lua

module("logic.extensions.livingfacilities.model.FurnitureStackData", package.seeall)

local M = class("FurnitureStackData", FurnitureData)

function M:ctor(params)
	M.super.ctor(self, params)

	self._uuidList = {}
end

function M:setCount(count)
	return
end

function M:getCount()
	return #self._uuidList
end

function M:getUuid()
	return self:getOneFurniture()
end

function M:getDecomposeReward()
	if not self._decomposeReward then
		self._decomposeReward = {}

		local decomposeRewardStr = self._itemInfo.decomposeReward

		for code, count in string.gmatch(decomposeRewardStr, "(%d+):(%d+)") do
			table.insert(self._decomposeReward, {
				code = tonumber(code),
				count = tonumber(count)
			})
		end
	end

	local data = self._decomposeReward[1]

	if data then
		return {
			code = data.code,
			count = data.count * self:getCount()
		}
	end

	return {}
end

function M:addFurniture(uuid)
	if uuid > 0 and not table.indexof(self._uuidList, uuid) then
		table.insert(self._uuidList, uuid)
		self:_sortFurniture()
	end
end

function M:removeFurniture(uuid)
	local idx = table.indexof(self._uuidList, uuid)

	if idx then
		table.remove(self._uuidList, idx)
	end
end

function M:getAllFurniture()
	return self._uuidList
end

function M:getOneFurniture()
	return self._uuidList[1]
end

function M:getAllUuid()
	return self._uuidList
end

function M:getOneUuidByIndex(index)
	return self._uuidList[index]
end

function M:isUsing()
	local _uuid = self:getOneFurniture()
	local isInUse, roomId = HouseFurnitureModel.instance:getIsFurnitureInUse(_uuid)

	return isInUse, roomId
end

function M:_sortFurniture()
	table.sort(self._uuidList, function(uidA, uidB)
		local moA = HouseFurnitureModel.instance:getFurniture(uidA)
		local moB = HouseFurnitureModel.instance:getFurniture(uidB)
		local hasBunkA = false

		if moA then
			hasBunkA = moA:hasBunk()
		end

		local hasBunkB = false

		if moB then
			hasBunkB = moB:hasBunk()
		end

		if hasBunkA and not hasBunkB then
			return true
		elseif hasBunkB and not hasBunkA then
			return false
		end

		return uidA < uidB
	end)
end

return M
