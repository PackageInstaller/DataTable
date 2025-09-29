-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/config/EquipmentConfig.lua

module("logic.extensions.equipment.config.EquipmentConfig", package.seeall)

local M = class("EquipmentConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.EquipmentAttr,
		ConfigName.EquipmentSuit,
		ConfigName.EquipmentUpgrade,
		ConfigName.EquipmentBreak,
		ConfigName.EquipmentConstant,
		ConfigName.DiceAttr,
		ConfigName.AttrPartDefine,
		ConfigName.DiceAttrLevelSection,
		ConfigName.EquipmentExpItem,
		ConfigName.EquipmentRerollCost,
		ConfigName.EquipmentQuality,
		ConfigName.D6Lv2Quality,
		ConfigName.D6Quality,
		ConfigName.EquipmentPrefab,
		ConfigName.DicePrefab,
		ConfigName.DiceClipInfo,
		ConfigName.DiceClipInfoIndex,
		ConfigName.EquipmentAttrGrowth
	}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg and cfg[key] then
		return cfg[key]
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", cfgName, key))
end

function M:getStrValue(key)
	local cfg = self:getConfig(ConfigName.EquipmentConstant)

	if cfg and cfg[key] then
		return cfg[key].strValue or "0"
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.EquipmentConstant, key))
end

function M:getConstNum(key)
	local cfg = self:getConfig(ConfigName.EquipmentConstant)

	if cfg and cfg[key] then
		return cfg[key].numValue or 0
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.EquipmentConstant, key))
end

function M:getFloatNum(key)
	local cfg = self:getConfig(ConfigName.EquipmentConstant)

	if cfg and cfg[key] then
		return cfg[key].floatValue or 0
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.EquipmentConstant, key))
end

function M:getConstNumList(key)
	local cfg = self:getConfig(ConfigName.EquipmentConstant)

	if cfg and cfg[key] then
		return cfg[key].numValues or 0
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.EquipmentConstant, key))
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.EquipmentAttr then
		for _, cfg in ipairs(content.dataList) do
			local attr = {}

			for attrId, minValue, maxValue, _ in string.gmatch(cfg.attr, "(%d+):%[(%d+)%,(%d+)%,%d+%]") do
				table.insert(attr, {
					value = "？？？",
					attrId = tonumber(attrId),
					maxCfgValue = tonumber(maxValue)
				})
			end

			cfg.attr = attr
		end
	end

	if name == ConfigName.EquipmentAttrGrowth then
		for _, cfg in ipairs(content.dataList) do
			local attr = {}

			for attrId, value in string.gmatch(cfg.attr, "(%d+):(%-?%d+%.*%d*)") do
				attr[tonumber(attrId)] = tonumber(value)
			end

			cfg.attr = attr
		end
	end

	if name == ConfigName.EquipmentRerollCost then
		for _, cfg in ipairs(content.dataList) do
			local info = string.gmatch(cfg.costItems, "(%d+):(%d+)")

			for id, count in info do
				cfg.costItemId = id
				cfg.costCount = tonumber(count)
			end
		end
	end
end

function M:getGrowth(equipId, attrId)
	local cfg = self:getConfigByKey(ConfigName.EquipmentAttr, equipId)

	return cfg.growth[attrId]
end

function M:getD6EDecomposeInfo(Quality)
	local cfg = self._dict[ConfigName.D6Quality]

	return cfg[Quality]
end

function M:getEquipExpItemInfo(id)
	local list = self._dict[ConfigName.EquipmentExpItem].dataList

	for i = 1, #list do
		if id == list[i].itemId then
			return list[i]
		end
	end

	return nil
end

function M:getEquipExpItemDataList()
	return self._dict[ConfigName.EquipmentExpItem].dataList
end

function M:getItemAddEquipExp(itemId)
	if not self._expItemData then
		self._expItemData = {}

		for index, value in ipairs(self._dict[ConfigName.EquipmentExpItem].dataList) do
			self._expItemData[value.itemId] = value.exp
		end
	end

	return self._expItemData[itemId] or 0
end

function M:getRecollInfo(times)
	return self._dict[ConfigName.EquipmentRerollCost].dataList[times]
end

function M:getAttrGrowth(growthId, lv)
	local data = self._dict[ConfigName.EquipmentAttrGrowth][growthId]

	if data and data[lv] then
		return data[lv].attr
	end

	return nil
end

M.instance = M.New()

return M
