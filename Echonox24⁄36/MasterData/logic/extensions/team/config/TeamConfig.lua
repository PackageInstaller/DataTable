-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/config/TeamConfig.lua

module("logic.extensions.team.config.TeamConfig", package.seeall)

local M = class("TeamConfig", BaseConfig)

function M:onInit()
	self._cfgTeam = false
end

function M:getNames()
	return {
		ConfigName.Team
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Team then
		self._cfgTeam = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getCfgTeamInfoByID(teamid)
	local teamCO = self._cfgTeam[teamid]

	if teamid > 0 and not teamCO and enableErrorLog then
		printError(string.format("TeamConfig::cannot find team config for teamid[%s]", teamid))
	end

	return teamCO
end

function M:getCfgTeam()
	return self._cfgTeam.dataList
end

M.instance = M.New()

return M
