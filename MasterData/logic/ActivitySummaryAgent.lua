-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/agent/ActivitySummaryAgent.lua

module("logic.extensions.activitysummary.agent.ActivitySummaryAgent", package.seeall)

local ActivitySummaryAgent = class("ActivitySummaryAgent", BaseAgent)

ActivitySummaryAgent.PM_ActivitySummaryInviteInfoRes = "ActivitySummaryAgent_PM_ActivitySummaryInviteInfoRes"
ActivitySummaryAgent.PM_ActivitySummaryAcceptInviteRes = "ActivitySummaryAgent_PM_ActivitySummaryAcceptInviteRes"
ActivitySummaryAgent.handlePM_ActivitySummaryLotteryRes = "ActivitySummaryAgent_handlePM_ActivitySummaryLotteryRes"

function ActivitySummaryAgent:ctor()
	return
end

function ActivitySummaryAgent:setExtId(extId)
	ActivitySummaryAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ActivitySummaryAgent:sendPM_ActivitySummaryInviteInfoReq(summaryId, handler, handlerObj, errHandler)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryInviteInfoReq()

	req.summaryId = summaryId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ActivitySummaryAgent.PM_ActivitySummaryInviteInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ActivitySummaryAgent:handlePM_ActivitySummaryInviteInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_invitationCardInfo===back")
	self:dispatch(ActivitySummaryAgent.PM_ActivitySummaryInviteInfoRes, status, msg)
end

function ActivitySummaryAgent:sendPM_ActivitySummaryAcceptInviteReq(summaryId, handler, handlerObj, errHandler)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryAcceptInviteReq()

	req.summaryId = summaryId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ActivitySummaryAgent.PM_ActivitySummaryAcceptInviteRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ActivitySummaryAgent:handlePM_ActivitySummaryAcceptInviteRes(status, msg)
	self:dispatch(ActivitySummaryAgent.PM_ActivitySummaryAcceptInviteRes, status, msg)
end

function ActivitySummaryAgent:sendPM_ActivitySummaryGetTaskInfosReq(summaryId)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryGetTaskInfosReq()

	req.summaryId = summaryId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_ActivitySummaryGetTaskInfosRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:getGetAllTask(msg)
	end
end

function ActivitySummaryAgent:sendPM_ActivitySummaryGainTaskPrizeReq(summaryId, taskId)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryGainTaskPrizeReq()

	req.summaryId = summaryId
	req.taskId = taskId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_ActivitySummaryGainTaskPrizeRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:onGetTaskPrize(msg)
	end
end

function ActivitySummaryAgent:sendPM_ActivitySummaryFinishStoryReq(summaryId, taskId)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryFinishStoryReq()

	req.summaryId = summaryId
	req.taskId = taskId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_ActivitySummaryFinishStoryRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:onPlayStroy(msg)
	end
end

function ActivitySummaryAgent:sendPM_ActivitySummaryLotteryReq(summaryId, handler, handlerObj, errHandler)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryLotteryReq()

	req.summaryId = summaryId

	self:addEventOnce(ActivitySummaryAgent.handlePM_ActivitySummaryLotteryRes, handler, handlerObj, errHandler)
	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_ActivitySummaryLotteryRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:onGetLotteryRes(msg)
		self:dispatch(ActivitySummaryAgent.handlePM_ActivitySummaryLotteryRes, status, msg)
	end
end

function ActivitySummaryAgent:sendPM_ActivitySummaryGainLotteryProgressPrizeReq(summaryId, prizeId)
	local req = ActivitySummaryExtension_pb.PM_ActivitySummaryGainLotteryProgressPrizeReq()

	req.summaryId = summaryId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_ActivitySummaryGainLotteryProgressPrizeRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:onGetLotteryProgressPrize(msg)
	end
end

function ActivitySummaryAgent:sendPM_GetActivityPluginProgressInfoReq(activityId)
	local req = ActivitySummaryExtension_pb.PM_GetActivityPluginProgressInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_GetActivityPluginProgressInfoRes(status, msg)
	if status == 0 then
		OpSummaryController.instance:handlePM_GetActivityPluginProgressInfoRes(status, msg)
	end
end

function ActivitySummaryAgent:sendPM_GainActivityPluginProgressPrizeReq(activityId, progressId, prizeId)
	local req = ActivitySummaryExtension_pb.PM_GainActivityPluginProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ActivitySummaryAgent:handlePM_GainActivityPluginProgressPrizeRes(status, msg)
	if status == 0 then
		OpSummaryController.instance:handlePM_GainActivityPluginProgressPrizeRes(status, msg)
	end
end

ActivitySummaryAgent.instance = ActivitySummaryAgent.New()

return ActivitySummaryAgent
