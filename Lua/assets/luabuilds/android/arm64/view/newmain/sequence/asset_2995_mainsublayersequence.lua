local MainSublayerSequence = class("MainSublayerSequence")

function MainSublayerSequence:Execute(arg_1_1)
	local var_1_0 = self:GetContextData()

	if var_1_0 and var_1_0.subContext then
		var_1_0.subContext.onRemoved = arg_1_1

		self:AddSubLayers(var_1_0.subContext)

		var_1_0.subContext = nil
	else
		arg_1_1()
	end

	return
end

function MainSublayerSequence:GetContextData()
	local var_2_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewMainMediator)

	return var_2_0 and var_2_0.data
end

function MainSublayerSequence:AddSubLayers(arg_3_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewMainMediator),
		context = arg_3_1
	})

	return
end

return MainSublayerSequence
