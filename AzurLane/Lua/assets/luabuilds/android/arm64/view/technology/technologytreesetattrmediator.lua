local var_0_0 = class("TechnologyTreeSetAttrMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		TechnologyConst.SET_TEC_ATTR_ADDITION_FINISH
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == TechnologyConst.SET_TEC_ATTR_ADDITION_FINISH then
		if var_3_0.onSuccess then
			var_3_0.onSuccess()
		end
	end

	return
end

return var_0_0
