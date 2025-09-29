-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/model/WelfareSigninActivityData.lua

module("logic.extensions.signin.model.WelfareSigninActivityData", package.seeall)

local M = class("WelfareSigninActivityData", ActivityWelfareData)

function M:ctor(ActivityNO)
	M.super.ctor(self, ActivityNO)
end

function M:initConfig()
	self._openLevel = 1
end

function M:getConditionOpen()
	if not WelfareUtil.isSystemOpen() then
		return false
	end

	local systemKey = 0

	if self:getId() == WelfareSigninEnum.DailySignActId then
		systemKey = GameEnum.SystemEnum.WelfareSignInDaily
	else
		systemKey = GameEnum.SystemEnum.WelfareSignInHistory
	end

	local isOpen = SystemOpenFacade.instance:isOpen(systemKey)

	if not isOpen then
		return false
	end

	return true
end

function M:IsDisappear()
	local signMo = WelfareSigninModel.instance:getSignInMo(self:getId())

	if not signMo then
		return true
	end

	if signMo:isAllReceive() then
		return true
	end

	return false
end

function M:getSignInActEndTime()
	return self._endedTime
end

return M
