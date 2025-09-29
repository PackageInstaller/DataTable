-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reddot/config/RedDotConfig.lua

module("logic.extensions.reddot.config.RedDotConfig", package.seeall)

local M = class("RedDotConfig", BaseConfig)

function M:onInit()
	self._redots = {}
end

function M:getNames()
	return {
		ConfigName.RedDot
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.RedDot then
		self._redots = content
	end
end

function M:getRedDotById(id)
	return self._redots[id]
end

M.instance = M.New()

return M
