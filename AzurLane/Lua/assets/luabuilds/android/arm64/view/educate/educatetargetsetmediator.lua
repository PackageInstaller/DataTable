local var_0_0 = class("EducateTargetSetMediator", import(".base.EducateContextMediator"))

var_0_0.ON_TARGET_SET = "EducateTargetSetMediator:ON_TARGET_SET"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TARGET_SET, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.EDUCATE_SET_TARGET, {
			id = arg_2_1.id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
