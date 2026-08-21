local var_0_0 = class("NewEducateCollectEntranceMediator", import("view.base.ContextMediator"))

var_0_0.GO_SUBLAYER = "NewEducateCollectEntranceMediator.GO_SUBLAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(arg_2_1, nil, arg_2_2)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		EducateProxy.CLEAR_NEW_TIP
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == EducateProxy.CLEAR_NEW_TIP and arg_4_1:getBody().index == EducateTipHelper.NEW_MEMORY then
		arg_4_0.viewComponent:UpdateMemoryTip()
	end

	return
end

return var_0_0
