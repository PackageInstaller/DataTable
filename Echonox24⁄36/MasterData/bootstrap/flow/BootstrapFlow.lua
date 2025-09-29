module("bootstrap.flow.BootstrapFlow", package.seeall)

local var_0_0 = class("BootstrapFlow")

function var_0_0.addDoneListener(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._handler = arg_1_1
	arg_1_0._handlerObj = arg_1_2
end

function var_0_0.removeDoneListener(arg_2_0)
	arg_2_0._handler = nil
	arg_2_0._handlerObj = nil
end

function var_0_0.destroy(arg_3_0)
	if arg_3_0._rootNode then
		arg_3_0._rootNode:destroy()
	end

	arg_3_0:removeDoneListener()
end

function var_0_0.clear(arg_4_0)
	if arg_4_0._rootNode then
		arg_4_0._rootNode:reset()
	end
end

function var_0_0.start(arg_5_0)
	local var_5_0 = BoostrapFlowContext.New()
	local var_5_1 = BoostrapFlowRoot.New(var_5_0)
	local var_5_2 = BoostrapFlowSequence.New(var_5_0)

	var_5_2:addChild(BootstrapResPreLoad.New(var_5_0))
	var_5_2:addChild(BootstrapUIAdaptive.New(var_5_0))
	var_5_2:addChild(BootstrapInitViews.New(var_5_0))
	var_5_2:addChild(BootstrapSdkInit.New(var_5_0))
	var_5_2:addChild(BootstrapHotUpdateDownload.New(var_5_0))
	var_5_1:addChild(var_5_2)
	var_5_1:setEndCallback(arg_5_0._onFinish, arg_5_0)
	var_5_1:tick()

	arg_5_0._rootNode = var_5_1
end

function var_0_0._onFinish(arg_6_0)
	if arg_6_0._handler ~= nil then
		arg_6_0._handler(arg_6_0._handlerObj)
	end

	arg_6_0:clear()
end

return var_0_0
