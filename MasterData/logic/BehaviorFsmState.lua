-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/BehaviorFsmState.lua

module("logic.extensions.spineinterface.comp.BehaviorFsmState", package.seeall)

local BehaviorFsmState = class("BehaviorFsmState", MsFsmState)

function BehaviorFsmState:ctor(stateId, skinId, behaviorLayerId, behaviorId)
	BehaviorFsmState.super.ctor(self, stateId)

	self._skinId = skinId
	self._behaviorLayerId = behaviorLayerId
	self._behaviorId = behaviorId
	self._behaviorData = SpineInterfaceConfig.instance:getMsBehaviorData(self._skinId, self._behaviorLayerId, self._behaviorId)
	self._triggerType = self._behaviorData.triggerType
	self._triggerParam = self._behaviorData.triggerParam
	self._triggerBoardName = self._behaviorData.triggerBoardName
	self._triggerMotionMoList = {}

	if self._behaviorData.triggerMotions ~= nil then
		for _, motionData in ipairs(self._behaviorData.triggerMotions) do
			local mo = MsTriggerMotionMo.New()

			mo:onInit(motionData)
			table.insert(self._triggerMotionMoList, mo)
		end
	end

	self._nextStateId = nil

	local nextBehaviorId = self._behaviorData.nextBehaviorId

	if nextBehaviorId > 0 then
		self._nextStateId = SpineInterfaceController.instance:getFsmStateId(self._skinId, self._behaviorLayerId, nextBehaviorId)
	end

	self._isEnterTrigger = false
	self._currentTime = 0
	self._timerTriggerTime = 0
end

function BehaviorFsmState:onDestroy()
	BehaviorFsmState.super.onDestroy(self)

	self._skinId = 0
	self._behaviorLayerId = 0
	self._behaviorId = 0
	self._behaviorData = nil
	self._triggerType = nil
	self._triggerParam = nil
	self._triggerBoardName = nil

	table.clear(self._triggerMotionMoList)

	self._nextStateId = nil
	self._isEnterTrigger = false
	self._isNeedToNextState = false
	self._currentTime = 0
end

function BehaviorFsmState:onEnter()
	BehaviorFsmState.super.onEnter(self)

	self._isNeedToNextState = false
	self._isEnterTrigger = true
	self._currentTime = 0

	if self._triggerType == MsEnum.TriggerType_Timer then
		local time = self._triggerParam.time

		if time == nil then
			printError(string.format("配置错误，触发类型为Timer,但时间参数为空( skinId:%s, behaviorLayerId:%s, behaviorId:%s )", self._skinId, self._behaviorLayerId, self._behaviorId))
		else
			local minTime = checknumber(time[1])
			local maxTime = checknumber(time[2])

			self._timerTriggerTime = math.random(minTime, maxTime)
		end
	end
end

function BehaviorFsmState:onExit()
	BehaviorFsmState.super.onExit(self)

	self._isNeedToNextState = false
	self._isEnterTrigger = false
	self._currentTime = 0
end

function BehaviorFsmState:onUpdate(elapseSeconds, realElapseSeconds)
	BehaviorFsmState.super.onUpdate(self, elapseSeconds, realElapseSeconds)

	self._currentTime = self._currentTime + realElapseSeconds
end

function BehaviorFsmState:getTriggerType()
	return self._triggerType
end

function BehaviorFsmState:getTriggerParam()
	return self._triggerParam
end

function BehaviorFsmState:getTriggerBoardName()
	return self._triggerBoardName
end

function BehaviorFsmState:getTriggerMotionMoList()
	return self._triggerMotionMoList
end

function BehaviorFsmState:getTriggerMotionMoCount()
	return #self._triggerMotionMoList
end

function BehaviorFsmState:getCondValidator()
	return self._behaviorData.condValidator
end

function BehaviorFsmState:getTriggerValidator()
	return self._behaviorData.triggerValidator
end

function BehaviorFsmState:getNextStateId()
	return self._nextStateId
end

function BehaviorFsmState:isNeedToNextState()
	return self._isNeedToNextState
end

function BehaviorFsmState:setIsNeedToNextState(isNeedToNextState)
	self._isNeedToNextState = isNeedToNextState
end

function BehaviorFsmState:isEnterTrigger()
	return self._isEnterTrigger
end

function BehaviorFsmState:setIsEnterTrigger(isEnterTrigger)
	self._isEnterTrigger = isEnterTrigger
end

function BehaviorFsmState:getCurrentTime()
	return self._currentTime
end

function BehaviorFsmState:getTimerTriggerTime()
	return self._timerTriggerTime
end

return BehaviorFsmState
