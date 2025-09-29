-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/chapter_reward/ChapterRewardController.lua

module("logic.extensions.welfare.controller.chapter_reward.ChapterRewardController", package.seeall)

local M = class("ChapterRewardController", BaseController)

function M:onInit()
	self:_addEvent()
end

function M:onReset()
	return
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.TASK_GET_TASKNOLIST, self._onGetTaskList, self)
	GlobalDispatcher:addEventListener(EventType.TASK_REFRESH_BOOL, self._onRefreshTaskList, self)
	GlobalDispatcher:addEventListener(EventType.TASK_RECEIVE_SUCCESS, self._onRecevieTaskReward, self)
	GlobalDispatcher:addEventListener(EventType.TASK_SCHEDULE_CHANGE, self._onTaskChange, self)
end

function M:_onGetTaskList(_, msg)
	if msg.label == TaskEnum.TaskLabel.ChapterReward then
		ChapterRewardModel.instance:setTaskList(msg.tasks)
		GlobalDispatcher:dispatchEvent(EventType.CHAPTER_REWARD_TASK_REFRESH)
	end
end

function M:_onRefreshTaskList(_, msg)
	local isRefresh = msg.refresh and msg.label == TaskEnum.TaskLabel.ChapterReward

	if isRefresh then
		TaskAgent.instance:sendListTaskRequest(msg.label)
	end
end

function M:_onRecevieTaskReward(_, taskIdList)
	local hasChapterTask = false

	for _, taskId in ipairs(taskIdList) do
		local isChapterTask = ChapterRewardModel.instance:receiveReward(taskId)

		hasChapterTask = hasChapterTask or isChapterTask
	end

	if hasChapterTask then
		GlobalDispatcher:dispatchEvent(EventType.CHAPTER_REWARD_TASK_REFRESH)
	end
end

function M:_onTaskChange(_, msg)
	local isChapterTask = ChapterRewardModel.instance:onTaskChange(msg.task)

	if isChapterTask then
		GlobalDispatcher:dispatchEvent(EventType.CHAPTER_REWARD_TASK_REFRESH)
	end
end

M.instance = M.New()

return M
