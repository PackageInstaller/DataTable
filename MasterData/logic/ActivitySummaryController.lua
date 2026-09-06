-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/controller/ActivitySummaryController.lua

module("logic.extensions.bonus.controller.ActivitySummaryController", package.seeall)

local ActivitySummaryController = class("ActivitySummaryController", BaseController)

function ActivitySummaryController:ctor()
	return
end

function ActivitySummaryController:onInit()
	self:onReset()
end

function ActivitySummaryController:onReset()
	self:initAllTableRedPoint()
end

function ActivitySummaryController:sendGetInfoReq()
	self._needSendReqOfActIdStack = {}

	local dataList = XiaonuoBirthConfig.instance:getActivityDataList()

	for _, xbData in pairs(dataList) do
		if self:isUnlockAsSign(xbData.activityId) then
			table.insert(self._needSendReqOfActIdStack, xbData.activityId)
		end
	end

	self:sendGetSignInfoReqFromStack()
end

function ActivitySummaryController:sendGetSignInfoReqFromStack()
	if self._needSendReqOfActIdStack == nil then
		return
	end

	if #self._needSendReqOfActIdStack == 0 then
		return
	end

	local actId = self._needSendReqOfActIdStack[#self._needSendReqOfActIdStack]

	self._needSendReqOfActIdStack[#self._needSendReqOfActIdStack] = nil

	self:sendGetSignInfo(actId)
end

function ActivitySummaryController:initAllTableRedPoint()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(checknumber(GameEnum.ActivityType.WelfareSummary))

	if cfg == nil or string.nilorempty(cfg.startTime) then
		return
	end

	local activityId = cfg.activityId
	local startTime = GameUtil.string2time(cfg.startTime)
	local nowTime = ServerTime.now()
	local redIdList = {
		RedPointModel.ID_BIRTH_TAB_1,
		RedPointModel.ID_BIRTH_TAB_2,
		RedPointModel.ID_BIRTH_TAB_3,
		RedPointModel.ID_BIRTH_TAB_4,
		RedPointModel.ID_BIRTH_TAB_5,
		RedPointModel.ID_BIRTH_TAB_6,
		RedPointModel.ID_BIRTH_TAB_7,
		RedPointModel.ID_BIRTH_TAB_8
	}
	local dataList = XiaonuoBirthConfig.instance:getTabList(activityId) or {}

	for _, redId in ipairs(redIdList) do
		local isNeedTryRed = true
		local data

		for _, v in ipairs(dataList) do
			if v.dayRedpointId == tostring(redId) then
				data = v

				break
			end
		end

		if data and not string.nilorempty(data.limitTime) then
			local arr = stirng.split(data.limitTime, "#")

			if not GameUtil.checkIsInTimePeriod(arr[1], arr[2]) then
				RedPointController.instance:setRedPointInfo(redId, false)

				isNeedTryRed = false
			end
		elseif not data then
			RedPointController.instance:setRedPointInfo(redId, false)

			isNeedTryRed = false
		end

		if isNeedTryRed then
			local index = startTime <= nowTime + 604800 and 1 or 2

			self:_setTableRedPoint(redId, index)
		end
	end

	local function regOnceRedPoint()
		RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_SUMMERDOUBLE_FIRST_OPEN)
		RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_BIRTH_SIGN_IN_TWO)
	end

	GameUtil.whenLocalDataInited(regOnceRedPoint)
end

function ActivitySummaryController:_setTableRedPoint(redId, index)
	if checknumber(redId) ~= 0 and checknumber(index) ~= 0 then
		local key = string.format("day_red_key_%s_%s", index, redId)

		GameUtil.getUserData(key, function(value)
			if checknumber(value) == 0 then
				RedPointController.instance:setRedPointInfo(redId, true)
			else
				RedPointController.instance:setRedPointInfo(redId, false)
			end
		end)
	end
end

function ActivitySummaryController:resetTableRedPoint(redId, index)
	if checknumber(redId) ~= 0 and checknumber(index) ~= 0 then
		local key = string.format("day_red_key_%s_%s", index, redId)

		GameUtil.saveUserData(key, 1)
		RedPointController.instance:setRedPointInfo(redId, false)
	end
end

function ActivitySummaryController:updateRedPoint()
	local actID = self:getActivityId()

	if actID < 0 then
		return
	end

	local hasAnyLikePrize = false
	local dailyLikeCfgs = XiaonuoBirthConfig.instance:getDailyLikeCfgs(actID)

	for _, cfg in pairs(dailyLikeCfgs) do
		for _, data in ipairs(cfg) do
			hasAnyLikePrize = hasAnyLikePrize or self:canGainAnyLikePrize(actID, data.tab)
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BIRTH_LIKE, hasAnyLikePrize)

	local signActRedIdListStr = XiaonuoBirthConfig.instance:getCommonValue("SIGN_ACT_REDID_LIST")

	if not string.nilorempty(signActRedIdListStr) then
		local signActRedIdList = string.split(signActRedIdListStr, "#")

		for _, signActRedIdStr in ipairs(signActRedIdList) do
			local array = string.split(signActRedIdStr, ":")

			RedPointController.instance:setRedPointInfo(checknumber(array[2]), self:canGainAnySignInPrize((checknumber(array[1]))))
		end
	end

	local info = ActivitySummaryModel.instance:getSignInfo(actID)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_XiaoNuoWeeklyPrize, (info or nil) and not info.hasGainedWeekPrize)
