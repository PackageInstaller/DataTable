local DayNotifyTool = class("DayNotifyTool")

function DayNotifyTool:ctor()
	self._records = nil
	self._userId = 0
	self._loginCache = {}
end

function DayNotifyTool:reLoadCache()
	local var_2_0 = g.core.network.GameNetProxy:getUserId() or 0

	if not self._records or self._userId ~= var_2_0 then
		self._userId = var_2_0
		self._records = g.core.common.Storage:load("day_notify_record.json", true) or {}
	end
end

function DayNotifyTool:isTodayHasRecord(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 == nil and true or arg_3_2

	self:reLoadCache()

	return g.core.common.ServerTime:getIsSameDay(tonumber((not arg_3_2 or nil) and (self._loginCache[arg_3_1] or 0)))
end

function DayNotifyTool:saveTodayRecord(arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 == nil and true or arg_4_3

	self:reLoadCache()

	local var_4_0 = arg_4_2 and g.core.common.ServerTime:getTime() or 0

	if arg_4_3 then
		self._records[arg_4_1] = var_4_0

		g.core.common.Storage:save("day_notify_record.json", self._records, true)
	else
		self._loginCache[arg_4_1] = var_4_0
	end
end

return DayNotifyTool
