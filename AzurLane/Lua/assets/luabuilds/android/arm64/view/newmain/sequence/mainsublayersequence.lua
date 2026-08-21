local var_0_0 = class("MainSublayerSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:GetContextData()

	if var_1_0 and var_1_0.subContext then
		var_1_0.subContext.onRemoved = arg_1_1

		arg_1_0:AddSubLayers(var_1_0.subContext)

		var_1_0.subContext = nil
	else
		arg_1_1()
	end

	return
end

function var_0_0.GetContextData(arg_2_0)
	local var_2_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewMainMediator)

	return var_2_0 and var_2_0.data
end

function var_0_0.AddSubLayers(arg_3_0, arg_3_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewMainMediator),
		context = arg_3_1
	})

	return
end

return var_0_0
