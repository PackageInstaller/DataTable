class = var_0_10000

local var_0_0 = "BuildShipRemindMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.SHOW_NEW_SHIP = "BuildShipRemindMediator.SHOW_NEW_SHIP"
var_0_1.ON_LOCK = "BuildShipRemindMediator.ON_LOCK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SHOW_NEW_SHIP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		NewShipMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		NewShipLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			ship = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_LOCK, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.UPDATE_LOCK, {
			ship_id_list = arg_3_1,
			is_locked = arg_3_2,
			callback = arg_3_3
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.setShips(var_1_0, arg_1_0.contextData.ships)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_1