end

function ActivitySummaryController:canGainAnySignInPrize(activityId)
	local info = ActivitySummaryModel.instance:getSignInfo(activityId) or {}
	local onlineDay = checknumber(info.onlineDay) + checknumber(info.buytimes)

	if not info.hasGainPrizeDays then
		local signInMap = {}

		for i, v in ipairs(info.hasGainPrizeDays) do
			signInMap[v] = true
		end

		local cfgList = XiaonuoBirthConfig.instance:getSignInList(activityId) or {}

		for i, v in pairs(cfgList) do
			if checknumber(i) > 0 and onlineDay >= v.signInDays and signInMap[i] == nil then
				return true
			end
		end

		local actCfg = XiaonuoBirthConfig.instance:getActivity(activityId)

		if actCfg and not string.nilorempty(actCfg.dailyPrize) and not info.hasGainedDailyPrize then
			return true
		end

		return false
	end
end

function ActivitySummaryController:canGainAnyLikePrize(activityId, tab)
	local all = XiaonuoBirthConfig.instance:getDailyLikeCfg(activityId, tab) or {}

	for _, v in ipairs(all) do
		if not ActivitySummaryModel.instance:hasLike(activityId, tab, v.id) then
			return true
		end
	end

	return false
end

function ActivitySummaryController:getActivityId()
	local str = XiaonuoBirthConfig.instance:getCommonValue("CURR_ACTIVITY_ID")

	return checknumber(str)
end

function ActivitySummaryController:sendGetSignInfo(actId)
	XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryGetInfoReq(actId)
end

function ActivitySummaryController:onGetSignInfo(msg)
	ActivitySummaryModel.instance:onGetSignInfo(msg)
	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
	self:sendGetSignInfoReqFromStack()
end

function ActivitySummaryController:sendGetSignInPrize(actId)
	XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryGainPrizeReq(actId)
end

function ActivitySummaryController:sendGetDaySignInPrize(actId)
	XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryGainDailyPrizeReq(actId)
end

function ActivitySummaryController:onGetSignInPrize(msg)
	ActivitySummaryModel.instance:onGetSignInPrize(msg)

	for _, day in ipairs(msg.day or {}) do
		if day == 14 then
			ViewAutoShowController.instance:trySetAutoEvaluation(0.25, ViewAutoShowController.TAPTAP_FUNC_1)

			break
		end
	end

	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
	self:sendGetSignInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.ActivityGainPrize, msg.activityId, msg.exchangeCode)
end

function ActivitySummaryController:onGainDailySignInPrize(msg)
	ActivitySummaryModel.instance:onGainDailySignInPrize(msg)
	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
end

function ActivitySummaryController:onBuyTime(msg)
	ActivitySummaryModel.instance:onBuyTime(msg, self:getActivityId())
	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
end

function ActivitySummaryController:sendLike(tab, id)
	XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryLikeReq(self:getActivityId(), tab, id)
end

function ActivitySummaryController:onLike(msg)
	ActivitySummaryModel.instance:onLike(msg, self:getActivityId())
	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
end

function ActivitySummaryController:getWeekPrize()
	XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryGainWeekPrizeReq(self:getActivityId())
end

function ActivitySummaryController:onGetWeeklyPrize(msg)
	ActivitySummaryModel.instance:onGetWeeklyPrize(msg)
	self:updateRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.ActivitySummaryUpdate)
end

function ActivitySummaryController:isUnlockAsSign(activityId)
	if not self:isInActTimeAsSign(activityId) then
		return false
	end

	local isUnlock = false
	local cfg = XiaonuoBirthConfig.instance:getSignInList(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isUnlockAsSignDay(activityId, data.signInDays) then
				isUnlock = true

				break
			end
		end
	end

	return isUnlock
end

function ActivitySummaryController:isInActTimeAsSign(activityId)
	return ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.WelfareSummary, activityId)
end

function ActivitySummaryController:isUnlockAsSignDay(activityId, signInDays)
	return self:isInActTimeAsSign(activityId) and self:isInTimeAsSignDay(activityId, signInDays)
end

function ActivitySummaryController:isInTimeAsSignDay(activityId, signInDays)
	return self:getTimePeriodAsSignDay(activityId, signInDays) == GameUtil.inTimePeriod
end

function ActivitySummaryController:getTimePeriodAsSignDay(activityId, signInDays)
	local data = XiaonuoBirthConfig.instance:getSignInTimeDataById(activityId, signInDays)

	return (data or nil) and GameUtil.getTimePeriod(data.startTime, data.endTime)
end

ActivitySummaryController.instance = ActivitySummaryController.New()

return ActivitySummaryController
