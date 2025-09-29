-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/controller/HouseTaskController.lua

module("logic.extensions.housemain.controller.HouseTaskController", package.seeall)

local M = class("HouseTaskController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	self:_setEvent(true)

	self._isInit = true
end

function M:onReset()
	self._isInit = nil
end

function M:checkInit()
	if not self._isInit then
		self:onInit()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TASK_SCHEDULE_CHANGE, self.onTaskSchedulePush, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TASK_SCHEDULE_CHANGE, self.onTaskSchedulePush, self)
	end
end

function M:getHouseInfoReply(msg)
	HouseTaskModel.instance:setHouseLevel(msg.level)
	HouseTaskModel.instance:setHouseExp(msg.exp)
	HouseTaskModel.instance:setHouseLevelReceive(msg.received)
	RoomBackpackModel.instance:setGoodsStore(msg.goodsStore)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_LEVEL_INFO_CHANGE)
end

function M:onHouseListTaskReply(tasks)
	HouseTaskModel.instance:updateTaskLst(tasks)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_TASK_INFO_CHANGE)
end

function M:onTaskRewardReceived(tasksIds, houseLevel, houseExp)
	HouseTaskModel.instance:onTaskRewardReceived(tasksIds)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_TASK_INFO_CHANGE)
	HouseTaskModel.instance:setHouseLevel(houseLevel)
	HouseTaskModel.instance:setHouseExp(houseExp)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_LEVEL_INFO_CHANGE)
end

function M:onTaskSchedulePush(e, msg)
	local taskNo = msg.task

	if taskNo then
		HouseTaskModel.instance:onTaskSchedulePush(taskNo)
		HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_TASK_INFO_CHANGE)
	end
end

function M:onRefreshTaskPush(refresh)
	if refresh then
		HouseAgent.instance:sendHouseListTaskRequest()
	end
end

function M:onReceiveLevelRewardReply(received)
	HouseTaskModel.instance:setHouseLevelReceive(received)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_LEVEL_INFO_CHANGE)
end

function M:onHouseExpChangePush(level, exp)
	HouseTaskModel.instance:setHouseLevel(level)
	HouseTaskModel.instance:setHouseExp(exp)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_LEVEL_INFO_CHANGE)
end

M.instance = M.New()

return M
