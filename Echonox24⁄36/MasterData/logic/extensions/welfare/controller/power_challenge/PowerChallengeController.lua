-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/power_challenge/PowerChallengeController.lua

module("logic.extensions.welfare.controller.power_challenge.PowerChallengeController", package.seeall)

local M = class("PowerChallengeController", BaseController)

function M:onInit()
	self:_addEvent()
end

function M:onReset()
	return
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.TASK_GET_TASKNOLIST, self._onGetTaskList, self)
	GlobalDispatcher:addEventListener(EventType.TASK_REFRESH_BOOL, self._onRefreshTaskList, self)
end

function M:_onGetTaskList(_, msg)
	if msg.label == TaskEnum.TaskLabel.PowerChallenge then
		PowerChallengeModel.instance:updateTaskLst(msg.tasks)
		GlobalDispatcher:dispatchEvent(EventType.POWER_CHALLENGE_TASK_REFRESH)
	end
end

function M:_onRefreshTaskList(_, msg)
	local isRefresh = msg.refresh and msg.label == TaskEnum.TaskLabel.PowerChallenge

	if isRefresh then
		TaskAgent.instance:sendListTaskRequest(msg.label)
	end
end

M.instance = M.New()

return M
