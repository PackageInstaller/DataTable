class = var_0_10000

local var_0_0 = "MallMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CHANGE_SCENE = "MallMapMediator.CHANGE_SCENE"
var_0_1.GO_SCENE = "MallMapMediator.GO_SCENE"
var_0_1.GO_SUBLAYER = "MallMapMediator.GO_SUBLAYER"
var_0_1.TRIGGER_POINT = "MallMapMediator.TRIGGER_POINT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.TRIGGER_POINT, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.ACTIVITY_MALL_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		ActivityMallOPCommand = var_2_10007
		var_5_3.cmd = var_2_10007.CMD.TRIGGER_POINT
		var_5_3.arg1 = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.ACTIVITY_MALL_OP_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GAME = var_7_1

	if var_7_0 == var_7_1.ACTIVITY_MALL_OP_DONE then
		local var_7_3 = var_7_2.cmd

		ActivityMallOPCommand = var_1_10005

		if var_7_3 == var_1_10005.CMD.TRIGGER_POINT then
			local var_7_4 = arg_7_0.viewComponent

			var_4.UpdateData(var_7_4)

			local var_7_5 = arg_7_0.viewComponent

			var_4.UpdateView(var_7_5)
		end
	end

	return
end

return var_0_1
