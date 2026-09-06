-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/agent/BrotherGroupAgent.lua

module("logic.extensions.brothergroup.agent.BrotherGroupAgent", package.seeall)

local BrotherGroupAgent = class("BrotherGroupAgent", BaseAgent)

function BrotherGroupAgent:sendPM_BrotherGroupInfoReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupInfoReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupInfoRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendBrotherGroupRequest(headInfo, teamId, memberNum, teamScore)
	local req = BrotherGroupExtension_pb.BrotherGroupRequest()

	req.headInfo = headInfo
	req.teamId = teamId
	req.memberNum = memberNum
	req.teamScore = teamScore

	self:sendMsg(req)
end

function BrotherGroupAgent:sendPM_BrotherGroupRequestListReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupRequestListReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupRequestListRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleGetRequestList(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupSendRequestReq(targetUserId)
	local req = BrotherGroupExtension_pb.PM_BrotherGroupSendRequestReq()

	for i, id in ipairs(targetUserId) do
		req.targetUserId:append(id)
	end

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupSendRequestRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleSendRequest(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupHandlerRequestReq(userId, action)
	local req = BrotherGroupExtension_pb.PM_BrotherGroupHandlerRequestReq()

	req.userId = userId
	req.action = action

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupHandlerRequestRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleHandleRequest(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupPersonalMatchingReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupPersonalMatchingReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupPersonalMatchingRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handlePersonMatching(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupTeamMatchingReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupTeamMatchingReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupTeamMatchingRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleTeamMatching(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupCancelMatchingReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupCancelMatchingReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupCancelMatchingRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleCancelMatching(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupGainPersonalPrizeReq(prizeId)
	local req = BrotherGroupExtension_pb.PM_BrotherGroupGainPersonalPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupGainPersonalPrizeRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleGainPersonalPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupGetTaskInfoReq()
	local req = BrotherGroupExtension_pb.PM_BrotherGroupGetTaskInfoReq()

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupGetTaskInfoRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleGetTaskInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:sendPM_BrotherGroupGainTaskPrizeReq(taskId)
	local req = BrotherGroupExtension_pb.PM_BrotherGroupGainTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function BrotherGroupAgent:handlePM_BrotherGroupGainTaskPrizeRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleGainTaskPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:handlePM_BG_NotifyReceivedRequestRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleNotifyReceived(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:handlePM_BG_NotifyTeamInfoChangeRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleNotifyTeamInfoChange(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:handlePM_BG_NotifyMatchingSuccessRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleNotifyMatchingSuc(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

function BrotherGroupAgent:handlePM_BG_NotifyMatchingFailRes(status, msg)
	if status == 0 then
		BrotherGroupController.instance:handleNotifyMatchingFail(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.BrotherGroupError, status)
	end
end

BrotherGroupAgent.instance = BrotherGroupAgent.New()

return BrotherGroupAgent
