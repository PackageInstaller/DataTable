module("framework.time.clock.ClockRegularCheckTask", package.seeall)

local var_0_0 = class("ClockRegularCheckTask", IClockTask)

function var_0_0.getDebugTaskName(arg_1_0)
	return "clock_task_second_check"
end

function var_0_0.onCheck(arg_2_0, arg_2_1)
	GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKSECOND, arg_2_1:getTimestamp())

	if arg_2_1:isMinuteChanged() then
		local var_2_0 = arg_2_1:getDateTable()

		GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKMINUTE)
	end

	if arg_2_1:isHourChanged() then
		local var_2_1 = arg_2_1:getDateTable()
		local var_2_2 = arg_2_1:getLastDateTable()

		GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKHOUR)
	end

	if arg_2_1:isDayChanged() then
		local var_2_3 = arg_2_1:getDateTable()
		local var_2_4 = arg_2_1:getLastDateTable()

		GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKDAY)
	end

	if arg_2_1:isWeekChanged() then
		local var_2_5 = arg_2_1:getDateTable()
		local var_2_6 = arg_2_1:getLastDateTable()

		GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKWEEK)
	end
end

return var_0_0
