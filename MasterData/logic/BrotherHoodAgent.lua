-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/agent/BrotherHoodAgent.lua

module("logic.extensions.brotherhood.agent.BrotherHoodAgent", package.seeall)

local BrotherHoodAgent = class("BrotherHoodAgent", BaseAgent)

function BrotherHoodAgent:sendPM_BrotherHoodPanelInfoReq(activityId)
	local req = BrotherHoodExtension_pb.PM_BrotherHoodPanelInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BrotherHoodAgent:handlePM_BrotherHoodPanelInfoRes(status, msg)
	if status == 0 then
		BrotherHoodModel.instance:onBrotherHoodPanelInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BrotherHoodPanelInfoRes)
	end
end

function BrotherHoodAgent:sendPM_BrotherHoodSinglePlotPlanReq(activityId, plotPlanId)
	local req = BrotherHoodExtension_pb.PM_BrotherHoodSinglePlotPlanReq()

	req.activityId = activityId
	req.plotPlanId = plotPlanId

	self:sendMsg(req)
end

function BrotherHoodAgent:handlePM_BrotherHoodSinglePlotPlanRes(status, msg)
	if status == 0 then
		BrotherHoodModel.instance:onBrotherHoodSinglePlotPlanRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BrotherHoodSinglePlotPlanRes)
	end
end

function BrotherHoodAgent:sendPM_BrotherHoodSplicePlotReq(activityId, plotPlanId, groupId, fragmentsId)
	local req = BrotherHoodExtension_pb.PM_BrotherHoodSplicePlotReq()

	req.activityId = activityId
	req.plotPlanId = plotPlanId
	req.groupId = groupId
	req.fragmentsId = fragmentsId

	self:sendMsg(req)
end

function BrotherHoodAgent:handlePM_BrotherHoodSplicePlotRes(status, msg)
	if status == 0 then
		BrotherHoodModel.instance:onBrotherHoodSplicePlotRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BrotherHoodSplicePlotRes)
	end
end

function BrotherHoodAgent:sendPM_BrotherHoodRewardProcessReq(activityId, processId)
	local req = BrotherHoodExtension_pb.PM_BrotherHoodRewardProcessReq()

	req.activityId = activityId
	req.processId = processId

	self:sendMsg(req)
end

function BrotherHoodAgent:handlePM_BrotherHoodRewardProcessRes(status, msg)
	if status == 0 then
		BrotherHoodModel.instance:onBrotherHoodRewardProcessRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BrotherHoodRewardProcessRes)
	end
end

BrotherHoodAgent.instance = BrotherHoodAgent.New()

return BrotherHoodAgent
