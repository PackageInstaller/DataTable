-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/ActivityWelfareData.lua

module("logic.extensions.welfare.model.ActivityWelfareData", package.seeall)

local M = class("ActivityWelfareData", ActivityBaseData)

function M:ctor(ActivityNO)
	M.super.ctor(self, ActivityNO)

	self._tabId = self:_getTabId()
end

function M:IsDisappear()
	return false
end

function M:getActivityTabId()
	return self._tabId
end

function M:_getTabId()
	local type = self:getType()
	local planId = self:getConfigId()

	if type and planId then
		return WelfareConfig.instance:getActivityTabId(type, planId)
	end
end

function M:getTimeString()
	if self:getIsActivityOpen() then
		local seconds = self:getLeftSeconds()

		if seconds <= 0 then
			seconds = 0
		end

		local left_Time = TextFormatter.formatFullExpireTime(seconds)

		return left_Time
	elseif self:isHaveExchangeTime() and self:getIsActivityExchange() then
		local seconds = self:getLeftExchangeSeconds()

		if seconds <= 0 then
			seconds = 0
		end

		local left_Time = TextFormatter.formatFullExpireTime(seconds)

		return lang("activity_timeExchange_left") .. left_Time
	elseif self:isHaveExchangeTime() then
		local temp_zero = TextFormatter.formatFullExpireTime(0)

		return lang("activity_timeExchange_left") .. temp_zero
	else
		return TextFormatter.formatFullExpireTime(0)
	end
end

return M
