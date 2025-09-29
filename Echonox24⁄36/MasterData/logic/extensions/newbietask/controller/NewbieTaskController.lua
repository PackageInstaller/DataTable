-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/controller/NewbieTaskController.lua

module("logic.extensions.newbietask.controller.NewbieTaskController", package.seeall)

local M = class("NewbieTaskController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	self:_setEvent(true)
	self:onReset()
end

function M:onReset()
	self._cacheItemMOList = {}

	self:setCrossDay(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
	end
end

function M:setCrossDay(isCrossDay)
	self._CrossDay = isCrossDay
end

function M:getCrossDay()
	return self._CrossDay
end

function M:_handleClockTickDailyRefresh(e, enum)
	self:setCrossDay(true)
	NewbieTaskAgent.instance:sendGetTaskListRequest()
end

function M:regLoginPopUp()
	local append = true
end

function M:checkUpEntryHide()
	local needHide = NewbieTaskModel.instance:allTaskFinish() and NewbieTaskModel.instance:allStepRewardReceived()

	if needHide then
		GlobalDispatcher:dispatchEvent(EventType.NEWBIE_ALL_FINISH)
	end

	return needHide
end

function M:onTaskListReply(msg)
	local task = msg.task
	local stepPointLst = msg.takedInfo

	NewbieTaskModel.instance:updateTaskLst(task)
	NewbieTaskModel.instance:updateStepPointReceiveLst(stepPointLst)
	GlobalDispatcher:dispatchEvent(EventType.NEWBIE_TASK_INFO_CHANGE)

	local needHide = self:checkUpEntryHide()

	if self:getCrossDay() then
		self:setCrossDay(false)

		if not needHide then
			self:regLoginPopUp()
		end
	end
end

function M:onFinishTaskReply(msg)
	local ids = msg.id

	if ids and #ids > 0 then
		for _, taskId in ipairs(ids) do
			local taskMo = NewbieTaskModel.instance:getTaskMo(taskId)

			if taskMo then
				taskMo:setIsFinish(true)
			end
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.NEWBIE_TASK_INFO_CHANGE)
	self:popCacheItemMoList()
	self:checkUpEntryHide()
end

function M:onTakeStepRewardReply(msg)
	NewbieTaskModel.instance:updateStepPointReceiveLst({
		msg
	})
	GlobalDispatcher:dispatchEvent(EventType.NEWBIE_STEP_POINT_CHANGE)
	self:popCacheItemMoList()
	self:checkUpEntryHide()
end

function M:_isItemCache(code)
	for i, cacheItem in ipairs(self._cacheItemMOList) do
		if cacheItem:getItemId() == code then
			return cacheItem
		end
	end

	return false
end

function M:setCacheItemMOList(itemMoList)
	for _, item in ipairs(itemMoList) do
		if item:getType() ~= GameEnum.ItemTypeEnum.EchoItemType and item:getType() ~= GameEnum.ItemTypeEnum.HeroType then
			local cacheItem = self:_isItemCache(item:getItemId())

			if cacheItem then
				local count = cacheItem:getCount() + item:getCount()

				cacheItem:setCount(count)
			else
				table.insert(self._cacheItemMOList, item)
			end
		end
	end
end

function M:popCacheItemMoList()
	GainItemController.instance:openView(self._cacheItemMOList)
end

function M:clearCacheItem()
	self._cacheItemMOList = {}
end

M.instance = M.New()

return M
