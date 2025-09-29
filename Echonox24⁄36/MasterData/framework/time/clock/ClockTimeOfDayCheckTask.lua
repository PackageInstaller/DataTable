module("framework.time.clock.ClockTimeOfDayCheckTask", package.seeall)

local var_0_0 = class("ClockTimeOfDayCheckTask", IClockTask)

function var_0_0.createGameRefreshTask(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.New()

	var_1_0:bindDispatchEventType(EventType.FW_CLOCK_TICKDAILYREFRESH)
	var_1_0:setCheckTime(arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.getDebugTaskName(arg_2_0)
	local var_2_0 = ServerTime.timeServerLook(arg_2_0._targetTimeStamp)

	return string.format("clock_time_of_day_check[%s]", os.date("%c", var_2_0))
end

function var_0_0.onInit(arg_3_0)
	arg_3_0._targetHour = 0
	arg_3_0._targetMinute = 0
	arg_3_0._targetSecond = 0
	arg_3_0._targetTimeStamp = 0
	arg_3_0._isDispatched = false
	arg_3_0._eventType = false
end

function var_0_0.bindDispatchEventType(arg_4_0, arg_4_1)
	arg_4_0._eventType = arg_4_1
end

function var_0_0.setCheckTime(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._isDispatched = false
	arg_5_0._targetHour = arg_5_1
	arg_5_0._targetMinute = arg_5_2
	arg_5_0._targetSecond = arg_5_3
	arg_5_0._targetTimeStamp = arg_5_0:_calculateTargetTimestamp()
end

function var_0_0.isTimePassed(arg_6_0)
	return ClockMgr.instance:getClockContext():getTimestamp() >= arg_6_0._targetTimeStamp
end

function var_0_0.onCheck(arg_7_0, arg_7_1)
	if arg_7_1:isDayChanged() then
		arg_7_0._isDispatched = false
		arg_7_0._targetTimeStamp = arg_7_0:_calculateTargetTimestamp()
	end

	if not arg_7_0._isDispatched and arg_7_1:getTimestamp() >= arg_7_0._targetTimeStamp then
		arg_7_0:logTriggered()

		arg_7_0._isDispatched = true

		if arg_7_0._eventType then
			GlobalDispatcher:dispatchEvent(arg_7_0._eventType)
		end
	end
end

function var_0_0._calculateTargetTimestamp(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = ClockMgr.instance:getClockContext()

	table.merge(var_8_0, var_8_1:getDateTable())

	var_8_0.hour = arg_8_0._targetHour
	var_8_0.min = arg_8_0._targetMinute
	var_8_0.sec = arg_8_0._targetSecond

	local var_8_2 = os.time(var_8_0)

	return ServerTime.serverTimestampOfDate(var_8_2)
end

return var_0_0
