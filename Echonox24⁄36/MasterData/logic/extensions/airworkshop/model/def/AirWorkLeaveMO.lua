-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkLeaveMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkLeaveMO", package.seeall)

local M = class("AirWorkLeaveMO", AirWorkUnitMOBase)

function M:_initByAgent(unionIndex)
	self._unionIndex = unionIndex
end

function M:setUnionIndex(unionIndex)
	self._unionIndex = unionIndex
end

function M:getUnionIndex()
	return self._unionIndex
end

function M:trans2AgentForm()
	return self._unionIndex
end

return M
