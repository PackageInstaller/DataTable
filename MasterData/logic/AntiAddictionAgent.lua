-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/antiaddiction/agent/AntiAddictionAgent.lua

module("logic.extensions.antiaddiction.agent.AntiAddictionAgent", package.seeall)

local AntiAddictionAgent = class("AntiAddictionAgent", BaseAgent)

AntiAddictionAgent.GetAntiInfoRes = "AntiAddictionAgent_GetAntiInfoRes"
AntiAddictionAgent.StartRelaxRes = "AntiAddictionAgent_StartRelaxRes"
AntiAddictionAgent.StopRelaxRes = "AntiAddictionAgent_StopRelaxRes"
AntiAddictionAgent.LoadReadNameInfoRes = "AntiAddictionAgent_LoadReadNameInfoRes"

function AntiAddictionAgent:ctor()
	return
end

function AntiAddictionAgent:setExtId(extId)
	AntiAddictionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
	MsgFlowMgr.instance:setIgoreOrderMsg(extId, 4)
end

function AntiAddictionAgent:sendGetAntiInfoReq(handler, handlerObj, errHandler)
	local req = AntiAddictionExtension_pb.GetAntiInfoReq()

	self:sendMsg(req)
	self:addEventOnce(AntiAddictionAgent.GetAntiInfoRes, handler, handlerObj, errHandler)
end

function AntiAddictionAgent:handleGetAntiInfoRes(status, msg)
	self:dispatch(AntiAddictionAgent.GetAntiInfoRes, status, msg)
end

function AntiAddictionAgent:sendStartRelaxReq(handler, handlerObj, errHandler)
	local req = AntiAddictionExtension_pb.StartRelaxReq()

	self:sendMsg(req)
	self:addEventOnce(AntiAddictionAgent.StartRelaxRes, handler, handlerObj, errHandler)
end

function AntiAddictionAgent:handleStartRelaxRes(status, msg)
	self:dispatch(AntiAddictionAgent.StartRelaxRes, status, msg)
end

function AntiAddictionAgent:sendStopRelaxReq(handler, handlerObj, errHandler)
	local req = AntiAddictionExtension_pb.StopRelaxReq()

	self:sendMsg(req)
	self:addEventOnce(AntiAddictionAgent.StopRelaxRes, handler, handlerObj, errHandler)
end

function AntiAddictionAgent:handleStopRelaxRes(status, msg)
	self:dispatch(AntiAddictionAgent.StopRelaxRes, status, msg)
end

function AntiAddictionAgent:sendLoadReadNameInfoReq(handler, handlerObj, errHandler)
	local req = AntiAddictionExtension_pb.LoadReadNameInfoReq()

	self:sendMsg(req)
	self:addEventOnce(AntiAddictionAgent.LoadReadNameInfoRes, handler, handlerObj, errHandler)
end

function AntiAddictionAgent:handleLoadReadNameInfoRes(status, msg)
	self:dispatch(AntiAddictionAgent.LoadReadNameInfoRes, status, msg)
end

function AntiAddictionAgent:handleNotifySdkCmd_WebRes(status, msg)
	AntiAddictionController.instance.linkUrl = msg.link

	AntiAddictionController.instance:tryShowAnti()
end

function AntiAddictionAgent:handleNotifySdkCmd_HintRes(status, msg)
	local p = TipsFacade.instance:openTipWindowNoXExt(msg.title, msg.msg, function()
		return
	end)
end

AntiAddictionAgent.instance = AntiAddictionAgent.New()

return AntiAddictionAgent
