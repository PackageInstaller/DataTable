module("framework.time.clock.ClockContext", package.seeall)

local var_0_0 = class("ClockContext")

function var_0_0.ctor(arg_1_0)
	arg_1_0._isTimeStampChanged = false
	arg_1_0._timestamp = ServerTime.now()
	arg_1_0._dateTable = ServerTime.nowDateServerLook()
	arg_1_0._lastDateTable = arg_1_0._dateTable
	arg_1_0._nextMinuteSecondDiff = 0
end

function var_0_0.internal_onBeforeFrame(arg_2_0)
	local var_2_0 = ServerTime.now()

	arg_2_0._isTimeStampChanged = var_2_0 ~= arg_2_0._timestamp

	if arg_2_0._isTimeStampChanged then
		arg_2_0._nextMinuteSecondDiff = arg_2_0._nextMinuteSecondDiff - (var_2_0 - arg_2_0._timestamp)
		arg_2_0._timestamp = var_2_0

		if arg_2_0._nextMinuteSecondDiff <= 0 then
			arg_2_0._dateTable = ServerTime.nowDateServerLook()
			arg_2_0._nextMinuteSecondDiff = 60 - arg_2_0._dateTable.sec
		end
	end
end

function var_0_0.internal_onAfterFrame(arg_3_0)
	if arg_3_0._isTimeStampChanged then
		arg_3_0._lastDateTable = arg_3_0._dateTable
	end
end

function var_0_0.isTimeStampChanged(arg_4_0)
	return arg_4_0._isTimeStampChanged
end

function var_0_0.getDateTable(arg_5_0)
	return arg_5_0._dateTable
end

function var_0_0.getLastDateTable(arg_6_0)
	return arg_6_0._lastDateTable
end

function var_0_0.getTimestamp(arg_7_0)
	return arg_7_0._timestamp
end

function var_0_0.isYearChanged(arg_8_0)
	return arg_8_0._dateTable.year ~= arg_8_0._lastDateTable.year
end

function var_0_0.isMonthChanged(arg_9_0)
	return arg_9_0._dateTable.month ~= arg_9_0._lastDateTable.month
end

function var_0_0.isDayChanged(arg_10_0)
	return arg_10_0._dateTable.day ~= arg_10_0._lastDateTable.day
end

function var_0_0.isHourChanged(arg_11_0)
	return arg_11_0._dateTable.hour ~= arg_11_0._lastDateTable.hour
end

function var_0_0.isMinuteChanged(arg_12_0)
	return arg_12_0._dateTable.min ~= arg_12_0._lastDateTable.min
end

function var_0_0.isWeekChanged(arg_13_0)
	return arg_13_0._dateTable.wday ~= arg_13_0._lastDateTable.wday
end

return var_0_0
