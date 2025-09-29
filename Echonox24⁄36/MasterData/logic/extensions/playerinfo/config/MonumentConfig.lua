-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/config/MonumentConfig.lua

module("logic.extensions.playerinfo.config.MonumentConfig", package.seeall)

local M = class("MonumentConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.Cup
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Cup then
		self._cupCfgs = content
	end
end

function M:getAllMonumentCfgs()
	return self._cupCfgs.dataList
end

function M:getMonumentCfgsByNo(no)
	local ret = {}

	for _, cfg in ipairs(self._cupCfgs.dataList) do
		if cfg.no == no then
			table.insert(ret, cfg)
		end
	end

	table.sort(ret, function(cfg1, cfg2)
		return cfg1.lv < cfg2.lv
	end)

	return ret
end

function M:getMonumentCfgById(id)
	return self._cupCfgs[id]
end

function M:maxGradeUpLevel(no)
	local maxLevel = 1

	for _, cfg in ipairs(self._cupCfgs.dataList) do
		if cfg.no == no then
			maxLevel = cfg.lv
		end
	end

	return maxLevel
end

M.instance = M.New()

return M
