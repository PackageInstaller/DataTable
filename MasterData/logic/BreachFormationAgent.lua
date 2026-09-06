-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/agent/BreachFormationAgent.lua

module("logic.extensions.breachformation.agent.BreachFormationAgent", package.seeall)

local BreachFormationAgent = class("BreachFormationAgent", BaseAgent)

BreachFormationAgent.PM_BreachFormationGetUserInfoRes = "BreachFormationAgent_PM_BreachFormationGetUserInfoRes"
BreachFormationAgent.PM_BreachFormationGetRankInfoRes = "BreachFormationAgent_PM_BreachFormationGetRankInfoRes"
BreachFormationAgent.PM_BreachFormationFightRes = "BreachFormationAgent_PM_BreachFormationFightRes"
BreachFormationAgent.PM_BreachFormationGetLatestRecordsRes = "BreachFormationAgent_PM_BreachFormationGetLatestRecordsRes"
BreachFormationAgent.PM_BreachFormationGainProgressPrizeRes = "BreachFormationAgent_PM_BreachFormationGainProgressPrizeRes"
BreachFormationAgent.PM_BreachFormationNotifyScoreRes = "BreachFormationAgent_PM_BreachFormationNotifyScoreRes"
BreachFormationAgent.PM_BreachFormationWatchBattleVideoRes = "BreachFormationAgent_PM_BreachFormationWatchBattleVideoRes"
BreachFormationAgent.PM_BreachFormationBuyFirstPassTimesRes = "BreachFormationAgent_PM_BreachFormationBuyFirstPassTimesRes"
BreachFormationAgent.PM_BreachFormationQuickPassRes = "BreachFormationAgent_PM_BreachFormationQuickPassRes"
BreachFormationAgent.PM_BreachFormationOneKeyGainProgressPrizeRes = "BreachFormationAgent_PM_BreachFormationOneKeyGainProgressPrizeRes"

function BreachFormationAgent:ctor()
	return
end

function BreachFormationAgent:setExtId(extId)
	BreachFormationAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BreachFormationAgent:sendPM_BreachFormationGetUserInfoReq(handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationGetUserInfoReq()

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationGetUserInfoRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationGetUserInfoRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationGetUserInfoRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationGetRankInfoReq(startIndex, endIndex, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationGetRankInfoReq()

	req.startIndex = startIndex
	req.endIndex = endIndex

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationGetRankInfoRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationGetRankInfoRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationGetRankInfoRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationFightReq(periodId, monsterId, normalMode, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationFightReq()

	req.periodId = periodId
	req.monsterId = monsterId
	req.normalMode = normalMode

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationFightRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationFightRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationFightRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationGetLatestRecordsReq(monsterId, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationGetLatestRecordsReq()

	req.monsterId = monsterId

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationGetLatestRecordsRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationGetLatestRecordsRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationGetLatestRecordsRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationGainProgressPrizeReq(periodId, progress, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationGainProgressPrizeReq()

	req.periodId = periodId
	req.progress = progress

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationGainProgressPrizeRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationGainProgressPrizeRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationGainProgressPrizeRes, status, msg)
end

function BreachFormationAgent:handlePM_BreachFormationNotifyScoreRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationNotifyScoreRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationWatchBattleVideoReq(teamId, monsterId, battleId, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationWatchBattleVideoReq()

	req.teamId = teamId
	req.monsterId = monsterId
	req.battleId = battleId

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationWatchBattleVideoRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationWatchBattleVideoRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationWatchBattleVideoRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationBuyFirstPassTimesReq(buyTimes, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationBuyFirstPassTimesReq()

	req.buyTimes = buyTimes

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationBuyFirstPassTimesRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationBuyFirstPassTimesRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationBuyFirstPassTimesRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationQuickPassReq(periodId, monsterId, handler, handlerObj, errHandler)
	local req = BreachFormationExtension_pb.PM_BreachFormationQuickPassReq()

	req.periodId = periodId
	req.monsterId = monsterId

	self:sendMsg(req)
	self:addEventOnce(BreachFormationAgent.PM_BreachFormationQuickPassRes, handler, handlerObj, errHandler)
end

function BreachFormationAgent:handlePM_BreachFormationQuickPassRes(status, msg)
	self:dispatch(BreachFormationAgent.PM_BreachFormationQuickPassRes, status, msg)
end

function BreachFormationAgent:sendPM_BreachFormationOneKeyGainProgressPrizeReq(periodId)
	local req = BreachFormationExtension_pb.PM_BreachFormationOneKeyGainProgressPrizeReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function BreachFormationAgent:handlePM_BreachFormationOneKeyGainProgressPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(BreachFormationAgent.PM_BreachFormationOneKeyGainProgressPrizeRes, status, msg)
end

BreachFormationAgent.instance = BreachFormationAgent.New()

return BreachFormationAgent
