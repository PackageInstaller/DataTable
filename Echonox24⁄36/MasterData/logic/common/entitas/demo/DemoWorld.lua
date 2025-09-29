-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/DemoWorld.lua

module("logic.common.entitas.demo.DemoWorld", package.seeall)

local M = class("DemoWorld")
local _systems

function M:ctor(comtainer)
	self._go = comtainer.gameObject
end

function M:Awake()
	local contexts = Contexts.sharedInstance

	_systems = self:createSystems(contexts)

	local logicSystems = self:createLogicSystems(contexts)

	_systems:add(logicSystems)
	_systems:add(GameEventSystems.New(contexts))
	contexts.game:setLogicSystem(logicSystems)
	_systems:initialize()
end

function M:Update()
	_systems:execute()
	_systems:cleanup()
end

function M:OnDestroy()
	_systems:tear_down()
end

function M:createSystems(contexts)
	return Feature.New(contexts, "Root System"):add(ReplaySystem.New(contexts)):add(CleanupConsumtionHistorySystem.New(contexts))
end

function M:createLogicSystems(contexts)
	return Feature.New(contexts, "Logic System"):add(TickUpdateSystem.New(contexts)):add(ProduceElixirSystem.New(contexts)):add(ConsumeElixirSystem.New(contexts)):add(ConsumeElixirCleanupSystem.New(contexts)):add(ElixirConsumePersistSystem.New(contexts))
end

return M
