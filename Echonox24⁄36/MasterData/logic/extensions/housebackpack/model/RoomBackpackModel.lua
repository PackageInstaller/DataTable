-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/model/RoomBackpackModel.lua

module("logic.extensions.housebackpack.model.RoomBackpackModel", package.seeall)

local M = class("RoomBackpackModel", BackpackBaseModel)
local ItemTypeEnum = GameEnum.ItemTypeEnum
local HouseItemSubTypeEnum = GameEnum.HouseItemSubTypeEnum
local RoomBackpackShowType = CommEnum.RoomBackpackShowType
local _cfg = {
	[RoomBackpackShowType.FurnitureShowType] = {
		maxCountInStack = 20,
		recyclable = true,
		stackItem = true,
		showItemInfo = {
			ItemTypeEnum.FurnitureItemType
		},
		filterCfg = RoomFuinitureFilterCfg
	},
	[RoomBackpackShowType.DrawingShowType] = {
		recyclable = false,
		showItemInfo = {
			ItemTypeEnum.DrawingItemType
		},
		filterCfg = RoomDrawingFilterCfg
	},
	[RoomBackpackShowType.BuildMaterialShowType] = {
		recyclable = false,
		showItemInfo = {
			ItemTypeEnum.HouseItemType,
			{
				HouseItemSubTypeEnum.AcceleratingMaterial,
				HouseItemSubTypeEnum.UpgradeMaterial
			}
		},
		filterCfg = BackpackBaseFilterCfg
	},
	[RoomBackpackShowType.TradeMaterialShowType] = {
		recyclable = false,
		showItemInfo = {
			ItemTypeEnum.HouseItemType,
			{
				HouseItemSubTypeEnum.NormalGoods,
				HouseItemSubTypeEnum.PremiumGoods
			}
		},
		filterCfg = RoomTradeFilterCfg
	}
}

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset(true)
end

function M:onLateInit()
	self._houseGoodsBagExtendNum = HouseConfig.instance:getHouseConst("HouseGoodsBagExtendNum").numValues
	self._houseRecycleMaxNum = 20

	local strValue = HouseConfig.instance:getHouseConst("HouseGoodsBagExtendCost").strValue

	self._houseGoodsBagExtendCost = {}

	for code, count in string.gmatch(strValue, "(%d+):(%d+)") do
		table.insert(self._houseGoodsBagExtendCost, {
			code = tonumber(code),
			count = tonumber(count)
		})
	end
end

function M:onReset(addEvent)
	M.super.onReset(self, addEvent)

	self._baseFilter = false
	self._curShowType = RoomBackpackShowType.FurnitureShowType
	self._isRecycling = false
	self._recycleItemsMap = {}
	self._goodsStore = 0
	self._showType2SortType = {}
	self._furnitureFilterList = {}
	self._furnitureSuitFilterList = {}
end

function M:isInRecycling()
	return _cfg[self._curShowType].recyclable and self._isRecycling
end

function M:isStackItem(showType)
	showType = showType or self._curShowType

	return _cfg[showType].stackItem
end

function M:getMaxCountInStack(showType)
	showType = showType or self._curShowType

	return _cfg[showType].maxCountInStack or 999
end

function M:refilter()
	local showType = self:getCurShowType()
	local sortFunc = self:getSortFunc(showType)

	if sortFunc then
		local filter = self:getFilterCfg(showType)

		self._curShowList = filter:doFilter(self._itemsMapBeforeFilter[showType])

		table.sort(self._curShowList, sortFunc)
	else
		M.super.refilter(self)
	end
end

function M:enterRecycle()
	if not _cfg[self._curShowType].recyclable then
		printError("当前显示页签不支持回收操作，请检查")

		return false
	end

	self._isRecycling = true

	table.clear(self._recycleItemsMap)
	self:refilter()

	return true
end

function M:exitRecycle()
	self._isRecycling = false

	table.clear(self._recycleItemsMap)
	self:refilter()
end

function M:clearRecycleItems()
	table.clear(self._recycleItemsMap)
