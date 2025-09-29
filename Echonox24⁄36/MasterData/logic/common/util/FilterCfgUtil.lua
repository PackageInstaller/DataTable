-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/FilterCfgUtil.lua

module("logic.common.util.FilterCfgUtil", package.seeall)

local CommAll = CommEnum.CommonAll

function checkEquipsD6Filter(itemData, partFilter, resonanceFilter, attrs)
	if itemData:getType() ~= GameEnum.ItemTypeEnum.EquipItemType then
		return false
	end

	if partFilter == CommAll and resonanceFilter == CommAll and (not attrs or attrs[1] == CommAll) then
		return true
	end

	local allD6AttrParts = {}
	local allD6s = itemData:getAllDiceAttr()

	for _, d6 in ipairs(allD6s) do
		table.insertto(allD6AttrParts, d6:getAttrs())
	end

	return _checkEquipD6Attr(allD6AttrParts, partFilter, resonanceFilter, attrs)
end

function checkD6Filter(itemData, partFilter, resonanceFilter, attrs)
	if itemData:getType() ~= GameEnum.ItemTypeEnum.DiceItem then
		return false
	end

	if partFilter == CommAll and resonanceFilter == CommAll and (not attrs or #attrs == 0) then
		return true
	end

	return _checkD6Attr(itemData, partFilter, resonanceFilter, attrs)
end

function _checkEquipD6Attr(allD6Attr, partFilter, resonanceFilter, attrsFilter)
	if attrsFilter and #attrsFilter == 0 then
		for _, diceAttrMO in ipairs(allD6Attr) do
			local part = diceAttrMO:getPart()
			local resonance = diceAttrMO:getEnhanceType()

			if MultipleEnumUtil.multipleEnumContainOnZeroAll(partFilter, part) and MultipleEnumUtil.multipleEnumContainOnZeroAll(resonanceFilter, resonance) then
				return true
			end
		end
	else
		local attrsMap = TableUtil.arrayToMap(attrsFilter)

		for _, diceAttrMO in ipairs(allD6Attr) do
			if attrsMap[diceAttrMO:getAttrId()] then
				return true
			end
		end
	end

	return false
end

function checkEquipDicesAttr(itemData, attrsFilter)
	if not attrsFilter or TableUtil.getLen(attrsFilter) == 0 then
		return true
	end

	local allDiceAttr = itemData:getAllDiceAttr()
	local attrsMap = TableUtil.tableToMap(attrsFilter)

	for _, diceAttrMO in ipairs(allDiceAttr) do
		if attrsMap[diceAttrMO:getAttrId()] then
			return true
		end
	end

	return false
end

function _checkD6Attr(itemData, partFilter, resonanceFilter, attrsFilter)
	local part = itemData:getPart()
	local allD6Attr = itemData:getAttrs()
	local partPass = MultipleEnumUtil.multipleEnumContainOnZeroAll(partFilter, part)

	if attrsFilter and #attrsFilter == 0 then
		for _, diceAttrMO in ipairs(allD6Attr) do
			local resonance = diceAttrMO:getEnhanceType()

			if partPass and MultipleEnumUtil.multipleEnumContainOnZeroAll(resonanceFilter, resonance) then
				return true
			end
		end
	else
		local attrsMap = TableUtil.arrayToMap(attrsFilter)

		for _, diceAttrMO in ipairs(allD6Attr) do
			if attrsMap[diceAttrMO:getAttrId()] then
				return true
			end
		end
	end

	return false
end

function doSeniorCheck(filterCfg, tarEnum, itemData)
	local allD6AttrParts = {}

	if itemData:getType() == GameEnum.ItemTypeEnum.EquipItemType then
		local allD6s = itemData:getAllDiceAttr()

		for _, d6 in ipairs(allD6s) do
			table.insertto(allD6AttrParts, d6:getAttrs())
		end
	else
		table.insertto(allD6AttrParts, itemData:getAttrs())
	end

	local status

	if tarEnum == TarEnum.SeniorPart then
		if filterCfg:unifyOperate(tarEnum, OptEnum.Check, CommEnum.CommonAll) then
			return true
		end

		for _, diceAttrMO in ipairs(allD6AttrParts) do
			if filterCfg:unifyOperate(tarEnum, OptEnum.Check, diceAttrMO:getPart() or -1) then
				return true
			end
		end
	elseif tarEnum == TarEnum.SeniorResonance then
		if filterCfg:unifyOperate(tarEnum, OptEnum.GetStatus, CommEnum.CommonAll) == StatusEnum.Selected then
			return true
		end

		for _, diceAttrMO in ipairs(allD6AttrParts) do
			if filterCfg:unifyOperate(tarEnum, OptEnum.GetStatus, diceAttrMO:getEnhanceType() or -1) == StatusEnum.Selected then
				return true
			end
		end
	elseif tarEnum == TarEnum.SeniorAttribute then
		if filterCfg:unifyOperate(tarEnum, OptEnum.GetStatus, CommEnum.CommonAll) == StatusEnum.Selected then
			return true
		end

		for _, diceAttrMO in ipairs(allD6AttrParts) do
			local attrLevel = diceAttrMO:getLevel()
			local attrId = diceAttrMO:getAttrId() or -1
			local section = {
				attrLevel,
				attrLevel
			}
			local sectionId = filterCfg:unifyOperate(tarEnum, OptEnum.GetSection, attrId)

			if sectionId then
				section = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttrLevelSection, sectionId).section
			end

			if filterCfg:unifyOperate(tarEnum, OptEnum.GetStatus, attrId) == StatusEnum.Selected and attrLevel >= section[1] and attrLevel <= section[2] then
				return true
			end
		end
	end

	return false
