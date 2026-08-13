class = var_0_10000

local var_0_0 = "ShipGiftMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SHIP_GIFT = "ShipGiftMediator:shipGift"
var_0_1.ADD_SHIP_INTIMACY = "ShipGiftMediator:addShipIntimacy"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SHIP_GIFT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ADD_SHIP_INTIMACY, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_3_1.id

		getProxy = var_2_10004
		BayProxy = var_2_10005

		local var_3_1 = var_2_10004(var_2_10005)
		local var_3_2 = var_4.RawGetShipById(var_3_1, var_3_0)

		var_4.addLikability(var_3_2, arg_3_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.USE_ITEM_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.USE_ITEM_DONE then
		local var_5_3

		if not var_5_2.drops[1] or not var_5_2.drops[1].count then
			var_5_3 = 0
		end

		local var_5_4 = arg_5_0.viewComponent

		var_5.OnGiftSuccess(var_5_4, var_5_3)
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
