class = var_0_10000

local var_0_0 = "LinerLogBookMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GET_SCHEDULE_AWARD = "LinerLogBookMediator.GET_SCHEDULE_AWARD"
var_0_1.GET_ROOM_AWARD = "LinerLogBookMediator.GET_ROOM_AWARD"
var_0_1.ON_START_REASONING = "LinerLogBookMediator.ON_START_REASONING"
var_0_1.GET_EVENT_AWARD = "LinerLogBookMediator.GET_EVENT_AWARD"
var_0_1.ON_CLOSE = "LinerLogBookMediator.ON_CLOSE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_SCHEDULE_AWARD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.ACTIVITY_LINER_OP, {
			cmd = 2,
			activity_id = arg_2_1,
			arg1 = arg_2_2,
			drop = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET_ROOM_AWARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		var_3_1(var_3_0, var_2_10007.ACTIVITY_LINER_OP, {
			cmd = 3,
			activity_id = arg_3_1,
			arg1 = arg_3_2,
			drop = arg_3_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_START_REASONING, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0.viewComponent

		var_3.OnStartReasoning(var_4_0, arg_4_1, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.GET_EVENT_AWARD, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0 = arg_1_0
		local var_5_1 = var_5.sendNotification

		GAME = var_2_10008

		var_5_1(var_5_0, var_2_10008.ACTIVITY_LINER_OP, {
			cmd = 4,
			activity_id = arg_5_1,
			arg1 = arg_5_2,
			arg2 = arg_5_3,
			drop = arg_5_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLOSE, function()
		local var_6_0 = arg_1_0.viewComponent

		var_0.onBackPressed(var_6_0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_LINER_OP_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GAME = var_8_0

	if var_8_1 == var_8_0.ACTIVITY_LINER_OP_DONE then
		local var_8_3 = arg_8_0.viewComponent
		local var_8_4 = var_4.emit

		BaseUI = var_1_10007

		var_8_4(var_8_3, var_1_10007.ON_ACHIEVE, var_8_2.awards)

		local var_8_5 = arg_8_0.viewComponent

		var_4.UpdateView(var_8_5)
	end

	return
end

return var_0_1
