-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/MainBackpackModel.lua

module("logic.extensions.backpack.model.MainBackpackModel", package.seeall)

local M = class("MainBackpackModel", BackpackBaseModel)
local BackpackShowType = CommEnum.MainBackpackShowType
local ItemTypeEnum = GameEnum.ItemTypeEnum
local QuickSelectType = CommEnum.MainBackpackQuickRecycleType
local _cfg = {
	[BackpackShowType.PropShowType] = {
		recyclable = false,
		showItemTypes = {
			ItemTypeEnum.PropItemType,
			ItemTypeEnum.TreasureBox,
			{
				ItemTypeEnum.PuzzlePiecesItem,
				GameEnum.PuzzlePiecesSubTypeEnum.Item
			}
		},
		filterCfg = BackpackPropFilterCfg,
		showItemFilterTypes = {
			[ItemTypeEnum.PropItemType] = {
				[GameEnum.PropSubTypeEnum.EchoCardPack] = true
			}
		}
	},
	[BackpackShowType.CurrencyShowType] = {
		recyclable = false,
		showItemTypes = ItemTypeEnum.CurrencyItemType,
		filterCfg = BackpackBaseFilterCfg
	},
	[BackpackShowType.EquipShowType] = {
		recyclable = true,
		showItemTypes = ItemTypeEnum.EquipItemType,
		filterCfg = BackpackEquipFilterCfg,
		defaultSortFun = BackpackUtil.LvDownSort
	},
	[BackpackShowType.D6ShowType] = {
		recyclable = true,
		showItemTypes = ItemTypeEnum.DiceItem,
		filterCfg = BackpackD6FilterCfg,
		defaultSortFun = BackpackUtil.QaDownSort
	},
	[BackpackShowType.EchoShowType] = {
		recyclable = true,
		showItemTypes = {
			ItemTypeEnum.EchoItemType,
			{
				ItemTypeEnum.PuzzlePiecesItem,
				GameEnum.PuzzlePiecesSubTypeEnum.Echo
			}
		},
		filterCfg = BackpackEchoFilterCfg,
		defaultSortFun = BackpackUtil.QaDownSort
	},
	[BackpackShowType.CardChipShowType] = {
		recyclable = false,
		showItemTypes = ItemTypeEnum.HeroItemType,
		filterCfg = BackpackBaseFilterCfg
	},
	[BackpackShowType.EchoCardPackType] = {
		recyclable = false,
		showItemTypes = {
			{
				ItemTypeEnum.PropItemType,
				GameEnum.PropSubTypeEnum.EchoCardPack
			}
		},
		filterCfg = BackpackBaseFilterCfg,
		defaultSortFun = BackpackUtil.QaDownSort
	}
}

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset(true)
end

function M:onReset(addEvent)
	M.super.onReset(self, addEvent)

	self._baseFilter = BackpackBaseFilterCfg.New()
	self._curShowType = BackpackShowType.PropShowType
	self._isRecycling = false
	self._recycleItemsMap = {}
	self._sortDatas = {}
	self._equipSuitMo = nil
	self._inRecycleList = nil
end

function M:isInRecycling()
	return _cfg[self._curShowType].recyclable and self._isRecycling
end

function M:enterRecycle()
	if not _cfg[self._curShowType].recyclable then
		printError("当前显示页签不支持回收操作，请检查")

		return
	end

	self._isRecycling = true

	self:refilter()
end

function M:isEmpty()
	local allitem = self._itemsMapBeforeFilter[self._curShowType] or {}

	return #allitem == 0
end

function M:exitRecycle()
	self._isRecycling = false

	table.clear(self._recycleItemsMap)
	self:refilter()
end

function M:isRecycleSelected(itemData)
	return self:isInRecycling() and self._recycleItemsMap[itemData:getUuid()]
end

function M:isPreviewEquip(itemData)
	local lastSelec = self._selectedItem[self._curShowType]

	return lastSelec and lastSelec:getUuid() == itemData:getUuid()
end

function M:isRecycleItem(itemUuid)
	return self:isInRecycling() and self._recycleItemsMap[itemUuid]
end

function M:getCurSelecedItem()
	return self._selectedItem[self._curShowType]
end

function M:setInRecycleListView(status)
	self._inRecycleList = status
end

