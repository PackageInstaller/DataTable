module("framework.time.clock.ClockSpecificDateCheckTask", package.seeall)

local var_0_0 = class("ClockSpecificDateCheckTask", IClockTask)

function var_0_0.getDebugTaskName(arg_1_0)
	local var_1_0 = ServerTime.timeServerLook(arg_1_0._targetTimeStamp)

	return string.format("clock_specific_date_check[%s]", os.date("%c", var_1_0))
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._targetTimeStamp = 0
	arg_2_0._isDispatched = false
	arg_2_0._eventType = false
end

function var_0_0.bindDispatchEventType(arg_3_0, arg_3_1)
	arg_3_0._eventType = arg_3_1
end

function var_0_0.setCheckDateTable(arg_4_0, arg_4_1)
	local var_4_0 = os.time(arg_4_1)
	local var_4_1 = ServerTime.serverTimestampOfDate(var_4_0)

	arg_4_0:setCheckTimestamp(var_4_1)
end

function var_0_0.setCheckTimestamp(arg_5_0, arg_5_1)
	arg_5_0._isDispatched = false
	arg_5_0._targetTimeStamp = arg_5_1
end

function var_0_0.isDatePassed(arg_6_0)
	return ClockMgr.instance:getClockContext():getTimestamp() >= arg_6_0._targetTimeStamp
end

function var_0_0.onCheck(arg_7_0, arg_7_1)
	if not arg_7_0._isDispatched and arg_7_1:getTimestamp() >= arg_7_0._targetTimeStamp then
		arg_7_0:logTriggered()

		arg_7_0._isDispatched = true

		if arg_7_0._eventType then
			GlobalDispatcher:dispatchEvent(arg_7_0._eventType)
		end
	end
end

return var_0_0
