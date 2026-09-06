-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/AnHeiMMChallengeAgent.lua

module("logic.extensions.anheimmchallenge.agent.AnHeiMMChallengeAgent", package.seeall)

local AnHeiMMChallengeAgent = class("AnHeiMMChallengeAgent", BaseAgent)

AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGetInfoRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeGetInfoRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGainDailyPrizeRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeGainDailyPrizeRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeBuyTimesRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeBuyTimesRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChooseModeRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeChooseModeRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeReChooseRuleRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeReChooseRuleRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeChallengeRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeConfirmResultRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeConfirmResultRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGiveUpRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeGiveUpRes"
AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeEndRes = "AnHeiMMChallengeAgent_PM_AnHeiMMChallengeChallengeEndRes"

function AnHeiMMChallengeAgent:ctor()
	return
end

function AnHeiMMChallengeAgent:setExtId(extId)
	AnHeiMMChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeGetInfoReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGetInfoRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeGetInfoRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGetInfoRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeGainDailyPrizeReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeGainDailyPrizeReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGainDailyPrizeRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeGainDailyPrizeRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGainDailyPrizeRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeBuyTimesReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeBuyTimesReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeBuyTimesRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeBuyTimesRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeBuyTimesRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeChooseModeReq(modeId, handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeChooseModeReq()

	req.modeId = modeId

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChooseModeRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeChooseModeRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChooseModeRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeReChooseRuleReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeReChooseRuleReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeReChooseRuleRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeReChooseRuleRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeReChooseRuleRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeChallengeReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeChallengeReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeChallengeRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeConfirmResultReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeConfirmResultReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeConfirmResultRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeConfirmResultRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeConfirmResultRes, status, msg)
end

function AnHeiMMChallengeAgent:sendPM_AnHeiMMChallengeGiveUpReq(handler, handlerObj, errHandler)
	local req = AnHeiMMChallengeExtension_pb.PM_AnHeiMMChallengeGiveUpReq()

	self:sendMsg(req)
	self:addEventOnce(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGiveUpRes, handler, handlerObj, errHandler)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeGiveUpRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeGiveUpRes, status, msg)
end

function AnHeiMMChallengeAgent:handlePM_AnHeiMMChallengeChallengeEndRes(status, msg)
	self:dispatch(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeEndRes, status, msg)
end

AnHeiMMChallengeAgent.instance = AnHeiMMChallengeAgent.New()

return AnHeiMMChallengeAgent
