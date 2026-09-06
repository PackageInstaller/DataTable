-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/controller/AccumulateChargeController.lua

module("logic.extensions.accumulatecharge.controller.AccumulateChargeController", package.seeall)

local AccumulateChargeController = class("AccumulateChargeController", BaseController)

function AccumulateChargeController:ctor()
	return
end

function AccumulateChargeController:onInit()
	GlobalDispatcher:addListener(CampaignConsumeAgent.PM_CampaignConsumeGetInfoRes, self._onCampaignConsumeGetInfoRes, self)
	GlobalDispatcher:addListener(CampaignConsumeAgent.PM_CampaignConsumeGainPrizeRes, self._onCampaignConsumeGainPrizeRes, self)
end

function AccumulateChargeController:onReset()
	return
end

function AccumulateChargeController:sendPM_CampaignConsumeGetInfoReq(activityId)
	CampaignConsumeAgent.instance:sendPM_CampaignConsumeGetInfoReq(activityId)
end

function AccumulateChargeController:sendPM_CampaignConsumeGainPrizeReq(activityId, id)
	self._prizeId = id

	CampaignConsumeAgent.instance:sendPM_CampaignConsumeGainPrizeReq(activityId, id)
end

function AccumulateChargeController:_onCampaignConsumeGetInfoRes(status, msg)
	if status == 0 then
		AccumulateChargeModel.instance:onCampaignConsumeGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CampaignConsumeGetInfoRes)
	end
end

function AccumulateChargeController:_onCampaignConsumeGainPrizeRes(status, msg)
	if status == 0 then
		AccumulateChargeModel.instance:addPrizeId(self._prizeId)
		AccumulateChargeModel.instance:onCampaignConsumeGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CampaignConsumeGainPrizeRes, self._prizeId)

		self._prizeId = nil
	end
end

function AccumulateChargeController:sendOneKeyGainPrizeReq(activityId)
	CampaignConsumeAgent.instance:sendPM_CampaignConsumeOneKeyGainPrizeReq(activityId)
end

function AccumulateChargeController:_oneKeyGainPrizeRes(msg)
	AccumulateChargeModel.instance:onCampaignConsumeOneKeyGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CampaignConsumeGetInfoRes)
end

function AccumulateChargeController:getRankInfo(rankType, actId)
	AccumulateChargeModel.instance:resetRankInfoList()

	local _rankType = checkint(rankType)

	if _rankType == 1 then
		GodGemAccConsumeAgent.instance:sendPM_GGACGetCostRankInfoReq(actId)
	else
		CampaignConsumeAgent.instance:sendPM_CampaignConsumeRankInfoReq(actId)
	end
end

function AccumulateChargeController:handleGetRankInfo(msg)
	AccumulateChargeModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CampaignConsumeGetInfoRes)
end

AccumulateChargeController.instance = AccumulateChargeController.New()

return AccumulateChargeController
