class = var_0_10000

local var_0_0 = "NewEducateCollectEntranceMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_SUBLAYER = "NewEducateCollectEntranceMediator.GO_SUBLAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.addSubLayers(var_2_0, arg_2_1, nil, arg_2_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	EducateProxy = var_1_10002
	var_3_0[1] = var_1_10002.CLEAR_NEW_TIP

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	EducateProxy = var_4_1

	if var_4_0 == var_4_1.CLEAR_NEW_TIP then
		local var_4_3 = var_4_2.index

		EducateTipHelper = var_1_10005

		if var_4_3 == var_1_10005.NEW_MEMORY then
			local var_4_4 = arg_4_0.viewComponent

			var_4.UpdateMemoryTip(var_4_4)
		end
	end

	return
end

return var_0_1
