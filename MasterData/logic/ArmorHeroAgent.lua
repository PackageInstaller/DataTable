-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/agent/ArmorHeroAgent.lua

module("logic.extensions.armorhero.agent.ArmorHeroAgent", package.seeall)

local ArmorHeroAgent = class("ArmorHeroAgent", BaseAgent)

function ArmorHeroAgent:sendPM_ArmorHeroInfoReq(activityId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroInfoRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleGetInfo(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroSummonReq(activityId, summonId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroSummonReq()

	req.activityId = activityId
	req.summonId = summonId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroSummonRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleSummon(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroGainTaskPrizeReq(activityId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroGainTaskPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroGainTaskPrizeRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleGainTaskPrize(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroGainBookPrizeReq(activityId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroGainBookPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroGainBookPrizeRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleGainBookPrize(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroGainSharePrizeReq(activityId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroGainSharePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroGainSharePrizeRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleGainSharePrize(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroGainProgressPrizeReq(activityId, progressId, stageId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroGainProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId
	req.stageId = stageId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroGainProgressPrizeRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleGainProgressPrize(msg)
	end
end

function ArmorHeroAgent:sendPM_ArmorHeroChallengeReq(activityId, form_pb, stageId)
	local req = ArmorHeroExtension_pb.PM_ArmorHeroChallengeReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function ArmorHeroAgent:handlePM_ArmorHeroChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ArmorHeroAgent:handlePM_ArmorHeroNotifyChallengeRes(status, msg)
	if status == 0 then
		ArmorHeroController.instance:handleNotifyClgFinish(msg)
	end
end

ArmorHeroAgent.instance = ArmorHeroAgent.New()

return ArmorHeroAgent
