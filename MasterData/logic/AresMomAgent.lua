-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/agent/AresMomAgent.lua

module("logic.extensions.aresmom.agent.AresMomAgent", package.seeall)

local AresMomAgent = class("AresMomAgent", BaseAgent)

function AresMomAgent:sendPM_AresMom_GetInfoReq(challengeId)
	local req = AresMomExtension_pb.PM_AresMom_GetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function AresMomAgent:handlePM_AresMom_GetInfoRes(status, msg)
	if status == 0 then
		AresMomController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AresMomError, status)
	end
end

function AresMomAgent:sendPM_AresMom_FightReq(challengeId, type, stageId, form)
	local req = AresMomExtension_pb.PM_AresMom_FightReq()

	req.challengeId = challengeId
	req.type = type
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function AresMomAgent:handlePM_AresMom_FightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function AresMomAgent:handlePM_AresMom_NotifyFightRes(status, msg)
	if status == 0 then
		AresMomController.instance:handleNotifyFight(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AresMomError, status)
	end
end

function AresMomAgent:sendPM_AresMom_GainPrizeReq(challengeId, type, prizeId)
	local req = AresMomExtension_pb.PM_AresMom_GainPrizeReq()

	req.challengeId = challengeId
	req.type = type
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AresMomAgent:handlePM_AresMom_GainPrizeRes(status, msg)
	if status == 0 then
		AresMomController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AresMomError, status)
	end
end

function AresMomAgent:sendPM_AresMom_UnlockReq(challengeId, type, blockId)
	local req = AresMomExtension_pb.PM_AresMom_UnlockReq()

	req.challengeId = challengeId
	req.type = type
	req.blockId = blockId

	self:sendMsg(req)
end

function AresMomAgent:handlePM_AresMom_UnlockRes(status, msg)
	if status == 0 then
		AresMomController.instance:handleUnlock(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AresMomError, status)
	end
end

function AresMomAgent:sendPM_AresMom_BuyTimesReq(challengeId, type)
	local req = AresMomExtension_pb.PM_AresMom_BuyTimesReq()

	req.challengeId = challengeId
	req.type = type

	self:sendMsg(req)
end

function AresMomAgent:handlePM_AresMom_BuyTimesRes(status, msg)
	if status == 0 then
		AresMomController.instance:handleBuyTimes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AresMomError, status)
	end
end

AresMomAgent.instance = AresMomAgent.New()

return AresMomAgent
