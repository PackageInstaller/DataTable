-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/agent/AnMoYanAgent.lua

module("logic.extensions.anmoyangame.agent.AnMoYanAgent", package.seeall)

local AnMoYanAgent = class("AnMoYanAgent", BaseAgent)

function AnMoYanAgent:sendPM_DarkMoYanGameInfoReq(activityId)
	local req = DarkMoYanGameExtension_pb.PM_DarkMoYanGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnMoYanAgent:handlePM_DarkMoYanGameInfoRes(status, msg)
	if status == 0 then
		AnMoYanController.instance:handlePM_DarkMoYanGameInfoRes(msg)
	end
end

function AnMoYanAgent:sendPM_DarkMoYanGameStartGameReq(activityId, clientKey)
	local req = DarkMoYanGameExtension_pb.PM_DarkMoYanGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AnMoYanAgent:handlePM_DarkMoYanGameStartGameRes(status, msg)
	if status == 0 then
		AnMoYanController.instance:handlePM_DarkMoYanGameStartGameRes(msg)
	end
end

function AnMoYanAgent:sendPM_DarkMoYanGameEndGameReq(activityId, score, encryptedKey)
	local req = DarkMoYanGameExtension_pb.PM_DarkMoYanGameEndGameReq()

	req.activityId = activityId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function AnMoYanAgent:handlePM_DarkMoYanGameEndGameRes(status, msg)
	if status == 0 then
		AnMoYanController.instance:handlePM_DarkMoYanGameEndGameRes(msg)
	end
end

function AnMoYanAgent:sendPM_DarkMoYanGameSweepReq(activityId, times)
	local req = DarkMoYanGameExtension_pb.PM_DarkMoYanGameSweepReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function AnMoYanAgent:handlePM_DarkMoYanGameSweepRes(status, msg)
	if status == 0 then
		AnMoYanController.instance:handlePM_DarkMoYanGameSweepRes(msg)
	end
end

function AnMoYanAgent:sendPM_DarkMoYanGameGainProgressPrizeReq(activityId, prizeId)
	local req = DarkMoYanGameExtension_pb.PM_DarkMoYanGameGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnMoYanAgent:handlePM_DarkMoYanGameGainProgressPrizeRes(status, msg)
	if status == 0 then
		AnMoYanController.instance:handlePM_DarkMoYanGameGainProgressPrizeRes(msg)
	end
end

AnMoYanAgent.instance = AnMoYanAgent.New()

return AnMoYanAgent
