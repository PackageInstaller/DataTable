-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/config/LivingFacilitiesConfig.lua

module("logic.extensions.livingfacilities.config.LivingFacilitiesConfig", package.seeall)

local M = class("LivingFacilitiesConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.HouseLiveRoom,
		ConfigName.HouseFurnitureTheme,
		ConfigName.HouseAtmosphere,
		ConfigName.HouseAtmosDorm,
		ConfigName.HouseAtmosLevel,
		ConfigName.HouseAtmosType,
		ConfigName.HouseFurnitureTemplate
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

M.instance = M.New()

return M
