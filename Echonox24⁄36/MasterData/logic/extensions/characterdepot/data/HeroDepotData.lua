-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/data/HeroDepotData.lua

module("logic.extensions.characterdepot.data.HeroDepotData", package.seeall)

local M = class("HeroDepotData")

function M:ctor()
	self._allData = {}
end

function M:getHeroDataList()
	return self._allData
end

function M:getHeroCount()
	return #self._allData
end

function M:clearAllData()
	table.clear(self._allData)
end

function M:addHeroData(heroData)
	table.insert(self._allData, heroData)
end

function M:updateHeroData(msgHeroData)
	local heroData = self:getHeroDataById(msgHeroData.id)

	heroData:updateHeroData(msgHeroData)
end

function M:getHeroDataById(id)
	for k, v in ipairs(self._allData) do
		if v:getId() == id then
			return v
		end
	end

	return false
end

function M:getHeroDataByIndex(index)
	return self._allData[index]
end

function M:removeHeroDataById(id)
	for k, v in ipairs(self._allData) do
		if v:getId() == id then
			table.remove(self._allData, k)

			break
		end
	end
end

function M:getShowDataList()
	self._showDataListMap = BaseListModel.New()

	for k, v in ipairs(self._allData) do
		self._showDataListMap:addMo(v)
	end

	return self._showDataListMap
end

function M:sortShowData(sortFunc)
	self._showDataListMap:sortMoList(sortFunc)
end

function M:removeShowDataById(id)
	local findHeroData, dataModel = false

	for k, v in ipairs(self._showDataListMap) do
		findHeroData = v:getMoById(id)

		if findHeroData then
			dataModel = v

			break
		end
	end

	if findHeroData then
		dataModel:removeMoById(uuid)
	end
end

return M
