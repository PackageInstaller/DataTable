-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/ItemModel.lua

module("logic.extensions.backpack.model.ItemModel", package.seeall)

local M = class("ItemModel", BaseModel)
local json = require("cjson")

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._isLoaded = false
	self._allDataTS = {}
	self._uuid2Item = {}
	self._prefabItemMap = {}
	self._actIdMap = {}

	local drawingCfgs = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.DrawingItemType)

	for _, cfg in ipairs(drawingCfgs) do
		local list = self:_getItemsByTS(cfg.type, cfg.subType, true)
		local itemData = ItemUtil.createItemData({
			count = 0,
			itemId = cfg.id
		})

		itemData:setUuid(cfg.id)
		itemData:setItemMarkType(EventType.ITEM_BACK_MARK_TYPE)

		self._uuid2Item[-cfg.id] = itemData

		table.insert(list, itemData)
	end
end

function M:parseLoadData(loadBagReply)
	local equipInfo = {}
	local diceInfo = {}

	for _, v in ipairs(loadBagReply.items) do
		self:_addItemByItemNO(v)

		if not string.nilorempty(v.extJson) then
			local bigType = ItemUtil.getItemTypeByItemId(v.itemId)

			if bigType == GameEnum.ItemTypeEnum.EquipItemType then
				local EquipNO = json.decode(v.extJson)

				table.insert(equipInfo, EquipNO)
			elseif bigType == GameEnum.ItemTypeEnum.DiceItem then
				local DiceNO = json.decode(v.extJson)

				table.insert(diceInfo, DiceNO)
			end
		end
	end

	self._isLoaded = true

	EquipController.instance:refreshEquipInfo(equipInfo)
	EquipController.instance:refreshD6Info(diceInfo)
	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_LOADED)
end

function M:isItemloaded()
	return self._isLoaded
end

function M:parseChangeDataPush(itemChangedPush)
	if not self._isLoaded then
		return
	end

	if itemChangedPush.optType == GameEnum.OptionType.Item_Expire then
		for _, ItemChange in ipairs(itemChangedPush.itemChanges) do
			if ItemChange.itemId and ItemChange.itemId ~= 0 then
				GlobalDispatcher:dispatchEvent(EventType.ITEM_EXPIRE_EVENT, ItemChange.uuid)
			end
		end
	end

	for _, ItemChange in ipairs(itemChangedPush.itemChanges) do
		local itemData = self._uuid2Item[ItemChange.uuid]

		if itemData then
			self:_updateItemByItemChange(itemData, ItemChange)
		else
			self:_addItemByItemChange(ItemChange)
		end
	end

	if itemChangedPush.result and #itemChangedPush.result > 0 then
		GlobalDispatcher:dispatchEvent(EventType.GAIN_ITEM_ADD_EVENT, itemChangedPush)
	end

	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ANY, itemChangedPush.optType)
end

function M:getItemsByType(type)
	local res = {}
	local itemsMap = self._allDataTS[type]

	if itemsMap then
		for _, subList in pairs(itemsMap) do
			table.insertto(res, subList)
		end
	end

	return res
end

function M:getItemsByTypeList(typeList)
	local res = {}

	for _, type in ipairs(typeList) do
		local itemsMap = self._allDataTS[type]

		if itemsMap then
			for _, subList in pairs(itemsMap) do
				table.insertto(res, subList)
			end
		end
	end

	return res
end

function M:getItemsByTS(type, subType)
	local res = {}

	if self._allDataTS[type] and self._allDataTS[type][subType] then
		for _, item in ipairs(self._allDataTS[type][subType]) do
			table.insert(res, item)
		end
	end

	return res
end

function M:getItemCountByTS(type, subType)
	local count = 0
	local items = self:_getItemsByTS(type, subType)

	for _, v in ipairs(items) do
		count = count + v:getCount()
	end

	return count
end

function M:getItemsByTypeAndSubTypeList(type, subTypeList)
	if not type or not subTypeList then
		return false
	end

	local res = {}
	local itemsMap = self._allDataTS[type]

	if not itemsMap then
		return res
	end

	for _, subType in ipairs(subTypeList) do
		local subTypeItems = itemsMap[subType]

		if subTypeItems then
			table.insertto(res, subTypeItems)
		end
	end

	return res
end

function M:getItemsCountByTypeAndSubTypeList(type, subTypeList)
	if not type or not subTypeList then
		return 0
	end

	local itemsMap = self._allDataTS[type]

	if not itemsMap then
		return 0
	end

	local count = 0

	for _, subType in ipairs(subTypeList) do
		local subTypeItems = itemsMap[subType]

		if subTypeItems then
			for _, v in ipairs(subTypeItems) do
				count = count + v:getCount()
			end
		end
	end

	return count
end

function M:getItemsByItemId(itemId)
	local res = {}
	local type, subType = ItemUtil.getItemTypeByItemId(itemId)
	local items = self:_getItemsByTS(type, subType)

	for _, v in ipairs(items) do
		if v:getItemId() == itemId then
			table.insert(res, v)
		end
	end

	return res
end

function M:getItemCountByItemId(itemId)
	local count = 0
	local type, subType = ItemUtil.getItemTypeByItemId(itemId)
	local items = self:_getItemsByTS(type, subType)

	for _, v in ipairs(items) do
		if v:getItemId() == itemId then
			count = count + v:getCount()
		end
	end

	return count
end

function M:getSameTypeItemsByItemId(itemId)
	local type, subType = ItemUtil.getItemTypeByItemId(itemId)

	return self:getItemsByTS(type, subType)
end

