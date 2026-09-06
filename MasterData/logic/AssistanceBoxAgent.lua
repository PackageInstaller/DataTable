-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/agent/AssistanceBoxAgent.lua

module("logic.extensions.assistancebox.agent.AssistanceBoxAgent", package.seeall)

local AssistanceBoxAgent = class("AssistanceBoxAgent", BaseAgent)

AssistanceBoxAgent.PM_AssistanceBoxTrigger = "PM_AssistanceBoxTrigger"
AssistanceBoxAgent.PM_AssistanceBoxInvite = "PM_AssistanceBoxInvite"
AssistanceBoxAgent.PM_AssistanceBoxBeHelp = "PM_AssistanceBoxBeHelp"

function AssistanceBoxAgent:ctor()
	return
end

function AssistanceBoxAgent:setExtId(extId)
	AssistanceBoxAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AssistanceBoxAgent:sendPM_AssistanceBoxGetInfoReq()
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxGetInfoReq()

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxGetInfoRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onGetInfo(msg)
	end
end

function AssistanceBoxAgent:sendPM_AssistanceBoxInviteReq(userIds_i64_Ary)
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxInviteReq()

	for i, v1 in ipairs(userIds_i64_Ary) do
		req.userIds:append(v1)
	end

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxInviteRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onUserInvite(msg)
	end
end

function AssistanceBoxAgent:sendPM_AssistanceBoxGetRecordReq()
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxGetRecordReq()

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxGetRecordRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onGetMyRecord(msg)
	end
end

function AssistanceBoxAgent:sendPM_AssistanceBoxHelpReq(boxOwnerId, boxToken)
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxHelpReq()

	req.boxOwnerId = boxOwnerId
	req.boxToken = boxToken

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxHelpRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onBoxHelp(msg)
	end
end

function AssistanceBoxAgent:sendPM_AssistanceBoxGainPrizeReq()
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxGainPrizeReq()

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxGainPrizeRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onBoxGain(msg)
	end
end

function AssistanceBoxAgent:sendPM_AssistanceBoxGetOtherInfoReq(boxOwnerId, boxToken)
	local req = AssistanceBoxExtension_pb.PM_AssistanceBoxGetOtherInfoReq()

	req.boxOwnerId = boxOwnerId
	req.boxToken = boxToken

	self:sendMsg(req)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxGetOtherInfoRes(status, msg)
	if status == 0 then
		AssistanceBoxController.instance:onGetOtherBoxInfo(msg)
	end
end

function AssistanceBoxAgent:handlePM_AssistanceBoxTrigger(status, msg)
	self:dispatch(AssistanceBoxAgent.PM_AssistanceBoxTrigger, status, msg)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxInvite(status, msg)
	self:dispatch(AssistanceBoxAgent.PM_AssistanceBoxInvite, status, msg)
end

function AssistanceBoxAgent:handlePM_AssistanceBoxBeHelp(status, msg)
	self:dispatch(AssistanceBoxAgent.PM_AssistanceBoxBeHelp, status, msg)
end

AssistanceBoxAgent.instance = AssistanceBoxAgent.New()

return AssistanceBoxAgent
