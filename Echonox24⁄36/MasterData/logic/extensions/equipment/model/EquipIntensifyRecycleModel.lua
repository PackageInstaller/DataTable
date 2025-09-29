-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/EquipIntensifyRecycleModel.lua

module("logic.extensions.equipment.model.EquipIntensifyRecycleModel", package.seeall)

local M = class("EquipIntensifyRecycleModel", BaseModel)
local BackpackShowType = CommEnum.MainBackpackShowType
local ItemTypeEnum = GameEnum.ItemTypeEnum
local QuickSelectType = CommEnum.MainBackpackQuickRecycleType

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._filterCfg = EquipIntensifyRecycleFilterCfg.New()
	self._allEquips = false
	self._recycleItemsMap = false
	self._previewItem = false
end

function M:clear()
	self._allEquips = false
	self._recycleItemsMap = false
	self._previewItem = false
end

function M:initRecycleEquips()
	self._recycleItemsMap = {}

	local items = ItemModel.instance:getItemsByType(ItemTypeEnum.EquipItemType) or {}

	if #items > 0 then
		self._allEquips = self._filterCfg:doFilter(items)

		ItemUtil.sortItemList(self._allEquips, BackpackShowType.EquipShowType, true)

		self._previewItem = self._allEquips[1]
	elseif enableErrorLog then
		printError("回收列表为空，请检查")
	end

	return self._allEquips
end

function M:getPreviewItem()
	return self._previewItem
end

function M:setPreviewItem(item)
	self._previewItem = item
end

function M:getRecycleItems(res)
	table.clear(res)

	local allItems = self._allEquips

	for _, item in ipairs(allItems) do
		if self._recycleItemsMap[item:getUuid()] then
			table.insert(res, item)
		end
	end
end

function M:getRecycleUUids()
	local res = {}

	for uuid, isIn in pairs(self._recycleItemsMap) do
		if isIn and ItemModel.instance:getItemDataByUuid(uuid) then
			table.insert(res, uuid)
		end
	end

	return res
end

function M:isChooseAnyRecycleItem()
	for _, isInRecycling in pairs(self._recycleItemsMap) do
		if isInRecycling then
			return true
		end
	end

	return false
end

function M:calEquipRecycleCount(equip, decomposedItemId)
	local quality = equip:getQuality()
	local exp = equip:getCurTotalExp()
	local lvUpItemInfo = EquipmentConfig.instance:getEquipExpItemInfo(decomposedItemId)

	if not lvUpItemInfo then
		return 0
	end

	local expPerLvItem = lvUpItemInfo.exp
	local equipCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentQuality, quality)
	local rate = equipCo.lossRate / 1000
	local count = exp * rate / expPerLvItem

	return math.floor(count)
end

function M:calRecycleGetItems(useItems, res)
	local itemsMap = {}

	table.clear(res)

	for _, mo in ipairs(useItems) do
		local id, count = mo:getDecomposedItem()

		itemsMap[id] = itemsMap[id] + count

		if not itemsMap[id] then
			itemsMap[id] = count
		else
			itemsMap[id] = itemsMap[id] + count
		end

		local decomposedItemId = EquipmentConfig.instance:getConstNum(EquipEnum.EquipExtraDecomposedItem)
		local extralCount = self:calEquipRecycleCount(mo, decomposedItemId)

		if extralCount > 0 then
			if not itemsMap[decomposedItemId] then
				itemsMap[decomposedItemId] = count
			else
				itemsMap[decomposedItemId] = itemsMap[decomposedItemId] + count
			end
		end
	end

	for id, count in pairs(itemsMap) do
		local itemId = tonumber(id)
		local itemData = ItemUtil.createItemData({
			itemId = itemId,
			count = count
		})

		table.insert(res, itemData)
	end

	table.sort(res, ItemUtil.commonSortFunc)
end

function M:addRecycleItem(uuid)
	self._recycleItemsMap[uuid] = true
end

function M:subRecycleItem(uuid)
	self._recycleItemsMap[uuid] = false
end

function M:isSelected(itemData)
	return self._recycleItemsMap[itemData:getUuid()]
end

function M:isPreviewEquip(itemData)
	return self._previewItem and self._previewItem:getUuid() == itemData:getUuid()
end

function M:addRecycleQuickItems(quickTypes)
	for uuid, isInRecycling in pairs(self._recycleItemsMap) do
		if isInRecycling then
			local item = ItemModel.instance:getItemDataByUuid(uuid)

			if self:_isQuickRemoveItem(item) then
				self._recycleItemsMap[uuid] = false
			end
		end
	end

	local canAddCount = self:getRecycleCanAddCount()

	if canAddCount > 0 then
		local allItems = {}

		for _, item in ipairs(self._allEquips) do
			table.insert(allItems, item)
		end

		BackpackUtil.sortQuickRecycleItems(allItems, false)

		for _, item in ipairs(allItems) do
			if canAddCount < 1 then
				return
			end

			local isAdd = self:_isQuickSelectItem(item, quickTypes)

			if isAdd then
				canAddCount = canAddCount - 1
				self._recycleItemsMap[item:getUuid()] = true
			end
		end
	end
end

function M:getRecycleCanAddCount()
	local hasNum = 0

	for _, isInRecycling in pairs(self._recycleItemsMap) do
		if isInRecycling then
			hasNum = hasNum + 1
		end
	end

	local limit = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.RecycleLimit)

	return limit - hasNum
end

function M:getQuickSelectTypes()
	local hasBlue = false
	local hasGreen = false

	for _, item in ipairs(self._allEquips) do
		hasBlue = hasBlue or item:getQuality() == GameEnum.QualityEnum.B
		hasGreen = hasGreen or item:getQuality() == GameEnum.QualityEnum.C

		if hasBlue and hasGreen then
			break
		end
	end

	return {
		hasBlue,
		hasGreen
	}
end

function M:_isQuickSelectItem(item, quickTypes)
	if item:getIsLock() then
		return false
	end

	if item:getType() == GameEnum.ItemTypeEnum.EquipItemType and item:getIsEquip() then
		return false
	end

	local qa = item:getQuality()

	return quickTypes[QuickSelectType.Blue] and qa == GameEnum.QualityEnum.B or quickTypes[QuickSelectType.Green] and qa == GameEnum.QualityEnum.C
end

function M:_isQuickRemoveItem(item)
	local qa = item:getQuality()

	return qa == GameEnum.QualityEnum.B or qa == GameEnum.QualityEnum.C
end

M.instance = M.New()

return M
