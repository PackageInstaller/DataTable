class = var_0_10000

local var_0_0 = "AllBuffDetailMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_SET_VALUE_LAYER = "AllBuffDetailMediator:OPEN_SET_VALUE_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_SET_VALUE_LAYER, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		TechnologyTreeSetAttrMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		TechnologyTreeSetAttrLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {}

		function var_2_3.onRemoved()
			local var_3_0 = arg_1_0.viewComponent

			var_0.updateDetail(var_3_0)

			return
		end

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_1
