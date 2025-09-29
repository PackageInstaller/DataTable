module("frameworkext.ai.workflow.work.WorkBase", package.seeall)

local var_0_0 = class("WorkBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0.context = nil
	arg_1_0.parent = nil
	arg_1_0.status = WorkStatus.Init
	arg_1_0.result = WorkResult.Unknown
	arg_1_0.id = nil
	arg_1_0.workflow = nil
	arg_1_0._workDoneCall = nil
	arg_1_0._workDoneCallObj = nil
	arg_1_0._isWorking = nil
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0.workflow:enterWork(arg_2_0)

	arg_2_0.context = arg_2_1
	arg_2_0.status = WorkStatus.Running
	arg_2_0._isWorking = true

	arg_2_0:onEnter(arg_2_1)
end

function var_0_0.onEnter(arg_3_0, arg_3_1)
	return
end

function var_0_0.onExit(arg_4_0, arg_4_1)
	return
end

function var_0_0.onDone(arg_5_0, arg_5_1)
	if arg_5_0._isWorking then
		if arg_5_1 == WorkResult.Succeed then
			arg_5_0.result = WorkResult.Succeed
		else
			arg_5_0.result = WorkResult.Fail
		end

		arg_5_0:onStop()
		arg_5_0:_dealDoneCall(arg_5_0.result)

		if arg_5_0.parent then
			arg_5_0.parent:onChildDone(arg_5_0)
		end
	end
end

function var_0_0.onStop(arg_6_0)
	if arg_6_0._isWorking then
		arg_6_0._isWorking = false

		arg_6_0:onExit(false)

		arg_6_0.context = nil
		arg_6_0.status = WorkStatus.Stopped
	end
end

function var_0_0.onInterrupt(arg_7_0)
	if arg_7_0._isWorking then
		arg_7_0._isWorking = false

		arg_7_0:onExit(true)

		arg_7_0.context = nil
		arg_7_0.status = WorkStatus.Stopped
		arg_7_0.result = WorkResult.Interrupt
	end
end

function var_0_0.serialize(arg_8_0)
	return {
		id = arg_8_0.id,
		status = arg_8_0.status,
		result = arg_8_0.result
	}
end

function var_0_0.deserialize(arg_9_0, arg_9_1)
	arg_9_0.status = arg_9_1.status
	arg_9_0.result = arg_9_1.result
end

function var_0_0.getChildren(arg_10_0)
	return nil
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0._isWorking then
		arg_11_0._isWorking = false

		arg_11_0:onExit(false)

		arg_11_0.parent = nil
		arg_11_0._dispatcher = nil
		arg_11_0.id = nil
		arg_11_0.workflow = nil
	end
end

function var_0_0._dealDoneCall(arg_12_0, arg_12_1)
	if arg_12_0._workDoneCall then
		if arg_12_0._workDoneCallObj then
			arg_12_0._workDoneCall(arg_12_0._workDoneCallObj, arg_12_1)
		else
			arg_12_0._workDoneCall(arg_12_1)
		end
	end
end

function var_0_0.setDoneCaller(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._workDoneCall = arg_13_1
	arg_13_0._workDoneCallObj = arg_13_2
end

return var_0_0
