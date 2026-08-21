-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Behavior\\Behavior.lua

local BehaviorState = require("Common/FrameBattle/Behavior/BehaviorState")
local BehaviorSerialization = require("Common/FrameBattle/Behavior/BehaviorSerialization")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "Behavior"
local Behavior = Class(strClassName)

function Behavior:ctor(entity, bhVariables, bhMgr)
	self.entityID = entity.id
	self.weaponType = entity.weaponType
	self.mStateDict = {}
	self.mEventList = {}
	self.mEventHandler = {}
	self.mVariables = bhVariables or {}

	BehaviorSerialization.init(self, self.weaponType)

	self.bhMgr = bhMgr

	bhMgr:addBehavior(self.entityID, self)

	self.mEntity = entity

	if self:getVariable("frameLength") == nil then
		self:setVariable("frameLength", 50)
	end

	self.inPause = false
end

function Behavior:destroy()
	self.bhMgr:delBehavior(self.entityID)

	self.bhMgr = nil

	self:clearEventHandler()

	self.mEventList = nil
	self.mEventHandler = nil
	self.mVariables = nil
end

function Behavior:addEventHandler(eventName, func)
	if BattleConst.EVENT_MAP[eventName] == nil then
		return nil
	end

	if BattleConst.EVENT_MAP[eventName] == BattleConst.BEHAVIOR_IGNORE then
		return nil
	end

	if not self.mEventHandler[eventName] then
		self.mEventHandler[eventName] = {}
	end

	table.insert(self.mEventHandler[eventName], func)
end

function Behavior:clearEventHandler(eventName)
	if self.mEventHandler[eventName] then
		self.mEventHandler[eventName] = {}
	end
end

function Behavior:delEventHandler(eventName, func)
	if self.mEventHandler[eventName] then
		local removeIndex = utils.getIndexByValue(self.mEventHandler[eventName], func)

		if removeIndex >= 0 then
			table.remove(self.mEventHandler[eventName], removeIndex)
		end
	end
end

function Behavior:useSkill(conditionName, useSkillArgs)
	if self.mStateDict[conditionName] then
		self:changeState(conditionName, -1, useSkillArgs)
	else
		table.insert(self.mEventList, BehaviorState.SkillEndEvent)
	end
end

function Behavior:changeState(nextState, duration, useSkillArgs, behaviorAnim)
	if self.mCurrentState then
		self.mCurrentState:exit()

		self.mCurrentState = nil
	end

	self.mEventList = {}

	if self.mStateDict[nextState] then
		self.duration = -1
		self.mCurrentState = self.mStateDict[nextState]

		self.mCurrentState:enter(useSkillArgs or {})
		self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM, {
			self.mCurrentState.mStateName,
			self.mCurrentState.aniSpeed,
			self.mCurrentState.skillCd
		})
	else
		if duration > 0 then
			self.duration = self:timeToFrame(duration)
			self.nowFrame = 0
		else
			self.duration = duration
		end

		self.stateName = BattleConst.DEFAULT_BH_STATE[nextState]

		self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM, {
			self.stateName or behaviorAnim
		})
	end

	self:handleEventList()
end

function Behavior:timeToFrame(seconds)
	local frame = math.floor(seconds * 1000 / self:getVariable("frameLength"))

	return frame
end

function Behavior:setVariable(varName, varValue)
	if self.mVariables[varName] == nil then
		self.mVariables[varName] = 0
	end

	self.mVariables[varName] = varValue
end

function Behavior:getVariable(varName)
	return self.mVariables[varName]
end

function Behavior:tick()
	if self.inPause then
		return false
	end

	if self.mCurrentState then
		self.mCurrentState:tick()
	elseif self.duration and self.duration > 0 then
		self.nowFrame = self.nowFrame + 1

		if self.nowFrame >= self.duration then
			table.insert(self.mEventList, {
				Type = BattleConst.BEHAVIOR_NOTICE_EVENT,
				Name = BattleConst.BEHAVIOR_END
			})
		end
	end
end

function Behavior:pauseBH()
	self.inPause = true
end

function Behavior:cancelPauseBH()
	self.inPause = false
end

function Behavior:handleEventList()
	if #self.mEventList > 0 then
		local eventInfo = self.mEventList[1]

		table.remove(self.mEventList, 1)
		self:_handleEvent(eventInfo)
	end

	if #self.mEventList > 0 then
		self:handleEventList()
	end
end

function Behavior:_handleEvent(eventInfo)
	local eventName = eventInfo.Name
	local eventType = eventInfo.Type

	if eventType == BattleConst.BEHAVIOR_NOTICE_EVENT then
		local eventPackage = {
			eventName,
			eventInfo.StringParameter,
			eventInfo.FloatParameter,
			eventInfo.IntParameter
		}

		if self.mEventHandler[eventName] then
			for i, f in ipairs(self.mEventHandler[eventName]) do
				f(eventPackage)
			end
		end
	end
end

return Behavior
