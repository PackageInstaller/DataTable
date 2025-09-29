-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/ProduceElixirSystem.lua

module("logic.common.entitas.demo.systems.ProduceElixirSystem", package.seeall)

local Matcher = require("Matcher")
local _productionStep = 0.01
local M = class("ProduceElixirSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
	self.ElixirCapacity = 14
end

function M:get_trigger()
	return {
		{
			Matcher({
				GameComponents.Tick
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasTick()
end

function M:initialize()
	self._context:replaceElixir(0)
end

function M:execute(es)
	local newAmount = self._context.elixir.amount + _productionStep

	newAmount = math.min(self.ElixirCapacity, newAmount)

	self._context:replaceElixir(newAmount)
end

return M
