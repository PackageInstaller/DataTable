-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/config/PlayerCourseConfig.lua

module("logic.extensions.playerinfo.config.PlayerCourseConfig", package.seeall)

local M = class("PlayerCourseConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.MainlineDiary
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.MainlineDiary then
		self._diaryCfgs = content
	end
end

function M:getDiaryCfgs(ids)
	local res = {}

	for _, v in ipairs(ids) do
		if self._diaryCfgs[v] then
			table.insert(res, self._diaryCfgs[v])
		else
			printError("can find MainlineDiaryConfig, id:" .. v)
		end
	end

	return res
end

M.instance = M.New()

return M
