-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/config/TimeLimitActivityConfig.lua

module("logic.extensions.timelimitactivity.config.TimeLimitActivityConfig", package.seeall)

local M = class("TimeLimitActivityConfig", BaseConfig)

function M:onInit()
	self._cfgTimeLimit = false
end

function M:getNames()
	return {
		ConfigName.TimeLimitActivityEntrance
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.TimeLimitActivityEntrance then
		self._cfgTimeLimit = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getCfgTimeLimitActivity(id)
	return self._cfgTimeLimit[id]
end

M.instance = M.New()

return M
