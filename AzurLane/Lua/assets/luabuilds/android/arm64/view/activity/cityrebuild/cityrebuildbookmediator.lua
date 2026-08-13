class = var_0_10000

local var_0_0 = "CityRebuildBookMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.REBUILD_OR_START_RECRUIT = "CityRebuildBookMediator.REBUILD_OR_START_RECRUIT"
var_0_1.END_RECRUIT = "CityRebuildBookMediator.END_RECRUIT"
var_0_1.UPGRADE_BUFF = "CityRebuildBookMediator.UPGRADE_BUFF"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.REBUILD_OR_START_RECRUIT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = arg_1_0
		local var_2_1 = var_5.sendNotification

		GAME = var_2_10008

		local var_2_2 = var_2_10008.CITY_REBUILD
		local var_2_3 = {}

		CityRebuildProxy = var_2_10010
		var_2_3.operation = var_2_10010.REBUILD_OR_START_RECRUIT
		var_2_3.activityId = arg_2_1
		var_2_3.buildingId = arg_2_2
		var_2_3.cost = arg_2_3
		var_2_3.ptCost = arg_2_4

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.END_RECRUIT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.CITY_REBUILD
		local var_3_3 = {}

		CityRebuildProxy = var_2_10008
		var_3_3.operation = var_2_10008.END_RECRUIT
		var_3_3.activityId = arg_3_1
		var_3_3.roles = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE_BUFF, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_1_0
		local var_4_1 = var_5.sendNotification

		GAME = var_2_10008

		local var_4_2 = var_2_10008.CITY_REBUILD
		local var_4_3 = {}

		CityRebuildProxy = var_2_10010
		var_4_3.operation = var_2_10010.UPGRADE_BUFF
		var_4_3.activityId = arg_4_1
		var_4_3.group = arg_4_2
		var_4_3.count = arg_4_3
		var_4_3.ptCost = arg_4_4

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.CITY_REBUILD_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	GAME = var_6_0

	if var_6_1 == var_6_0.CITY_REBUILD_DONE then
		local var_6_4 = var_6_3.operation

		CityRebuildProxy = var_6_2

		if var_6_4 ~= var_6_2.REBUILD_OR_START_RECRUIT then
			local var_6_5 = var_6_3.operation

			CityRebuildProxy = var_5

			if var_6_5 ~= var_5.END_RECRUIT then
				local var_6_6 = var_6_3.operation

				CityRebuildProxy = var_5

				if var_6_6 == var_5.UPGRADE_BUFF then
					local var_6_7 = arg_6_0.viewComponent

					var_4.Refresh(var_6_7)
				end

				return
			end
		end
	end
end

return var_0_1
