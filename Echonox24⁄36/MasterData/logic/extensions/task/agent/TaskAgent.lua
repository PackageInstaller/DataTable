-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/agent/TaskAgent.lua

module("logic.extensions.task.agent.TaskAgent", package.seeall)

local M = class("TaskAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:handleRefreshPush(status, msg)
	if status == 0 and msg.refresh then
		-- block empty
	end
end

function M:handleOnTaskSchedulePush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.TASK_SCHEDULE_CHANGE, msg)
	end
end

function M:_updateTask(tasks)
	if not tasks then
		return
	end

	local taskLen = #tasks

	for i = 1, taskLen do
		TaskModel.instance:initTaskData(tasks[i].id, tasks[i].count, tasks[i].finish)
	end
end

function M:_updatePoint(points)
	if not points then
		return
	end

	local len = #points

	for i = 1, len do
		local tabId = points[i].label
		local labelCO = TaskConfig.instance:getTaskLabelCO(tabId)

		if labelCO and labelCO.pointIds then
			local pointLength = #labelCO.pointIds

			if pointLength >= 1 then
				for m = 1, pointLength do
					local isFinish = false
					local boxLen = #points[i].boxes

					for n = 1, boxLen do
						if points[i].boxes[n] == labelCO.pointIds[m] then
							isFinish = true
						end
					end

					TaskModel.instance:initPointData(tabId, points[i].point, isFinish, labelCO.pointIds[m])
				end
			end
		end
	end
end

function M:sendListTaskRequest(label)
	local msg = TaskExtension_pb.ListTaskRequest()

	msg.label = label

	self:sendMsg(msg)
end

function M:handleListTaskReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.TASK_GET_TASKNOLIST, msg)
	end
end

function M:sendRewardRequest(taskIdtable)
	local msg = TaskExtension_pb.RewardRequest()

	for k, v in pairs(taskIdtable) do
		table.insert(msg.id, v)
	end

	self:sendMsg(msg)
end

function M:handleRewardReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.TASK_RECEIVE_SUCCESS, msg.tasks)
	end
end

function M:handleRefreshTaskPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.TASK_REFRESH_BOOL, msg)
	end
end

function M:handleHomeTaskPush(status, msg)
	if status == 0 then
		MainUITaskController.instance:setChaseTask(msg.taskId, true)
	end
end

M.instance = M.New()

return M
