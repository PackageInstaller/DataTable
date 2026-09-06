-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/agent/BuryPitGameAgent.lua

module("logic.extensions.burypitgame.agent.BuryPitGameAgent", package.seeall)

local BuryPitGameAgent = class("BuryPitGameAgent", BaseAgent)

BuryPitGameAgent.PM_BuryPitGameGetInfoRes = "BuryPitGameAgent_PM_BuryPitGameGetInfoRes"
BuryPitGameAgent.PM_BuryPitGameStartGameRes = "BuryPitGameAgent_PM_BuryPitGameStartGameRes"
BuryPitGameAgent.PM_BuryPitGameEndGameRes = "BuryPitGameAgent_PM_BuryPitGameEndGameRes"
BuryPitGameAgent.PM_BuryPitGameBuyGameTimesRes = "BuryPitGameAgent_PM_BuryPitGameBuyGameTimesRes"
BuryPitGameAgent.PM_BuryPitGameGainScorePrizeRes = "BuryPitGameAgent_PM_BuryPitGameGainScorePrizeRes"
BuryPitGameAgent.PM_BuryPitGameGetRankInfoRes = "BuryPitGameAgent_PM_BuryPitGameGetRankInfoRes"

function BuryPitGameAgent:ctor()
	return
end

function BuryPitGameAgent:setExtId(extId)
	BuryPitGameAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BuryPitGameAgent:sendPM_BuryPitGameGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameGetInfoRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameGetInfoRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameGetInfoRes, status, msg)
end

function BuryPitGameAgent:sendPM_BuryPitGameStartGameReq(activityId, clientKey, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameStartGameRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameStartGameRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameStartGameRes, status, msg)
end

function BuryPitGameAgent:sendPM_BuryPitGameEndGameReq(score, specialPrizeCount, encryptedKey, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameEndGameReq()

	req.score = score
	req.specialPrizeCount = specialPrizeCount
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameEndGameRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameEndGameRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameEndGameRes, status, msg)
end

function BuryPitGameAgent:sendPM_BuryPitGameBuyGameTimesReq(activityId, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameBuyGameTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameBuyGameTimesRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameBuyGameTimesRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameBuyGameTimesRes, status, msg)
end

function BuryPitGameAgent:sendPM_BuryPitGameGainScorePrizeReq(activityId, prizeId, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameGainScorePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameGainScorePrizeRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameGainScorePrizeRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameGainScorePrizeRes, status, msg)
end

function BuryPitGameAgent:sendPM_BuryPitGameGetRankInfoReq(activityId, startRank, endRank, handler, handlerObj, errHandler)
	local req = BuryPitGameExtension_pb.PM_BuryPitGameGetRankInfoReq()

	req.activityId = activityId
	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
	self:addEventOnce(BuryPitGameAgent.PM_BuryPitGameGetRankInfoRes, handler, handlerObj, errHandler)
end

function BuryPitGameAgent:handlePM_BuryPitGameGetRankInfoRes(status, msg)
	self:dispatch(BuryPitGameAgent.PM_BuryPitGameGetRankInfoRes, status, msg)
end

BuryPitGameAgent.instance = BuryPitGameAgent.New()

return BuryPitGameAgent
