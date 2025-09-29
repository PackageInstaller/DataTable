-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/controller/SigninController.lua

module("logic.extensions.signin.controller.SigninController", package.seeall)

local M = class("SigninController", BaseController)

M.POP_UP_DAILY = {
	jumpId = 10900001,
	key = LoginPopEnum.PopCode[LoginPopEnum.PopType.Sign]
}
M.POP_UP_HISTORY = {
	jumpId = 10900003,
	key = LoginPopEnum.PopCode[LoginPopEnum.PopType.LoginOfSeven]
}

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
	self:_setEvent(true)
end

function M:onReset()
	self:setCrossDay(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleActivityAllRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
		GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.WelfareSignInDaily), self._handleOnSystemOpenDaily, self)
		GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.WelfareSignInHistory), self._handleOnSystemOpenHistory, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleActivityAllRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.WelfareSignInDaily), self._handleOnSystemOpenDaily, self)
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.WelfareSignInHistory), self._handleOnSystemOpenHistory, self)
	end
end

function M:_handleOnSystemOpenDaily()
	self:setCrossDay(true)
	ActivityAgent.instance:sendGetActivityInfoRequest()
end

function M:_handleOnSystemOpenHistory()
	self:setCrossDay(true)
	ActivityAgent.instance:sendGetActivityInfoRequest()
end

function M:setCrossDay(isCrossDay)
	self._CrossDay = isCrossDay
end

function M:getCrossDay()
	return self._CrossDay
end

function M:regLoginPopUp()
	self:regDailySign()
	self:regSevenSign()
end

function M:regDailySign()
	if WelfareSigninModel.instance:HasDailySignInAct() then
		local code = self.POP_UP_DAILY.key
		local otherCode = 0
		local jumpId = self.POP_UP_DAILY.jumpId

		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, otherCode, true, jumpId)
	end
end

function M:regSevenSign()
	local sevenSignActLst = WelfareSigninModel.instance:getAllSevenSignInActMo()

	if #sevenSignActLst > 0 then
		for _, value in ipairs(sevenSignActLst) do
			local needAppend = true

			if value:isAllReceive() then
				needAppend = false
			end

			if not value:getCanReward() then
				needAppend = false
			end

			if needAppend then
				local info = {}

				info.actId = value:getActivity()

				local code = self.POP_UP_HISTORY.key
				local otherCode = value:getActivity()
				local jumpId = self.POP_UP_HISTORY.jumpId

				GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, otherCode, true, jumpId, info)
			end
		end
	end
end

function M:refreshSignInInfoLst(dataLst)
	WelfareSigninModel.instance:updateSigninInfoLst(dataLst, true)

	if self:getCrossDay() then
		self:setCrossDay(false)
		self:regLoginPopUp()
	end
end

function M:onSignInReward(activityId, day)
	WelfareSigninModel.instance:receiveReward(activityId, day)

	local sevenSignActLst = WelfareSigninModel.instance:getAllSevenSignInActMo()

	if #sevenSignActLst > 0 then
		for _, value in ipairs(sevenSignActLst) do
			local needAppend = true

			if value:isAllReceive() then
				needAppend = false
			end

			if not value:getCanReward() then
				needAppend = false
			end

			if not needAppend then
				local code = self.POP_UP_HISTORY.key
				local otherCode = value:getActivity()

				GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, otherCode, false)
			end
		end
	end
end

function M:_handleActivityAllRefresh(e)
	WelfareSigninAgent.instance:sendGetSignInInfoRequest()
end

function M:_handleClockTickDailyRefresh(e, enum)
	local currentTime = ServerTime.now()

	printWarn(string.format("<color=#45e6f9>TickDailyRefresh,每日更新回调,当前时间 [%s] [%s]</color>", currentTime, TimeUtil.instance:stampToDateStr(currentTime)))
	self:setCrossDay(true)
	ActivityAgent.instance:sendGetActivityInfoRequest()
	BackpackAgent.instance:sendExchangeRemainedTimesRequest()
end

function M:tryPopUpCacheSignInReward(callBack, callBackHandler)
	local popUp = false
	local cacheItemLst = WelfareSigninModel.instance:getCacheItemMOList()

	if #cacheItemLst > 0 then
		GainItemController.instance:openView(cacheItemLst, false, nil, nil, false, callBack, callBackHandler)

		popUp = true
	end

	WelfareSigninModel.instance:setCacheItemMOList(nil)

	return popUp
end

M.instance = M.New()

return M
