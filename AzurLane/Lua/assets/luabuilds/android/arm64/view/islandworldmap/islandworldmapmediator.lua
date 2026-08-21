local var_0_0 = class("IslandWorldMapMediator", import("view.base.ContextMediator"))

var_0_0.GO_ISLAND = "IslandWorldMapMediator:GO_ISLAND"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_0.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.GO_ISLAND, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(ISLAND_EVT.SWITCH_SCENE, {
			mapId = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.BEGIN_STAGE_DONE then
		-- block empty
	end

	return
end

return var_0_0
