class = var_0_10000

local var_0_0 = "TechnologyTreeSetAttrMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	TechnologyConst = var_1_10002
	var_2_0[1] = var_1_10002.SET_TEC_ATTR_ADDITION_FINISH

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	TechnologyConst = var_3_1

	if var_3_0 == var_3_1.SET_TEC_ATTR_ADDITION_FINISH and var_3_2.onSuccess then
		var_4()
	end

	return
end

return var_0_1
