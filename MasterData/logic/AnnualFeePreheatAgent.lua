-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/agent/AnnualFeePreheatAgent.lua

module("logic.extensions.annualfeepreheat.agent.AnnualFeePreheatAgent", package.seeall)

local AnnualFeePreheatAgent = class("AnnualFeePreheatAgent", BaseAgent)

function AnnualFeePreheatAgent:sendPM_GetAnnualFeeInfoReq(activityId)
	local req = AnnualFeePreheatExtension_pb.PM_GetAnnualFeeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnnualFeePreheatAgent:handlePM_GetAnnualFeeInfoRes(status, msg)
	if status == 0 then
		YearCardPreheatController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatError, status)
		printInfo("年费预热售卖协议回调报错：" .. status)
	end
end

function AnnualFeePreheatAgent:sendPM_AnnualFeeStartGameReq(activityId, clientKey)
	local req = AnnualFeePreheatExtension_pb.PM_AnnualFeeStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function AnnualFeePreheatAgent:handlePM_AnnualFeeStartGameRes(status, msg)
	if status == 0 then
		YearCardPreheatController.instance:handleStartGame(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatError, status)
		printInfo("年费预热售卖协议回调报错：" .. status)
	end
end

function AnnualFeePreheatAgent:sendPM_AnnualFeeEndGameReq(activityId, isWin, stageId, encryptedKey)
	local req = AnnualFeePreheatExtension_pb.PM_AnnualFeeEndGameReq()

	req.activityId = activityId
	req.isWin = isWin
	req.stageId = stageId
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function AnnualFeePreheatAgent:handlePM_AnnualFeeEndGameRes(status, msg)
	if status == 0 then
		YearCardPreheatController.instance:handleGameOver(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatError, status)
		printInfo("年费预热售卖协议回调报错：" .. status)
	end
end

function AnnualFeePreheatAgent:sendPM_GainAnnualFeePrizeReq(activityId, id)
	local req = AnnualFeePreheatExtension_pb.PM_GainAnnualFeePrizeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function AnnualFeePreheatAgent:handlePM_GainAnnualFeePrizeRes(status, msg)
	if status == 0 then
		YearCardPreheatController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatError, status)
		printInfo("年费预热售卖协议回调报错：" .. status)
	end
end

function AnnualFeePreheatAgent:sendPM_AnnualFeeUnlockReq(activityId, id)
	local req = AnnualFeePreheatExtension_pb.PM_AnnualFeeUnlockReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function AnnualFeePreheatAgent:handlePM_AnnualFeeUnlockRes(status, msg)
	if status == 0 then
		YearCardPreheatController.instance:handleUnlock(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatError, status)
		printInfo("年费预热售卖协议回调报错：" .. status)
	end
end

AnnualFeePreheatAgent.instance = AnnualFeePreheatAgent.New()

return AnnualFeePreheatAgent