end

function M:getRecycleItems()
	local res = {}
	local allItems = self:getCurShowTypeAllItems()

	for _, item in ipairs(allItems) do
		if self._recycleItemsMap[item:getUuid()] then
			table.insert(res, item)
		end
	end

	return res
end

function M:getRecycleItemsCount()
	return TableUtil.getLen(self._recycleItemsMap)
end

function M:getRecycleItemsUuidMap()
	return self._recycleItemsMap or {}
end

function M:getRecycleUuids()
	local res = {}

	for uuid, isIn in pairs(self._recycleItemsMap) do
		if isIn then
			table.insert(res, uuid)
		end
	end

	return res
end

function M:subRecycleItem(uuid, itemData)
	if self:isStackItem() then
		for _, _uuid in ipairs(itemData:getAllUuid()) do
			self._recycleItemsMap[_uuid] = nil
		end
	else
		self._recycleItemsMap[uuid] = nil
	end
end

function M:setCurShowType(showType)
	if self:isInRecycling() then
		self:exitRecycle()
	end

	M.super.setCurShowType(self, showType)
end

function M:setCurSortType(sortType, ascending)
	self._showType2SortType = self._showType2SortType or {}

	local sortData = self._showType2SortType[self._curShowType] or {}

	sortData.sortType = sortType
	sortData.ascending = ascending
	self._showType2SortType[self._curShowType] = sortData

	local sortFunc = self:getSortFunc(self._curShowType)

	if sortFunc then
		table.sort(self._curShowList, sortFunc)
	end
end

function M:getSortData(showType)
	return self._showType2SortType[showType] or {}
end

function M:isSelected(itemData)
	if self:isInRecycling() then
		return self._recycleItemsMap[itemData:getUuid()]
	else
		local lastSelec = self._selectedItem[self._curShowType]

		return lastSelec and lastSelec:getUuid() == itemData:getUuid()
	end
end

function M:getCurSelecedItem()
	return self._selectedItem[self._curShowType]
end

function M:trySelecedFirstItem()
	local items = self:getCurShownItems() or {}

	if #items == 0 then
		self._selectedItem[self._curShowType] = nil
	else
		self._selectedItem[self._curShowType] = items[1]
	end
end

function M:setCurSelecedItem(itemData)
	if self:isInRecycling() then
		if self._recycleItemsMap[itemData:getUuid()] then
			self._selectedItem[self._curShowType] = itemData

			self:subRecycleItem(itemData:getUuid(), itemData)
		else
			local curSelectedCount = self:getRecycleItemsCount()
			local maxRecycleNum = self:getMaxRecycleNum()

			if self._curShowType == RoomBackpackShowType.FurnitureShowType then
				local isInUse, roomId = itemData:isUsing()

				if isInUse then
					FloatWordMgr.instance:show(lang("tip_recycle_furniture_use_status_limit"))

					return
				end

				if maxRecycleNum < curSelectedCount + itemData:getCount() then
					FloatWordMgr.instance:show(lang("tip_recycle_furniture_count_limit"))

					return
				end
			end

			self._selectedItem[self._curShowType] = itemData

			if self:isStackItem() then
				for _, _uuid in ipairs(itemData:getAllUuid()) do
					self._recycleItemsMap[_uuid] = true
				end
			else
				self._recycleItemsMap[itemData:getUuid()] = true
			end
		end
	else
		self._selectedItem[self._curShowType] = itemData
	end
end

function M:getMaxRecycleNum()
	return self._houseRecycleMaxNum
end

function M:getFilterCfg(showType)
	local cfg = self._filterCfgMap[showType]

	if not cfg then
		cfg = _cfg[showType].filterCfg.New()

		cfg:reset()

		self._filterCfgMap[showType] = cfg
	end

	return cfg
end

function M:setGoodsStore(store)
	self._goodsStore = store

	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_GOODS_STORE_CHANGE)
end

