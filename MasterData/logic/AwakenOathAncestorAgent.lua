-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/agent/AwakenOathAncestorAgent.lua

module("logic.extensions.awakenoathancestor.agent.AwakenOathAncestorAgent", package.seeall)

local AwakenOathAncestorAgent = class("AwakenOathAncestorAgent", BaseAgent)

function AwakenOathAncestorAgent:sendPM_AwakenOathAncestorInfoReq(activityId)
	local req = AwakenOathAncestorExtension_pb.PM_AwakenOathAncestorInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AwakenOathAncestorAgent:handlePM_AwakenOathAncestorInfoRes(status, msg)
	if status == 0 then
		AwakenOathAncestorController.instance:handlePM_AwakenOathAncestorInfoRes(msg)
	end
end

function AwakenOathAncestorAgent:sendPM_AwakenOathAncestorUnlockPointReq(activityId, pointId)
	local req = AwakenOathAncestorExtension_pb.PM_AwakenOathAncestorUnlockPointReq()

	req.activityId = activityId
	req.pointId = pointId

	self:sendMsg(req)
end

function AwakenOathAncestorAgent:handlePM_AwakenOathAncestorUnlockPointRes(status, msg)
	if status == 0 then
		AwakenOathAncestorController.instance:handlePM_AwakenOathAncestorUnlockPointRes(msg)
	end
end

function AwakenOathAncestorAgent:sendPM_GainProgressPrizeReq(activityId, progressId)
	local req = AwakenOathAncestorExtension_pb.PM_GainProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function AwakenOathAncestorAgent:handlePM_GainProgressPrizeRes(status, msg)
	if status == 0 then
		AwakenOathAncestorController.instance:handlePM_GainProgressPrizeRes(msg)
	end
end

function AwakenOathAncestorAgent:sendPM_AwakenOathAncestorChallengeReq(activityId, form, stageId)
	local req = AwakenOathAncestorExtension_pb.PM_AwakenOathAncestorChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function AwakenOathAncestorAgent:handlePM_AwakenOathAncestorChallengeRes(status, msg)
	if status == 0 then
		AwakenOathAncestorController.instance:handlePM_AwakenOathAncestorChallengeRes(msg)
	end
end

function AwakenOathAncestorAgent:handlePM_AwakenOathAncestorNotifyChallengeRes(status, msg)
	if status == 0 then
		AwakenOathAncestorController.instance:handlePM_AwakenOathAncestorNotifyChallengeRes(msg)
	end
end

AwakenOathAncestorAgent.instance = AwakenOathAncestorAgent.New()

return AwakenOathAncestorAgent
