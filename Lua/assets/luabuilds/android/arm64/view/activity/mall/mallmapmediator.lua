local var_0_0 = class("MallMapMediator", import("view.base.ContextMediator"))

var_0_0.CHANGE_SCENE = "MallMapMediator.CHANGE_SCENE"
var_0_0.GO_SCENE = "MallMapMediator.GO_SCENE"
var_0_0.GO_SUBLAYER = "MallMapMediator.GO_SUBLAYER"
var_0_0.TRIGGER_POINT = "MallMapMediator.TRIGGER_POINT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_0.TRIGGER_POINT, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_5_1,
			cmd = ActivityMallOPCommand.CMD.TRIGGER_POINT,
			arg1 = arg_5_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GAME.ACTIVITY_MALL_OP_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	if arg_7_1:getName() == GAME.ACTIVITY_MALL_OP_DONE and arg_7_1:getBody().cmd == ActivityMallOPCommand.CMD.TRIGGER_POINT then
		arg_7_0.viewComponent:UpdateData()
		arg_7_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
