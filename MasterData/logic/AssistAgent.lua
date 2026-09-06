-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/agent/AssistAgent.lua

module("logic.extensions.assist.agent.AssistAgent", package.seeall)

local AssistAgent = class("AssistAgent", BaseAgent)

AssistAgent.PM_AssistInfoRes = "AssistAgent_PM_AssistInfoRes"
AssistAgent.PM_AssistUpgradePowerRes = "AssistAgent_PM_AssistUpgradePowerRes"
AssistAgent.PM_AssistUpgradeTeamRes = "AssistAgent_PM_AssistUpgradeTeamRes"
AssistAgent.PM_AssistSetPetPositionRes = "AssistAgent_PM_AssistSetPetPositionRes"
AssistAgent.PM_NotifyPetPositionDropRes = "AssistAgent_PM_NotifyPetPositionDropRes"
AssistAgent.PM_AssistOneClickUpgradeTeamRes = "AssistAgent_PM_AssistOneClickUpgradeTeamRes"
AssistAgent.PM_AssistOneClickDeployRes = "AssistAgent_PM_AssistOneClickDeployRes"

function AssistAgent:ctor()
	return
end

function AssistAgent:setExtId(extId)
	AssistAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AssistAgent:sendPM_AssistInfoReq(handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestPetAssist===back")
	self:dispatch(AssistAgent.PM_AssistInfoRes, status, msg)
end

function AssistAgent:sendPM_AssistUpgradePowerReq(handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistUpgradePowerReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistUpgradePowerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistUpgradePowerRes(status, msg)
	self:dispatch(AssistAgent.PM_AssistUpgradePowerRes, status, msg)
end

function AssistAgent:sendPM_AssistUpgradeTeamReq(teamType, handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistUpgradeTeamReq()

	req.teamType = teamType

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistUpgradeTeamRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistUpgradeTeamRes(status, msg)
	self:dispatch(AssistAgent.PM_AssistUpgradeTeamRes, status, msg)
end

function AssistAgent:sendPM_AssistSetPetPositionReq(teamType, petId, position, handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistSetPetPositionReq()

	req.teamType = teamType
	req.petId = petId
	req.position = position

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistSetPetPositionRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistSetPetPositionRes(status, msg)
	self:dispatch(AssistAgent.PM_AssistSetPetPositionRes, status, msg)
end

function AssistAgent:handlePM_NotifyPetPositionDropRes(status, msg)
	self:dispatch(AssistAgent.PM_NotifyPetPositionDropRes, status, msg)
end

function AssistAgent:sendPM_AssistOneClickUpgradeTeamReq(handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistOneClickUpgradeTeamReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistUpgradeTeamRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistOneClickUpgradeTeamRes(status, msg)
	self:dispatch(AssistAgent.PM_AssistOneClickUpgradeTeamRes, status, msg)
end

function AssistAgent:sendPM_AssistOneClickDeployReq(handler, handlerObj, errHandler)
	local req = AssistExtension_pb.PM_AssistOneClickDeployReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AssistAgent.PM_AssistOneClickDeployRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AssistAgent:handlePM_AssistOneClickDeployRes(status, msg)
	self:dispatch(AssistAgent.PM_AssistOneClickDeployRes, status, msg)
end

AssistAgent.instance = AssistAgent.New()

return AssistAgent
