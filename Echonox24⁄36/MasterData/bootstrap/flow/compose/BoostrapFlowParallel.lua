module("bootstrap.flow.compose.BoostrapFlowParallel", package.seeall)

local var_0_0 = class("BoostrapFlowParallel", BoostrapFlowParentNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._finishedCount = 0
	arg_1_0._runningList = {}
	arg_1_0._runningListTmp = {}
end

function var_0_0.onStart(arg_2_0)
	var_0_0.super.onStart(arg_2_0)

	arg_2_0._finishedCount = 0

	arg_2_0:resetRunningList()

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:getChildren()) do
		local var_2_1 = iter_2_1:onStart()

		if arg_2_0:getStatus() == BootstrapFlowConst.BTStatus.RUNNING then
			if var_2_1 then
				table.insert(arg_2_0._runningListTmp, var_2_1)
			end
		else
			var_2_0 = var_2_1

			break
		end
	end

	return var_2_0 or arg_2_0
end

function var_0_0.resetRunningList(arg_3_0)
	table.clear(arg_3_0._runningList)
	table.clear(arg_3_0._runningListTmp)
end

function var_0_0.SwapRunningList(arg_4_0)
	arg_4_0._runningListTmp, arg_4_0._runningList = arg_4_0._runningList, arg_4_0._runningListTmp

	table.clear(arg_4_0._runningListTmp)
end

function var_0_0.onUpdate(arg_5_0)
	arg_5_0:SwapRunningList()

	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._runningList) do
		local var_5_1 = iter_5_1:onUpdate()

		if arg_5_0:getStatus() == BootstrapFlowConst.BTStatus.RUNNING then
			if var_5_1 then
				table.insert(arg_5_0._runningListTmp, var_5_1)
			end
		else
			var_5_0 = var_5_1

			break
		end
	end

	return var_5_0 or arg_5_0
end

function var_0_0.onChildEnd(arg_6_0, arg_6_1)
	if arg_6_1:getStatus() == BootstrapFlowConst.BTStatus.SUCCESS then
		arg_6_0._finishedCount = arg_6_0._finishedCount + 1

		local var_6_0 = arg_6_0:getChildren()

		if arg_6_0._finishedCount == #var_6_0 then
			return arg_6_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
		end
	else
		return arg_6_0:onEnd(BootstrapFlowConst.BTStatus.FAIL)
	end
end

function var_0_0.handleEnd(arg_7_0)
	arg_7_0:resetRunningList()
end

function var_0_0.onReset(arg_8_0)
	var_0_0.super.onReset(arg_8_0)
	arg_8_0:resetRunningList()

	arg_8_0._finishedCount = 0
end

function var_0_0.onReuse(arg_9_0, arg_9_1)
	var_0_0.super.onReuse(arg_9_0, arg_9_1)
	arg_9_0:resetRunningList()
end

function var_0_0.onRecycle(arg_10_0)
	var_0_0.super.onRecycle(arg_10_0)

	arg_10_0._finishedCount = 0

	arg_10_0:resetRunningList()
end

function var_0_0.onDestroy(arg_11_0)
	var_0_0.super.onDestroy(arg_11_0)

	arg_11_0._finishedCount = nil
	arg_11_0._runningList = nil
	arg_11_0._runningListTmp = nil
end

return var_0_0
