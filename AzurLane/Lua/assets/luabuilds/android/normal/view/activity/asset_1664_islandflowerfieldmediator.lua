class = var_0_10000

local var_0_0 = "IslandFlowerFieldMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.GET_FLOWER_AWARD = "IslandFlowerFieldMediator.GET_FLOWER_AWARD"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_2 = var_1_1(var_1_0, var_1_10003.ACTIVITY_TYPE_FLOWER_FIELD)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setActivity(var_1_3, var_1_2)
	arg_1_0:bind(var_0_1.GET_FLOWER_AWARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ISLAND_FLOWER_GET, {
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
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	local var_4_4

	if var_4_0 == var_4_1.ISLAND_FLOWER_GET_DONE then
		if #var_4_2.awards > 0 then
			if var_4_2.isAuto then
				local var_4_3 = arg_4_0

				var_4_4 = arg_4_0.addSubLayers
				Context = var_1_10006
				var_1_10006 = var_1_10006.New

				local var_4_5 = {}

				SixthAnniversaryIslandFlowerWindowMediator = var_1_10008
				var_4_5.mediator = var_1_10008
				SixthAnniversaryIslandFlowerWindowLayer = var_1_10008
				var_4_5.viewComponent = var_1_10008

				local var_4_6 = {
					awards = var_4_2.awards
				}

				pg = var_9
				var_4_6.name = var_9.ship_data_statistics[arg_4_0.contextData.shipConfigId].name
				var_4_5.data = var_4_6

				var_4_4(var_4_3, var_1_10006(var_4_5))
			else
				local var_4_7 = arg_4_0.viewComponent

				var_4_4 = var_4_4.emit
				BaseUI = var_1_10006

				var_4_4(var_4_7, var_1_10006.ON_ACHIEVE, var_4_2.awards)
			end
		end
	else
		ActivityProxy = var_4_4

		if var_4_0 == var_4_4.ACTIVITY_UPDATED then
			local var_4_8 = var_4_2
			local var_4_9 = var_4_2.getConfig(var_4_8, "type")

			ActivityConst = var_4_8

			if var_4_9 == var_4_8.ACTIVITY_TYPE_FLOWER_FIELD then
				local var_4_10 = arg_4_0.viewComponent

				var_4.setActivity(var_4_10, var_4_2)

				local var_4_11 = arg_4_0.viewComponent

				var_4.refreshDisplay(var_4_11)
			end
		end
	end

	return
end

return var_0_1
