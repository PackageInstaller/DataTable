class = var_0_10000

local var_0_0 = "BackyardFeedMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.USE_FOOD = "BackyardFeedMediator:USE_FOOD"
var_0_1.BUY_FOOD = "BackyardFeedMediator:BUY_FOOD"
var_0_1.EXTEND = "BackyardFeedMediator:EXTEND"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.USE_FOOD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_2_3 then
			local var_2_0 = var_1_0

			var_4.setBackyardRemind(var_2_0)

			local var_2_1 = arg_1_0.viewComponent
			local var_2_2 = var_4.SetIsRemind
			local var_2_3 = var_1_0

			var_2_2(var_2_1, var_2_10007.getBackyardRemind(var_2_3))
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_4.sendNotification

		GAME = var_2_10007

		var_2_5(var_2_4, var_2_10007.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUY_FOOD, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.SHOPPING, {
			id = arg_3_1,
			count = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.EXTEND, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.SHOPPING, {
			id = arg_4_1,
			count = arg_4_2
		})

		return
	end)

	local var_1_1 = arg_1_0.viewComponent

	var_2.SetIsRemind(var_1_1, var_1_0:getBackyardRemind())

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.ADD_FOOD_DONE
	DormProxy = var_2
	var_5_0[2] = var_2.DORM_UPDATEED
	GAME = var_2
	var_5_0[3] = var_2.SHOPPING_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)
	local var_6_3 = arg_6_1:getType()

	GAME = var_6_1

	if var_6_0 == var_6_1.ADD_FOOD_DONE then
		local var_6_4 = arg_6_0.viewComponent

		var_5.OnUsageItem(var_6_4, var_6_2.id)
	else
		DormProxy = var_5

		if var_6_0 == var_5.DORM_UPDATEED then
			BackYardConst = var_5

			if var_6_3 == var_5.DORM_UPDATE_TYPE_USEFOOD then
				local var_6_5 = arg_6_0.viewComponent

				var_5.OnDormUpdated(var_6_5)

				goto label_6_0
			end
		end

		GAME = var_5

		if var_6_0 == var_5.SHOPPING_DONE then
			local var_6_6 = arg_6_0.viewComponent

			var_5.OnShopDone(var_6_6)
		end
	end

	::label_6_0::

	return
end

return var_0_1
