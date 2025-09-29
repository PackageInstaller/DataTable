-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/model/GainItemModel.lua

module("logic.extensions.gainitem.model.GainItemModel", package.seeall)

local GAIN_ITEM_ID_SORT = "GainItemIdSort"
local GAIN_ITEM_TYPE_SORT = "GainItemTypeSort"
local DEFAULT_INDEX = 99999999
local M = class("GainItemModel", BaseModel)

function M:ctor()
	self._idSortMap = nil
	self._typeSortMap = nil
end

function M:onInit()
	return
end

function M:onReset()
	self._cacheGainItem = nil
	self._cacheGainHeroIds = nil
end

function M:getIndexById(id)
	if not self._idSortMap then
		self._idSortMap = TableUtil.arrayToMap(ConstConfig.instance:getNumValuesByKey(GAIN_ITEM_ID_SORT))
	end

	return self._idSortMap[id]
end

function M:getIndexByType(type)
	if not self._typeSortMap then
		self._typeSortMap = TableUtil.arrayToMap(ConstConfig.instance:getNumValuesByKey(GAIN_ITEM_TYPE_SORT))
	end

	return self._typeSortMap[type]
end

function M.sortItemCompare(itemA, itemB)
	local flag = false
	local aValue = itemA:getItemId()
	local bValue = itemB:getItemId()
	local aIndex = M.instance:getIndexById(aValue) or DEFAULT_INDEX
	local bIndex = M.instance:getIndexById(bValue) or DEFAULT_INDEX

	if aIndex == bIndex then
		aValue = itemA:getType()
		bValue = itemB:getType()
		aIndex = M.instance:getIndexByType(aValue) or DEFAULT_INDEX
		bIndex = M.instance:getIndexByType(bValue) or DEFAULT_INDEX

		if aIndex == bIndex then
			aValue = itemA:getQuality()
			bValue = itemB:getQuality()

			if aValue == bValue then
				flag = itemA:getItemId() < itemB:getItemId()
			else
				flag = aValue < bValue
			end
		else
			flag = aIndex < bIndex
		end
	else
		flag = aIndex < bIndex
	end

	return flag
end

function M:handleItemAddEvent(dataLst, heroIds)
	if not self._cacheGainItem then
		self._cacheGainItem = {}
	end

	for index, value in ipairs(dataLst or {}) do
		table.insert(self._cacheGainItem, value)
	end

	self._cacheGainHeroIds = heroIds

	GlobalDispatcher:dispatchEvent(EventType.GAIN_ITEM_ADD_ITEM_CHANGE)
end

function M:handleGainItemViewClose()
	self._cacheGainItem = nil
	self._cacheGainHeroIds = nil
end

function M:getGainItemAddEventCacheItemLst()
	return self._cacheGainItem or {}
end

function M:getGainHerosAddEventCacheItemLst()
	return self._cacheGainHeroIds or {}
end

M.instance = M.New()

return M
