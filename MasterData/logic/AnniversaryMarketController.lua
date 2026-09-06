-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/controller/AnniversaryMarketController.lua

module("logic.extensions.anniversarymarket.controller.AnniversaryMarketController", package.seeall)

local AnniversaryMarketController = class("AnniversaryMarketController", BaseController)

function AnniversaryMarketController:ctor()
	return
end

function AnniversaryMarketController:onInit()
	self:onReset()
end

function AnniversaryMarketController:onReset()
	self._invitCdTime = 0
end

function AnniversaryMarketController:getInviteCdTime()
	return checknumber(self._invitCdTime)
end

function AnniversaryMarketController:setInviteCdTime(time)
	self._invitCdTime = time
end

function AnniversaryMarketController:beginIniteCdTime()
	settimer(1, self._onIniteCd, self, true)
end

function AnniversaryMarketController:_onIniteCd()
	self._invitCdTime = checknumber(self._invitCdTime) - 1

	if self._invitCdTime <= 0 then
		removetimer(self._onIniteCd, self)
	end
end

function AnniversaryMarketController:sendPM_AnniversaryMarketGetInfoReq(activityId)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketGetInfoReq(activityId)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketGetInfoRes(msg)
	AnniversaryMarketModel.instance:handlePM_AnniversaryMarketGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketGetInfoRes)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketGetMyShareCodeReq(activityId)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketGetMyShareCodeReq(activityId)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketGetMyShareCodeRes(msg)
	AnniversaryMarketModel.instance:handlePM_AnniversaryMarketGetMyShareCodeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketGetMyShareCodeRes, msg.shareCode, msg.otherSellCount)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketGetOtherInfoReq(activityId, shareCode)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketGetOtherInfoReq(activityId, shareCode)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketGetOtherInfoRes(msg)
	local isCorrectShareCode = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketGetOtherInfoRes, msg, isCorrectShareCode)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketSellInMyMarketReq(activityId, useMaterialCount)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketSellInMyMarketReq(activityId, useMaterialCount)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketSellInMyMarketRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketSellInMyMarketRes)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketSellInOtherMarketReq(activityId, otherShareCode, useMaterialCount)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketSellInOtherMarketReq(activityId, otherShareCode, useMaterialCount)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketSellInOtherMarketRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketSellInOtherMarketRes)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketRefreshPrizePoolReq(activityId, prizePoolId)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketRefreshPrizePoolReq(activityId, prizePoolId)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketRefreshPrizePoolRes(msg)
	local prizePoolId = msg.prizePoolId
	local info = AnniversaryMarketModel.instance:getInfo(msg.activityId)
	local prePoolInfo = info.prizePools[prizePoolId]
	local prePrizeId = prePoolInfo.prizeId

	AnniversaryMarketModel.instance:handlePM_AnniversaryMarketRefreshPrizePoolRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketRefreshPrizePoolRes, msg.prizePoolId, prePrizeId, msg.newPrizeId)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketConfirmRefreshReq(activityId, prizePoolId)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketConfirmRefreshReq(activityId, prizePoolId)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketConfirmRefreshRes(msg)
	AnniversaryMarketModel.instance:handlePM_AnniversaryMarketConfirmRefreshRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketConfirmRefreshRes)
end

function AnniversaryMarketController:sendPM_AnniversaryMarketGainPrizePoolReq(activityId, prizePoolId)
	AnniversaryMarketAgent.instance:sendPM_AnniversaryMarketGainPrizePoolReq(activityId, prizePoolId)
end

function AnniversaryMarketController:handlePM_AnniversaryMarketGainPrizePoolRes(msg)
	AnniversaryMarketModel.instance:handlePM_AnniversaryMarketGainPrizePoolRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnniversaryMarketGainPrizePoolRes)
end

function AnniversaryMarketController:handlePM_Notify_AnniversaryMarketOtherSellInMyMarketRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_AnniversaryMarketOtherSellInMyMarketRes)
end

function AnniversaryMarketController:getRateInRewardPool(prizeWeightPlanId, weight, sameWeightNum, idx, weightLength)
	local weightPlanCfg = AnniversaryMarketConfig.instance:getWeightPlanCfg(prizeWeightPlanId)
	local totalWeight = 0

	for k, cfg in pairs(weightPlanCfg) do
		totalWeight = totalWeight + cfg.weight
	end

	return (self:_caculateRate(weight, sameWeightNum, totalWeight))
end

function AnniversaryMarketController:_caculateRate(weight, sameWeightNum, totalWeight)
	local num = weight * sameWeightNum / totalWeight * 10000
	local leftNum = num % 10

	return (leftNum >= 5 and math.ceil(num / 10) or math.floor(num / 10)) / 10
end

AnniversaryMarketController.instance = AnniversaryMarketController.New()

return AnniversaryMarketController
