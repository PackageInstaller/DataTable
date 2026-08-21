local var_0_0 = class("LinerLogBookMediator", import("view.base.ContextMediator"))

var_0_0.GET_SCHEDULE_AWARD = "LinerLogBookMediator.GET_SCHEDULE_AWARD"
var_0_0.GET_ROOM_AWARD = "LinerLogBookMediator.GET_ROOM_AWARD"
var_0_0.ON_START_REASONING = "LinerLogBookMediator.ON_START_REASONING"
var_0_0.GET_EVENT_AWARD = "LinerLogBookMediator.GET_EVENT_AWARD"
var_0_0.ON_CLOSE = "LinerLogBookMediator.ON_CLOSE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GET_SCHEDULE_AWARD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 2,
			activity_id = arg_2_1,
			arg1 = arg_2_2,
			drop = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_ROOM_AWARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_1_0:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 3,
			activity_id = arg_3_1,
			arg1 = arg_3_2,
			drop = arg_3_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_START_REASONING, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.viewComponent:OnStartReasoning(arg_4_1, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_0.GET_EVENT_AWARD, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		arg_1_0:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 4,
			activity_id = arg_5_1,
			arg1 = arg_5_2,
			arg2 = arg_5_3,
			drop = arg_5_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLOSE, function()
		arg_1_0.viewComponent:onBackPressed()

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.ACTIVITY_LINER_OP_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	if arg_8_1:getName() == GAME.ACTIVITY_LINER_OP_DONE then
		arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_8_1:getBody().awards)
		arg_8_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
