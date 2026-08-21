local var_0_0 = class("RandomDockYardMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_INDEX = "RandomDockYardMediator:OPEN_INDEX"
var_0_0.ON_ADD_SHIPS = "RandomDockYardMediator:ON_ADD_SHIPS"
var_0_0.ON_REMOVE_SHIPS = "RandomDockYardMediator:ON_REMOVE_SHIPS"
var_0_0.OPEN_PHANTOM_LAYER = "RandomDockYardMediator.OPEN_PHANTOM_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_ADD_SHIPS, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = underscore.map(arg_2_1, function(arg_3_0)
				return ShipPhantom.PackMark(arg_3_0, 0)
			end),
			deleteList = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REMOVE_SHIPS, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = {},
			deleteList = underscore.map(arg_4_1, function(arg_5_0)
				return ShipPhantom.PackMark(arg_5_0, 0)
			end)
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INDEX, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = RandomDockYardIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_PHANTOM_LAYER, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = DockyardMediator,
			viewComponent = DockyardScene,
			data = {
				mode = DockyardScene.MODE_SHIP_PHANTOM
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		GAME.CHANGE_RANDOM_SHIPS_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getBody()

	if arg_9_1:getName() == GAME.CHANGE_RANDOM_SHIPS_DONE then
		arg_9_0.viewComponent:OnChangeRandomShips()
	end

	return
end

return var_0_0
