local var_0_0 = class("YoumiyaStrongholdMediator", import("view.base.ContextMediator"))

var_0_0.MAKE_FURNITURE = "YoumiyaStrongholdMediator.MAKE_FURNITURE"
var_0_0.GET_AWARD = "YoumiyaStrongholdMediator.GET_AWARD"
var_0_0.YOUMIA_GO_SCENE = "YoumiyaStrongholdMediator.YOUMIA_GO_SCENE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.MAKE_FURNITURE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.YUMIA_BASE_ACT_ID,
			arg1 = arg_2_1,
			consumes = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = ActivityConst.YUMIA_BASE_ACT_ID,
			arg1 = arg_3_1,
			canGetIndex = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.YOUMIA_GO_SCENE, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_4_1, arg_4_2)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_6_0.viewComponent:RefreshView()
	end

	return
end

return var_0_0
