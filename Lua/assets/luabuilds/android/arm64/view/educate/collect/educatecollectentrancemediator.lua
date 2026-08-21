local var_0_0 = class("EducateCollectEntranceMediator", import("..base.EducateContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		EducateProxy.CLEAR_NEW_TIP
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	if arg_3_1:getName() == EducateProxy.CLEAR_NEW_TIP and arg_3_1:getBody().index == EducateTipHelper.NEW_MEMORY then
		arg_3_0.viewComponent:updateMemoryTip()
	end

	return
end

return var_0_0
