-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/controller/BirthdayWishesController.lua

module("logic.extensions.birthdaywishes.controller.BirthdayWishesController", package.seeall)

local BirthdayWishesController = class("BirthdayWishesController", BaseController)

function BirthdayWishesController:ctor()
	self._curParams = nil
	self._szSupTime = nil
end

function BirthdayWishesController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._tickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._regRedPoint, self)
	self:onReset()
end

function BirthdayWishesController:onReset()
	self._curParams = nil
	self._szSupTime = nil
	self._lotteryRpCache = nil
end

function BirthdayWishesController:csGetBirthdayWishesUserInfoReq(activityId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesUserInfoReq(activityId)
end

function BirthdayWishesController:csSendBirthdayWishesUserInfo(msg)
	BirthdayWishesModel.instance:csSendBirthdayWishesUserInfo(msg)
	BirthdayWishesModel.instance:handlePM_BirthdayWishesUserInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesInfo)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_COLLECTBLESSING_CAN_LOTTERY, self:checkLotteryRp())
end

function BirthdayWishesController:csGetBirthdayWishesSendWishReq(activityId, textId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesSendWishReq(activityId, textId)
end

function BirthdayWishesController:csSendBirthdayWishesSendWish(msg)
	BirthdayWishesModel.instance:csSendBirthdayWishesSendWish()
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesBlessText)
end

function BirthdayWishesController:csGetBirthdayWishesGiftOpenReq(activityId, giftType)
	self._curParams = {
		actId = activityId,
		giftType = giftType
	}

	BirthdayWishesAgent.instance:sendPM_BirthdayWishesGiftOpenReq(activityId, giftType)
end

function BirthdayWishesController:csSendBirthdayWishesGiftOpen(msg)
	if self._curParams == nil then
		return
	end

	local changeSetId = checknumber(msg.changeSetId)
	local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
	local prizeStrList = {}

	for _, mo in ipairs(matMos) do
		local prizeStr = mo:toString()

		table.insert(prizeStrList, prizeStr)
	end

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesOpenGift, changeSetId, prizeStrList)
	self:csGetBirthdayWishesUserInfoReq(self._curParams.actId)

	self._lotteryRpCache = nil
end

function BirthdayWishesController:csGetBirthdayWishesGiveFriendReq(activityId, friendUserId, tokenId)
	self._curParams = {
		actId = activityId,
		friendUserId = friendUserId,
		tokenId = tokenId
	}

	BirthdayWishesAgent.instance:sendPM_BirthdayWishesGiveFriendReq(activityId, friendUserId, tokenId)
end

function BirthdayWishesController:csSendBirthdayWishesGiveFriend(msg)
	if self._curParams == nil then
		return
	end

	BirthdayWishesModel.instance:csSendBirthdayWishesGiveFriend(self._curParams)

	self._curParams = nil

	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesGiveaway)

	self._lotteryRpCache = nil
end

function BirthdayWishesController:csGetBirthdayWishesGiveAndGetRecordReq(activityId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesGiveAndGetRecordReq(activityId)
end

function BirthdayWishesController:csSendBirthdayWishesGiveAndGetRecord(msg)
	local list = {}

	if msg and msg.records then
		list = msg.records
	end

	BirthdayWishesModel.instance:handleBirthdayWishesGiveAndGetRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesReceived, list)

	self._lotteryRpCache = nil
end

function BirthdayWishesController:csGetBirthdayWishesUserRedPointSetReq(activityId, giftType, redOpen)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesUserRedPointSetReq(activityId, giftType, redOpen)
end

function BirthdayWishesController:csSendBirthdayWishesUserRedPointSet(msg)
	if msg == nil or msg.giftType == nil then
		return
	end

	BirthdayWishesModel.instance:csSendBirthdayWishesUserRedPointSet(msg)
end