function M:canJump(showTypeInfo, itemIdInfo)
	if not showTypeInfo then
		return false, false
	end

	local showTypeIndex = tonumber(showTypeInfo)

	if not showTypeIndex then
		return false, false
	end

	local index2ShowType = {
		CommEnum.MainBackpackShowType.PropShowType,
		CommEnum.MainBackpackShowType.CurrencyShowType,
		CommEnum.MainBackpackShowType.EquipShowType,
		CommEnum.MainBackpackShowType.D6ShowType,
		CommEnum.MainBackpackShowType.EchoShowType,
		CommEnum.MainBackpackShowType.CardChipShowType,
		CommEnum.MainBackpackShowType.EchoCardPackType
	}
	local showType = index2ShowType[showTypeIndex] or false

	if not showType then
		return false, false
	end

	local canJump = true
	local jumpItem = false

	if itemIdInfo then
		local itemId = tonumber(itemIdInfo)

		if itemId then
			canJump = false

			local filter = self:getFilterCfg(showType)
			local jumpShowList = filter:doFilter(self._itemsMapBeforeFilter[showType])

			if jumpShowList then
				for _, itemData in pairs(jumpShowList) do
					if itemData:getItemId() == itemId then
						jumpItem = itemData
						canJump = true

						break
					end
				end
			end
		end
	end

	if canJump then
		return showType, jumpItem
	end

	return false, false
end

function M:setJumpItem(showType, jumpItem)
	self._curShowType = showType
	self._selectedItem[showType] = jumpItem
end

function M:setCurSelecedItem(itemData)
	self._selectedItem[self._curShowType] = itemData

	local reason = CommEnum.MainBackpackRefreshType.SelecItem
	local isShowTips = false

	if self:isInRecycling() then
		local itemUuid = itemData:getUuid()

		if (self._curShowType == BackpackShowType.EquipShowType or self._curShowType == BackpackShowType.EchoShowType) and itemData:getIsEquip() then
			ToolTipsMgr.showCharacterTopToast(lang(BackpackUtil.getRecycleTips(self._curShowType, 1)), CommEnum.CharacterTopToastIcon.Fail, 1)
		elseif itemData:getIsLock() then
			ToolTipsMgr.showCharacterTopToast(lang(BackpackUtil.getRecycleTips(self._curShowType, 2)), CommEnum.CharacterTopToastIcon.Fail, 1)
		else
			local isInRecycling = self._recycleItemsMap[itemUuid]

			if isInRecycling and self._inRecycleList then
				isShowTips = true
			elseif self:getRecycleCanAddCount() > 0 then
				self._recycleItemsMap[itemUuid] = true
				reason = CommEnum.MainBackpackRefreshType.RecycleChanged
			else
				FloatWordMgr.instance:show(lang("tip_equip_recycle_count_limit"))
			end
		end
	end

	return reason, isShowTips
end

function M:getRecycleTips()
	return
end

function M:subRecycleItem(itemData)
	self._selectedItem[self._curShowType] = itemData
	self._recycleItemsMap[itemData:getUuid()] = false
end

function M:addRecycleQuickItems(quickTypes)
	local canAddCount = self:getRecycleCanAddCount()

	if canAddCount > 0 then
		local allItems = self:getCurShownItems()

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

function M:removeRecycleQuickItems(quickTypes)
	local allItems = self:getCurShownItems()

	for _, item in ipairs(allItems) do
		local qa = item:getQuality()

		if quickTypes[qa] then
			self._recycleItemsMap[item:getUuid()] = false
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

function M:getRecycleItems(res)
	table.clear(res)

	local allItems = self:getCurShowTypeAllItems()

	for _, item in ipairs(allItems) do
		if self._recycleItemsMap[item:getUuid()] then
			table.insert(res, item)
		end
	end
end

function M:isChooseAnyRecycleItem()
	for _, isInRecycling in pairs(self._recycleItemsMap) do
		if isInRecycling then
			return true
		end
	end

	return false
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

function M:setCurShowType(showType)
	if self:isInRecycling() then
		self:exitRecycle()
	end

	M.super.setCurShowType(self, showType)
end

function M:getCurSortData()
	return self._sortDatas[self._curShowType]
end

function M:resort(BackpackItemSortData)
	self._sortDatas[self._curShowType] = BackpackItemSortData

	self:_resort()
end

function M:getEquipSuitMo()
	return self._equipSuitMo
end

