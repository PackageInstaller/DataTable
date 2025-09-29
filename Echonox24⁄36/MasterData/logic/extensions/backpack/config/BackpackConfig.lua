-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/config/BackpackConfig.lua

module("logic.extensions.backpack.config.BackpackConfig", package.seeall)

local M = class("BackpackConfig", BaseConfig)

function M:onInit()
	self._itemDictTS = {}
end

function M:getNames()
	return {
		ConfigName.ItemProp,
		ConfigName.ItemCurrency,
		ConfigName.Character,
		ConfigName.ItemEquip,
		ConfigName.ItemHero,
		ConfigName.ItemHeroSkin,
		ConfigName.ItemBackground,
		ConfigName.EchoItem,
		ConfigName.ItemHouse,
		ConfigName.ItemProtomer,
		ConfigName.ItemRunGroupEquip,
		ConfigName.ItemRunGroupClue,
		ConfigName.Furniture,
		ConfigName.ItemPortrait,
		ConfigName.ItemDisplayCard,
		ConfigName.FurniturePaper,
		ConfigName.ItemDice,
		ConfigName.ItemPrefab,
		ConfigName.ItemTreasureBox,
		ConfigName.ItemOnlyShowConfig,
		ConfigName.ItemChamberClue,
		ConfigName.ItemAirScene,
		ConfigName.ItemAirBuilding,
		ConfigName.ItemAirSeasonCup,
		ConfigName.ItemAirAchievementCup,
		ConfigName.ItemPuzzle
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	local info = false

	for k, v in ipairs(content.dataList or {}) do
		if not self._itemDictTS[v.type] then
			self._itemDictTS[v.type] = {}
		end

		if not self._itemDictTS[v.type][v.subType] then
			self._itemDictTS[v.type][v.subType] = {}
		end

		self._itemDictTS[v.type][v.subType][k] = v
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getItemInfoByItemId(itemId)
	local info = false

	for k, v in pairs(self._dict) do
		info = v[itemId]

		if info then
			break
		end
	end

	if not info then
		printWarn("没有物品配置，id：", itemId)
	end

	return info
end

function M:getItemsInfoByTS(type, subType)
	local info = self._itemDictTS[type]

	return info and info[subType]
end

function M:getCharacterConfig()
	return self._dict[ConfigName.Character]
end

function M:getItemsInfoByType(type)
	local info = self._itemDictTS[type]
	local list = {}

	if info then
		for subType, items in pairs(info) do
			for k, v in pairs(items) do
				table.insert(list, v)
			end
		end
	end

	return list
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getDiceId(part)
	local itemDice = self._dict[ConfigName.ItemDice]

	for i, v in pairs(itemDice) do
		if v.part == part then
			return v.id
		end
	end

	return nil
end

function M:getHackDice()
	local itemDice = self._dict[ConfigName.ItemDice]
	local res = {}

	for i, v in pairs(itemDice) do
		if v.quality and v.quality > 0 then
			table.insert(res, v)
		end
	end

	return res
end

M.instance = M.New()

return M
