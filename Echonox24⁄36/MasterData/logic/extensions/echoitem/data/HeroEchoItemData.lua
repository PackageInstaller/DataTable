-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/data/HeroEchoItemData.lua

module("logic.extensions.echoitem.data.HeroEchoItemData", package.seeall)

local M = class("HeroEchoItemData")

function M:ctor()
	self._echoItemData = nil
end

function M:setEchoItem(echoItemData)
	self._echoItemData = echoItemData
end

function M:getEchoItem()
	return self._echoItemData
end

return M
