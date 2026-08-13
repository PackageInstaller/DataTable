class = var_0_10000

local var_0_0 = "NewEducateScheduleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateContextMediator"))

var_0_1.ON_SELECTED_PLANS = "NewEducateScheduleMediator.ON_SELECTED_PLANS"
var_0_1.ON_UPGRADE_PLANS = "NewEducateScheduleMediator.ON_UPGRADE_PLANS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SELECTED_PLANS, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = {}

		ipairs = var_2_10004

		for iter_2_0, iter_2_1 in var_2_10004(arg_2_2) do
			if iter_2_1.plan then
				table = var_9

				var_9.insert(var_2_0, {
					key = iter_2_0,
					value = iter_2_1.plan.id
				})
			end
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_4.sendNotification

		GAME = iter_2_0

		var_2_2(var_2_1, iter_2_0.NEW_EDUCATE_SCHEDULE, {
			id = arg_1_0.contextData.char.id,
			planKVs = var_2_0,
			isSkip = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE_PLANS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.NEW_EDUCATE_UPGRADE_PLAN, {
			id = arg_1_0.contextData.char.id,
			planIds = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.NEW_EDUCATE_UPGRADE_PLAN_DONE
	GAME = var_2
	var_4_0[2] = var_2.NEW_EDUCATE_SCHEDULE_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	if var_5_1 == var_5_0.NEW_EDUCATE_UPGRADE_PLAN_DONE then
		local var_5_3 = arg_5_0.viewComponent

		var_4.OnUpgradePlans(var_5_3)
	else
		GAME = var_4

		if var_5_1 == var_4.NEW_EDUCATE_SCHEDULE_DONE then
			local var_5_4 = arg_5_0.viewComponent

			var_4.SetScheduleData(var_5_4, var_5_2)

			local var_5_5 = arg_5_0.viewComponent

			var_4.closeView(var_5_5)
		end
	end

	return
end

return var_0_1
