-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/model/RoomFuinitureFilterCfg.lua

module("logic.extensions.housebackpack.model.RoomFuinitureFilterCfg", package.seeall)

local M = class("RoomFuinitureFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._filterType = nil
end

function M:reset()
	self._filterType = CommEnum.RoomFurnitureFilterType.All
end

function M:setFilterType(filterType)
	self._filterType = filterType
end

function M:getFilterType()
	return self._filterType
end

function M:getIsStack()
	return RoomBackpackModel.instance:isStackItem(CommEnum.RoomBackpackShowType.FurnitureShowType)
end

function M:getMaxCountInStack()
	return RoomBackpackModel.instance:getMaxCountInStack(CommEnum.RoomBackpackShowType.FurnitureShowType)
end

function M:doFilter(list)
	local result

	result = self:_usingFilter(list)
	result = self:_subTypeFilter(result)
	result = self:_suitFilter(result)

	return result
end

function M:_usingFilter(list)
	local filterType = self:getFilterType()
	local isStack = self:getIsStack()
	local res = {}
	local resMap = {}
	local resMapUsing = {}
	local All = CommEnum.RoomFurnitureFilterType.All
	local NotUsing = CommEnum.RoomFurnitureFilterType.NotUsing
	local Using = CommEnum.RoomFurnitureFilterType.Using

	for _, itemData in ipairs(list) do
		local isInUse = HouseFurnitureModel.instance:getIsFurnitureInUse(itemData:getUuid())

		if itemData:getIsOnline() and (filterType == All or filterType == NotUsing and not isInUse or filterType == Using and isInUse) then
			if isStack then
				local furnitureId = itemData:getItemId()
				local furnitureUuid = tonumber(itemData:getUuid())

				if filterType == NotUsing then
					self:_addStackDataToMap(furnitureId, furnitureUuid, resMap)
				elseif filterType == Using then
					self:_addStackDataToMap(furnitureId, furnitureUuid, resMapUsing)
				elseif isInUse then
					self:_addStackDataToMap(furnitureId, furnitureUuid, resMapUsing)
				else
					self:_addStackDataToMap(furnitureId, furnitureUuid, resMap)
				end
			else
				table.insert(res, itemData)
			end
		end
	end

	if isStack then
		if filterType == NotUsing then
			self:_addMapToLst(res, resMap)
		elseif filterType == Using then
			self:_addMapToLst(res, resMapUsing)
		else
			self:_addMapToLst(res, resMap)
			self:_addMapToLst(res, resMapUsing)
		end
	end

	return res
end

function M:_subTypeFilter(dataList)
	local filterList = RoomBackpackModel.instance:getFurnitureSubTypeFilterList()

	if #filterList == 0 then
		return dataList
	end

	for i = #dataList, 1, -1 do
		if not table.indexof(filterList, dataList[i]:getSubType()) then
			table.remove(dataList, i)
		end
	end

	return dataList
end

function M:_suitFilter(dataList)
	local themeList = RoomBackpackModel.instance:getFurnitureSuitFilterList()

	if #themeList == 0 then
		return dataList
	end

	local map = TableUtil.tableToMap(themeList)

	for i = #dataList, 1, -1 do
		if map[dataList[i]:getTheme()] == nil then
			table.remove(dataList, i)
		end
	end

	return dataList
end

function M:_addStackDataToMap(itemId, itemUuid, map)
	if not map[itemId] then
		map[itemId] = FurnitureStackData.New({
			count = 1,
			itemId = itemId
		})
	end

	map[itemId]:addFurniture(itemUuid)
end

function M:_addMapToLst(lst, map)
	local countMax = self:getMaxCountInStack()

	for _, data in pairs(map or {}) do
		local count = data:getCount()

		if countMax < count then
			local tmpLst = {}

			for i = 1, count do
				if countMax <= #tmpLst then
					local newData = self:_createStackData(data:getItemId(), tmpLst)

					table.insert(lst, newData)

					tmpLst = {}
				end

				table.insert(tmpLst, data:getOneUuidByIndex(i))
			end

			if #tmpLst > 0 then
				local newData = self:_createStackData(data:getItemId(), tmpLst)

				table.insert(lst, newData)

				tmpLst = {}
			end
		else
			table.insert(lst, data)
		end
	end
end

function M:_createStackData(itemId, uuidLst)
	local newData = FurnitureStackData.New({
		count = 1,
		itemId = itemId
	})

	for _, _uuid in ipairs(uuidLst) do
		newData:addFurniture(_uuid)
	end

	return newData
end

function M:filterOneItem(itemData)
	local All = CommEnum.RoomFurnitureFilterType.All
	local NotUsing = CommEnum.RoomFurnitureFilterType.NotUsing
	local Using = CommEnum.RoomFurnitureFilterType.Using
	local isInUse = HouseFurnitureModel.instance:getIsFurnitureInUse(itemData:getUuid())
	local filterType = self:getFilterType()

	return itemData:getIsOnline() and (filterType == All or filterType == NotUsing and not isInUse or filterType == Using and isInUse)
end

return M
