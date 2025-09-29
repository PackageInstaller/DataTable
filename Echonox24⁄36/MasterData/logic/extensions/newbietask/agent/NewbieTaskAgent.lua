-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/agent/NewbieTaskAgent.lua

module("logic.extensions.newbietask.agent.NewbieTaskAgent", package.seeall)

local M = class("NewbieTaskAgent", BaseAgent)

function M:ctor()
	return
end

function M:sendGetTaskListRequest()
	local msg = NewbieExtension_pb.GetTaskListRequest()

	self:sendMsg(msg)
end

function M:handleGetTaskListReply(status, msg)
	if status == 0 then
		NewbieTaskController.instance:onTaskListReply(msg)
	end
end

function M:sendFinishTaskRequest(ids)
	if ids and #ids > 0 then
		local msg = NewbieExtension_pb.FinishTaskRequest()

		for _, id in ipairs(ids) do
			table.insert(msg.id, id)
		end

		NewbieTaskController.instance:clearCacheItem()
		self:sendMsg(msg)
	end
end

function M:handleFinishTaskReply(status, msg)
	if status == 0 then
		NewbieTaskController.instance:onFinishTaskReply(msg)
	end
end

function M:sendTakeStepRewardRequest(stepPointLst)
	if stepPointLst then
		local msg = NewbieExtension_pb.TakeStepRewardRequest()

		msg.info.group = stepPointLst.group

		for _, sp in ipairs(stepPointLst.stepPoints) do
			table.insert(msg.info.stepPoint, sp)
		end

		NewbieTaskController.instance:clearCacheItem()
		self:sendMsg(msg)
	end
end

function M:handleTakeStepRewardReply(status, msg)
	if status == 0 then
		NewbieTaskController.instance:onTakeStepRewardReply(msg.info)
	end
end

M.instance = M.New()

return M
