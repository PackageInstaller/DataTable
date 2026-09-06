-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/agent/BadgeAgent.lua

module("logic.extensions.badge.agent.BadgeAgent", package.seeall)

local BadgeAgent = class("BadgeAgent", BaseAgent)

BadgeAgent.PM_LoadAllBadgeRes = "BadgeAgent_PM_LoadAllBadgeRes"
BadgeAgent.PM_notifyGainBadgeRes = "BadgeAgent_PM_notifyGainBadgeRes"

function BadgeAgent:ctor()
	return
end

function BadgeAgent:setExtId(extId)
	BadgeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BadgeAgent:sendPM_LoadAllBadgeReq(otherUserId, handler, handlerObj, errHandler)
	local req = BadgeExtension_pb.PM_LoadAllBadgeReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(BadgeAgent.PM_LoadAllBadgeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function BadgeAgent:handlePM_LoadAllBadgeRes(status, msg)
	self:dispatch(BadgeAgent.PM_LoadAllBadgeRes, status, msg)
end

function BadgeAgent:handlePM_notifyGainBadgeRes(status, msg)
	self:dispatch(BadgeAgent.PM_notifyGainBadgeRes, status, msg)
end

function BadgeAgent:sendPM_ComposeOrUpgradeBadgeReq(badgeId)
	local req = BadgeExtension_pb.PM_ComposeOrUpgradeBadgeReq()

	req.badgeId = badgeId

	self:sendMsg(req)
end

function BadgeAgent:handlePM_ComposeOrUpgradeBadgeRes(status, msg)
	if status == 0 then
		BadgeController.instance:handlePM_ComposeOrUpgradeBadgeRes(msg)
	end
end

function BadgeAgent:sendPM_GetBadgeUpgradeLogsReq(badgeId)
	local req = BadgeExtension_pb.PM_GetBadgeUpgradeLogsReq()

	req.badgeId = badgeId

	self:sendMsg(req)
end

function BadgeAgent:handlePM_GetBadgeUpgradeLogsRes(status, msg)
	if status == 0 then
		BadgeController.instance:handlePM_GetBadgeUpgradeLogsRes(msg)
	end
end

BadgeAgent.instance = BadgeAgent.New()

return BadgeAgent
