-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/agent/CakeSiginAgent.lua

module("logic.extensions.cakesigin.agent.CakeSiginAgent", package.seeall)

local CakeSiginAgent = class("CakeSiginAgent", BaseAgent)

CakeSiginAgent.PM_CakeSiginGetInfoRes = "CakeSiginAgent_PM_CakeSiginGetInfoRes"
CakeSiginAgent.PM_EatCakeRes = "CakeSiginAgent_PM_EatCakeRes"

function CakeSiginAgent:ctor()
	return
end

function CakeSiginAgent:setExtId(extId)
	CakeSiginAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function CakeSiginAgent:sendPM_CakeSiginGetInfoReq(handler, handlerObj, errHandler)
	local req = CakeSiginExtension_pb.PM_CakeSiginGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(CakeSiginAgent.PM_CakeSiginGetInfoRes, handler, handlerObj, errHandler)
end

function CakeSiginAgent:handlePM_CakeSiginGetInfoRes(status, msg)
	self:dispatch(CakeSiginAgent.PM_CakeSiginGetInfoRes, status, msg)
end

function CakeSiginAgent:sendPM_EatCakeReq(handler, handlerObj, errHandler)
	local req = CakeSiginExtension_pb.PM_EatCakeReq()

	self:sendMsg(req)
	self:addEventOnce(CakeSiginAgent.PM_EatCakeRes, handler, handlerObj, errHandler)
end

function CakeSiginAgent:handlePM_EatCakeRes(status, msg)
	self:dispatch(CakeSiginAgent.PM_EatCakeRes, status, msg)
end

CakeSiginAgent.instance = CakeSiginAgent.New()

return CakeSiginAgent
