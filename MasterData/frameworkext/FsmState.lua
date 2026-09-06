-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/fsm/FsmState.lua

module("frameworkext.ai.fsm.FsmState", package.seeall)

local FsmState = class("FsmState")

FsmState.Entered = 1
FsmState.Exited = 2

function FsmState:ctor(id)
	self.stateId = id
	self._stateMachine = nil
	self._stateGroup = nil
end

function FsmState:setFsm(stateMachine, stateGroup)
	self._stateMachine = stateMachine
	self._stateGroup = stateGroup
end

function FsmState:getGroup()
	return 0
end

function FsmState:onEnter()
	if self._dispatcher then
		self._dispatcher:dispatch(FsmState.Entered)
	end
end

function FsmState:onExit()
	return
end

function FsmState:onDestroy()
	self._stateMachine = nil
	self._dispatcher = nil
end

function FsmState:doExitDone()
	if self._dispatcher then
		self._dispatcher:dispatch(FsmState.Exited)
	end

	self._stateGroup:onExitDone(self)
end

function FsmState:addEnteredListener(handler, handlerObj)
	if not self._dispatcher then
		self._dispatcher = {}

		NotifyDispatcher.extend(self._dispatcher)
	end

	self._dispatcher:addListener(FsmState.Entered, handler, handlerObj)
end

function FsmState:removeEnteredListener(handler, handlerObj)
	if not self._dispatcher then
		return
	end

	self._dispatcher:removeListener(FsmState.Entered, handler, handlerObj)
end

function FsmState:addExitedListener(handler, handlerObj)
	if not self._dispatcher then
		self._dispatcher = {}

		NotifyDispatcher.extend(self._dispatcher)
	end

	self._dispatcher:addListener(FsmState.Exited, handler, handlerObj)
end

function FsmState:removeExitedListener(handler, handlerObj)
	if not self._dispatcher then
		return
	end

	self._dispatcher:removeListener(FsmState.Exited, handler, handlerObj)
end

return FsmState
