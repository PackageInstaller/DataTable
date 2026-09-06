-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/controller/AccumulateLotteryController.lua

module("logic.extensions.accumulatelottery.controller.AccumulateLotteryController", package.seeall)

local AccumulateLotteryController = class("AccumulateLotteryController", BaseController)

function AccumulateLotteryController:onReset()
	return
end

function AccumulateLotteryController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(PayController.NotifyPayResultRes, self._onNotifyPayResultRes, self)
end

function AccumulateLotteryController:getActivityId()
	local activities = AccumulateLotteryConfig.instance:getActivities()

	for i = 1, #activities do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AccumulateLottery, activities[i].activityId) then
			return activities[i].activityId
		end
	end

	return 0
end

function AccumulateLotteryController:getLocalStorageKey(isYear)
	local activityId = self:getActivityId()

	if activityId == 0 then
		return
	end

	local activityCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.AccumulateLottery, activityId)
	local startTime = GameUtil.string2date(activityCfg.startTime)
	local endTime = GameUtil.string2date(activityCfg.endTime)
	local key = isYear and RoleModel.instance:getUserId() .. "acc_lottery_" or RoleModel.instance:getUserId() .. "acc_lottery_nyear_"

	key = key .. activityId .. "_" .. startTime.year .. "_" .. startTime.month .. "_" .. startTime.day .. "_" .. startTime.hour .. "_" .. startTime.min .. "_" .. endTime.year .. "_" .. endTime.month .. "_" .. endTime.day .. "_" .. endTime.hour .. "_" .. endTime.min

	return key
end

function AccumulateLotteryController:hasShowYearTips(isYear)
	local key = self:getLocalStorageKey(isYear)

	if isYear then
		return checknumber(UnityEngine.PlayerPrefs.GetInt(key)) ~= 0
	end

	return GameUtil.getUserDayData(key) ~= nil
end

function AccumulateLotteryController:setShowYearTips(isYear)
	local key = self:getLocalStorageKey(isYear)

	if isYear then
		UnityEngine.PlayerPrefs.SetInt(key, 1)
	else
		GameUtil.saveUserDayData(key, 1)
	end
end

function AccumulateLotteryController:needPlayRewardsAnim()
	local key = RoleModel.instance:getUserId() .. "_acc_lottery_rewards_anim"

	return GameUtil.getUserDayData(key) == nil
end

function AccumulateLotteryController:setPlayRewardsAnim()
	local key = RoleModel.instance:getUserId() .. "_acc_lottery_rewards_anim"

	GameUtil.saveUserDayData(key, 1)
end

function AccumulateLotteryController:requestActivityInfo()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		AccumulateLotteryModel.instance:setActivityId(0)
		AccumulateLotteryModel.instance:setActivityInfo()

		return
	end

	local activityId = AccumulateLotteryModel.instance:getActivityId()
	local activityInfo = AccumulateLotteryModel.instance:getActivityInfo()

	if activityId == currActivityId and activityInfo then
		return
	end

	AccumulateLotteryModel.instance:setActivityId(currActivityId)
	AccumulateLotteryAgent.instance:sendPM_GetAnnuityAccLotteryInfoReq(currActivityId)
end

function AccumulateLotteryController:onActivityInfo(msg)
	AccumulateLotteryModel.instance:setActivityInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAccumulateLotteryInfo)
end

function AccumulateLotteryController:onAccLotteryDraw(msg)
	AccumulateLotteryModel.instance:setLotteryResult(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.OnAccumulateLotteryDraw)
end

function AccumulateLotteryController:_onNotifyPayResultRes(msg)
	AccumulateLotteryModel.instance:addPayMoney(msg.money)
end

AccumulateLotteryController.instance = AccumulateLotteryController.New()

return AccumulateLotteryController
