-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/agent/BountyPKCompeteAgent.lua

module("logic.extensions.bountypkcompete.agent.BountyPKCompeteAgent", package.seeall)

local BountyPKCompeteAgent = class("BountyPKCompeteAgent", BaseAgent)

function BountyPKCompeteAgent:sendPM_BountyPKGetInfoReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKGetInfoReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKGetInfoRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKGetInfoRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKMatchReq(matchType)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKMatchReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKMatchRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKMatchRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKCancelMatchReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKCancelMatchReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKCancelMatchRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKCancelMatchRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKSetFormReq(form)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKSetFormReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKSetFormRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKSetFormRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKSetBetReq(fallow)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKSetBetReq()

	req.fallow = fallow

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKSetBetRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKSetBetRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKRetreatReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKRetreatReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKRetreatRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKRetreatRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyMatchingOverTimeRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyMatchingOverTimeRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyMatchFailRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyMatchFailRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyGameStartRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyGameStartRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyRoundStartRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyRoundStartRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyShowFormRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyShowFormRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifyGameEndRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifyGameEndRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKDailyPrizeReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKDailyPrizeReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKDailyPrizeRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKDailyPrizeRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKTopScorePrizeReq(prizeId)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKTopScorePrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKTopScorePrizeRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKTopScorePrizeRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKDailyTaskPrizeReq(taskNum)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKDailyTaskPrizeReq()

	req.taskNum = taskNum

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKDailyTaskPrizeRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKDailyTaskPrizeRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKGetRecordReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKGetRecordReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKGetRecordRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKGetRecordRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKGetRankInfoReq()
	local req = BountyPKCompeteExtension_pb.PM_BountyPKGetRankInfoReq()

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKGetRankInfoRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKGetRankInfoRes(status, msg)
end

function BountyPKCompeteAgent:sendPM_BountyPKGetBattleVideoReq(battleId)
	local req = BountyPKCompeteExtension_pb.PM_BountyPKGetBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function BountyPKCompeteAgent:handlePM_BountyPKGetBattleVideoRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKGetBattleVideoRes(status, msg)
end

function BountyPKCompeteAgent:handlePM_BountyPKNotifySetFormRes(status, msg)
	BountyPKCompeteController.instance:handleBountyPKNotifySetFormRes(status, msg)
end

BountyPKCompeteAgent.instance = BountyPKCompeteAgent.New()

return BountyPKCompeteAgent
