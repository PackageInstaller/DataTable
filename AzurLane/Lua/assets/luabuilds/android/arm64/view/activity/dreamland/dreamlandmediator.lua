class = var_0_10000

local var_0_0 = "DreamlandMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.AnniversaryIsland2023.AnniversaryIslandHotSpringMediator"))

var_0_1.GET_MAP_AWARD = "DreamlandMediator:GET_MAP_AWARD"
var_0_1.GET_EXPLORE_AWARD = "DreamlandMediator:GET_EXPLORE_AWARD"
var_0_1.RECORD_EXPLORE = "DreamlandMediator:RECORD_EXPLORE"
var_0_1.HOT_SPRING_OP = "DreamlandMediator:HOT_SPRING_OP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.HOT_SPRING_OP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.maxSlotCnt = arg_2_2

		local var_2_0 = arg_1_0

		var_4.OnSelShips(var_2_0, arg_2_1, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_MAP_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.ACTIVITY_DREAMLAND_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		DreamlandData = var_2_10008
		var_3_3.cmd = var_2_10008.OP_GET_MAP_AWARD
		var_3_3.arg1 = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_EXPLORE_AWARD, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_4_2 = var_2_10006.ACTIVITY_DREAMLAND_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		DreamlandData = var_2_10008
		var_4_3.cmd = var_2_10008.OP_GET_EXPLORE_AWARD
		var_4_3.arg1 = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.RECORD_EXPLORE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_1_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_5_2 = var_2_10007.ACTIVITY_DREAMLAND_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		DreamlandData = var_2_10009
		var_5_3.cmd = var_2_10009.OP_RECORD_EXPLORE
		var_5_3.arg1 = arg_5_3

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4
	arg_1_0.activity = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_HOTSPRING_2)

	return
end

function var_0_1.GetGetSlotCount(arg_6_0)
	local var_6_0

	if not arg_6_0.maxSlotCnt then
		var_6_0 = 0
	end

	return var_6_0
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_DREAMLAND_OP_DONE
	ActivityProxy = var_2
	var_7_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_7_0[3] = var_2.STORY_UPDATE_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.getBody(var_8_2)

	GAME = var_8_0

	local var_8_4

	if var_8_1 == var_8_0.ACTIVITY_DREAMLAND_OP_DONE then
		var_1_10006 = arg_8_0.viewComponent

		var_8_4.UpdateActivity(var_1_10006, var_8_3.activity, var_8_3.cmd)

		var_8_4 = #var_8_3.awards

		if 0 < var_8_4 then
			var_1_10006 = arg_8_0.viewComponent
			var_8_4 = var_8_4.emit
			BaseUI = var_1_10007

			var_8_4(var_1_10006, var_1_10007.ON_ACHIEVE, var_8_3.awards)
		end
	else
		ActivityProxy = var_8_4

		local var_8_5

		if var_8_1 == var_8_4.ACTIVITY_UPDATED then
			var_1_10006 = var_8_3
			var_8_5 = var_8_3.getConfig(var_1_10006, "type")
			ActivityConst = var_8_2

			if var_8_5 == var_8_2.ACTIVITY_TYPE_HOTSPRING_2 then
				arg_8_0.activity = var_8_3
				var_1_10006 = arg_8_0.viewComponent

				var_8_5.UpdateSpringActivity(var_1_10006, var_8_3)
			end
		else
			GAME = var_8_5

			if var_8_1 == var_8_5.STORY_UPDATE_DONE then
				getProxy = var_4
				ActivityProxy = var_1_10006

				local var_8_6 = var_4(var_1_10006)
				local var_8_7 = var_4.getActivityByType

				ActivityConst = var_1_10007
				arg_8_0.activity = var_8_7(var_8_6, var_1_10007.ACTIVITY_TYPE_HOTSPRING_2)

				local var_8_8 = arg_8_0.viewComponent

				var_4.UpdateSpringActivity(var_8_8, arg_8_0.activity)
			end
		end
	end

	return
end

return var_0_1
