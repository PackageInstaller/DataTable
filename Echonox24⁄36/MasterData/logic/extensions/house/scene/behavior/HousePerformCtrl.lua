-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/behavior/HousePerformCtrl.lua

module("logic.extensions.house.scene.behavior.HousePerformCtrl", package.seeall)

local M = class("HousePerformCtrl")
local PerformStatus = HouseEnum.PerformStatus
local PerformCtrlType = HouseEnum.PerformCtrlType
local AnimationState = HouseEnum.AnimationState
local kDelimiterJH = "#"

function M.createId(heroIdA, heroIdB)
	if heroIdA and heroIdB then
		if heroIdB < heroIdA then
			return string.format("%s%s%s", heroIdB, kDelimiterJH, heroIdA)
		end

		return string.format("%s%s%s", heroIdA, kDelimiterJH, heroIdB)
	elseif heroIdA then
		return tostring(heroIdA)
	end
end

function M:ctor()
	self._id = nil
	self._performStatus = PerformStatus.None
	self._performUnitA = nil
	self._performUnitB = nil
	self._usablePerformCOs = {}
	self._currPerformCO = nil
	self._parallelPFTotalNum = 0
	self._parallelPFNum = 0
	self._performDataA = nil
	self._performDataB = nil
	self._doingBreakPerform = false
	self._wordBubbleTimer = SchedulerCtrl.New(self._showDefaultWordBubble, self)
	self._cdTimer = SchedulerCtrl.New(self._endPerformCD, self)
	self._lastWordInst = nil
	self._lastActionInst = nil
end

function M:clear()
	FrameUpdate:removeListener(self)
	self._wordBubbleTimer:clear()

	self._wordBubbleTimer = nil

	self._cdTimer:clear()

	self._cdTimer = nil

	self:_clearPerformInst()

	self._id = nil
	self._performStatus = PerformStatus.None
	self._performUnitA = nil
	self._performUnitB = nil

	table.clear(self._usablePerformCOs)

	self._currPerformCO = nil
	self._parallelPFTotalNum = 0
	self._parallelPFNum = 0
	self._doingBreakPerform = false
	self._lastWordInst = nil
	self._lastActionInst = nil
	self._endCallback = nil
	self._endTarget = nil
end

function M:_tryCreatePerformInst()
	if not self._performInstA then
		self._performInstA = HousePerformInstance:createInstance()

		self._performInstA:setUnit(self._performUnitA)
		self._performInstA:setOtherPlayer(self._performUnitB)
	end

	if not self._performInstB then
		self._performInstB = HousePerformInstance:createInstance()

		self._performInstB:setUnit(self._performUnitB)
		self._performInstB:setOtherPlayer(self._performUnitA)
	end
end

function M:_clearPerformInst()
	if self._performInstA then
		self._performInstA:returnSelf()
	end

	self._performInstA = nil

	if self._performInstB then
		self._performInstB:returnSelf()
	end

	self._performInstB = nil
end

function M:_canPlayDefaultPerform(performCO)
	local canPlay = true

	if performCO:getId() == HouseEnum.DEFAULT_SINGLE_PERFORM_ID or performCO:getId() == HouseEnum.DEFAULT_DOUBLE_PERFORM_ID then
		canPlay = not HouseGMController.instance:getForbidDefaultPerform()
	end

	return canPlay
end

function M:getCtrlType()
	return
end

