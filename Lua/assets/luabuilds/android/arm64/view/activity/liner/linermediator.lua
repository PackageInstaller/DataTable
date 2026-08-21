local var_0_0 = class("LinerMediator", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "LinerMediator.GO_SCENE"
var_0_0.GO_SUBLAYER = "LinerMediator.GO_SUBLAYER"
var_0_0.SET_NAME = "LinerMediator.SET_NAME"
var_0_0.CLICK_ROOM = "LinerMediator.CLICK_ROOM"
var_0_0.CLICK_EVENT = "LinerMediator.CLICK_EVENT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.SET_NAME, function(arg_4_0, arg_4_1)
		({
			activity_id = arg_4_1.actId
		}).intValue = arg_4_1.intValue or 0
		;({
			activity_id = arg_4_1.actId
		}).strValue = arg_4_1.strValue or ""
		;({
			activity_id = arg_4_1.actId
		}).callback = arg_4_1.callback

		arg_1_0:sendNotification(GAME.ACTIVITY_STORE_DATE, {
			activity_id = arg_4_1.actId
		})

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_ROOM, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 1,
			activity_id = arg_5_1,
			arg1 = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_EVENT, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_LINER_OP, {
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

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.ACTIVITY_LINER_OP_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == GAME.ACTIVITY_LINER_OP_DONE then
		arg_8_0.viewComponent:UpdateData()
		arg_8_0.viewComponent:UpdateTips()
	end

	return
end

return var_0_0
