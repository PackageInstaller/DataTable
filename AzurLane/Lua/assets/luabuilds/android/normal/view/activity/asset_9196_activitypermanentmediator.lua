class = var_0_10000

local var_0_0 = "ActivityPermanentMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.START_SELECT = "ActivityPermanentMediator.START_SELECT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.START_SELECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ACTIVITY_PERMANENT_START, {
			activity_id = arg_2_1
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setActivitys

	getProxy = var_3
	ActivityPermanentProxy = var_4

	local var_1_2 = var_3(var_4)
	local var_1_3 = var_3.getActivityIdsByType

	ActivityPermanentProxy = var_1_10005

	var_1_1(var_1_0, var_1_3(var_1_2, var_1_10005.TYPE_NORMAL_ACTIVITY))

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_PERMANENT_START_DONE
	GAME = var_2
	var_3_0[2] = var_2.ACTIVITY_PERMANENT_FINISH_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1

	if arg_4_1:getBody() and not var_3.id then
		var_4_1 = var_3.activity_id
	end

	GAME = var_1_10005

	if var_4_0 ~= var_1_10005.ACTIVITY_PERMANENT_START_DONE then
		GAME = var_5

		if var_4_0 == var_5.ACTIVITY_PERMANENT_FINISH_DONE then
			getProxy = var_5
			ActivityPermanentProxy = var_1_10006

			local var_4_2 = var_5(var_1_10006)

			if not var_5.IsNormalActivityId(var_4_2, var_4_1) then
				return
			end

			local var_4_3 = arg_4_0.viewComponent

			var_5.closeView(var_4_3)
		end

		return
	end
end

return var_0_1