function M:getGoodsStore()
	if self._goodsStore == 0 then
		self._goodsStore = self._houseGoodsBagExtendNum[1]
	end

	return self._goodsStore
end

function M:getIsTradeMaterialFull()
	local count = TableUtil.getLen(self._itemsMapBeforeFilter[RoomBackpackShowType.TradeMaterialShowType])

	return count >= self:getGoodsStore()
end

function M:getCanAddGoodsStore()
	local index = table.indexof(self._houseGoodsBagExtendNum, self._goodsStore)

	if index then
		return index + 1 <= #self._houseGoodsBagExtendNum
	end

	return false
end

function M:getAddGoodsStoreCost()
	local index = table.indexof(self._houseGoodsBagExtendNum, self._goodsStore)

	return self._houseGoodsBagExtendCost[index]
end

function M:setFurnitureSubTypeFilterList(filterList)
	self._furnitureFilterList = filterList
end

function M:getFurnitureSubTypeFilterList()
	return self._furnitureFilterList or {}
end

function M:resetFurnitureSubTypeFilterList()
	self._furnitureFilterList = {}
end

function M:setFurnitureSuitFilterList(themeList)
	self._furnitureSuitFilterList = themeList
end

function M:getFurnitureSuitFilterList()
	return self._furnitureSuitFilterList
end

function M:resetFurnitureSuitFilterList()
	self._furnitureSuitFilterList = {}
end

function M:_iniItemsData()
	for showType, itemInfo in pairs(_cfg) do
		local showItemInfo = itemInfo.showItemInfo
		local bigType, subTypes = showItemInfo[1], showItemInfo[2]

		if subTypes then
			self._itemsMapBeforeFilter[showType] = ItemModel.instance:getItemsByTypeAndSubTypeList(bigType, subTypes) or {}
		else
			self._itemsMapBeforeFilter[showType] = ItemModel.instance:getItemsByType(bigType) or {}
		end
	end
end

function M:getBackpackShowType(item)
	local itemType = item:getType()
	local subType = item:getSubType()

	for showType, info in pairs(_cfg) do
		local cfgTypes = info.showItemInfo

		if cfgTypes[1] == itemType then
			if cfgTypes[2] then
				if table.indexof(cfgTypes[2], subType) then
					return showType
				end
			else
				return showType
			end
		end
	end

	return false
end

function M:getSortFunc(showType)
	if showType == RoomBackpackShowType.FurnitureShowType then
		return self:_furnitureSort()
	end

	return nil
end

function M:_furnitureSort()
	local sortData = self:getSortData(RoomBackpackShowType.FurnitureShowType)

	if sortData.sortType == nil then
		return M._furnitureDefaultSort(false)
	elseif sortData.sortType == CommEnum.RoomBackPackSortType.Atmosphere then
		return M._furnitureAtmoshereSort(sortData.ascending)
	end
end

function M._furnitureDefaultSort(ascending)
	return M._furnitureAtmoshereSort(ascending)
end

function M._furnitureAtmoshereSort(ascending)
	return function(itemA, itemB)
		local valA = itemA:getAtmosphere() or 0
		local valB = itemB:getAtmosphere() or 0

		if valA ~= valB then
			if ascending then
				return valA < valB
			else
				return valB < valA
			end
		end

		local _valA, _typA = itemA:getCfgSpAtmosValAndTyp()
		local _valB, _typB = itemB:getCfgSpAtmosValAndTyp()

		if _valA ~= _valB then
			if ascending then
				return _valA < _valB
			else
				return _valB < _valA
			end
		end

		valA = itemA:getSubType() or 0
		valB = itemB:getSubType() or 0

		if valA ~= valB then
			return valA < valB
		end

		valA = itemA:getItemId() or 0
		valB = itemB:getItemId() or 0

		if valA ~= valB then
			return valA < valB
		end

		valA = itemA:getCount() or 0
		valB = itemB:getCount() or 0

		if valA ~= valB then
			return valB < valA
		end

		return ItemUtil.commonSortFunc(itemA, itemB)
	end
end

M.instance = M.New()

return M
