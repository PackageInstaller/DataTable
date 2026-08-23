local ScheduleService = class("ScheduleService")

function ScheduleService:ctor()
	self._schedules = {}
	self._index = 1
	self._isRunning = false
	self._lastTime = nil

	for iter_1_0 = 1, g.core.config.time_event_info.getLength() do
		local var_1_0 = g.core.config.time_event_info.indexOf(iter_1_0)

		table.insert(self._schedules, {
			time = var_1_0.open_time,
			key = var_1_0
		})
		table.insert(self._schedules, {
			time = var_1_0.end_time,
			key = var_1_0
		})
	end

	table.sort(self._schedules, function(arg_2_0, arg_2_1)
		return arg_2_0.time < arg_2_1.time
	end)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH, self._onFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_SCHEDULE_TIME, self._addScheduleTime, self)
end

function ScheduleService:reset()
	self._index = 1
	self._isRunning = false
	self._lastTime = nil

	if self._schedulerHandler then
		g.core.common.Scheduler:cancelSchedule(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function ScheduleService:_onFlush()
	if not self._isRunning then
		self._isRunning = true
		self._schedulerHandler = g.core.common.Scheduler:newSchedule(handler(self, self._onSchedule), 1)
	end
end

function ScheduleService:_addScheduleTime(arg_5_1, arg_5_2, arg_5_3)
	assert(type(arg_5_2) == "number" and arg_5_2 >= 0 and arg_5_2 <= 86399, "Invalid time: " .. tostring(arg_5_2))
	assert(arg_5_3, "Invalid key: " .. tostring(arg_5_3))
	table.insert(self._schedules, {
		time = arg_5_2,
		key = arg_5_3
	})
	table.sort(self._schedules, function(arg_6_0, arg_6_1)
		return arg_6_0.time < arg_6_1.time
	end)

	if self._lastTime and arg_5_2 < self._lastTime then
		self._index = self._index + 1
	end
end

function ScheduleService:_onSchedule()
	if #self._schedules == 0 then
		return
	end

	self._index = (self._index - 1) % #self._schedules + 1

	local var_7_0 = self:_getTime()
	local var_7_1 = self._lastTime or var_7_0

	self._lastTime = var_7_0

	if var_7_0 < var_7_1 then
		var_7_1 = var_7_1 - 86400
	end

	repeat
		if var_7_1 <= self._schedules[self._index].time and self._schedules[self._index].time <= var_7_0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SCHEDULE_NOTIFY, false, var_7_1, var_7_0, self._schedules[self._index].key)

			self._index = self._index + 1
		elseif self._schedules[self._index].time < var_7_1 then
			self._index = self._index + 1
		else
			break
		end
	until not self._schedules[self._index]
end

function ScheduleService:_getTime()
	return g.core.common.ServerTime:secondsFromToday()
end

return ScheduleService
