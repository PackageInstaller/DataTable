-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/GameEventSystems.lua

module("logic.common.entitas.generated.events.GameEventSystems", package.seeall)

local M = class("GameEventSystems", Feature)

function M:ctor(contexts)
	M.super.ctor(self, contexts)
	self:add(GameElixirAddedEventSystem.New(contexts.game))
	self:add(GamePauseAddedEventSystem.New(contexts.game))
	self:add(GameTickAddedEventSystem.New(contexts.game))
end

return M