function M:getItemByHeroId(heroId, subType)
	local items = self:_getItemsByTS(GameEnum.ItemTypeEnum.HeroItemType, subType)

	for _, v in ipairs(items) do
		if v:getItemInfo().heroId == heroId then
			return v:getCount(), v
		end
	end

	return 0, false
end

function M:getItemDataByUuid(uuid)
	return self._uuid2Item[uuid]
end

function M:getHeartAnchorDataByHero(quality)
	local items = self:_getItemsByTS(GameEnum.ItemTypeEnum.HeroItemType, CommEnum.HeroItemSubType.NormalHeartAnchor)

	for _, v in ipairs(items) do
		if v:getQuality() == quality then
			return v:getCount(), v
		end
	end

	return 0, false
end

function M:updatePrefabItemData(prefabId, itemNo)
	self._prefabItemMap[prefabId] = itemNo
end

function M:getPrefabItemData(prefabId)
	return self._prefabItemMap[prefabId]
end

function M:clearAllPrefabItemData()
	table.clear(self._prefabItemMap)
end

function M:getItemByHeroId(heroId, subType)
	local count = 0
	local itemData = false
	local itemDataS = self:getItemsByTS(GameEnum.ItemTypeEnum.HeroItemType, subType) or {}

	for k, v in ipairs(itemDataS) do
		if v:getItemInfo().heroId == heroId then
			count = v:getCount()
			itemData = v

			break
		end
	end

	return count, itemData
end

function M:getHeartAnchorDataByHero(qua)
	local count = 0
	local itemData = false
	local itemDataS = self:getItemsByTS(GameEnum.ItemTypeEnum.HeroItemType, CommEnum.HeroItemSubType.NormalHeartAnchor) or {}

	for k, v in ipairs(itemDataS) do
		if v:getQuality() == qua then
			count = v:getCount()
			itemData = v

			break
		end
	end

	return count, itemData
end

function M:_getItemsByType(type, addIfNil)
	if not type then
		return {}
	end

	if not self._allDataTS[type] and addIfNil then
		self._allDataTS[type] = {}
	end

	return self._allDataTS[type]
end

function M:_getItemsByTS(type, subType, addIfNil)
	local info = self:_getItemsByType(type, addIfNil)

	if addIfNil and not info[subType] then
		info[subType] = {}
	end

	return info and info[subType] or {}
end

function M:_removeItemByTSU(type, subType, uuid)
	self._uuid2Item[uuid] = nil

	local info = self:_getItemsByTS(type, subType)

	for k, v in ipairs(info) do
		if v:getUuid() == uuid then
			table.remove(info, k)

			break
		end
	end
end

function M:_addItemByItemNO(ItemNO)
	local itemData = false
	local type, subType = ItemUtil.getItemTypeByItemId(ItemNO.itemId)
	local list = self:_getItemsByTS(type, subType, true)

	if ItemNO.count < 0 and type ~= GameEnum.ItemTypeEnum.CurrencyItemType then
		return nil
	end

	if type == GameEnum.ItemTypeEnum.DrawingItemType then
		itemData = TableUtil.findByFun(list, ItemNO.itemId, function(item, itemId)
			return item:getItemId() == itemId
		end)

		GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_REMOVED_ONE, itemData)
		itemData:setUuid(ItemNO.uuid)
		itemData:setAddTime(ItemNO.addTime)

		self._uuid2Item[ItemNO.uuid] = itemData
		self._uuid2Item[-ItemNO.itemId] = nil
	else
		if self._uuid2Item[ItemNO.uuid] then
			TableUtil.removeByFun(list, ItemNO.uuid, function(item, removeInfo)
				return item:getUuid() == removeInfo
			end, false)

			self._uuid2Item[ItemNO.uuid] = false
		end

		itemData = ItemUtil.createItemData(ItemNO)

		table.insert(list, itemData)

		self._uuid2Item[ItemNO.uuid] = itemData

		if ItemNO.activityId and ItemNO.activityId ~= 0 then
			self:_addActivityMap(ItemNO.activityId, ItemNO.uuid)
		end
	end

	itemData:setCount(ItemNO.count)
	itemData:setIsLock(ItemNO.isLocked)

	return itemData
end

function M:_addActivityMap(activityId, uuid)
	if self._actIdMap[activityId] then
		local length = #self._actIdMap[activityId]

		self._actIdMap[activityId][length + 1] = uuid
	else
		local uuidTemp = {}

		uuidTemp[1] = uuid
		self._actIdMap[activityId] = uuidTemp
	end
end

function M:_addItemByItemChange(ItemChange)
	local itemData = self:_addItemByItemNO(ItemChange)

	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_ADDED_ONE, itemData)
end

function M:_updateItemByItemChange(itemData, ItemChange)
	itemData:setIsLock(ItemChange.isLocked)
	itemData:setRedPoint(ItemChange.redpoint)

	if ItemChange.count ~= 0 then
		local type, subType = ItemUtil.getItemTypeByItemId(ItemChange.itemId)
		local newCount = itemData:getCount() + ItemChange.count

		if newCount <= 0 and type ~= GameEnum.ItemTypeEnum.CurrencyItemType and type ~= GameEnum.ItemTypeEnum.DrawingItemType then
			self:_removeItemByTSU(type, subType, itemData:getUuid())
			GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_REMOVED_ONE, itemData)
		else
			itemData:setCount(newCount)

			if ItemChange.count > 0 then
				itemData:setAddTime(ItemChange.addTime)
			end

			GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ONE, itemData)
		end
	end
end

function M:setCloseActivityNumber(activityId)
	if self._actIdMap[activityId] then
		for k, v in pairs(self._actIdMap[activityId]) do
			local itemData = self:getItemDataByUuid(v)

			if itemData then
				itemData:setCount(0)
			end
		end
	end
end

M.instance = M.New()

return M