function BirthdayWishesController:sendBirthdayWishesPutOutWishListReq(activityId, wishListId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesPutOutWishListReq(activityId, wishListId)
end

function BirthdayWishesController:handleBirthdayWishesPutOutWishListRes(msg)
	self:csGetBirthdayWishesUserInfoReq(BirthdayWishesModel.instance:getActivityId())
	self:sendBirthdayWishesGetAllWishListReq(BirthdayWishesModel.instance:getActivityId())
end

function BirthdayWishesController:sendBirthdayWishesRepealWishListReq(activityId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesRepealWishListReq(activityId)
end

function BirthdayWishesController:handleBirthdayWishesRepealWishListRes(msg)
	self:sendBirthdayWishesGetAllWishListReq(BirthdayWishesModel.instance:getActivityId())
	self:csGetBirthdayWishesUserInfoReq(BirthdayWishesModel.instance:getActivityId())
end

function BirthdayWishesController:sendBirthdayWishesGetAllWishListReq(activityId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesGetAllWishListReq(activityId)
end

function BirthdayWishesController:handleBirthdayWishesGetAllWishListRes(msg)
	BirthdayWishesModel.instance:handleBirthdayWishesGetAllWishListRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BuddyWishListInfoRes)
end

function BirthdayWishesController:sendBirthdayWishesGetWishListRecordReq(activityId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesGetWishListRecordReq(activityId)
end

function BirthdayWishesController:handleBirthdayWishesGetWishListRecordRes(msg)
	BirthdayWishesModel.instance:handleBirthdayWishesGetWishListRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WishListRecordRes)
end

function BirthdayWishesController:sendBirthdayWishesFinishBuddyWishListReq(activityId, targetUserId)
	BirthdayWishesAgent.instance:sendPM_BirthdayWishesFinishBuddyWishListReq(activityId, targetUserId)
end

function BirthdayWishesController:handleBirthdayWishesFinishBuddyWishListRes(msg)
	self:sendBirthdayWishesGetAllWishListReq(BirthdayWishesModel.instance:getActivityId())

	self._lotteryRpCache = nil
end

function BirthdayWishesController:sendPM_BirthadyWishesGainCollectPrizeReq(activityId, prizeId)
	BirthdayWishesAgent.instance:sendPM_BirthadyWishesGainCollectPrizeReq(activityId, prizeId)
end

function BirthdayWishesController:handlePM_BirthadyWishesGainCollectPrizeRes(msg)
	BirthdayWishesModel.instance:handlePM_BirthadyWishesGainCollectPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BirthadyWishesGainCollectPrizeRes)
end

function BirthdayWishesController:sendPM_BirthadyWishesGainGivePrizeReq(activityId, prizeId)
	BirthdayWishesAgent.instance:sendPM_BirthadyWishesGainGivePrizeReq(activityId, prizeId)
end

function BirthdayWishesController:handlePM_BirthadyWishesGainGivePrizeRes(msg)
	BirthdayWishesModel.instance:handlePM_BirthadyWishesGainGivePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BirthadyWishesGainGivePrizeRes)
end

function BirthdayWishesController:canGetPrize(activityId, prizeId)
	local collectPrizeData = BirthdayWishesConfig.instance:getCollectPrizeDataById(activityId, prizeId)
	local tokens = collectPrizeData.needTokens

	for i, tokenId in ipairs(tokens) do
		local matStr = BirthdayWishesConfig.instance:getTokenMatStr(tokenId)
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		local num = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if num <= 0 then
			return false
		end
	end

	return true
end

function BirthdayWishesController:hasGainPrize(activityId, prizeId)
	local curModel = BirthdayWishesModel.instance:GetModel(activityId)
	local hasGainIds = curModel.gainCollectPrizeIds

	return table.indexof(hasGainIds, prizeId)
end

function BirthdayWishesController:canGetWishGivePrize(activityId, prizeId)
	local curModel = BirthdayWishesModel.instance:GetModel(activityId)
	local data = BirthdayWishesConfig.instance:getWishGivePrizeDataById(activityId, prizeId)
	local totalGiveNum = curModel.totalGiveNum

	return totalGiveNum >= data.times
end

function BirthdayWishesController:hasGainWishGivePrize(activityId, prizeId)
	local curModel = BirthdayWishesModel.instance:GetModel(activityId)
	local hasGainIds = curModel.gainGivePrizeIds

	return table.indexof(hasGainIds, prizeId)
end

function BirthdayWishesController:isCanLottery()
	local activityId = BirthdayWishesModel.instance:getActivityId()

	if checknumber(activityId) <= 0 then
		return false, 3
	end

	local giftPlan = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(activityId).giftPlan
	local giftType = BirthdayWishesModel.instance:getGiftType()
	local planCfgs = BirthdayWishesConfig.instance:getBirthdayWishesPlanCfgsById(giftPlan, giftType)

	if planCfgs == nil then
		return false, 3
	end

	local costList = string.split(planCfgs.cost, "#")

	for i, v in ipairs(costList) do
		local type, id, num = MaterialMgr.getMatParams(v)

		if not MaterialModel.instance:IsEnough(type, id, num) then
			return false, 1
		end
	end

	local baseInfo = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo()
	local lotteryMaxNum = planCfgs.lotteryMaxNum

	for k, v in pairs(baseInfo.giftInfos) do
		if lotteryMaxNum <= v.openTime then
			return false, 2
		end
	end

	return true
end

function BirthdayWishesController:isWishListCD()
	local cdTimeStamp = BirthdayWishesModel.instance:getWishListCD()

	if cdTimeStamp == nil or cdTimeStamp == 0 then
		return false
	end

	return cdTimeStamp > ServerTime.nowMs()
end

function BirthdayWishesController:checkLotteryRp()
	if RedPointModel.instance:isActive(RedPointModel.ID_COLLECTBLESSING_TASK) then
		return true
	end

	if self._lotteryRpCache then
		return self._lotteryRpCache
	end

	self._lotteryRpCache = self:isCanLottery()

	return self._lotteryRpCache
end

function BirthdayWishesController:_tickDailyRefreshData()
	self:_regRedPoint()
end

function BirthdayWishesController:_regRedPoint()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_COLLECTBLESSING_DAILY_RED)
end

function BirthdayWishesController:markDailyRedPoint()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_COLLECTBLESSING_DAILY_RED)
end

function BirthdayWishesController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function BirthdayWishesController:getActivityType()
	return GameEnum.ActivityType.BirthdayWishes
end

function BirthdayWishesController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

BirthdayWishesController.instance = BirthdayWishesController.New()

return BirthdayWishesController
