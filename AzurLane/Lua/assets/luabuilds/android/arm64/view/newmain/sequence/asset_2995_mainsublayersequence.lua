class = var_0_10000

local var_0_0 = var_0_10000("MainSublayerSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	if arg_1_0:GetContextData() and var_2.subContext then
		var_2.subContext.onRemoved = arg_1_1

		arg_1_0:AddSubLayers(var_2.subContext)

		var_2.subContext = nil
	else
		arg_1_1()
	end

	return
end

function var_0_0.GetContextData(arg_2_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getCurrentContext(var_2_0)
	local var_2_2 = var_2.getContextByMediator

	NewMainMediator = var_1_10006

	return var_2_2(var_2_1, var_1_10006) and var_3.data
end

function var_0_0.AddSubLayers(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1 = var_2.getCurrentContext(var_3_0)
	local var_3_2 = var_3.getContextByMediator

	NewMainMediator = var_1_10007

	local var_3_3 = var_3_2(var_3_1, var_1_10007)

	pg = var_3_0

	local var_3_4 = var_3_0.m02
	local var_3_5 = var_5.sendNotification

	GAME = var_1_10008

	var_3_5(var_3_4, var_1_10008.LOAD_LAYERS, {
		parentContext = var_3_3,
		context = arg_3_1
	})

	return
end

return var_0_0
