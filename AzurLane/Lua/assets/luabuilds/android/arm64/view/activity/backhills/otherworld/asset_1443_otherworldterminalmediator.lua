class = var_0_10000

local var_0_0 = "OtherworldTerminalMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_GET_PT_ALL_AWARD = "OtherworldTerminalMediator.ON_GET_PT_AWARD"
var_0_1.ON_BUFF_LIST_CHANGE = "OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_GET_PT_ALL_AWARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.ACT_NEW_PT, {
			cmd = 4,
			activity_id = arg_2_1.actId,
			arg1 = arg_2_1.arg1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_BUFF_LIST_CHANGE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = arg_3_1.actId,
			arg_list = arg_3_1.ids
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_4_0[2] = var_2.ACT_NEW_PT_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	ActivityProxy = var_5_0

	if var_5_1 == var_5_0.ACTIVITY_UPDATED then
		local var_5_3 = var_5_2.id

		TerminalAdventurePage = var_1_10006

		if var_5_3 == var_1_10006.BIND_PT_ACT_ID then
			var_1_10007 = arg_5_0.viewComponent

			var_5.UpdateAdventurePtAct(var_1_10007, var_4)
		else
			local var_5_4 = var_4.id

			TerminalAdventurePage = var_6

			if var_5_4 == var_6.BIND_TASK_ACT_ID then
				var_1_10007 = arg_5_0.viewComponent

				var_5.UpdateAdventureTaskAct(var_1_10007, var_4)
			else
				local var_5_5 = var_4.id

				ActivityConst = var_6

				if var_5_5 == var_6.OTHER_WORLD_TERMINAL_LOTTERY_ID then
					var_1_10007 = arg_5_0.viewComponent

					var_5.UpdateGuardianAct(var_1_10007, var_4)
				end
			end
		end
	else
		GAME = var_4

		if var_5_1 == var_4.ACT_NEW_PT_DONE then
			local var_5_6 = arg_5_0.viewComponent
			local var_5_7 = var_4.emit

			BaseUI = var_1_10007

			var_5_7(var_5_6, var_1_10007.ON_ACHIEVE, var_5_2.awards)

			local var_5_8 = arg_5_0.viewComponent

			var_4.UpdateAdventureTip(var_5_8)
		end
	end

	return
end

return var_0_1
