-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/agent/ControlActionAgent.lua

module("logic.extensions.controlaction.agent.ControlActionAgent", package.seeall)

local M = class("ControlActionAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetControlActionsRequest()
	local msg = ControlActionExtension_pb.GetControlActionsRequest()

	self:sendMsg(msg)
end

function M:handleGetControlActionsReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateMonitor(msg.actions)
		ControlActionModel.instance:updateWeekTimes(msg.passTime)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITORDATA_FINISH)
	end
end

function M:sendGetPostListRequest()
	local msg = ControlActionExtension_pb.GetPostListRequest()

	self:sendMsg(msg)
end

function M:handleGetPostListReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateThemePost(msg.posts)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_FORUMDATA_FINISH)
	end
end

function M:sendGetPostRequest(id)
	local msg = ControlActionExtension_pb.GetPostRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleGetPostReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateReplyPost(msg.id, msg.posts)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_FORUM_POSTREPLY)
	end
end

function M:sendLikePostRequest(id, floor)
	local msg = ControlActionExtension_pb.LikePostRequest()

	msg.id = id
	msg.floor = floor

	self:sendMsg(msg)
end

function M:handleLikePostReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updatePostLike(true, msg.id, msg.floor)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_FORUM_POSTLIKE, msg.id, msg.floor)
	end
end

function M:sendCancelLikePostRequest(id, floor)
	local msg = ControlActionExtension_pb.CancelLikePostRequest()

	msg.id = id
	msg.floor = floor

	self:sendMsg(msg)
end

function M:handleCancelLikePostReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updatePostLike(false, msg.id, msg.floor)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_FORUM_POSTLIKE, msg.id, msg.floor)
	end
end

function M:sendGetUnlockedProtomersRequest()
	local msg = ControlActionExtension_pb.GetUnlockedProtomersRequest()

	self:sendMsg(msg)
end

function M:handleGetUnlockedProtomersReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateManual(msg.protomers)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MANUAL_DATA_DONE)
	end
end

function M:sendHoldProtomerRequest(id)
	local msg = ControlActionExtension_pb.HoldProtomerRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleHoldProtomerReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateManualDataState(msg.id)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MANUAL_DATA_UPDATE)
	end
end

function M:sendGetTaskRewardRequest(taskId)
	local msg = ControlActionExtension_pb.GetTaskRewardRequest()

	msg.id = taskId

	self:sendMsg(msg)
end

function M:handleGetTaskRewardReply(status, msg)
	if status == 0 then
		ControlActionModel.instance:updateManualDataTaskState(msg.id)
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MANUAL_DATA_UPDATE)
	end
end

M.instance = M.New()

return M
