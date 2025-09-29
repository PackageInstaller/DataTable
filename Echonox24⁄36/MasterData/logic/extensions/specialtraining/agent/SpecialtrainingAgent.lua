-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/agent/SpecialtrainingAgent.lua

module("logic.extensions.specialtraining.agent.SpecialtrainingAgent", package.seeall)

local M = class("SpecialtrainingAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGrowthPlanRequest()
	local msg = GrowthPlanExtension_pb.GrowthPlanRequest()

	self:sendMsg(msg)
end

function M:handleGrowthPlanReply(status, msg)
	if status == 0 then
		SpecialtrainingModel.instance:updateTrainPlanData(msg)
		GlobalDispatcher:dispatchEvent(EventType.SPECIAL_TRAINING_UPDATESTAGE)
	end
end

function M:handlePlanStartPush(status, msg)
	if status == 0 then
		self:sendGrowthPlanRequest()
	end
end

function M:sendGrowthStageRewardRequest(stage)
	local msg = GrowthPlanExtension_pb.GrowthStageRewardRequest()

	msg.stage = stage

	self:sendMsg(msg)
end

function M:handleGrowthStageRewardReply(status, msg)
	if status == 0 then
		self:sendGrowthPlanRequest()
	end
end

function M:sendGrowthTasksRequest()
	local msg = GrowthPlanExtension_pb.GrowthTasksRequest()

	self:sendMsg(msg)
end

function M:handleGrowthTasksReply(status, msg)
	if status == 0 then
		local tasks = msg.tasks
		local taskLen = #tasks

		for i = 1, taskLen do
			SpecialtrainingModel.instance:initTaskData(tasks[i].id, tasks[i].count, tasks[i].finish)
		end

		GlobalDispatcher:dispatchEvent(EventType.SPECIAL_TRAINING_PLANDATA)
	end
end

function M:sendGrowthTaskRewardRequest(taskId)
	local msg = GrowthPlanExtension_pb.GrowthTaskRewardRequest()

	msg.id = taskId

	self:sendMsg(msg)
end

function M:handleGrowthTaskRewardReply(status, msg)
	if status == 0 then
		local task = msg.tasks

		SpecialtrainingModel.instance:initTaskData(task.id, task.count, task.finish)
	end

	GlobalDispatcher:dispatchEvent(EventType.SPECIAL_TRAINING_UPDATETASK, true)
end

M.instance = M.New()

return M
