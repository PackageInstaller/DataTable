-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/config/SupervisorConfig.lua

module("logic.extensions.supervisor.config.SupervisorConfig", package.seeall)

local M = class("SupervisorConfig", BaseConfig)

function M:ctor()
	M.super.ctor(self)

	self._maxLv = nil
	self._maxModuleLv = nil
end

function M:getNames()
	return {
		ConfigName.HouseManager,
		ConfigName.HouseManagerConst
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

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getConfigByLevel(level)
	local list = self:getConfig(ConfigName.HouseManager)

	return list[level]
end

function M:getMaxLv()
	if not self._maxLv then
		self._maxLv = 1

		local list = self:getConfigList(ConfigName.HouseManager)

		for _, cfg in ipairs(list) do
			if cfg.level > self._maxLv then
				self._maxLv = cfg.level
			end
		end
	end

	return self._maxLv
end

function M:getMaxModuleLv()
	if not self._maxModuleLv then
		self._maxModuleLv = 1

		local list = self:getConfigList(ConfigName.HouseManager)

		for _, cfg in ipairs(list) do
			if cfg.muduleLevel > self._maxModuleLv then
				self._maxModuleLv = cfg.muduleLevel
			end
		end
	end

	return self._maxModuleLv
end

function M:getProductivityNeed()
	local cfg = self:getConfigByKey(ConfigName.HouseManagerConst, "ProductivityNeed")

	return cfg.numValue
end

function M:getProductId()
	local cfg = self:getConfigByKey(ConfigName.HouseManagerConst, "Product")

	return cfg.numValue
end

function M:getZoneUnlockOrder()
	local cfg = self:getConfigByKey(ConfigName.HouseManagerConst, "ZoneUnlockOrder")

	return cfg.numValues
end

M.instance = M.New()

return M
