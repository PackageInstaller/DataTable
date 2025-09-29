-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/util/BackpackUtil.lua

module("logic.extensions.backpack.util.BackpackUtil", package.seeall)

local originOrder

function sortShownItems(list, BackpackItemSortData, defaultSortFun)
	if not list then
		return
	end

	local sortFun = defaultSortFun

	if BackpackItemSortData then
		sortFun = BackpackUtil.getSortFun(BackpackItemSortData)
	end

	if sortFun then
		table.sort(list, sortFun)
	end
end

function getSortFun(BackpackItemSortData)
	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Level then
		return BackpackItemSortData.isUp and BackpackUtil.LvUpSort or BackpackUtil.LvDownSort
	end

	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Quality then
		return BackpackItemSortData.isUp and BackpackUtil.QaUpSort or BackpackUtil.QaDownSort
	end

	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Time then
		return BackpackItemSortData.isUp and BackpackUtil.TimeUpSort or BackpackUtil.TimeDownSort
	end

	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Experience then
		return BackpackItemSortData.isUp and BackpackUtil.ExperienceUpSort or BackpackUtil.ExperienceDownSort
	end
end

function getEquipSortFun(BackpackItemSortData)
	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Level then
		return BackpackItemSortData.isUp and BackpackUtil.EquipLvUpSort or BackpackUtil.EquipLvDownSort
	end

	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Quality then
		return BackpackItemSortData.isUp and BackpackUtil.EquipQaUpSort or BackpackUtil.EquipQaDownSort
	end

	if BackpackItemSortData.sortType == CommEnum.MainBackpackSortType.Time then
		return BackpackItemSortData.isUp and BackpackUtil.EquipTimeUpSort or BackpackUtil.EquipTimeDownSort
	end
end

function sortRecycleItems(list, isEquip)
	if not list then
		return
	end

	if isEquip then
		table.sort(list, BackpackUtil.QaAndLvDownSort)
	else
		table.sort(list, BackpackUtil.QaDownSort)
	end
end

function sortQuickRecycleItems(list, isEcho)
	if not list then
		return
	end

	if isEcho then
		table.sort(list, BackpackUtil.QaUpSort)
	else
		table.sort(list, BackpackUtil.DiscardAndQaUpSort)
	end
end

function sortItemsByQualityDown(list)
	if not list then
		return
	end

	table.sort(list, BackpackUtil.QaDownSort)
end

function sortItemsByQualityUp(list)
	if not list then
		return
	end

	table.sort(list, BackpackUtil.QaUpSort)
end

function LvUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() < itemB:getLevel()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function LvDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() > itemB:getLevel()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function QaUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() < itemB:getQuality()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function QaDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local compoundA = 0
	local compoundB = 0

	if itemA:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		compoundA = itemA:isShowRedPoint() and 1 or 0
	end

	if itemB:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		compoundB = itemB:isShowRedPoint() and 1 or 0
	end

	if compoundA ~= 0 or compoundB ~= 0 then
		if compoundA == 1 and compoundB == 1 then
			return itemA:getQuality() > itemB:getQuality()
		end

		return compoundB < compoundA
	elseif itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() > itemB:getQuality()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function QaAndLvDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local quA, quB = itemA:getQuality(), itemB:getQuality()

	if quA ~= quB then
		return quB < quA
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() > itemB:getLevel()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function DiscardAndQaUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local disA, disB = itemA:getIsDiscard(), itemB:getIsDiscard()

	if disA ~= disB then
		return quA
	end

	if itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() < itemB:getQuality()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function TimeUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	return tonumber(itemA:getAddTime()) < tonumber(itemB:getAddTime())
end

function TimeDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	return tonumber(itemA:getAddTime()) > tonumber(itemB:getAddTime())
end

function ExperienceUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	return tonumber(itemA:getDecomposedCanGetExp()) < tonumber(itemB:getDecomposedCanGetExp())
end

function ExperienceDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	return tonumber(itemA:getDecomposedCanGetExp()) > tonumber(itemB:getDecomposedCanGetExp())
end

function setOriginOrder(list)
	originOrder = {}

	for idx, item in pairs(list) do
		if not item.getUuid then
			originOrder = false

			return
		end

		originOrder[item:getUuid()] = idx
	end
end

function originOrderKeep(itemA, itemB)
	if originOrder and originOrder[itemA:getUuid()] and originOrder[itemB:getUuid()] then
		return originOrder[itemA:getUuid()] < originOrder[itemB:getUuid()]
	else
		return false
	end
end

