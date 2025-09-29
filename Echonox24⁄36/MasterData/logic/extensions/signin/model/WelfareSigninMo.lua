-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/model/WelfareSigninMo.lua

module("logic.extensions.signin.model.WelfareSigninMo", package.seeall)

local M = class("WelfareSigninMo")

function M:ctor()
	return
end

function M:updateFromServer(signInInfoNO)
	self._activity = signInInfoNO.activity
	self._tokenRewardDays = signInInfoNO.tokenRewardDays or {}
	self._totalSigned = signInInfoNO.totalSigned or 0
	self._fakeData = false
end

function M:updateFromClient(signInMo)
	self._activity = signInMo:getActivity()
	self._tokenRewardDays = signInMo._tokenRewardDays or {}
	self._totalSigned = signInMo._totalSigned or 0
	self._fakeData = false
end

function M:getActivity()
	return self._activity
end

function M:receiveReward(day)
	for _, _day in pairs(self._tokenRewardDays) do
		if _day == day then
			return
		end
	end

	table.insert(self._tokenRewardDays, day)
end

function M:isDailySignIn()
	return self._activity == WelfareSigninEnum.DailySignActId
end

function M:getActTyp()
	local actId = self:getActivity()
	local typ = WelfareSigninEnum.ActTyp.NotDefine

	if actId then
		if actId == WelfareSigninEnum.DailySignActId then
			typ = WelfareSigninEnum.ActTyp.DailySignIn
		else
			typ = WelfareSigninEnum.ActTyp.SevenDaySignIn
		end
	end

	return typ
end

function M:getTotalSigned()
	return self._totalSigned
end

function M:getCanReward()
	local maxRewardDay = self:getMaxRewardDay()

	return self._totalSigned > #self._tokenRewardDays and maxRewardDay > #self._tokenRewardDays
end

function M:isCanReceive(day)
	local serverDay = WelfareSigninUtil.client2ServerDay(day)

	for _, _day in pairs(self._tokenRewardDays) do
		if _day == serverDay then
			return false
		end
	end

	return self:isSigned(day)
end

function M:isSigned(day)
	return day <= self._totalSigned
end

function M:isReceived(day)
	return self:isSigned(day) and not self:isCanReceive(day)
end

function M:getMaxRewardDay()
	if not self._maxSignedDay then
		self._maxSignedDay = 0

		local actId = self:getActivity()

		if actId == WelfareSigninEnum.DailySignActId then
			self._maxSignedDay = WelfareSigninConfig.instance:getMaxDailyRewardDay()
		else
			local formula = WelfareSigninUtil.getSignInActFormula(actId)

			self._maxSignedDay = WelfareSigninConfig.instance:getMaxHistoryRewardDay(formula)
		end
	end

	return self._maxSignedDay
end

function M:getIsSignAll()
	local totalSigned = self:getTotalSigned() or 0
	local maxRewardDay = self:getMaxRewardDay()

	return maxRewardDay <= totalSigned
end

function M:isAllReceive()
	local maxRewardDay = self:getMaxRewardDay()

	return maxRewardDay <= #self._tokenRewardDays
end

function M:getIsFakeData()
	return self._fakeData
end

function M:createFakeData(actId)
	self._activity = actId
	self._todaySigned = false
	self._totalSigned = 0
	self._timestamps = {}
	self._fakeData = true
end

function M:fakeSign()
	if self._totalSigned >= 28 then
		return
	end

	self._totalSigned = self._totalSigned + 1
	self._todaySigned = true

	table.insert(self._timestamps, ServerTime.now())
end

return M
