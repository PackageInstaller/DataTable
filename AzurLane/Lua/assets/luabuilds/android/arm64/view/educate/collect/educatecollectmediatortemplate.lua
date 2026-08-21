local var_0_0 = class("EducateCollectMediatorTemplate", import("..base.EducateContextMediator"))

var_0_0.UNLOCK = "EducateCollectMediatorTemplate.UNLOCK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.UNLOCK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.EDUCATE_BUY_COLLECT, {
			type = arg_2_1.type,
			id = arg_2_1.id,
			cost = arg_2_1.cost
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		EducateProxy.CLEAR_NEW_TIP,
		GAME.EDUCATE_BUY_COLLECT_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == EducateProxy.CLEAR_NEW_TIP then
		if var_4_1.index == EducateTipHelper.NEW_MEMORY or var_4_1.index == EducateTipHelper.NEW_POLAROID then
			arg_4_0.viewComponent:Flush()
		end
	elseif var_4_0 == GAME.EDUCATE_BUY_COLLECT_DONE then
		arg_4_0.viewComponent:Flush()
	end

	return
end

return var_0_0
