class = var_0_10000

local var_0_0 = "ThirdAnniversarySquareMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINIGAME_OPERATION = "MINIGAME_OPERATION"
var_0_1.ON_OPEN_TOWERCLIMBING_SIGNED = "ON_OPEN_TOWERCLIMBING_SIGNED"
var_0_1.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_3 = var_1_2(var_1_1, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF)

	assert = var_1_10002

	var_1_10002(var_1_3, "Building Activity Not Found")

	arg_1_0.activity = var_1_3

	local var_1_4 = arg_1_0.viewComponent

	var_2.UpdateActivity(var_1_4, var_1_3)

	return
end

function var_0_1.BindEvent(arg_2_0)
	var_0_1.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_OPEN_TOWERCLIMBING_SIGNED, function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.ACTIVITY
		local var_3_4 = {}

		ActivityConst = var_2_10006
		var_3_4.id = var_2_10006.TOWERCLIMBING_SIGN

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_2_0:bind(var_0_1.ACTIVITY_OPERATION, function(arg_4_0, arg_4_1)
		assert = var_2_10002

		var_2_10002(arg_2_0.activity, "Cant Initialize Activity")

		arg_4_1.activity_id = arg_2_0.activity.id

		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_5

		var_4_1(var_4_0, var_5.ACTIVITY_OPERATION, arg_4_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_UPDATED

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	GAME = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.SEND_MINI_GAME_OP_DONE then
		var_6_4 = {
			function(arg_7_0)
				if #var_6_3.awards > 0 then
					local var_7_0 = arg_6_0.viewComponent
					local var_7_1 = var_2.emit

					BaseUI = var_2_10005

					var_7_1(var_7_0, var_2_10005.ON_ACHIEVE, var_1, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				local var_8_0 = arg_6_0.viewComponent

				var_1.UpdateView(var_8_0)

				return
			end
		}
		seriesAsync = var_6_2

		var_6_2(var_6_4)
	else
		ActivityProxy = var_6_4

		if var_6_1 == var_6_4.ACTIVITY_UPDATED then
			local var_6_5 = var_6_3:getConfig("type")

			ActivityConst = var_6_2

			if var_6_5 == var_6_2.ACTIVITY_TYPE_BUILDING_BUFF then
				arg_6_0.activity = var_6_3

				local var_6_6 = arg_6_0.viewComponent

				var_4.UpdateActivity(var_6_6, var_6_3)
			end
		end
	end

	return
end

return var_0_1
