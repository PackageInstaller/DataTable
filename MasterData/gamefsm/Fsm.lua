-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\Fsm.lua

local strClassName = "Fsm"
local Fsm = Class(strClassName)

function Fsm:ctor()
	self.mStates = {}
	self.mCurStateName = nil
	self.mEventTranslate = nil
end

function Fsm:addState(newState)
	self.mStates[newState.stateName] = newState
end

function Fsm:translateState(tgtStateName, enterArgs)
	if self.mCurStateName then
		local curState = self.mStates[self.mCurStateName]

		if curState then
			curState:exit(tgtStateName)
		end
	end

	local preStateName = self.mCurStateName

	self.mCurStateName = tgtStateName

	if tgtStateName then
		local tgtState = self.mStates[tgtStateName]

		if tgtState then
			tgtState:enter(preStateName, enterArgs)
		end
	end

	if self.mEventTranslate ~= nil then
		self.mEventTranslate(preStateName, tgtStateName)
	end
end

function Fsm:getState(tgtStateName)
	tgtStateName = tgtStateName or self.mCurStateName

	return self.mStates[tgtStateName]
end

function Fsm:isInState(tgtS)
	return self.mCurStateName == tgtS
end

function Fsm:getCurState()
	return self:getState()
end

return Fsm
