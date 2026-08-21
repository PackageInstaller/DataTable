module("bootstrap.flow.base.BoostrapFlowRoot", package.seeall)

local var_0_0 = class("BoostrapFlowRoot", BoostrapFlowParentNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._currentAI = nil
	arg_1_0._isStartup = false
	arg_1_0._name = nil
	arg_1_0._strErrorAI = ""
end

function var_0_0.getName(arg_2_0)
	return arg_2_0._name
end

function var_0_0.setName(arg_3_0, arg_3_1)
	arg_3_0._name = arg_3_1

	return arg_3_0
end

function var_0_0.onStart(arg_4_0)
	if arg_4_0:getStatus() == BootstrapFlowConst.BTStatus.INACTIVE then
		arg_4_0._isStartup = true

		var_0_0.super.onStart(arg_4_0)

		arg_4_0._currentAI = arg_4_0:getFirstChild():onStart()
	else
		printError(string.format("the ai[%s] has actived!", tostring(arg_4_0._currentAI)))
	end

	return arg_4_0
end

function var_0_0.onUpdate(arg_5_0)
	if arg_5_0._currentAI:getStatus() == BootstrapFlowConst.BTStatus.RUNNING then
		arg_5_0._currentAI = arg_5_0._currentAI:onUpdate()

		return arg_5_0
	else
		local var_5_0 = tostring(arg_5_0._currentAI)

		if arg_5_0._strErrorAI ~= var_5_0 then
			printError(string.format("the ai[%s] class[%s] tag[%s] has finished!", var_5_0, arg_5_0._currentAI.__cname, arg_5_0._currentAI._aiTag))
		end

		arg_5_0._strErrorAI = var_5_0
	end

	return arg_5_0
end

function var_0_0.tick(arg_6_0)
	if arg_6_0._isStartup then
		arg_6_0:onUpdate()
	else
		arg_6_0:onStart()
	end
end

function var_0_0.interrupt(arg_7_0)
	if arg_7_0._isStartup then
		arg_7_0:onReset()
	end
end

function var_0_0.interruptNode(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		if arg_8_1 == arg_8_0 then
			return false
		end

		local var_8_0, var_8_1 = arg_8_1:interrupt(arg_8_2)

		if var_8_0 then
			arg_8_0._currentAI = var_8_1
		end

		return false
	end

	return false
end

function var_0_0.onChildEnd(arg_9_0, arg_9_1)
	return arg_9_0:onEnd(arg_9_1:getStatus())
end

function var_0_0.onReset(arg_10_0)
	local var_10_0 = arg_10_0:getContext()

	var_0_0.super.onReset(arg_10_0)

	if var_10_0 then
		var_10_0:onReset()
	end

	arg_10_0._currentAI = nil
	arg_10_0._isStartup = false
	arg_10_0._strErrorAI = ""
end

function var_0_0.onReuse(arg_11_0, arg_11_1)
	var_0_0.super.onReuse(arg_11_0, arg_11_1)

	arg_11_0._currentAI = nil
	arg_11_0._isStartup = false
end

function var_0_0.onRecycle(arg_12_0)
	var_0_0.super.onRecycle(arg_12_0)

	arg_12_0._currentAI = nil
	arg_12_0._isStartup = false
	arg_12_0._strErrorAI = ""
end

function var_0_0.onDestroy(arg_13_0)
	var_0_0.super.onDestroy(arg_13_0)

	arg_13_0._currentAI = nil
	arg_13_0._isStartup = nil
	arg_13_0._strErrorAI = nil
end

return var_0_0
