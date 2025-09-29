-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/impl/DefaultRogueGameFlow.lua

module("logic.extensions.roguelike.flow.impl.DefaultRogueGameFlow", package.seeall)

local M = class("DefaultRogueGameFlow", IRogueGameFlowHandler)

function M:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
	self:_notifyComponents(BattleFunctionName.onInit)
	self:handleInit()
end

function M:handleInit()
	return
end

function M:enter()
	self:_notifyComponents(BattleFunctionName.onStart)
end

function M:exit()
	self:_notifyComponents(BattleFunctionName.onClear)
end

function M:_registerComponents()
	self:_addComponent("gamePlay", RogueGamePlayMgr)
end

function M:_notifyComponents(functionName)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function M:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

return M
