module("framework.time.clock.IClockTask", package.seeall)

local var_0_0 = class("IClockTask")

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskId = -1

	arg_1_0:onInit()
end

function var_0_0.internal_setupTask(arg_2_0, arg_2_1)
	arg_2_0._taskId = arg_2_1
end

function var_0_0.getTaskId(arg_3_0)
	return arg_3_0._taskId
end

function var_0_0.getDebugTaskName(arg_4_0)
	return arg_4_0._taskId
end

function var_0_0.onInit(arg_5_0)
	return
end

function var_0_0.onCheck(arg_6_0, arg_6_1)
	printError("unimplement method")
end

function var_0_0.logTriggered(arg_7_0)
	if enableDebug then
		printInfo("ClockTask triggered::", arg_7_0:getDebugTaskName())
	end
end

return var_0_0
