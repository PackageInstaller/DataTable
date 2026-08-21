local var_0_0 = class("ClueGroupSingleMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_CLUE_JUMP = "ClueGroupSingleMediator.OPEN_CLUE_JUMP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_CLUE_JUMP, function(arg_2_0, arg_2_1)
		print(arg_2_1)
		arg_1_0:sendNotification(ClueMapMediator.OPEN_CLUE_JUMP, {
			jumpID = arg_2_1
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
