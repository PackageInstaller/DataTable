local var_0_0 = class("AllBuffDetailMediator", import("..base.ContextMediator"))

var_0_0.OPEN_SET_VALUE_LAYER = "AllBuffDetailMediator:OPEN_SET_VALUE_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_SET_VALUE_LAYER, function()
		arg_1_0:addSubLayers(Context.New({
			mediator = TechnologyTreeSetAttrMediator,
			viewComponent = TechnologyTreeSetAttrLayer,
			data = {},
			onRemoved = function()
				arg_1_0.viewComponent:updateDetail()

				return
			end
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_0
