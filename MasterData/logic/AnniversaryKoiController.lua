-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/controller/AnniversaryKoiController.lua

module("logic.extensions.anniversarykoi.controller.AnniversaryKoiController", package.seeall)

local AnniversaryKoiController = class("AnniversaryKoiController", BaseController)

function AnniversaryKoiController:ctor()
	return
end

function AnniversaryKoiController:onInit()
	self:onReset()
end

function AnniversaryKoiController:onReset()
	return
end

function AnniversaryKoiController:sendPM_AnniversaryKoiGetInfoReq(activityId)
	AnniversaryKoiAgent.instance:sendPM_AnniversaryKoiGetInfoReq(activityId)
end

function AnniversaryKoiController:handlePM_AnniversaryKoiGetInfoRes(status, msg)
	AnniversaryKoiModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryKoiGetInfoRes)
end

function AnniversaryKoiController:sendPM_AnniversaryKoiLotteryReq(activityId, poolId)
	AnniversaryKoiAgent.instance:sendPM_AnniversaryKoiLotteryReq(activityId, poolId)
end

function AnniversaryKoiController:handlePM_AnniversaryKoiLotteryRes(status, msg)
	AnniversaryKoiModel.instance:setMyNumberInfo(msg.myNumbers)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryKoiLotteryRes)
end

function AnniversaryKoiController:sendPM_AnniversaryKoiGetRecordsReq(activityId)
	AnniversaryKoiAgent.instance:sendPM_AnniversaryKoiGetRecordsReq(activityId)
end

function AnniversaryKoiController:handlePM_AnniversaryKoiGetRecordsRes(status, msg)
	AnniversaryKoiModel.instance:setRecordInfo(msg.records)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryKoiGetRecordsRes)
end

function AnniversaryKoiController:sendPM_AnniversaryKoiRankViewReq(activityId, poolId, prizeType)
	AnniversaryKoiAgent.instance:sendPM_AnniversaryKoiRankViewReq(activityId, poolId, prizeType)
end

function AnniversaryKoiController:handlePM_AnniversaryKoiRankViewRes(status, msg)
	AnniversaryKoiModel.instance:setRankList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryKoiRankViewRes)
end

function AnniversaryKoiController:handlePM_AnniversaryKoiNotifyLuckNumberRes(status, msg)
	AnniversaryKoiModel.instance:setKoiNumberInfo(msg.myNumbers)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryKoiNotifyLuckNumberRes)
end

function AnniversaryKoiController:checkAnniversaryKoiLottery()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AnniversaryKoi)

	self:sendPM_AnniversaryKoiGetInfoReq(activityId)

	local koiNumber = AnniversaryKoiModel.instance:getKoiNumber() or {}
	local nowTime = ServerTime.now()
	local openTime, endTime = "0-0-0 20:00:00", "0-0-0 05:00:00"
	local key = "AnniversaryKoimainView"
	local isPlayAnim = GameUtil.getUserDayData(key)

	return GameUtil.checkIsInTimePeriod(openTime, endTime) and #koiNumber > 0 and not isPlayAnim
end

function AnniversaryKoiController:setRdInfo()
	local myNumber = AnniversaryKoiModel.instance:getMyNumberInfo() or {}
	local isInLotteryTime = self:timeState() ~= GameUtil.beforeTimePeriod

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNIVERSARYKOI_NUMBER, #myNumber <= 0 and not isInLotteryTime)

	local isHasNewRecord = AnniversaryKoiModel.instance:getRecordLightRed()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNIVERSARYKOI_RECORD, isHasNewRecord)
end

function AnniversaryKoiController:timeState()
	local openTime, endTime = "0-0-0 20:00:00", "0-0-0 05:00:00"

	return GameUtil.getTimePeriodType(openTime, endTime)
end

function AnniversaryKoiController:_TickDailyRefreshData()
	AnniversaryKoiModel.instance:resetMyNumberInfo()
end

AnniversaryKoiController.instance = AnniversaryKoiController.New()

return AnniversaryKoiController
