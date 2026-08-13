class = var_0_10000

local var_0_0 = "CommanderHomeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_CLEAN = "CommanderHomeMediator:ON_CLEAN"
var_0_1.ON_FEED = "CommanderHomeMediator:ON_FEED"
var_0_1.ON_PLAY = "CommanderHomeMediator:ON_PLAY"
var_0_1.ON_SEL_COMMANDER = "CommanderHomeMediator:ON_SEL_COMMANDER"
var_0_1.ON_CHANGE_STYLE = "CommanderHomeMediator:ON_CHANGE_STYLE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CLEAN, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.COMMANDER_CATTERY_OP, {
			op = 1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FEED, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.COMMANDER_CATTERY_OP, {
			op = 2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_PLAY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.COMMANDER_CATTERY_OP, {
			op = 3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SEL_COMMANDER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		defaultValue = var_2_10005
		arg_5_3 = var_2_10005(arg_5_3, true)

		local var_5_0 = arg_1_0
		local var_5_1 = var_5.sendNotification

		GAME = var_8

		var_5_1(var_5_0, var_8.PUT_COMMANDER_IN_CATTERY, {
			id = arg_5_1,
			commanderId = arg_5_2,
			tip = arg_5_3,
			callback = arg_5_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHANGE_STYLE, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		var_6_1(var_6_0, var_2_10006.COMMANDER_CHANGE_CATTERY_STYLE, {
			id = arg_6_1,
			styleId = arg_6_2
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetHome

	getProxy = var_4
	CommanderProxy = var_1_10006

	local var_1_2 = var_4(var_1_10006)

	var_1_1(var_1_0, var_4.GetCommanderHome(var_1_2))

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.PUT_COMMANDER_IN_CATTERY_DONE
	GAME = var_2
	var_7_0[2] = var_2.COMMANDER_CHANGE_CATTERY_STYLE_DONE
	GAME = var_2
	var_7_0[3] = var_2.COMMANDER_CATTERY_OP_DONE
	GAME = var_2
	var_7_0[4] = var_2.ZERO_HOUR_OP_DONE
	GAME = var_2
	var_7_0[5] = var_2.CALC_CATTERY_EXP_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GAME = var_8_0

	if var_8_1 == var_8_0.PUT_COMMANDER_IN_CATTERY_DONE then
		local var_8_3 = arg_8_0.viewComponent

		var_4.OnCatteryUpdate(var_8_3, var_8_2.id)
	else
		GAME = var_4

		if var_8_1 == var_4.COMMANDER_CHANGE_CATTERY_STYLE_DONE then
			local var_8_4 = arg_8_0.viewComponent

			var_4.OnCatteryStyleUpdate(var_8_4, var_8_2.id)
		else
			GAME = var_4

			local var_8_5

			if var_8_1 == var_4.COMMANDER_CATTERY_OP_DONE then
				var_8_5 = arg_8_0.viewComponent
				var_8_5.forbiddenClose = true
				seriesAsync = var_8_5

				var_8_5({
					function(arg_9_0)
						local var_9_0 = arg_8_0.viewComponent

						var_1.OnCatteryOPDone(var_9_0)

						local var_9_1 = arg_8_0.viewComponent

						var_1.OnOpAnimtion(var_9_1, var_8_2.cmd, var_8_2.opCatteries, arg_9_0)

						return
					end,
					function(arg_10_0)
						local var_10_0 = arg_8_0.viewComponent
						local var_10_1 = var_1.emit

						BaseUI = var_2_10004

						var_10_1(var_10_0, var_2_10004.ON_ACHIEVE, var_8_2.awards, arg_10_0)

						arg_8_0.viewComponent.forbiddenClose = false

						return
					end,
					function(arg_11_0)
						local var_11_0 = var_8_2.cmd
						local var_11_1 = arg_8_0.viewComponent

						var_2.OnDisplayAwardDone(var_11_1, var_8_2)

						return
					end
				})
			else
				GAME = var_8_5

				if var_8_1 == var_8_5.ZERO_HOUR_OP_DONE then
					local var_8_6 = arg_8_0.viewComponent

					var_4.OnZeroHour(var_8_6)
				else
					GAME = var_4

					if var_8_1 == var_4.CALC_CATTERY_EXP_DONE then
						local var_8_7 = arg_8_0.viewComponent

						var_4.OnCommanderExpChange(var_8_7, var_8_2.commanderExps)
					end
				end
			end
		end
	end

	return
end

return var_0_1
