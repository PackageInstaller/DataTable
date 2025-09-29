-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/util/EquipUtil.lua

module("logic.extensions.charactersystem.util.EquipUtil", package.seeall)

function d6Sort(mo1, mo2)
	if mo1:getPart() ~= mo2:getPart() then
		return mo1:getPart() < mo2:getPart()
	end

	if mo1:getIsLock() ~= mo2:getIsLock() then
		return mo1:getIsLock() and not mo2:getIsLock()
	end

	return mo1:getQuality() > mo2:getQuality()
end

function equipMaxLVData(equipItemId)
	local equip = EquipmentData.New({
		itemId = equipItemId
	})
	local maxLv = equip:getMaxLevel()

	equip:setLevelAndExp(maxLv, 0)

	local attrs = {}
	local lvUp = maxLv - 1
	local attrCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentAttr, equipItemId)

	for key, attrInfo in ipairs(attrCo.attr) do
		local EquipAttrNO = {}

		EquipAttrNO.attrId = attrInfo.attrId
		EquipAttrNO.baseValue = math.floor(attrInfo.maxCfgValue)
		EquipAttrNO.value = math.floor(attrInfo.maxCfgValue + attrCo.growth[attrInfo.attrId] * lvUp)

		table.insert(attrs, EquipAttrNO)
	end

	equip:refreshAttrs(attrs)

	return equip
end

function getValueDesc(coDesc, value)
	if string.find(coDesc, "-%%") then
		return "-" .. 100 * value .. "%"
	elseif string.find(coDesc, "+%%") then
		return "+" .. 100 * value .. "%"
	elseif string.find(coDesc, "+") then
		return "+" .. value
	elseif string.find(coDesc, "-") then
		return "-" .. value
	end

	return value
end

function getValueDesc2(coDesc, value)
	if string.find(coDesc, "-%%") then
		return "+" .. 100 * value .. "%"
	elseif string.find(coDesc, "+%%") then
		return "+" .. 100 * value .. "%"
	elseif string.find(coDesc, "+") then
		return "+" .. value
	elseif string.find(coDesc, "-") then
		return "+" .. value
	end

	return value
end

function calDecomposeItemGetExp(itemData)
	local total = 0
	local itemList = self:getRecycleGetItems(itemData)

	for id, count in pairs(itemList) do
		local perExp = EquipmentConfig.instance:getItemAddEquipExp(tonumber(id))

		total = total + perExp * count
	end

	return total
end

function calRecycleGetItems(itemData)
	local itemsMap = {}
	local id, count = itemData:getDecomposedItem()

	if not itemsMap[id] then
		itemsMap[id] = count
	else
		itemsMap[id] = itemsMap[id] + count
	end

	if itemData:getType() == GameEnum.ItemTypeEnum.EquipItemType then
		local decomposedItemId = EquipmentConfig.instance:getConstNum(EquipEnum.EquipExtraDecomposedItem)
		local extraCount = EquipUtil.calEquipRecycleCount(itemData, decomposedItemId)

		if extraCount > 0 then
			if not itemsMap[decomposedItemId] then
				itemsMap[decomposedItemId] = extraCount
			else
				itemsMap[decomposedItemId] = itemsMap[decomposedItemId] + extraCount
			end
		end
	end

	return itemsMap
end

function calEquipRecycleCount(equip, decomposedItemId)
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

IntensifyHolePos = {
	{
		holePos = {
			Vector2.New(76, 18)
		},
		qipaoPos = {
			Vector2.New(326, 18)
		}
	},
	{
		holePos = {
			Vector2.New(76, 53),
			Vector2.New(76, -24)
		},
		qipaoPos = {
			Vector2.New(325, 53),
			Vector2.New(325, -24)
		}
	},
	{
		holePos = {
			Vector2.New(46, 85),
			Vector2.New(76, 9),
			Vector2.New(46, -67)
		},
		qipaoPos = {
			Vector2.New(296, 86),
			Vector2.New(325, 9.5),
			Vector2.New(296, -67)
		}
	},
	{
		holePos = {
			Vector2.New(43, 128.5),
			Vector2.New(73, 51.5),
			Vector2.New(73, -24),
			Vector2.New(43.6, -102)
		},
		qipaoPos = {
			Vector2.New(295, 128.5),
			Vector2.New(323.5, 51.5),
			Vector2.New(323.5, -24),
			Vector2.New(292, -100)
		}
	}
}
TimingHolePos = {
	{
		holePos = {
			Vector2.New(181, 18)
		},
		qipaoPos = {
			Vector2.New(430, 18)
		}
	},
	{
		holePos = {
			Vector2.New(181, 52),
			Vector2.New(181, -24)
		},
		qipaoPos = {
			Vector2.New(433, 52),
			Vector2.New(433, -24)
		}
	},
	{
		holePos = {
			Vector2.New(150, 86),
			Vector2.New(181, 9.5),
			Vector2.New(150.5, -67)
		},
		qipaoPos = {
			Vector2.New(401, 86),
			Vector2.New(430, 9),
			Vector2.New(400, -68)
		}
	},
	{
		holePos = {
			Vector2.New(150, 128.5),
			Vector2.New(180, 52),
			Vector2.New(180, -24),
			Vector2.New(150, -101)
		},
		qipaoPos = {
			Vector2.New(450.5, 128.5),
			Vector2.New(481, 52),
			Vector2.New(481, -24),
			Vector2.New(450.5, -100)
		}
	}
}
EquipHolePos1New = {
	{
		holePos = {
			Vector2.New(231, 3)
		},
		qipaoPos = {
			Vector2.New(492, 3)
		}
	},
	{
		holePos = {
			Vector2.New(231, 68),
			Vector2.New(231, -62)
		},
		qipaoPos = {
			Vector2.New(492, 68),
			Vector2.New(492, -62)
		}
	},
	{
		holePos = {
			Vector2.New(201, 126),
			Vector2.New(231, 3),
			Vector2.New(201, -120)
		},
		qipaoPos = {
			Vector2.New(462, 126),
			Vector2.New(492, 3),
			Vector2.New(462, -120)
		}
	},
	{
		holePos = {
			Vector2.New(161, 183),
			Vector2.New(231, 68),
			Vector2.New(231, -62),
			Vector2.New(161, -177)
		},
		qipaoPos = {
			Vector2.New(422, 183),
			Vector2.New(492, 68),
			Vector2.New(492, -62),
			Vector2.New(422, -177)
		}
	}
}
EquipIntensifyModelPos = {
	{
		cameraPos = Vector3.New(0, 2.2, -3.3),
		attachPointPos = Vector3.New(2.22, -0.68, -0.4),
		attachPointRotation = Vector3.New(0, 0, 0),
		targetPos = Vector3.New(0, 0.36, -0.6)
	},
	{
		cameraPos = Vector3.New(0, 1.9, -4.5),
		attachPointPos = Vector3.New(2, 0.5, 0),
		attachPointRotation = Vector3.New(0, 0, 0),
		targetPos = Vector3.New(0, 0.36, -1.2)
	},
	{
		cameraPos = Vector3.New(0, 2.35, -7),
		attachPointPos = Vector3.New(2.23, 1.5, 0),
		attachPointRotation = Vector3.New(0, 0, 7),
		targetPos = Vector3.New(0, 0.36, -2.5)
	}
}
EquipModelEmptyPosInCharacter = {
	Vector3.New(2.3, -1.9, 0),
	Vector3.New(-2.6, 0, 0),
	(Vector3.New(-7.5, 0.5, 0))
}
