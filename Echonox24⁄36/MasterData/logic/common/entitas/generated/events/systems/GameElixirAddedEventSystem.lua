-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/systems/GameElixirAddedEventSystem.lua

module("logic.common.entitas.generated.events.systems.GameElixirAddedEventSystem", package.seeall)

local Game_comps = GameComponents
local Game_comps_ext = GameElixirListenerComponent
local Matcher = require("Matcher")
local M = class("GameElixirAddedEventSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context)

	self._listeners = context:get_group(Matcher({
		Game_comps.ElixirListener
	}))
end

function M:get_trigger()
	return {
		{
			Matcher({
				Game_comps.Elixir
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasElixir()
end

function M:execute(es)
	local buffer = self._listeners:get_entity_buffer()

	es:foreach(function(e)
		local comp = e.elixir

		for _, entity in pairs(buffer) do
			local list = entity.elixirListener.value

			list:OnGameElixir(e, comp.amount)
		end
	end)
end

function GameEntity:hasElixirListener()
	return self:has(Game_comps.ElixirListener) ~= nil
end

function GameEntity:addElixirListener(value)
	self:add(Game_comps.ElixirListener, value)

	return self
end

function GameEntity:replaceElixirListener(value)
	self:replace(Game_comps.ElixirListener, value)

	return self
end

function GameEntity:removeElixirListener()
	self:remove(Game_comps.ElixirListener)

	return self
end

return M
