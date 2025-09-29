-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/contract/UniversalHeroItemConfig.lua

module("logic.extensions.charactersystem.config.contract.UniversalHeroItemConfig", package.seeall)

local M = class("UniversalHeroItemConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.UniversalHeroItem
	}
end

function M:getInfo(id)
	local tableInfo = self._dict[ConfigName.UniversalHeroItem]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

M.instance = M.New()

return M