end

function d6AttrFilterSort(attr1, attr2)
	if attr1 == nil or attr2 == nil then
		return false
	end

	local canSelect1 = 0
	local canSelect2 = 0

	if attr1[2] then
		canSelect1 = 1
	end

	if attr2[2] then
		canSelect2 = 1
	end

	if canSelect1 ~= canSelect2 then
		return canSelect2 < canSelect1
	elseif attr1[1] ~= attr2[1] then
		return attr1[1] < attr2[1]
	end

	return false
end

function commonEquipsFilter(equips, CommonEquipFilterCfg)
	if not equips or not CommonEquipFilterCfg then
		return {}
	end

	local quality = CommonEquipFilterCfg:getQualityFilterType()
	local part = CommonEquipFilterCfg:getPartFilterType()
	local suitId = CommonEquipFilterCfg:getSuitId()
	local d6Part = CommonEquipFilterCfg:getD6PartFilter()
	local d6Resonance = CommonEquipFilterCfg:getD6ResonanceFilter()
	local d6Attr = CommonEquipFilterCfg:getD6AttributeFilter()
	local diceAttrs = CommonEquipFilterCfg:getDiceIds()
	local res = {}

	for _, equip in ipairs(equips) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, equip:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(part, equip:getPart()) and (suitId == 0 or equip:getSuitId() == suitId) and checkEquipDicesAttr(equip, diceAttrs) and checkEquipsD6Filter(equip, d6Part, d6Resonance, d6Attr) then
			table.insert(res, equip)
		end
	end

	return res
end

function sortEquip(itemA, itemB)
	local qualityA = itemA:getQuality()
	local qualityB = itemB:getQuality()

	if qualityA ~= qualityB then
		return qualityB < qualityA
	end

	local suitIdA = itemA:getSuitId()
	local suitIdB = itemB:getSuitId()

	if suitIdA ~= suitIdB then
		return suitIdB < suitIdA
	end

	local levelA = itemA:getLevel()
	local levelB = itemB:getLevel()

	if levelA ~= levelB then
		return levelB < levelA
	end

	local maxLevelA = itemA:getMaxLevel()
	local maxLevelB = itemB:getMaxLevel()

	if maxLevelA ~= maxLevelB then
		return maxLevelB < maxLevelA
	end

	local expireTimeA = itemA:getExpireTime()
	local expireTimeB = itemB:getExpireTime()

	if expireTimeA ~= expireTimeB then
		return expireTimeB < expireTimeA
	end

	local idA = itemA:getItemId()
	local idB = itemB:getItemId()

	if idA ~= idB then
		return idB < idA
	end

	return itemA:getUuid() > itemB:getUuid()
end
