local var_0_0 = class("IndexMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	assert(arg_1_0.contextData.display)

	if arg_1_0.contextData.display.sort then
		assert(arg_1_0.contextData.sort)
	end

	if arg_1_0.contextData.display.index then
		assert(arg_1_0.contextData.index)
	end

	if arg_1_0.contextData.display.camp then
		assert(arg_1_0.contextData.camp)
	end

	if arg_1_0.contextData.display.rarity then
		assert(arg_1_0.contextData.rarity)
	end

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	return
end

return var_0_0
