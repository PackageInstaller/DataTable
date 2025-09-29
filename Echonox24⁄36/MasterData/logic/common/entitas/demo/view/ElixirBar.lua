-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/ElixirBar.lua

module("logic.common.entitas.demo.view.ElixirBar", package.seeall)

local M = class("ElixirBar", IGameElixirListener)

ElixirCapacity = 14

function M:ctor(container)
	self._go = container.gameObject
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addElixirListener(self)

	self._entity = entity
	self._slider = self._go:GetComponent("Slider")
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
end

function M:OnGameElixir(entity, amount)
	local value = amount / ElixirCapacity

	self._slider.value = value
end

return M
