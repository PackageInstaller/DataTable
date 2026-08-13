class = var_0_10000

local var_0_0 = "IslandFlowerFieldMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.GET_FLOWER_AWARD = "IslandFlowerFieldMediator.GET_FLOWER_AWARD"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10004.ACTIVITY_TYPE_FLOWER_FIELD)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setActivity(var_1_3, var_1_2)
	arg_1_0:bind(var_0_1.GET_FLOWER_AWARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.ISLAND_FLOWER_GET, {
			act_id = var_1_2.id,
			isAuto = arg_2_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.ISLAND_FLOWER_GET_DONE
	ActivityProxy = var_2
	var_3_0[2] = var_2.ACTIVITY_UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	GAME = var_4_0

	local var_4_4

	if var_4_1 == var_4_0.ISLAND_FLOWER_GET_DONE then
		var_4_4 = #var_4_3.awards

		if 0 < var_4_4 then
			if var_4_3.isAuto then
				local var_4_5 = arg_4_0

				var_4_4 = arg_4_0.addSubLayers
				Context = var_1_10007
				var_1_10007 = var_1_10007.New

				local var_4_6 = {}

				SixthAnniversaryIslandFlowerWindowMediator = var_1_10010
				var_4_6.mediator = var_1_10010
				SixthAnniversaryIslandFlowerWindowLayer = var_1_10010
				var_4_6.viewComponent = var_1_10010

				local var_4_7 = {
					awards = var_4_3.awards
				}

				pg = var_11
				var_4_7.name = var_11.ship_data_statistics[arg_4_0.contextData.shipConfigId].name
				var_4_6.data = var_4_7

				var_4_4(var_4_5, var_1_10007(var_4_6))
			else
				local var_4_8 = arg_4_0.viewComponent

				var_4_4 = var_4_4.emit
				BaseUI = var_1_10007

				var_4_4(var_4_8, var_1_10007.ON_ACHIEVE, var_4_3.awards)
			end
		end
	else
		ActivityProxy = var_4_4

		if var_4_1 == var_4_4.ACTIVITY_UPDATED then
			local var_4_9 = var_4_3:getConfig("type")

			ActivityConst = var_4_2

			if var_4_9 == var_4_2.ACTIVITY_TYPE_FLOWER_FIELD then
				local var_4_10 = arg_4_0.viewComponent

				var_4.setActivity(var_4_10, var_4_3)

				local var_4_11 = arg_4_0.viewComponent

				var_4.refreshDisplay(var_4_11)
			end
		end
	end

	return
end

return var_0_1
