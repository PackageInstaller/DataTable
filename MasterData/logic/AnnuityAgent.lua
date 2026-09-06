-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/agent/AnnuityAgent.lua

module("logic.extensions.annuity.agent.AnnuityAgent", package.seeall)

local AnnuityAgent = class("AnnuityAgent", BaseAgent)

AnnuityAgent.PM_AnnuityGainWeeklyPrizeRes = "AnnuityAgent_PM_AnnuityGainWeeklyPrizeRes"
AnnuityAgent.PM_AnnuityGainFixedPrizeRes = "AnnuityAgent_PM_AnnuityGainFixedPrizeRes"
AnnuityAgent.PM_GetUserAnnuityInfoRes = "AnnuityAgent_PM_GetUserAnnuityInfoRes"
AnnuityAgent.PM_ActivateAnnuityRes = "AnnuityAgent_PM_ActivateAnnuityRes"
AnnuityAgent.PM_AnnuityGainMonthPrizeRes = "AnnuityAgent_PM_AnnuityGainMonthPrizeRes"

function AnnuityAgent:ctor()
	return
end

function AnnuityAgent:setExtId(extId)
	AnnuityAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AnnuityAgent:sendPM_AnnuityGainWeeklyPrizeReq(activityId, handler, handlerObj, errHandler)
	local req = AnnuityExtension_pb.PM_AnnuityGainWeeklyPrizeReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AnnuityAgent.PM_AnnuityGainWeeklyPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AnnuityAgent:handlePM_AnnuityGainWeeklyPrizeRes(status, msg)
	self:dispatch(AnnuityAgent.PM_AnnuityGainWeeklyPrizeRes, status, msg)
end

function AnnuityAgent:sendPM_AnnuityGainFixedPrizeReq(activityId, handler, handlerObj, errHandler)
	local req = AnnuityExtension_pb.PM_AnnuityGainFixedPrizeReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AnnuityAgent.PM_AnnuityGainFixedPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AnnuityAgent:handlePM_AnnuityGainFixedPrizeRes(status, msg)
	self:dispatch(AnnuityAgent.PM_AnnuityGainFixedPrizeRes, status, msg)
end

function AnnuityAgent:sendPM_GetUserAnnuityInfoReq(handler, handlerObj, errHandler)
	local req = AnnuityExtension_pb.PM_GetUserAnnuityInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AnnuityAgent.PM_GetUserAnnuityInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AnnuityAgent:handlePM_GetUserAnnuityInfoRes(status, msg)
	self:dispatch(AnnuityAgent.PM_GetUserAnnuityInfoRes, status, msg)
end

function AnnuityAgent:sendPM_ActivateAnnuityReq(activityId, handler, handlerObj, errHandler)
	local req = AnnuityExtension_pb.PM_ActivateAnnuityReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(AnnuityAgent.PM_ActivateAnnuityRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function AnnuityAgent:handlePM_ActivateAnnuityRes(status, msg)
	self:dispatch(AnnuityAgent.PM_ActivateAnnuityRes, status, msg)
end

function AnnuityAgent:sendPM_AnnuityGainMonthPrizeReq(activityId, prizeId)
	local req = AnnuityExtension_pb.PM_AnnuityGainMonthPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)

	self._activityId = activityId
	self._prizeId = prizeId
end

function AnnuityAgent:handlePM_AnnuityGainMonthPrizeRes(status, msg)
	if status == 0 then
		if self._activityId and self._prizeId then
			YearCardModel.instance:setIsGainMonthPrize(self._activityId, self._prizeId)
		end

		self._activityId = nil
		self._prizeId = nil

		GlobalDispatcher:dispatch(GlobalNotify.AnnuityGainMonthPrize)
		ViewAutoShowController.instance:trySetAutoEvaluation()
	end

	self:dispatch(AnnuityAgent.PM_AnnuityGainMonthPrizeRes, status, msg)
end

function AnnuityAgent:sendPM_AnnuityGainProgressPrizeReq(activityId, prizeId)
	local req = AnnuityExtension_pb.PM_AnnuityGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnnuityAgent:handlePM_AnnuityGainProgressPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
	end
end

function AnnuityAgent:sendPM_AnnuityGetRankInfoReq(activityId, space)
	local req = AnnuityExtension_pb.PM_AnnuityGetRankInfoReq()

	req.activityId = activityId
	req.space = space

	self:sendMsg(req)
end

function AnnuityAgent:handlePM_AnnuityGetRankInfoRes(status, msg)
	if status == 0 then
		YearCardController.instance:onGetRankInfo(msg)
	end
end

function AnnuityAgent:handlePM_AnnuityBuyGiftSuccess(status, msg)
	if status == 0 then
		YearCardModel.instance:onBuyGiftSuc(msg)
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
	end
end

function AnnuityAgent:sendPM_AnnuityGainSpaceProgressPrizeReq(actId, prizeId)
	local req = AnnuityExtension_pb.PM_AnnuityGainSpaceProgressPrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function AnnuityAgent:handlePM_AnnuityGainSpaceProgressPrizeRes(status, msg)
	if status == 0 then
		YearCardController.instance:handleGainSpaceProgressPrize(msg)
	end
end

function AnnuityAgent:sendPM_AnnuityGainForwardPayPrizeReq(actId)
	local req = AnnuityExtension_pb.PM_AnnuityGainForwardPayPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function AnnuityAgent:handlePM_AnnuityGainForwardPayPrizeRes(status, msg)
	if status == 0 then
		YearCardModel.instance:onGainForWardPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
	end
end

function AnnuityAgent:sendPM_AnnuityExchangeReq(activityId, giftId)
	local req = AnnuityExtension_pb.PM_AnnuityExchangeReq()

	req.activityId = activityId
	req.giftId = giftId

	self:sendMsg(req)
end

function AnnuityAgent:handlePM_AnnuityExchangeRes(status, msg)
	if status == 0 then
		YearCardModel.instance:onExchangeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityExchangeRes)
	end
end

AnnuityAgent.instance = AnnuityAgent.New()

return AnnuityAgent
