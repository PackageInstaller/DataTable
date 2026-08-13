class = var_0_10000

local var_0_0 = "AcceptActivityTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("accpet activity task...................")

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_1_0 = var_1_10002(var_4)

	_ = var_1_10003

	local var_1_1 = var_1_10003.each
	local var_1_2 = var_1_0
	local var_1_3 = var_1_0.getActivitiesByTypes
	local var_1_4 = {}

	ActivityConst = var_1_10009
	var_1_4[1] = var_1_10009.ACTIVITY_TYPE_TASK_LIST
	ActivityConst = var_9
	var_1_4[2] = var_9.ACTIVITY_TYPE_TASK_RES

	var_1_1(var_1_3(var_1_2, var_1_4), function(arg_2_0)
		if not arg_2_0:isEnd() then
			updateActivityTaskStatus = var_1

			var_1(arg_2_0)
		end

		return
	end)

	underscore = var_1_1

	local var_1_5 = var_1_1.each
	local var_1_6 = var_1_0
	local var_1_7 = var_1_0.getActivitiesByTypes
	local var_1_8 = {}

	ActivityConst = var_9
	var_1_8[1] = var_9.ACTIVITY_TYPE_PT_CRUSING

	var_1_5(var_1_7(var_1_6, var_1_8), function(arg_3_0)
		if not arg_3_0:isEnd() then
			updateCrusingActivityTask = var_1

			var_1(arg_3_0)
		end

		return
	end)

	return
end

return var_0_1