function M:onEquipSuitChanged(suitMo, dices)
	if self._curShowType ~= BackpackShowType.EquipShowType then
		return
	end

	self._equipSuitMo = suitMo

	local suitId = suitMo and suitMo:getId() or CommEnum.CommonAll
	local diceIds = {}

	for k, v in pairs(dices) do
		local id = v:getAttrId()

		diceIds[id] = id
	end

	local filter = self:getCurFilterCfg()

	filter:setSuitId(suitId)
	filter:setDiceIds(diceIds)
	self:refilter()
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

function M:refilter()
	M.super.refilter(self)

	if self._curShowType == BackpackShowType.EquipShowType or self._curShowType == BackpackShowType.D6ShowType or self._curShowType == BackpackShowType.EchoShowType then
		BackpackUtil.setOriginOrder(self._curShowList)
	end

	self:_resort()
end

function M:onRecycleReplied()
	table.clear(self._recycleItemsMap)
	self:refilter()

	self._itemModelChanged = false
end

function M:clearOperate()
	for showType, _ in pairs(_cfg) do
		if self._filterCfgMap[showType] then
			self._filterCfgMap[showType]:reset()
		end

		self._sortDatas[showType] = nil
	end

	self:exitRecycle()

	self._equipSuitMo = nil
	self._curShowList = {}
	self._selectedItem = {}
end

function M:isPropGiftRed()
	local isRed = false
	local showItems = self._itemsMapBeforeFilter[CommEnum.MainBackpackShowType.PropShowType]

	if showItems then
		for _, item in pairs(showItems) do
			if item:getRedPointIsUseableGiftBox() then
				isRed = true

				break
			end

			if item:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem and item:isShowRedPoint() then
				isRed = true

				break
			end
		end
	elseif enableErrorLog then
		printError("道具数据为空")
	end

	return isRed
end

function M:isEchoNewRed()
	local isRed = false

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, false) then
		local showItems = self._itemsMapBeforeFilter[CommEnum.MainBackpackShowType.EchoShowType]

		if showItems then
			for _, item in pairs(showItems) do
				if item:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem and item:isShowRedPoint() then
					isRed = true

					break
				end
			end
		elseif enableErrorLog then
			printError("残响数据为空")
		end
	end

	return isRed
end

function M:calRecycleGetItems(useItems, res)
	local itemsMap = {}

	table.clear(res)

	local isEquipRecycle = self._curShowType == BackpackShowType.EquipShowType

	for _, mo in ipairs(useItems) do
		local id, count = mo:getDecomposedItem()

		if isEquipRecycle then
			local list = EquipUtil.calRecycleGetItems(mo)

			for k, v in pairs(list) do
				if not itemsMap[k] then
					itemsMap[k] = v
				else
					itemsMap[k] = itemsMap[k] + v
				end
			end
		elseif not itemsMap[id] then
			itemsMap[id] = count
		else
			itemsMap[id] = itemsMap[id] + count
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

function M:_isInSubFilter(itemData, showItemFilterTypes)
	if not showItemFilterTypes then
		return false
	end

	local type = itemData:getType()
	local subType = itemData:getSubType()
	local subFilters = showItemFilterTypes[type]

	if subFilters and subFilters[subType] then
		return true
	end

	return false
end

function M:_iniItemsData()
	for showType, itemInfo in pairs(_cfg) do
		local itemTypes = itemInfo.showItemTypes
		local filterTypes = itemInfo.showItemFilterTypes
		local itemList = {}
		local items = false

		if type(itemTypes) == "table" then
			for i, v in ipairs(itemTypes) do
				if type(v) == "table" then
					for i = 2, #v do
						items = ItemModel.instance:getItemsByTS(v[1], v[i]) or {}

						for m, n in ipairs(items) do
							if not self:_isInSubFilter(n, filterTypes) then
								table.insert(itemList, n)
							end
						end
					end
				else
					items = ItemModel.instance:getItemsByType(v) or {}

					for m, n in ipairs(items) do
						if not self:_isInSubFilter(n, filterTypes) then
							table.insert(itemList, n)
						end
					end
				end
			end
		else
			items = ItemModel.instance:getItemsByType(itemTypes) or {}

			for m, n in ipairs(items) do
				if not self:_isInSubFilter(n, filterTypes) then
					table.insert(itemList, n)
				end
			end
		end

		self._itemsMapBeforeFilter[showType] = self._baseFilter:doFilter(itemList)
	end
end

function M:_onRemoveItem(e, item)
	local showType = M.super._onRemoveItem(self, e, item)

	if showType then
		local lastSelecItem = self._selectedItem[showType]

		if lastSelecItem and ItemUtil.itemEqual(lastSelecItem, item) then
			self:resetAutoSelect()
		end
	end
