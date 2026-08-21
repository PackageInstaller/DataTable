local var_0_0 = class("CityRebuildBookMediator", import("view.base.ContextMediator"))

var_0_0.REBUILD_OR_START_RECRUIT = "CityRebuildBookMediator.REBUILD_OR_START_RECRUIT"
var_0_0.END_RECRUIT = "CityRebuildBookMediator.END_RECRUIT"
var_0_0.UPGRADE_BUFF = "CityRebuildBookMediator.UPGRADE_BUFF"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.REBUILD_OR_START_RECRUIT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.REBUILD_OR_START_RECRUIT,
			activityId = arg_2_1,
			buildingId = arg_2_2,
			cost = arg_2_3,
			ptCost = arg_2_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.END_RECRUIT, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.END_RECRUIT,
			activityId = arg_3_1,
			roles = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.UPGRADE_BUFF, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.UPGRADE_BUFF,
			activityId = arg_4_1,
			group = arg_4_2,
			count = arg_4_3,
			ptCost = arg_4_4
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.CITY_REBUILD_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.CITY_REBUILD_DONE and (var_6_0.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT or var_6_0.operation == CityRebuildProxy.END_RECRUIT or var_6_0.operation == CityRebuildProxy.UPGRADE_BUFF) then
		arg_6_0.viewComponent:Refresh()
	end

	return
end

return var_0_0
