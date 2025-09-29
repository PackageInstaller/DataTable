-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/CleanupConsumtionHistorySystem.lua

module("logic.common.entitas.demo.systems.CleanupConsumtionHistorySystem", package.seeall)

local Matcher = require("Matcher")
local M = class("CleanupConsumtionHistorySystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
end

function M:get_trigger()
	return {
		{
			Matcher({
				GameComponents.Pause
			}),
			GroupEvent.REMOVED
		}
	}
end

function M:filter(entity)
	return entity:hasPause()
end

function M:execute(es)
	local actions = self._context:hasConsumptionHistory() and self._context.consumptionHistory.entries or {}
	local count = 0

	for i = #actions, 0, -1 do
		if actions[i].tick > self._context.tick.currentTick then
			count = count + 1
		end
	end

	for i = 1, count do
		table.remove(actions, #actions)
	end
end

return M
