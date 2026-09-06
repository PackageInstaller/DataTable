-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/agent/AnniversaryMarketAgent.lua

module("logic.extensions.anniversarymarket.agent.AnniversaryMarketAgent", package.seeall)

local AnniversaryMarketAgent = class("AnniversaryMarketAgent", BaseAgent)

function AnniversaryMarketAgent:sendPM_AnniversaryMarketGetInfoReq(activityId)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketGetInfoRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketGetInfoRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketGetMyShareCodeReq(activityId)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketGetMyShareCodeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketGetMyShareCodeRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketGetMyShareCodeRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketGetOtherInfoReq(activityId, shareCode)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketGetOtherInfoReq()

	req.activityId = activityId
	req.shareCode = shareCode

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketGetOtherInfoRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketGetOtherInfoRes(msg)
	else
		local isCorrectShareCode = false

		GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketGetOtherInfoRes, nil, isCorrectShareCode)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketSellInMyMarketReq(activityId, useMaterialCount)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketSellInMyMarketReq()

	req.activityId = activityId
	req.useMaterialCount = useMaterialCount

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketSellInMyMarketRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketSellInMyMarketRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketSellInOtherMarketReq(activityId, otherShareCode, useMaterialCount)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketSellInOtherMarketReq()

	req.activityId = activityId
	req.otherShareCode = otherShareCode
	req.useMaterialCount = useMaterialCount

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketSellInOtherMarketRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketSellInOtherMarketRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketRefreshPrizePoolReq(activityId, prizePoolId)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketRefreshPrizePoolReq()

	req.activityId = activityId
	req.prizePoolId = prizePoolId

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketRefreshPrizePoolRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketRefreshPrizePoolRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketConfirmRefreshReq(activityId, prizePoolId)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketConfirmRefreshReq()

	req.activityId = activityId
	req.prizePoolId = prizePoolId

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketConfirmRefreshRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketConfirmRefreshRes(msg)
	end
end

function AnniversaryMarketAgent:sendPM_AnniversaryMarketGainPrizePoolReq(activityId, prizePoolId)
	local req = AnniversaryMarketExtension_pb.PM_AnniversaryMarketGainPrizePoolReq()

	req.activityId = activityId
	req.prizePoolId = prizePoolId

	self:sendMsg(req)
end

function AnniversaryMarketAgent:handlePM_AnniversaryMarketGainPrizePoolRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_AnniversaryMarketGainPrizePoolRes(msg)
	end
end

function AnniversaryMarketAgent:handlePM_Notify_AnniversaryMarketOtherSellInMyMarketRes(status, msg)
	if status == 0 then
		AnniversaryMarketController.instance:handlePM_Notify_AnniversaryMarketOtherSellInMyMarketRes(msg)
	end
end

AnniversaryMarketAgent.instance = AnniversaryMarketAgent.New()

return AnniversaryMarketAgent
