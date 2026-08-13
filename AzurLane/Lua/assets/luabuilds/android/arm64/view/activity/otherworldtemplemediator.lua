class = var_0_10000

local var_0_0 = "OtherWorldTempleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_TERMINAL = "OPEN_TERMINAL"
var_0_1.SHOW_CHAR_AWARDS = "SHOW_CHAR_AWARDS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_TERMINAL, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		OtherworldTerminalMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		OtherworldTerminalLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_CHAR_AWARDS, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0.viewComponent
		local var_3_1 = var_3.emit

		BaseUI = var_2_10006

		var_3_1(var_3_0, var_2_10006.ON_ACHIEVE, arg_3_1, arg_3_2)

		return
	end)

	return
end

function var_0_1.onUIAvalible(arg_4_0)
	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_LOTTERY_SHOW_AWARDS
	GAME = var_2
	var_5_0[3] = var_2.ZERO_HOUR_OP_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	ActivityProxy = var_6_0

	if var_6_1 == var_6_0.ACTIVITY_OPERATION_DONE then
		ActivityConst = var_4

		if var_6_2 == var_4.OTHER_WORLD_TERMINAL_LOTTERY_ID then
			local var_6_3 = arg_6_0.viewComponent

			var_4.updateActivity(var_6_3)

			local var_6_4 = arg_6_0.viewComponent

			var_4.displayTempleCharAward(var_6_4)
		end
	else
		ActivityProxy = var_4

		local var_6_6

		if var_6_1 == var_4.ACTIVITY_LOTTERY_SHOW_AWARDS then
			local var_6_5 = arg_6_0.viewComponent

			var_6_6 = var_6_6.emit
			BaseUI = var_1_10007

			var_6_6(var_6_5, var_1_10007.ON_ACHIEVE, var_6_2.awards, function()
				if var_6_2.callback then
					var_6_2.callback()
				end

				return
			end)
		else
			GAME = var_6_6

			if var_6_1 == var_6_6.ZERO_HOUR_OP_DONE then
				-- block empty
			end
		end
	end

	return
end

return var_0_1
