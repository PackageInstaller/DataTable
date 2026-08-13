class = var_0_10000

local var_0_0 = "YoumiyaStrongholdMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.MAKE_FURNITURE = "YoumiyaStrongholdMediator.MAKE_FURNITURE"
var_0_1.GET_AWARD = "YoumiyaStrongholdMediator.GET_AWARD"
var_0_1.YOUMIA_GO_SCENE = "YoumiyaStrongholdMediator.YOUMIA_GO_SCENE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.MAKE_FURNITURE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.ACTIVITY_OPERATION
		local var_2_3 = {
			cmd = 1
		}

		ActivityConst = var_2_10008
		var_2_3.activity_id = var_2_10008.YUMIA_BASE_ACT_ID
		var_2_3.arg1 = arg_2_1
		var_2_3.consumes = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.ACTIVITY_OPERATION
		local var_3_3 = {
			cmd = 2
		}

		ActivityConst = var_2_10008
		var_3_3.activity_id = var_2_10008.YUMIA_BASE_ACT_ID
		var_3_3.arg1 = arg_3_1
		var_3_3.canGetIndex = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.YOUMIA_GO_SCENE, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.GO_SCENE, arg_4_1, arg_4_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	ActivityProxy = var_6_0

	if var_6_1 == var_6_0.ACTIVITY_OPERATION_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.RefreshView(var_6_3)
	end

	return
end

return var_0_1
