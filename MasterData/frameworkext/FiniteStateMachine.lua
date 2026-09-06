-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/fsm/FiniteStateMachine.lua

module("frameworkext.ai.fsm.FiniteStateMachine", package.seeall)

local FiniteStateMachine = class("FiniteStateMachine")

function FiniteStateMachine:ctor()
	self._groups = {}
	self._states = {}
end

function FiniteStateMachine:registerState(state)
	local group = state:getGroup()
	local stateGroup = self._groups[group]

	if not stateGroup then
		stateGroup = FiniteStateGroup.New(self)
		self._groups[group] = stateGroup
	end

	self._states[state.stateId] = state

	stateGroup:addState(state)
end

function FiniteStateMachine:getState(stateId)
	return self._states[stateId]
end

function FiniteStateMachine:isActive(stateId)
	local state = self._states[stateId]

	if not state then
		printWarn("Unkown FiniteStateMachine stateId:", stateId)

		return false
	end

	local group = state:getGroup()
	local stateGroup = self._groups[group]

	if not stateGroup then
		return false
	end

	return stateGroup:getCurStateId() == stateId
end

function FiniteStateMachine:isExiting(stateId)
	local state = self._states[stateId]

	if not state then
		printWarn("Unkown FiniteStateMachine stateId:", stateId)

		return false
	end

	local group = state:getGroup()
	local stateGroup = self._groups[group]

	if not stateGroup then
		return false
	end

	return stateGroup:getCurStateId() == stateId and stateGroup:getTargetStateId() > -1
end

function FiniteStateMachine:isTargetState(stateId)
	local state = self._states[stateId]

	if not state then
		printWarn("Unkown FiniteStateMachine stateId:", stateId)

		return false
	end

	local group = state:getGroup()
	local stateGroup = self._groups[group]

	if not stateGroup then
		return false
	end

	return stateGroup:getTargetStateId() == stateId
end

function FiniteStateMachine:destroy()
	for k, v in pairs(self._groups) do
		v:destroy()
	end

	self._groups = nil
	self._states = nil
end

function FiniteStateMachine:enterState(newStateId)
	local newState = self._states[newStateId]

	if not newState then
		printWarn("Unkown FiniteStateMachine stateId:", newStateId)

		return
	end

	local newGroup = newState:getGroup()
	local newStateGroup = self._groups[newGroup]

	if newStateGroup then
		newStateGroup:enterState(newStateId)
	end
end

return FiniteStateMachine
