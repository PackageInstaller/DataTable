class = var_0_10000

local var_0_0 = "AmusementParkMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINIGAME_OPERATION = "MINIGAME_OPERATION"
var_0_1.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_3 = var_1_2(var_1_1, var_1_10003.ACTIVITY_TYPE_BUILDING_BUFF)

	assert = var_1_1

	var_1_1(var_1_3, "Building Activity Not Found")

	arg_1_0.activity = var_1_3

	local var_1_4 = arg_1_0.viewComponent

	var_2.UpdateActivity(var_1_4, var_1_3)

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		assert = var_2_10002

		var_2_10002(arg_2_0.activity, "Cant Initialize Activity")

		arg_3_1.activity_id = arg_2_0.activity.id

		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_4

		var_3_1(var_3_0, var_4.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	local var_5_3

	if var_5_0 == var_5_1.SEND_MINI_GAME_OP_DONE then
		var_5_3 = {
			function(arg_6_0)
				if #var_5_2.awards > 0 then
					local var_6_0 = arg_5_0.viewComponent
					local var_6_1 = var_2.emit

					BaseUI = var_2_10004

					var_6_1(var_6_0, var_2_10004.ON_ACHIEVE, var_1, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				local var_7_0 = arg_5_0.viewComponent

				var_1.UpdateView(var_7_0)

				return
			end
		}
		seriesAsync = var_5

		var_5(var_5_3)
	else
		ActivityProxy = var_5_3

		if var_5_0 == var_5_3.ACTIVITY_UPDATED then
			local var_5_4 = var_5_2
			local var_5_5 = var_5_2.getConfig(var_5_4, "type")

			ActivityConst = var_5_4

			if var_5_5 == var_5_4.ACTIVITY_TYPE_BUILDING_BUFF then
				arg_5_0.activity = var_5_2

				local var_5_6 = arg_5_0.viewComponent

				var_4.UpdateActivity(var_5_6, var_5_2)
			else
				local var_5_7 = var_5_2
				local var_5_8 = var_5_2.getConfig(var_5_7, "type")

				ActivityConst = var_5_7

				if var_5_8 == var_5_7.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
					local var_5_9 = var_5_2
					local var_5_10 = arg_5_0.viewComponent

					var_5.UpdateView(var_5_10)
				end
			end
		end
	end

	return
end

return var_0_1
