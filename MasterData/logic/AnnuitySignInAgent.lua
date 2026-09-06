-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/agent/AnnuitySignInAgent.lua

module("logic.extensions.yearcardsignin.agent.AnnuitySignInAgent", package.seeall)

local AnnuitySignInAgent = class("AnnuitySignInAgent", BaseAgent)

function AnnuitySignInAgent:sendPM_AnnuitySignInGetInfoReq(actId)
	local req = AnnuitySignInExtension_pb.PM_AnnuitySignInGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function AnnuitySignInAgent:handlePM_AnnuitySignInGetInfoRes(status, msg)
	if status == 0 then
		YearCardSignInController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInError, status)
		printInfo("年费签到协议回调报错：" .. status)
	end
end

function AnnuitySignInAgent:sendPM_AnnuitySignInGainPrizeReq(actId, day)
	local req = AnnuitySignInExtension_pb.PM_AnnuitySignInGainPrizeReq()

	req.actId = actId
	req.day = day

	self:sendMsg(req)
end

function AnnuitySignInAgent:handlePM_AnnuitySignInGainPrizeRes(status, msg)
	if status == 0 then
		YearCardSignInController.instance:handleSignIn(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInError, status)
		printInfo("年费签到协议回调报错：" .. status)
	end
end

function AnnuitySignInAgent:sendPM_AnnuitySignInGainPrizeOnekeyReq(actId)
	local req = AnnuitySignInExtension_pb.PM_AnnuitySignInGainPrizeOnekeyReq()

	req.actId = actId

	self:sendMsg(req)
end

function AnnuitySignInAgent:handlePM_AnnuitySignInGainPrizeOnekeyRes(status, msg)
	if status == 0 then
		YearCardSignInController.instance:handleSignInOneKey(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInError, status)
		printInfo("年费签到协议回调报错：" .. status)
	end
end

function AnnuitySignInAgent:sendPM_AnnuitySignInCostReq(actId, giftId)
	local req = AnnuitySignInExtension_pb.PM_AnnuitySignInCostReq()

	req.actId = actId
	req.giftId = giftId

	self:sendMsg(req)
end

function AnnuitySignInAgent:handlePM_AnnuitySignInCostRes(status, msg)
	if status == 0 then
		YearCardSignInController.instance:handleBuyGift(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInError, status)
		printInfo("年费签到协议回调报错：" .. status)
	end
end

AnnuitySignInAgent.instance = AnnuitySignInAgent.New()

return AnnuitySignInAgent
