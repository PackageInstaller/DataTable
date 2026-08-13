class = var_0_10000

local var_0_0 = "RandomDockYardMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_INDEX = "RandomDockYardMediator:OPEN_INDEX"
var_0_1.ON_ADD_SHIPS = "RandomDockYardMediator:ON_ADD_SHIPS"
var_0_1.ON_REMOVE_SHIPS = "RandomDockYardMediator:ON_REMOVE_SHIPS"
var_0_1.OPEN_PHANTOM_LAYER = "RandomDockYardMediator.OPEN_PHANTOM_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ADD_SHIPS, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.CHANGE_RANDOM_SHIPS
		local var_2_3 = {}

		underscore = var_2_10007
		var_2_3.addList = var_2_10007.map(arg_2_1, function(arg_3_0)
			ShipPhantom = var_3_10001

			return var_3_10001.PackMark(arg_3_0, 0)
		end)
		var_2_3.deleteList = {}

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REMOVE_SHIPS, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.CHANGE_RANDOM_SHIPS
		local var_4_3 = {
			addList = {}
		}

		underscore = var_7
		var_4_3.deleteList = var_7.map(arg_4_1, function(arg_5_0)
			ShipPhantom = var_3_10001

			return var_3_10001.PackMark(arg_5_0, 0)
		end)

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INDEX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_6_2 = var_2_10005.New
		local var_6_3 = {}

		RandomDockYardIndexLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		var_6_3.data = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PHANTOM_LAYER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_7_2 = var_2_10005.New
		local var_7_3 = {}

		DockyardMediator = var_2_10008
		var_7_3.mediator = var_2_10008
		DockyardScene = var_2_10008
		var_7_3.viewComponent = var_2_10008

		local var_7_4 = {}

		DockyardScene = var_2_10009
		var_7_4.mode = var_2_10009.MODE_SHIP_PHANTOM
		var_7_3.data = var_7_4

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.CHANGE_RANDOM_SHIPS_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	if var_9_1 == var_9_0.CHANGE_RANDOM_SHIPS_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_4.OnChangeRandomShips(var_9_3)
	end

	return
end

return var_0_1
