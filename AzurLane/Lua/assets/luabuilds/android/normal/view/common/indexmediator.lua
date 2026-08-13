class = var_0_10000

local var_0_0 = "IndexMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.display)

	if arg_1_0.contextData.display.sort then
		assert = var_1

		var_1(arg_1_0.contextData.sort)
	end

	if arg_1_0.contextData.display.index then
		assert = var_1

		var_1(arg_1_0.contextData.index)
	end

	if arg_1_0.contextData.display.camp then
		assert = var_1

		var_1(arg_1_0.contextData.camp)
	end

	if arg_1_0.contextData.display.rarity then
		assert = var_1

		var_1(arg_1_0.contextData.rarity)
	end

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	return
end

return var_0_1
