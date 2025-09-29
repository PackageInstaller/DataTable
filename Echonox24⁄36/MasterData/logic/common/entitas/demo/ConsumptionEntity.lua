-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/ConsumptionEntity.lua

module("logic.common.entitas.demo.ConsumptionEntity", package.seeall)

local M = class("ConsumptionEntity")

function M:ctor(tick, amount)
	self._tick = tick
	self._amount = amount
end

function M:getTick()
	return self._tick
end

function M:getAmount()
	return self._amount
end

return M
