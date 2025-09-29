-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/perform/FurniturePerformCO.lua

module("logic.extensions.house.model.perform.FurniturePerformCO", package.seeall)

local M = class("FurniturePerformCO")
local kDelimiterJH = "#"
local kDelimiterFH = ";"
local kDelimiterAND = "&"
local kDelimiterOR = "|"
local kDelimiterZKH = "("
local kDelimiterYKH = ")"

function M:ctor(cfg)
	self._cfg = cfg
	self._performQueue = nil
	self._dictText = nil
	self._cacheTriggerUnits = nil
	self._cacheFurniture = nil

	self:_formatData()
end

function M:getId()
	return self._cfg.id
end

function M:getFurnitureId()
	return self._cfg.furnitureId
end

function M:getWaitActionName()
	return self._cfg.waitAction
end

function M:getMatchDatas()
	return self._dictMatchPlayer
end

function M:getTriggerIdxs()
	local idxs = {}

	for idx, data in pairs(self._dictMatchPlayer) do
		table.insert(idxs, idx)
	end

	table.sort(idxs, function(idxA, idxB)
		return idxA < idxB
	end)

	return idxs
end

function M:interruptAI()
	return true
end

function M:canPerform(furniture, units)
	local triggerCount = self:getTriggerCount()
	local triggerIdxs = {}
	local freeCount = 0

	for idx, data in pairs(self._dictMatchPlayer) do
		if furniture.perform:isTriggerFree(idx) then
			freeCount = freeCount + 1

			table.insert(triggerIdxs, idx)
		end
	end

	if freeCount == triggerCount and #units > 0 then
		local dictFilterUnits = self:_filterHeros(triggerIdxs, units)
		local filterCount = 0

		for _, unit in pairs(dictFilterUnits) do
			filterCount = filterCount + 1
		end

		if filterCount > 0 then
			self:cachePerformDatas(furniture, dictFilterUnits)

			return true
		end
	end

	return false
end

function M:_filterHeros(triggerIdxs, units)
	local filterDatas = {}

	for _, idx in ipairs(triggerIdxs) do
		local filterData = {}

		filterData.idx = idx
		filterData.filterUnits = {}

		for _, unit in ipairs(units) do
			if self:isPlayerMatch(idx, unit.heroId) then
				table.insert(filterData.filterUnits, unit)
			end
		end

		table.insert(filterDatas, filterData)
	end

	table.sort(filterDatas, function(dataA, dataB)
		local lenA = #dataA.filterUnits
		local lenB = #dataB.filterUnits

		return lenA < lenB
	end)

	local hasUsedUnits = {}
	local dictFilterUnits = {}

	for _, filterData in ipairs(filterDatas) do
		for _, unit in ipairs(filterData.filterUnits) do
			if not table.indexof(hasUsedUnits, unit.heroId) then
				dictFilterUnits[filterData.idx] = unit

				table.insert(hasUsedUnits, unit.heroId)

				break
			end
		end
	end

	return dictFilterUnits
end

function M:cachePerformDatas(furniture, dictFilterUnits)
	self._cacheFurniture = furniture
	self._cacheTriggerUnits = dictFilterUnits
end

function M:getCachePerformDatas()
	return self._cacheFurniture, self._cacheTriggerUnits
end

function M:isPlayerMatch(idx, heroId)
	local isMatch = false
	local data = self._dictMatchPlayer[idx]

	if not data then
		isMatch = true
	elseif data.type == 1 then
		isMatch = true
	elseif data.type == 2 then
		if table.indexof(data.heroList, heroId) then
			isMatch = true
		end
	elseif data.type == 3 and not table.indexof(data.heroList, heroId) then
		isMatch = true
	end

	return isMatch
end

function M:getTriggerCount()
	return self._cfg.peopleNum
end

function M:getWeight()
	local weights = HouseConfig.instance:getHousePerformWeight()

	return weights[self._cfg.weight] or 1
end

function M:getText(key)
	local text = self._dictText[key]

	if string.nilorempty(text) then
		printWarn(string.format("文本%s为空，表演id：%s", key, self._cfg.id))

		return ""
	end

	return text
end

function M:getPerformQueueClone()
	return clone(self._performQueue)
end

function M:_formatData()
	self:_initPlayerMatch()
	self:_initPerformData()
	self:_initTextList()
end

function M:_initPlayerMatch()
	self._dictMatchPlayer = {}

	if not string.nilorempty(self._cfg.statusCondition) then
		local matchStrList = string.split(self._cfg.statusCondition, kDelimiterOR)

		for _, matchStr in ipairs(matchStrList or {}) do
			local dataList = string.split(matchStr, kDelimiterFH)
			local idx = tonumber(dataList[1])
			local strList = string.split(dataList[2], kDelimiterJH)
			local heroStrList = string.split(strList[2], ",")
			local heroList = {}

			for _, hero in ipairs(heroStrList or {}) do
				table.insert(heroList, tonumber(hero))
			end

			local data = {}

			data.type = tonumber(strList[1])
			data.heroList = heroList
			self._dictMatchPlayer[idx] = data
		end
	end
end

function M:_initPerformData()
	self._performQueue = Queue.create()

	if string.nilorempty(self._cfg.performList) then
		return
	end

	local performStrList = string.split(self._cfg.performList, kDelimiterOR)

	for _, performStr in ipairs(performStrList) do
		local performs = {}
		local dataStrList = string.split(performStr, kDelimiterAND)

		for _, dataStr in ipairs(dataStrList) do
			local performData = {}

			performData.str = dataStr
			performData.arr = string.split(dataStr, kDelimiterFH)

			table.insert(performs, performData)
		end

		self._performQueue:enqueue(performs)
	end
end

function M:_initTextList()
	self._dictText = {}

	local textList = string.split(self._cfg.textList, kDelimiterAND)

	for idx, text in ipairs(textList) do
		local key = string.format("text%s", idx)

		self._dictText[key] = text
	end
end

return M