end

function M:getBackpackShowType(item)
	local itemType = item:getType()
	local itemSubType = item:getSubType()

	for showType, info in pairs(_cfg) do
		local cfgTypes = info.showItemTypes
		local showItemFilterTypes = info.showItemFilterTypes

		if not self:_isInSubFilter(item, showItemFilterTypes) then
			if type(cfgTypes) == "table" then
				for i, v in pairs(cfgTypes) do
					if type(v) == "table" then
						if v[1] == itemType then
							for i = 2, #v do
								if v[i] == itemSubType then
									return showType
								end
							end
						end
					elseif v == itemType then
						return showType
					end
				end
			elseif cfgTypes == itemType then
				return showType
			end
		end
	end

	return false
end

function M:_resort()
	local defaultSortFun = _cfg[self._curShowType].defaultSortFun or false
	local BackpackItemSortData = self._sortDatas[self._curShowType]

	ItemUtil.sortItemList(self._curShowList, self._curShowType, true)
	BackpackUtil.sortShownItems(self._curShowList, BackpackItemSortData, defaultSortFun)
end

function M:getQuickSelectTypes()
	local allItems = self:getCurShowTypeAllItems()
	local hasS = false
	local hasA = false
	local hasB = false
	local hasC = false

	for _, item in ipairs(allItems) do
		if item:getIsLock() or self._recycleItemsMap[item:getUuid()] or item:getType() == GameEnum.ItemTypeEnum.EquipItemType and item:getIsEquip() or item:getType() == GameEnum.ItemTypeEnum.EchoItemType and item:getHeroId() and item:getHeroId() ~= 0 then
			-- block empty
		else
			hasS = hasS or item:getQuality() == GameEnum.QualityEnum.S
			hasA = hasA or item:getQuality() == GameEnum.QualityEnum.A
			hasB = hasB or item:getQuality() == GameEnum.QualityEnum.B
			hasC = hasC or item:getQuality() == GameEnum.QualityEnum.C

			if hasS and hasA and hasB and hasC then
				break
			end
		end
	end

	return {
		hasS,
		hasA,
		hasB,
		hasC
	}
end

function M:_isQuickSelectItem(item, quickTypes)
	if item:getIsLock() then
		return false
	end

	if item:getType() == GameEnum.ItemTypeEnum.EquipItemType and item:getIsEquip() then
		return false
	end

	if item:getType() == GameEnum.ItemTypeEnum.EchoItemType and item:getHeroId() and item:getHeroId() ~= 0 then
		return false
	end

	local qa = item:getQuality()

	return quickTypes[qa]
end

function M:_isQuickRemoveItem(item)
	return true
end

function M:isCanAddToBackPackById(rewardId)
	local itemList = RewardConfig.instance:getAllRewardListCfgByCode(rewardId)
	local itemIds = {}

	for i = 1, #itemList do
		table.insert(itemIds, itemList[i].code)
	end

	return self:isCanAddToBackPack(itemIds)
end

function M:isCanAddToBackPack(itemIds)
	local hasEquip = false
	local hasEcho = false
	local hasD6 = false

	for i = 1, #itemIds do
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemIds[i])
		local type = itemCo.type

		if type == GameEnum.ItemTypeEnum.EquipItemType then
			hasEquip = true
		elseif type == GameEnum.ItemTypeEnum.DiceItem then
			hasD6 = true
		elseif type == GameEnum.ItemTypeEnum.EchoItemType then
			hasEcho = true
		end
	end

	if hasEquip and self:isReachUpperLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity") then
		return false, lang("tip_backpack_overflow_equip")
	end

	if hasD6 and self:isReachUpperLimit(GameEnum.ItemTypeEnum.DiceItem, "DiceBackpackCapacity") then
		return false, lang("tip_backpack_overflow_dice")
	end

	if hasEcho and self:isReachUpperLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity") then
		return false, lang("tip_backpack_overflow_echo")
	end

	return true, ""
end

function M:isReachUpperLimit(itemTypeEnum, capacityName)
	local max = PlayerModel.instance:getBackpackLimit(itemTypeEnum, capacityName)
	local items = ItemModel.instance:getItemsByType(itemTypeEnum)

	if items and max <= #items then
		return true
	end

	return false
end

M.instance = M.New()

return M
