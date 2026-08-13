class = var_0_10000

local var_0_0 = "ChargeActGiftMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.DO_PAY = "ChargeActGiftMediator.DO_PAY"
var_0_1.GO_SHOP = "ChargeActGiftMediator.GO_SHOP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.DO_PAY, function(arg_2_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getActivityById(var_2_0, arg_1_0.contextData.actId)
		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_4 = var_2_10005.ACTIVITY_OPERATION
		local var_2_5 = {
			cmd = 1,
			activity_id = var_2_1.id
		}

		Drop = var_7

		local var_2_6 = var_7.New
		local var_2_7 = {}

		DROP_TYPE_RESOURCE = var_2_10010
		var_2_7.type = var_2_10010
		PlayerConst = var_2_10010
		var_2_7.id = var_2_10010.ResDiamond
		GiftActCommodity = var_10
		var_2_7.count = var_10.CalcPrice(var_2_1)
		var_2_5.costDrop = var_2_6(var_2_7)

		var_2_3(var_2_2, var_2_4, var_2_5)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_3_1(var_3_0, var_3_2, var_2_10006.SKINSHOP)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	ActivityProxy = var_5_0

	if var_5_1 == var_5_0.ACTIVITY_OPERATION_DONE and var_5_2 == arg_5_0.contextData.actId then
		local var_5_3 = arg_5_0.viewComponent

		var_4.closeView(var_5_3)
	end

	return
end

return var_0_1
