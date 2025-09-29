-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/config/RogueConstConfig.lua

module("logic.extensions.roguelike.config.RogueConstConfig", package.seeall)

local M = class("RogueConstConfig", BaseConfig)

function M:onInit()
	self._endOptions = {}
end

function M:getNames()
	return {
		ConfigName.RoguelikeEndOption
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.RoguelikeEndOption then
		self._endOptions = content
	end
end

function M:getOptionCoById(id)
	return self._endOptions[id]
end

M.instance = M.New()

return M
