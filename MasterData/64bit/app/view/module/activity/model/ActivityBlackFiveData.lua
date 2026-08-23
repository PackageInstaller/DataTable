local var_0_0 = g.core.common.ServerTime
local ActivityBlackFiveData = class("ActivityBlackFiveData")

function ActivityBlackFiveData:ctor()
	self:initData()
end

function ActivityBlackFiveData:initData()
	self._startTime = 1732770000
	self._endTime = 1733288400
end

function ActivityBlackFiveData:isShowEntrance()
	local var_3_0 = var_0_0:getTime()

	return self:_checkChannel() and var_3_0 >= self._startTime and var_3_0 < self._endTime
end

function ActivityBlackFiveData:_checkChannel()
	if g.core.platform.PlatformProxy:isChannelOfEn() then
		return true
	end

	return false
end

function ActivityBlackFiveData:saveRedPointStatus()
	local var_5_0 = g.core.common.Storage:load("black_five.json", true) or {}

	var_5_0.is_click = true

	g.core.common.Storage:save("black_five.json", var_5_0, true)
end

function ActivityBlackFiveData:isFirstClick()
	if not self:isShowEntrance() then
		return false
	end

	return not checkbool((g.core.common.Storage:load("black_five.json", true) or {}).is_click)
end

return ActivityBlackFiveData
