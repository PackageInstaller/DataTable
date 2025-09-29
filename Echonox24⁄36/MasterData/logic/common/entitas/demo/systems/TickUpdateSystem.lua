-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/TickUpdateSystem.lua

module("logic.common.entitas.demo.systems.TickUpdateSystem", package.seeall)

local M = class("TickUpdateSystem", EntitasSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
end

function M:initialize()
	self._context:replaceTick(0)
end

function M:execute()
	if not self._context:hasPause() then
		self._context:replaceTick(self._context.tick.currentTick + 1)
	end
end

return M
