class = var_0_10000

local var_0_0 = "SpringFestival2024Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
var_0_1.GO_SCENE = "GO_SCENE"
var_0_1.GO_SUBLAYER = "GO_SUBLAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)
	arg_2_0:bind(var_0_1.MINI_GAME_OPERATOR, function(arg_5_0, ...)
		local var_5_0 = arg_2_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	ActivityProxy = var_2
	var_6_0[2] = var_2.ACTIVITY_UPDATED

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	GAME = var_7_0

	local var_7_3

	if var_7_1 == var_7_0.SEND_MINI_GAME_OP_DONE then
		var_7_3 = {
			function(arg_8_0)
				if #var_7_2.awards > 0 then
					local var_8_0 = arg_7_0.viewComponent
					local var_8_1 = var_2.emit

					BaseUI = var_2_10005

					var_8_1(var_8_0, var_2_10005.ON_ACHIEVE, var_1, arg_8_0)
				else
					arg_8_0()
				end

				return
			end,
			function(arg_9_0)
				local var_9_0 = arg_7_0.viewComponent

				var_1.UpdateView(var_9_0)

				return
			end
		}
		seriesAsync = var_5

		var_5(var_7_3)
	else
		ActivityProxy = var_7_3

		if var_7_1 == var_7_3.ACTIVITY_UPDATED then
			local var_7_4 = arg_7_0.viewComponent

			var_4.UpdateActivity(var_7_4, var_7_2)
		end
	end

	return
end

return var_0_1