function useItem(itemData)
	if not itemData or itemData:getCount() < 0 then
		return
	end

	local itemId = itemData:getItemId()
	local bigType, subType = ItemUtil.getItemTypeByItemId(itemId)

	if bigType == GameEnum.ItemTypeEnum.TreasureBox then
		BackpackUtil.useTreasureItem(itemData)
	elseif subType == CommEnum.PropSubType.PowerProp then
		ToolTipsMgr.showHealthTips(itemData)
	elseif subType == CommEnum.PropSubType.GiftBoxProp or subType == CommEnum.PropSubType.AirtightTimeProp then
		GlobalDispatcher:dispatchEvent(EventType.ITEM_USE_EVENT, {
			uuid = itemData:getUuid(),
			type = bigType,
			subType = subType,
			itemId = itemId,
			count = itemData:getCount()
		})
	else
		local jumpId = itemData:getJumpId()

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	end
end

function useTreasureItem(itemData, needItemId, needItemCount)
	local itemId = itemData:getItemId()
	local bigType, subType = ItemUtil.getItemTypeByItemId(itemId)

	if bigType ~= GameEnum.ItemTypeEnum.TreasureBox or itemData:getCount() < 1 then
		return
	end

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCo.boxType == GameEnum.TreasureBoxType.Select then
		ViewMgr.instance:open(ViewName.TreasureChooseViewNew, itemData, needItemId, needItemCount)
	elseif itemCo.batchUseLimit and itemCo.batchUseLimit ~= 0 then
		ToolTipsMgr.showUseItemTips(itemData, itemCo.batchUseLimit)
	else
		GlobalDispatcher:dispatchEvent(EventType.ITEM_USE_EVENT, {
			count = 1,
			uuid = itemData:getUuid(),
			type = bigType,
			subType = subType,
			itemId = itemId
		})
	end
end

local specialEquipId = false

function SetSpecialEquipId(equipId)
	specialEquipId = equipId
end

function SpecialEquipSort(itemA, itemB)
	if specialEquipId and itemA:getUuid() == specialEquipId then
		return true
	end

	if specialEquipId and itemB:getUuid() == specialEquipId then
		return false
	end

	return originOrderKeep(itemA, itemB)
end

local heroTags = false

function SetHeroTags(tags)
	heroTags = tags
end

function EquipLvUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() < itemB:getLevel()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function EquipLvDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() > itemB:getLevel()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function EquipQaUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	if itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() < itemB:getQuality()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function EquipQaDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	local compoundA = 0
	local compoundB = 0

	if itemA:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		compoundA = itemA:isShowRedPoint() and 1 or 0
	end

	if itemB:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		compoundB = itemB:isShowRedPoint() and 1 or 0
	end

	if compoundA ~= 0 or compoundB ~= 0 then
		if compoundA == 1 and compoundB == 1 then
			return itemA:getQuality() > itemB:getQuality()
		end

		return compoundB < compoundA
	elseif itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() > itemB:getQuality()
	else
		return originOrderKeep(itemA, itemB)
	end
end

function EquipTimeUpSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	return tonumber(itemA:getAddTime()) < tonumber(itemB:getAddTime())
end

function EquipTimeDownSort(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	local sortResult = getEquipTagsSort(itemA, itemB)

	if sortResult ~= nil then
		return sortResult
	end

	return tonumber(itemA:getAddTime()) > tonumber(itemB:getAddTime())
end

function getEquipTagsSort(itemA, itemB)
	local isInTagsA = itemA:isSuitTagsContainTargetTag(heroTags)
	local isInTagsB = itemB:isSuitTagsContainTargetTag(heroTags)

	if isInTagsA ~= isInTagsB then
		return sortByBool(isInTagsA, isInTagsB)
	end

	local inDiceNumA = itemA:getDiceTagsMatchNum(heroTags)
	local inDiceNumB = itemB:getDiceTagsMatchNum(heroTags)

	if inDiceNumA ~= inDiceNumB then
		return inDiceNumB < inDiceNumA
	end
end

function sortByBool(first, second)
	return first and not second
end

local recycleTisTable = {
	[2] = {
		[1] = "tip_equip_recycle_is_use",
		[2] = "tip_equip_recycle_is_lock"
	},
	[6] = {
		[2] = "tip_d6_recycle_is_lock"
	},
	[4] = {
		[1] = "tip_echo_recycle_is_use",
		[2] = "tip_echo_recycle_is_lock"
	}
}

function getRecycleTips(type, reason)
	return recycleTisTable[type][reason]
end
