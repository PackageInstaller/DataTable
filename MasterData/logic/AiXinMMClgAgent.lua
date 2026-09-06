-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/agent/AiXinMMClgAgent.lua

module("logic.extensions.aixinmmclg.agent.AiXinMMClgAgent", package.seeall)

local AiXinMMClgAgent = class("AiXinMMClgAgent", BaseAgent)

AiXinMMClgAgent.PM_AiXinMMClgGetInfoRes = "AiXinMMClgAgent_PM_AiXinMMClgGetInfoRes"
AiXinMMClgAgent.PM_AiXinMMClgChallengeRes = "AiXinMMClgAgent_PM_AiXinMMClgChallengeRes"
AiXinMMClgAgent.PM_AiXinMMClgChallengeEndRes = "AiXinMMClgAgent_PM_AiXinMMClgChallengeEndRes"

function AiXinMMClgAgent:ctor()
	return
end

function AiXinMMClgAgent:setExtId(extId)
	AiXinMMClgAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AiXinMMClgAgent:sendPM_AiXinMMClgGetInfoReq(handler, handlerObj, errHandler)
	local req = AiXinMMClgExtension_pb.PM_AiXinMMClgGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AiXinMMClgAgent.PM_AiXinMMClgGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AiXinMMClgAgent:handlePM_AiXinMMClgGetInfoRes(status, msg)
	self:dispatch(AiXinMMClgAgent.PM_AiXinMMClgGetInfoRes, status, msg)
end

function AiXinMMClgAgent:sendPM_AiXinMMClgChallengeReq(monsterId, handler, handlerObj, errHandler)
	local req = AiXinMMClgExtension_pb.PM_AiXinMMClgChallengeReq()

	req.monsterId = monsterId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AiXinMMClgAgent.PM_AiXinMMClgChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AiXinMMClgAgent:handlePM_AiXinMMClgChallengeRes(status, msg)
	self:dispatch(AiXinMMClgAgent.PM_AiXinMMClgChallengeRes, status, msg)
end

function AiXinMMClgAgent:handlePM_AiXinMMClgChallengeEndRes(status, msg)
	self:dispatch(AiXinMMClgAgent.PM_AiXinMMClgChallengeEndRes, status, msg)
end

AiXinMMClgAgent.instance = AiXinMMClgAgent.New()

return AiXinMMClgAgent
