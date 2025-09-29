-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/ElixirConsumePersistSystem.lua

module("logic.common.entitas.demo.systems.ElixirConsumePersistSystem", package.seeall)

local Matcher = require("Matcher")
local M = class("ElixirConsumePersistSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
end

function M:get_trigger()
	return {
		{
			Matcher({
				GameComponents.ConsumeElixir
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasConsumeElixir()
end

function M:execute(es)
	if self._context:hasPause() then
		return
	end

	local previousEntries = self._context:hasConsumptionHistory() and self._context.consumptionHistory.entries or {}

	es:foreach(function(e)
		table.insert(previousEntries, ConsumptionEntity.New(self._context.tick.currentTick, e.consumeElixir.amount))
	end)
	self._context:replaceConsumptionHistory(previousEntries)
end

return M
