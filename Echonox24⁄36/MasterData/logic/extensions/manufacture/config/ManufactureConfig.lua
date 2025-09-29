-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/config/ManufactureConfig.lua

module("logic.extensions.manufacture.config.ManufactureConfig", package.seeall)

local M = class("ManufactureConfig", BaseConfig)

function M:ctor()
	M.super.ctor(self)

	self._maxLv = nil
	self._dictScheme = {}
end

function M:getNames()
	return {
		ConfigName.HouseManufacture,
		ConfigName.HouseManufactureConst,
		ConfigName.HouseManufactureScheme
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.HouseManufactureScheme then
		local list = self:getConfigList(ConfigName.HouseManufactureScheme)

		self._dictScheme = {}

		for _, cfg in ipairs(list) do
			local type = cfg.type

			if self._dictScheme[type] == nil then
				self._dictScheme[type] = {}
			end

			table.insert(self._dictScheme[type], cfg)
		end
	end
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

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getUnlockLv(id)
	local list = self:getConfigList(ConfigName.HouseManufacture)

	for _, cfg in ipairs(list) do
		if cfg.plant == id then
			return cfg.level
		end
	end
end

function M:getSchemeList(type, sortType, isSortUp)
	local currLv = ManufactureModel.instance:getLv()
	local schemeList = clone(self._dictScheme[type]) or {}

	sortType = sortType or 1

	local function _defaultSort(coA, coB)
		local isAUnlock = coA.unlockLevel <= currLv
		local isBUnlock = coB.unlockLevel <= currLv

		if isAUnlock and not isBUnlock then
			return true
		elseif not isAUnlock and isBUnlock then
			return false
		end
	end

	local function _sortQuality(coA, coB)
		local defSort = _defaultSort(coA, coB)

		if defSort == true or defSort == false then
			return defSort
		end

		local itemA = BackpackConfig.instance:getItemInfoByItemId(coA.id)
		local itemB = BackpackConfig.instance:getItemInfoByItemId(coB.id)

		if isSortUp then
			return itemA.quality < itemB.quality
		end

		return itemA.quality > itemB.quality
	end

	local function _sortTime(coA, coB)
		local defSort = _defaultSort(coA, coB)

		if defSort == true or defSort == false then
			return defSort
		end

		if isSortUp then
			return coA.need < coB.need
		end

		return coA.need > coB.need
	end

	local sortFuncMap = {
		_sortQuality,
		_sortTime
	}

	table.sort(schemeList, sortFuncMap[sortType])

	return schemeList
end

function M:getSchemeListByUnlockLv(unlockLv)
	local schemeCOs = {}
	local list = self:getConfigList(ConfigName.HouseManufactureScheme)

	for _, cfg in ipairs(list) do
		if cfg.unlockLevel == unlockLv then
			table.insert(schemeCOs, cfg)
		end
	end

	return schemeCOs
end

function M:getSpeedUpItemId()
	local cfg = self:getConfigByKey(ConfigName.HouseManufactureConst, "StoreSpeedUpCostItem")

	return cfg.numValue
end

function M:getSpeedUpItemTime()
	local cfg = self:getConfigByKey(ConfigName.HouseManufactureConst, "StoreSpeedUpMinute")

	return cfg.numValue
end

function M:getSchemeLimit(schemeId)
	local list = self:getConfigList(ConfigName.HouseManufactureScheme)

	for _, cfg in ipairs(list) do
		if cfg.id == schemeId then
			return cfg.limit
		end
	end
end

function M:isSchemeMaxLimit(schemeId, schemeNum)
	local limit = self:getSchemeLimit(schemeId)

	if limit == nil or limit == 0 then
		return false
	else
		return limit - schemeNum <= 0
	end
end

M.instance = M.New()

return M
