class = var_0_10000

local var_0_0 = "SharedIslandMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..View.base.IslandBaseMediator"))

var_0_1.EXIT = "SharedIslandMediator:EXIT"
var_0_1.RETURN_SELF_ISLAND = "SharedIslandMediator:RETURN_SELF_ISLAND"

function var_0_1._register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	IslandMediator = var_1_10004

	var_1_1(var_1_0, var_1_10004.SELECT_GIFT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ISLAND_SELECT_GIFT, {
			islandId = arg_2_1,
			pos = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.EXIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.ISLAND_EXIT_SHARED, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.RETURN_SELF_ISLAND, function(arg_4_0)
		local var_4_0 = arg_1_0.viewComponent
		local var_4_1 = var_1.GetIsland(var_4_0)

		getProxy = var_2_10002
		IslandProxy = var_2_10004

		local var_4_2 = var_2_10002(var_2_10004)
		local var_4_3 = var_2.GetIsland(var_4_2)

		pg = var_4_0

		local var_4_4 = var_4_0.m02
		local var_4_5 = var_3.sendNotification

		GAME = var_2_10006

		var_4_5(var_4_4, var_2_10006.ISLAND_EXIT, {
			id = var_4_1.id,
			callback = function()
				pg = var_3_10000

				local var_5_0 = var_3_10000.m02
				local var_5_1 = var_0.sendNotification

				GAME = var_3_10003

				var_5_1(var_5_0, var_3_10003.ISLAND_ENTER, {
					id = var_4_3.id
				})

				return
			end
		})

		return
	end)

	return
end

function var_0_1._listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.ISLAND_EXIT_SHARED_DONE

	return var_6_0
end

function var_0_1._handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	GAME = var_7_0

	if var_7_1 == var_7_0.ISLAND_EXIT_SHARED_DONE then
		local var_7_3 = arg_7_0.viewComponent
		local var_7_4 = var_4.emit

		BaseUI = var_1_10007

		var_7_4(var_7_3, var_1_10007.ON_HOME)
	end

	return
end

return var_0_1
