-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/fsm/FiniteStateGroup.lua

module("frameworkext.ai.fsm.FiniteStateGroup", package.seeall)

local FiniteStateGroup = class("FiniteStateGroup")

function FiniteStateGroup:ctor(fsm)
	self._states = {}
	self._curStateId = -1
	self._targetStateId = -1
	self._stateMachine = nil
end

function FiniteStateGroup:getCurStateId()
	return self._curStateId
end

function FiniteStateGroup:getTargetStateId()
	return self._targetStateId
end

function FiniteStateGroup:addState(state)
	self._states[state.stateId] = state

	state:setFsm(self._stateMachine, self)
end

function FiniteStateGroup:destroy()
	for k, v in pairs(self._states) do
		v:onDestroy()
	end

	self._states = nil
	self._stateMachine = nil
end

function FiniteStateGroup:enterState(newStateId)
	if self._curStateId == newStateId then
		return
	end

	if not self._states[newStateId] then
		printWarn("Unkown stateId:", newStateId)

		return
	end

	if self._targetStateId > -1 then
		self._targetStateId = newStateId
	else
		self._targetStateId = newStateId

		local state = self._states[self._curStateId]

		state:onExit()
	end
end

function FiniteStateGroup:onExitDone(state)
	if state.stateId ~= self._curStateId then
		return
	end

	self._curStateId = self._targetStateId
	self._targetStateId = -1

	local targetState = self._states[self._curStateId]

	targetState:onEnter()
end

return FiniteStateGroup
