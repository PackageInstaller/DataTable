local BaseData = class("BaseData")

BaseData.RESET_TIME = 0
BaseData.SECONDS_ONE_DAY = 86400

function BaseData:ctor()
	self._isExpired = false
	self._lastUpdateTime = g.core.common.ServerTime:getTime()
end

function BaseData:isExpired()
	if self._isExpired then
		return true
	end

	local var_2_0 = self:checkExpired(self._lastUpdateTime)

	self._isExpired = var_2_0

	return var_2_0
end

function BaseData:resetExpired()
	self._isExpired = false
	self._lastUpdateTime = g.core.common.ServerTime:getTime()
end

function BaseData:checkExpired(arg_4_1)
	local var_4_0 = g.core.common.ServerTime:getTime()

	if arg_4_1 < var_4_0 then
		local var_4_1 = g.core.common.ServerTime:secondsFromToday(arg_4_1)

		return var_4_0 >= arg_4_1 - var_4_1 + BaseData.RESET_TIME * 3600 + ((BaseData.RESET_TIME * 3600 < var_4_1 or nil) and (BaseData.SECONDS_ONE_DAY or 0))
	end

	return false
end

return BaseData
