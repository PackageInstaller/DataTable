-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/agent/AnnualFubenAgent.lua

module("logic.extensions.annualfuben.agent.AnnualFubenAgent", package.seeall)

local AnnualFubenAgent = class("AnnualFubenAgent", BaseAgent)

function AnnualFubenAgent:sendPM_AnnualFubenInfoReq(activityId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenInfoRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenInfoRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenGainClueReq(activityId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenGainClueReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenGainClueRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenGainClueRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenFormulaReq(activityId, clueIds)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenFormulaReq()

	req.activityId = activityId

	for i, v in ipairs(clueIds) do
		req.clueIds:append(v)
	end

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenFormulaRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenFormulaRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenGainCluePrizeReq(activityId, prizeId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenGainCluePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenGainCluePrizeRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenGainCluePrizeRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenStageChallengeReq(activityId, stageId, form)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenStageChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenStageChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenSimpleStageChallengeReq(activityId, stageId, form)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenSimpleStageChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenSimpleStageChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenStageRankInfoReq(activityId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenStageRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenStageRankInfoRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenStageRankInfoRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenStageResetReq(activityId, stageId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenStageResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenStageResetRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenStageResetRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenBossChallengeReq(activityId, form)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenBossChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenGainBossPrizeReq(activityId, prizeId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenGainBossPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenGainBossPrizeRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenGainBossPrizeRes(msg)
	end
end

function AnnualFubenAgent:sendPM_AnnualFubenBossRankInfoReq(activityId)
	local req = AnnualFubenExtension_pb.PM_AnnualFubenBossRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFubenAgent:handlePM_AnnualFubenBossRankInfoRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_AnnualFubenBossRankInfoRes(msg)
	end
end

function AnnualFubenAgent:handlePM_NotifyAnnualFubenStageFinishRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_NotifyAnnualFubenStageFinishRes(msg)
	end
end

function AnnualFubenAgent:handlePM_NotifyAnnualFubenBossFinishRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_NotifyAnnualFubenBossFinishRes(msg)
	end
end

function AnnualFubenAgent:handlePM_NotifyAnnualFubenSimpleStageFinishRes(status, msg)
	if status == 0 then
		AnnualFubenController.instance:handlePM_NotifyAnnualFubenSimpleStageFinishRes(msg)
	end
end

AnnualFubenAgent.instance = AnnualFubenAgent.New()

return AnnualFubenAgent
