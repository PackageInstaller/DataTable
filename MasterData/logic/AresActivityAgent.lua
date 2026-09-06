-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/givepet/agent/AresActivityAgent.lua

module("logic.extensions.aresactivity.agent.AresActivityAgent", package.seeall)

local AresActivityAgent = class("AresActivityAgent", BaseAgent)

AresActivityAgent.PM_AresActivityGetRecordRes = "AresActivityAgent_PM_AresActivityGetRecordRes"
AresActivityAgent.PM_AresActivityGetInfoRes = "AresActivityAgent_PM_AresActivityGetInfoRes"
AresActivityAgent.PM_AresActivityGainPrizeRes = "AresActivityAgent_PM_AresActivityGainPrizeRes"

function AresActivityAgent:ctor()
	return
end

function AresActivityAgent:setExtId(extId)
	AresActivityAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AresActivityAgent:sendPM_AresActivityGetRecordReq(id, handler, handlerObj, errHandler)
	local req = AresActivityExtension_pb.PM_AresActivityGetRecordReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AresActivityAgent.PM_AresActivityGetRecordRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AresActivityAgent:handlePM_AresActivityGetRecordRes(status, msg)
	self:dispatch(AresActivityAgent.PM_AresActivityGetRecordRes, status, msg)
end

function AresActivityAgent:sendPM_AresActivityGetInfoReq(id, handler, handlerObj, errHandler)
	local req = AresActivityExtension_pb.PM_AresActivityGetInfoReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AresActivityAgent.PM_AresActivityGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AresActivityAgent:handlePM_AresActivityGetInfoRes(status, msg)
	self:dispatch(AresActivityAgent.PM_AresActivityGetInfoRes, status, msg)
end

function AresActivityAgent:sendPM_AresActivityGainPrizeReq(id, handler, handlerObj, errHandler)
	local req = AresActivityExtension_pb.PM_AresActivityGainPrizeReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AresActivityAgent.PM_AresActivityGainPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AresActivityAgent:handlePM_AresActivityGainPrizeRes(status, msg)
	self:dispatch(AresActivityAgent.PM_AresActivityGainPrizeRes, status, msg)
end

AresActivityAgent.instance = AresActivityAgent.New()

return AresActivityAgent
