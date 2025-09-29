-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/ReplaySystem.lua

module("logic.common.entitas.demo.systems.ReplaySystem", package.seeall)

local Matcher = require("Matcher")
local M = class("ReplaySystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
end

function M:get_trigger()
	return {
		{
			Matcher({
				GameComponents.JumpInTime
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasJumpInTime()
end

function M:initialize()
	self._context:replaceElixir(0)
end

function M:execute(es)
	local logicSystems = self._context.logicSystem.systems

	logicSystems:initialize()

	local actions = self._context:hasConsumptionHistory() and self._context.consumptionHistory.entries or {}
	local actionIndex = 0

	for tick = 0, self._context.jumpInTime.targetTick do
		self._context:replaceTick(tick)

		if actionIndex < #actions and actions[actionIndex] ~= nil and actions[actionIndex]:getTick() == tick then
			self._context:CreateEntity():addConsumeElixir(actions[actionIndex].amount)

			actionIndex = actionIndex + 1
		end

		logicSystems:execute()
	end
end

return M
