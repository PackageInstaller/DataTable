-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loginpopups/config/LoginPopUpsConfig.lua

module("logic.extensions.loginpopups.config.LoginPopUpsConfig", package.seeall)

local M = class("LoginPopUpsConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.LoginPopUps
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

function M:getCo(key)
	local cfg = self:getConfig(ConfigName.LoginPopUps)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

M.instance = M.New()

return M
