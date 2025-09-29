-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/AIContext.lua

module("logic.extensions.ai.core.AIContext", package.seeall)

local AIContext = class("AIContext", AbstractGlobalReusable)

AIContext.END_STEP_INDEX = 999

local BehaviorStatus = HouseEnum.BehaviorStatus

function AIContext:ctor(unit, aiName)
	self.unit = unit
	self.aiName = aiName
	self._targetPos = nil
	self._targetRoomId = nil
	self._eatFoodChairUUId = nil
	self._dataId = -1
	self._behaviorData = nil
	self._step = -1
	self._useRandomPos = true
end

function AIContext:getCapacity()
	return 999
end

function AIContext:getUnit()
	return self.unit
end

function AIContext:isManualAI()
	return false
end

function AIContext:sink()
	return
end

function AIContext:float()
	return
end

function AIContext:setBehaviorData(data)
	local id = data:getId()

	if self._dataId == id then
		return
	end

	self._behaviorData = data
	self._dataId = id

	self:_setData()
end

function AIContext:getBehaviorData()
	return self._behaviorData
end

function AIContext:_setData()
	self:setTargetPos(self._behaviorData.targetPos, self._behaviorData.targetRoomId)

	self._step = self._behaviorData.step
	self._useRandomPos = self._behaviorData.useRandomPos
end

function AIContext:writebackToData()
	self._behaviorData.targetPos = nil

	if self._targetPos then
		self._behaviorData.targetPos = self._targetPos:Clone()
	end

	self._behaviorData.targetRoomId = self._targetRoomId
	self._behaviorData.step = self._step
	self._behaviorData.useRandomPos = self._useRandomPos
end

function AIContext:setStep(step)
	self._step = step
end

function AIContext:getStep()
	return self._step
end

function AIContext:setTargetPos(targetPos, targetRoomId)
	if targetPos then
		self._targetPos = targetPos:Clone()
	end

	if checknumber(targetRoomId) > 0 then
		self._targetRoomId = targetRoomId

		self.unit.model:setOccupyRoom(targetRoomId)
	end
end

function AIContext:getTargetRoomId()
	if not self._targetRoomId then
		printWarn("小人行为树数据错误，没有目标房间。小人id:", self.unit.heroId)
	end

	return self._targetRoomId
end

function AIContext:getDestination()
	if not self._targetPos then
		printWarn("小人行为树数据错误，没有目标坐标点。小人id:", self.unit.heroId)
	end

	return self._targetPos
end

function AIContext:setEatFoodChairId(uuid)
	self._eatFoodChairUUId = uuid
end

function AIContext:getEatFoodChairId()
	return self._eatFoodChairUUId
end

function AIContext:setUseRandomPos(use)
	self._useRandomPos = use
end

function AIContext:getUseRandomPos()
	return self._useRandomPos
end

function AIContext:onReset()
	self.unit.model:setBehaviorStatus(BehaviorStatus.None)
	self:writebackToData()
end

function AIContext:reuse(unit, aiName)
	self:onReuse(unit, aiName)
end

function AIContext:onReuse(unit, aiName)
	self.unit = unit
	self.aiName = aiName
end

function AIContext:reset()
	self:onRecycle()
end

function AIContext:onRecycle()
	self:_clearUnit()

	self.unit = nil
	self.aiName = nil

	self:clearData()
end

function AIContext:destroy()
	self:onDestroy()
end

function AIContext:onDestroy()
	self:clearData()
end

function AIContext:clearData()
	self._targetPos = nil
	self._targetRoomId = nil
	self._eatFoodChairUUId = nil
	self._dataId = -1
	self._behaviorData = nil
	self._step = -1
	self._useRandomPos = true
end

function AIContext:_clearUnit()
	self.unit.followRobot:destroyRobot()
	self.unit.followRobot:removeTransportGoods()
end

return AIContext
