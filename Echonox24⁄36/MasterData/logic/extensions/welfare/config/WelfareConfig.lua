-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/WelfareConfig.lua

module("logic.extensions.welfare.config.WelfareConfig", package.seeall)

local M = class("WelfareConfig", BaseConfig)

function M:onInit()
	self._actTab = {}
	self._planId = {}
end

function M:getNames()
	return {
		ConfigName.ActivityTab
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.ActivityTab then
		for k, cfg in pairs(content.dataList or {}) do
			if not self._actTab[cfg.type] then
				self._actTab[cfg.type] = {}
			end

			if cfg.planIds then
				for i = 1, #cfg.planIds do
					local planId = cfg.planIds[i]

					self._actTab[cfg.type][planId] = cfg
				end
			end

			self._planId[cfg.program] = cfg.planIds
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

function M:getActivityTabCfg(tabId)
	return self._dict[ConfigName.ActivityTab] and self._dict[ConfigName.ActivityTab][tabId]
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s, key = %s", cfgName, key))
end

function M:getCfgTab(logicTyp, planId)
	if self._actTab[logicTyp] and self._actTab[logicTyp][planId] then
		return self._actTab[logicTyp][planId]
	end

	printError(string.format("无法从[t_%s]找到typ[%s]planId[%s]的配置", ConfigName.ActivityTab, logicTyp, planId))

	return nil
end

function M:getActivityTabId(logicTyp, planId)
	if self._actTab[logicTyp] and self._actTab[logicTyp][planId] then
		local cfg = self._actTab[logicTyp][planId]

		return cfg.id
	end
end

function M:isActivityTab(logicTyp, planId)
	if self._actTab[logicTyp] and self._actTab[logicTyp][planId] then
		return true
	end

	return false
end

function M:getCfgPlanId(className)
	return self._planId[className]
end

function M:getTabSystemOpenId(tabId)
	local cfg = self:getActivityTabCfg(tabId)

	return cfg and cfg.systemId
end

function M:getTabTipsId(tabId)
	local cfg = self:getActivityTabCfg(tabId)

	return cfg and cfg.tipsId
end

M.instance = M.New()

return M
