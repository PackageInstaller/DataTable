-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/agent/AnnualFeeSkinAgent.lua

module("logic.extensions.yearcardlottery.agent.AnnualFeeSkinAgent", package.seeall)

local AnnualFeeSkinAgent = class("AnnualFeeSkinAgent", BaseAgent)

function AnnualFeeSkinAgent:sendPM_GetAnnualFeeSkinInfoReq(activityId)
	local req = AnnualFeeSkinExtension_pb.PM_GetAnnualFeeSkinInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFeeSkinAgent:handlePM_GetAnnualFeeSkinInfoRes(status, msg)
	if status == 0 then
		YearCardLotteryController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardLotteryError, status)
		printInfo("年费抽奖协议回调报错：" .. status)
	end
end

function AnnualFeeSkinAgent:sendPM_AnnualFeeLotteryReq(activityId)
	local req = AnnualFeeSkinExtension_pb.PM_AnnualFeeLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFeeSkinAgent:handlePM_AnnualFeeLotteryRes(status, msg)
	if status == 0 then
		YearCardLotteryController.instance:handleLottery(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardLotteryError, status)
		printInfo("年费抽奖协议回调报错：" .. status)
	end
end

function AnnualFeeSkinAgent:sendPM_AnnualFeeBuyReq(activityId, count)
	local req = AnnualFeeSkinExtension_pb.PM_AnnualFeeBuyReq()

	req.activityId = activityId
	req.count = count

	self:sendMsg(req)
end

function AnnualFeeSkinAgent:handlePM_AnnualFeeBuyRes(status, msg)
	if status == 0 then
		YearCardLotteryController.instance:handleBuy(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardLotteryError, status)
		printInfo("年费抽奖协议回调报错：" .. status)
	end
end

AnnualFeeSkinAgent.instance = AnnualFeeSkinAgent.New()

return AnnualFeeSkinAgent