function M:setId(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:setEndCallback(callback, target)
	self._endCallback = callback
	self._endTarget = target
end

function M:containHero(heroId)
	local ids = string.split(self._id, kDelimiterJH)
	local id1 = checknumber(ids[1])
	local id2 = checknumber(ids[2])

	return heroId == id1 or heroId == id2
end

function M:reFindAllUsablePerformCO()
	return self._usablePerformCOs
end

function M:getAllUsablePerformCO()
	return self._usablePerformCOs
end

function M:getPerformStatus()
	return self._performStatus
end

function M:canPerform()
	return self._performStatus == PerformStatus.None
end

function M:setPerformUnits(unitA, unitB)
	self._performUnitA = unitA
	self._performUnitB = unitB
end

function M:luaUpdate(dt)
	if not self._doingBreakPerform and self:_canBreakPerform(true) then
		self:showBreakPerformance()
	end
end

function M:showPerformance()
	self._currPerformCO = self:_getPerformCOByWeight()

	local performId = self._currPerformCO:getId()

	self._doingBreakPerform = false
	self._performStatus = PerformStatus.Running

	self:_tryCreatePerformInst()
	self:_beforeStartPerform()
	FrameUpdate:addListener(self)

	if self._currPerformCO:isDefault() then
		self:_startDefaultPerform()
	else
		self:_startPerformQueue()
	end

	return performId
end

function M:_beforeStartPerform()
	return
end

function M:showBreakPerformance()
	if self:_canBreakPerform() and not self._doingBreakPerform then
		self._doingBreakPerform = true

		self._performInstA:interruptPerform()
		self._performInstB:interruptPerform()
		self:_startPerformQueue()
	end
end

function M:_canBreakPerform(withCondition)
	if self._currPerformCO and self._currPerformCO:canBreak() and self._performStatus == PerformStatus.Running then
		if withCondition then
			if self._performUnitA then
				return self._currPerformCO:isBreakConditionMatch(self._performUnitA)
			end
		else
			return true
		end
	end

	return false
end

function M:_beforeEndPerform(isInterrput)
	return
end

function M:interruptPerform()
	if self._performStatus == PerformStatus.Running then
		self:endPerformance(true)
	end
end

function M:endPerformance(isInterrput)
	FrameUpdate:removeListener(self)
	self._wordBubbleTimer:stop()

	if isInterrput then
		self._performInstA:interruptPerform()
		self._performInstB:interruptPerform()
	else
		self._performInstA:endPerform()
		self._performInstB:endPerform()
	end

	self:_beforeEndPerform(isInterrput)

	self._currPerformCO = nil
	self._doingBreakPerform = false
	self._performStatus = PerformStatus.CDing

	self:_startPerformCDTimer()

	if self._endCallback then
		self._endCallback(self._endTarget)
	end
end

function M:_startPerformCDTimer()
	local performCd = HouseConfig.instance:getHouseConst("PerformCd")

	self._cdTimer:restart(performCd.numValue, false)
end

function M:_endPerformCD()
	self._performStatus = PerformStatus.None

	self:_clearPerformInst()
end

function M:clearPerformCD()
	self._cdTimer:stop()

	self._performStatus = PerformStatus.None
end

function M:_getPerformCOByWeight()
	local totalWeight = 0

	for _, CO in ipairs(self._usablePerformCOs) do
		totalWeight = totalWeight + CO:getWeight()
	end

	local weight = math.random(1, totalWeight)

	for _, CO in ipairs(self._usablePerformCOs) do
		if weight <= CO:getWeight() then
			return CO
		end

		weight = weight - CO:getWeight()
	end
end

function M:_startPerformQueue()
	self._currPerformQueue = self._doingBreakPerform and self._currPerformCO:getBreakPerformQueueClone() or self._currPerformCO:getPerformQueueClone()

	self._performInstA:setFinishCallback(self._finishOnePerform, self)
	self._performInstA:setPerformCO(self._currPerformCO)
	self._performInstA:setBreaking(self._doingBreakPerform)
	self._performInstB:setFinishCallback(self._finishOnePerform, self)
	self._performInstB:setPerformCO(self._currPerformCO)
	self._performInstB:setBreaking(self._doingBreakPerform)
	self:_showNextPerform()
end

function M:_showNextPerform()
	if self._currPerformQueue:size() == 0 then
		self:endPerformance()

		return
	end

	local performs = self._currPerformQueue:dequeue()

	self._parallelPFTotalNum = #performs
	self._parallelPFNum = 0

	for _, perform in ipairs(performs) do
		local type = tonumber(perform.arr[1])
		local paramlist = string.split(perform.arr[2], kDelimiterJH)
		local performInst = self._performInstA

		if table.indexof(HousePerformInstance.LimitPlayerTypes, type) and paramlist[2] == "B" then
			performInst = self._performInstB
		end

		performInst:perform(type, paramlist)
	end
end

function M:_finishOnePerform()
	self._parallelPFNum = self._parallelPFNum + 1

	if self._parallelPFNum >= self._parallelPFTotalNum then
		self:_showNextPerform()
	end
end

local kPerformTimeMin = 20
local kPerformTimeMax = 40
local kBubbleStartTimeMin = 5
local kBubbleStartTimeMax = 10
local kBubbleIntervalTimeMin = 10
local kBubbleIntervalTimeMax = 12
local kActionStartTimeMin = 10
local kActionStartTimeMax = 15
local kActionIntervalTimeMin = 5
local kActionIntervalTimeMax = 10
local kSingleActionList = {
	AnimationState.Speak,
	AnimationState.Happy,
	AnimationState.Sad,
	AnimationState.Nod,
	AnimationState.Shake
}
local kDoubleActionList = {
	AnimationState.Speak,
	AnimationState.Happy,
	AnimationState.Sad,
	AnimationState.Nod,
	AnimationState.Shake,
	AnimationState.Jump,
	AnimationState.Shock
}

function M:_startDefaultPerform()
	local limitCount = 2

	self._defaultPerformEndTime = Time.time + math.random(kPerformTimeMin, kPerformTimeMax)

	self._performInstA:setFinishCallback(self._showNextDefaultPerform, self)
	self._performInstA:setPerformCO(self._currPerformCO)
	self._performInstA:initWords(limitCount)
	self._performInstB:setFinishCallback(self._showNextDefaultPerform, self)
	self._performInstB:setPerformCO(self._currPerformCO)
	self._performInstB:initWords(limitCount)

	self._lastWordInst = nil
	self._lastActionInst = nil

	local time = math.random(kBubbleStartTimeMin, kBubbleStartTimeMax) / 10

	self._wordBubbleTimer:restart(time, false)
	self:_showNextDefaultPerform()
end

function M:_showNextDefaultPerform()
	if Time.time > self._defaultPerformEndTime then
		if self._performUnitA then
			self._performUnitA.bubble:endBubble()
		end

		if self._performUnitB then
			self._performUnitB.bubble:endBubble()
		end

		self:endPerformance()

		return
	end

	self:_showDefaultAction()
end

function M:_showDefaultAction()
	local performInst = self._performInstA
	local actionName = kSingleActionList[math.random(1, #kSingleActionList)]

	if self._currPerformCO:getPerformType() == PerformCtrlType.Double then
		local rateA = 50

		if self._lastActionInst == self._performInstA then
			rateA = 30
		elseif self._lastActionInst == self._performInstB then
			rateA = 70
		end

		local randomNum = math.random(1, 100)

		performInst = randomNum <= rateA and self._performInstA or self._performInstB
		actionName = kDoubleActionList[math.random(1, #kDoubleActionList)]
	end

	local waitTime = 0

	if self._lastActionInst == nil then
		waitTime = math.random(kActionStartTimeMin, kActionStartTimeMax) / 10
	else
		waitTime = math.random(kActionIntervalTimeMin, kActionIntervalTimeMax) / 10
	end

	local paramlist = {
		waitTime,
		[4] = 1,
		[3] = actionName
	}

	performInst:perform(3, paramlist)

	self._lastActionInst = performInst
end

function M:_showDefaultWordBubble()
	local performInst = self._performInstA

	if self._currPerformCO:getPerformType() == PerformCtrlType.Double then
		local rateA = 50

		if self._lastWordInst == self._performInstA then
			rateA = 30
		elseif self._lastWordInst == self._performInstB then
			rateA = 70
		end

		local randomNum = math.random(1, 100)

		performInst = randomNum <= rateA and self._performInstA or self._performInstB
	end

	if performInst:showWordBubble() then
		self._lastWordInst = performInst
	end

	local time = math.random(kBubbleIntervalTimeMin, kBubbleIntervalTimeMax) / 10

	self._wordBubbleTimer:restart(time, false)
end

return M
