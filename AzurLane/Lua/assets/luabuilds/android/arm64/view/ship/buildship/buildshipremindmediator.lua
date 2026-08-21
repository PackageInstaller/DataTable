local var_0_0 = class("BuildShipRemindMediator", import("...base.ContextMediator"))

var_0_0.SHOW_NEW_SHIP = "BuildShipRemindMediator.SHOW_NEW_SHIP"
var_0_0.ON_LOCK = "BuildShipRemindMediator.ON_LOCK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHOW_NEW_SHIP, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_LOCK, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_1_0:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_3_1,
			is_locked = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	arg_1_0.viewComponent:setShips(arg_1_0.contextData.ships)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_0
