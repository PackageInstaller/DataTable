class = var_0_10000

local var_0_0 = "BlackWhiteGridMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_FINISH = "VirtualSpaceMediator:ON_FINISH"
var_0_1.ON_UPDATE_SCORE = "VirtualSpaceMediator:ON_UPDATE_SCORE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_1_2 = var_1_1(var_1_0, var_1_10005.ACTIVITY_TYPE_BLACKWHITE)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setActivity(var_1_3, var_1_2)
	arg_1_0:bind(var_0_1.ON_FINISH, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.BLACK_WHITE_GRID_OP, {
			cmd = 1,
			activityId = var_1_2.id,
			id = arg_2_1,
			score = arg_2_2
		})

		return
	end)

	local var_1_4 = arg_1_0

	arg_1_0.bind(var_1_4, var_0_1.ON_UPDATE_SCORE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.BLACK_WHITE_GRID_OP, {
			cmd = 2,
			activityId = var_1_2.id,
			id = arg_3_1,
			score = arg_3_2
		})

		return
	end)

	getProxy = var_3
	PlayerProxy = var_1_4

	local var_1_5 = var_3(var_1_4)
	local var_1_6 = var_3.getRawData(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_7, var_1_6)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.BLACK_WHITE_GRID_OP_DONE
	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_3

	if var_5_1 == var_5_0.BLACK_WHITE_GRID_OP_DONE then
		var_5_3 = {
			function(arg_6_0)
				local var_6_0 = arg_5_0.viewComponent

				var_1.playStory(var_6_0, arg_6_0)

				return
			end,
			function(arg_7_0)
				if #var_5_2.awards > 0 then
					local var_7_0 = arg_5_0.viewComponent
					local var_7_1 = var_2.emit

					BaseUI = var_2_10005

					var_7_1(var_7_0, var_2_10005.ON_ACHIEVE, var_1, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				local var_8_0 = arg_5_0.viewComponent

				var_1.updateBtnsState(var_8_0)
				arg_8_0()

				return
			end
		}
		seriesAsync = var_5

		var_5(var_5_3)
	else
		ActivityProxy = var_5_3

		if var_5_1 == var_5_3.ACTIVITY_UPDATED and arg_5_0.viewComponent.activityVO.id == var_5_2.id then
			local var_5_4 = arg_5_0.viewComponent

			var_4.setActivity(var_5_4, var_5_2)
		end
	end

	return
end

return var_0_1
