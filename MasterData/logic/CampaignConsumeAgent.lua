-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/agent/CampaignConsumeAgent.lua

module("logic.extensions.accumulategift.agent.CampaignConsumeAgent", package.seeall)

local CampaignConsumeAgent = class("CampaignConsumeAgent", BaseAgent)

CampaignConsumeAgent.PM_CampaignConsumeGetInfoRes = "CampaignConsumeAgent_PM_CampaignConsumeGetInfoRes"
CampaignConsumeAgent.PM_CampaignConsumeGainPrizeRes = "CampaignConsumeAgent_PM_CampaignConsumeGainPrizeRes"
CampaignConsumeAgent.PM_CampaignSignPanelRes = "CampaignConsumeAgent_PM_CampaignSignPanelRes"

function CampaignConsumeAgent:ctor()
	return
end

function CampaignConsumeAgent:setExtId(extId)
	CampaignConsumeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function CampaignConsumeAgent:sendPM_CampaignConsumeGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = CampaignConsumeExtension_pb.PM_CampaignConsumeGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(CampaignConsumeAgent.PM_CampaignConsumeGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function CampaignConsumeAgent:handlePM_CampaignConsumeGetInfoRes(status, msg)
	self:dispatch(CampaignConsumeAgent.PM_CampaignConsumeGetInfoRes, status, msg)
end

function CampaignConsumeAgent:sendPM_CampaignConsumeGainPrizeReq(activityId, id, handler, handlerObj, errHandler)
	local req = CampaignConsumeExtension_pb.PM_CampaignConsumeGainPrizeReq()

	req.activityId = activityId
	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(CampaignConsumeAgent.PM_CampaignConsumeGainPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function CampaignConsumeAgent:handlePM_CampaignConsumeGainPrizeRes(status, msg)
	self:dispatch(CampaignConsumeAgent.PM_CampaignConsumeGainPrizeRes, status, msg)
end

function CampaignConsumeAgent:sendPM_CampaignSignPanelReq(activityId, handler, handlerObj, errHandler)
	local req = CampaignConsumeExtension_pb.PM_CampaignSignPanelReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(CampaignConsumeAgent.PM_CampaignSignPanelRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function CampaignConsumeAgent:handlePM_CampaignSignPanelRes(status, msg)
	self:dispatch(CampaignConsumeAgent.PM_CampaignSignPanelRes, status, msg)
end

function CampaignConsumeAgent:sendPM_CampaignConsumeRankInfoReq(activityId)
	local req = CampaignConsumeExtension_pb.PM_CampaignConsumeRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CampaignConsumeAgent:handlePM_CampaignConsumeRankInfoRes(status, msg)
	if status == 0 then
		AccumulateChargeController.instance:handleGetRankInfo(msg)
	end
end

function CampaignConsumeAgent:sendPM_CampaignConsumeOneKeyGainPrizeReq(activityId)
	local req = CampaignConsumeExtension_pb.PM_CampaignConsumeOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CampaignConsumeAgent:handlePM_CampaignConsumeOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	AccumulateChargeController.instance:_oneKeyGainPrizeRes(msg)
end

CampaignConsumeAgent.instance = CampaignConsumeAgent.New()

return CampaignConsumeAgent
