class = var_0_10000

local var_0_0 = "OtherworldBackHilllMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
var_0_1.GO_SCENE = "GO_SCENE"
var_0_1.CHANGE_SCENE = "CHANGE_SCENE"
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
	arg_2_0:bind(var_0_1.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0

		var_3.addSubLayers(var_5_0, arg_5_1, nil, arg_5_2)

		return
	end)
	arg_2_0:bind(var_0_1.MINI_GAME_OPERATOR, function(arg_6_0, ...)
		local var_6_0 = arg_2_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	ActivityProxy = var_2
	var_7_0[2] = var_2.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_7_0[3] = var_2.UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GAME = var_8_0

	local var_8_3

	if var_8_1 == var_8_0.SEND_MINI_GAME_OP_DONE then
		var_8_3 = {
			function(arg_9_0)
				if #var_8_2.awards > 0 then
					local var_9_0 = arg_8_0.viewComponent
					local var_9_1 = var_2.emit

					BaseUI = var_2_10005

					var_9_1(var_9_0, var_2_10005.ON_ACHIEVE, var_1, arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				local var_10_0 = arg_8_0.viewComponent

				var_1.UpdateView(var_10_0)

				return
			end
		}
		seriesAsync = var_5

		var_5(var_8_3)
	else
		ActivityProxy = var_8_3

		if var_8_1 == var_8_3.ACTIVITY_UPDATED then
			local var_8_4 = arg_8_0.viewComponent

			var_4.UpdateActivity(var_8_4, var_8_2)
		else
			PlayerProxy = var_4

			if var_8_1 == var_4.UPDATED then
				local var_8_5 = arg_8_0.viewComponent

				var_4.UpdateRes(var_8_5)

				local var_8_6 = arg_8_0.viewComponent

				var_4.UpdateView(var_8_6)
			end
		end
	end

	return
end

return var_0_1
