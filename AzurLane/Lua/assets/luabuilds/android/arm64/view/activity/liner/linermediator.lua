class = var_0_10000

local var_0_0 = "LinerMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_SCENE = "LinerMediator.GO_SCENE"
var_0_1.GO_SUBLAYER = "LinerMediator.GO_SUBLAYER"
var_0_1.SET_NAME = "LinerMediator.SET_NAME"
var_0_1.CLICK_ROOM = "LinerMediator.CLICK_ROOM"
var_0_1.CLICK_EVENT = "LinerMediator.CLICK_EVENT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0

		var_3.addSubLayers(var_3_0, arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.SET_NAME, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.ACTIVITY_STORE_DATE
		local var_4_3 = {
			activity_id = arg_4_1.actId
		}
		local var_4_4

		if not arg_4_1.intValue then
			var_4_4 = 0
		end

		var_4_3.intValue = var_4_4

		local var_4_5

		if not arg_4_1.strValue then
			var_4_5 = ""
		end

		var_4_3.strValue = var_4_5
		var_4_3.callback = arg_4_1.callback

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_ROOM, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.ACTIVITY_LINER_OP, {
			cmd = 1,
			activity_id = arg_5_1,
			arg1 = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_EVENT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.ACTIVITY_LINER_OP, {
			cmd = 1,
			activity_id = arg_6_1.actId,
			arg1 = arg_6_1.roomId,
			arg2 = arg_6_1.eventId,
			callback = arg_6_1.callback
		})

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

		var_4.UpdateData(var_8_3)

		local var_8_4 = arg_8_0.viewComponent

		var_4.UpdateTips(var_8_4)
	end

	return
end

return var_0_1
