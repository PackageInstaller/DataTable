local var_0_0 = class("SharedIslandMediator", import("..View.base.IslandBaseMediator"))

var_0_0.EXIT = "SharedIslandMediator:EXIT"
var_0_0.RETURN_SELF_ISLAND = "SharedIslandMediator:RETURN_SELF_ISLAND"

function var_0_0._register(arg_1_0)
	arg_1_0:bind(IslandMediator.SELECT_GIFT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ISLAND_SELECT_GIFT, {
			islandId = arg_2_1,
			pos = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.EXIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ISLAND_EXIT_SHARED, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.RETURN_SELF_ISLAND, function(arg_4_0)
		local var_4_0 = getProxy(IslandProxy):GetIsland()

		pg.m02:sendNotification(GAME.ISLAND_EXIT, {
			id = arg_1_0.viewComponent:GetIsland().id,
			callback = function()
				pg.m02:sendNotification(GAME.ISLAND_ENTER, {
					id = var_4_0.id
				})

				return
			end
		})

		return
	end)

	return
end

function var_0_0._listNotificationInterests(arg_6_0)
	return {
		GAME.ISLAND_EXIT_SHARED_DONE
	}
end

function var_0_0._handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.ISLAND_EXIT_SHARED_DONE then
		arg_7_0.viewComponent:emit(BaseUI.ON_HOME)
	end

	return
end

return var_0_0
