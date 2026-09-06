-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/agent/AccumulateLotteryAgent.lua

module("logic.extensions.accumulatelottery.agent.AccumulateLotteryAgent", package.seeall)

local AccumulateLotteryAgent = class("AccumulateLotteryAgent", BaseAgent)

function AccumulateLotteryAgent:sendPM_GetAnnuityAccLotteryInfoReq(activityId)
	local req = AnnuityAccumulateLotteryExtension_pb.PM_GetAnnuityAccLotteryInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AccumulateLotteryAgent:handlePM_GetAnnuityAccLotteryInfoRes(status, msg)
	if status == 0 then
		AccumulateLotteryController.instance:onActivityInfo(msg)
	end
end

function AccumulateLotteryAgent:sendAnnuityAccumulateLotteryDrawReq(activityId)
	local req = AnnuityAccumulateLotteryExtension_pb.AnnuityAccumulateLotteryDrawReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AccumulateLotteryAgent:handleAnnuityAccumulateLotteryDrawRes(status, msg)
	if status == 0 then
		AccumulateLotteryController.instance:onAccLotteryDraw(msg)
	end
end

AccumulateLotteryAgent.instance = AccumulateLotteryAgent.New()

return AccumulateLotteryAgent
