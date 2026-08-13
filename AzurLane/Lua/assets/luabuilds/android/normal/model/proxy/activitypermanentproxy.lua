class = var_0_10000

local var_0_0 = "ActivityPermanentProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.TYPE_NORMAL_ACTIVITY = 1
var_0_1.TYPE_REMASTER_ACTIVITY = 2
var_0_1.ACTIVITY_GROUP_RANGES = {
	[var_0_1.TYPE_NORMAL_ACTIVITY] = {
		max = 1999,
		min = 1
	},
	[var_0_1.TYPE_REMASTER_ACTIVITY] = {
		max = 2999,
		min = 2000
	}
}

function var_0_1.register(arg_1_0)
	arg_1_0:on(11210, function(arg_2_0)
		arg_1_0.finishActivity = {}

		local var_2_0 = arg_1_0

		var_2_0.doingActivities = {}
		underscore = var_2_0

		var_2_0.each(arg_2_0.permanent_activity, function(arg_3_0)
			arg_1_0.finishActivity[arg_3_0] = true

			return
		end)

		type = var_1

		if var_1(arg_2_0.permanent_now) == "number" then
			table = var_1

			var_1.insert(arg_1_0.doingActivities, arg_2_0.permanent_now)
		else
			ipairs = var_1

			for iter_2_0, iter_2_1 in var_1(arg_2_0.permanent_now) do
				table = var_2_10006

				var_2_10006.insert(arg_1_0.doingActivities, iter_2_1)
			end
		end

		return
	end)

	return
end

function var_0_1.startSelectActivity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetActivityTypeById(arg_4_1)

	for iter_4_0 = #arg_4_0.doingActivities, 1, -1 do
		if arg_4_0.doingActivities[iter_4_0] == arg_4_1 or var_4_0 and arg_4_0:GetActivityTypeById(arg_4_0.doingActivities[iter_4_0]) == var_4_0 then
			table = var_7

			var_7.remove(arg_4_0.doingActivities, iter_4_0)
		end
	end

	table = var_3

	var_3.insert(arg_4_0.doingActivities, arg_4_1)

	return
end

function var_0_1.StopNowActivity(arg_5_0, arg_5_1)
	table = var_1_10002

	if var_1_10002.contains(arg_5_0.doingActivities, arg_5_1) then
		table = var_2

		var_2.removebyvalue(arg_5_0.doingActivities, arg_5_1)
	end

	return
end

function var_0_1.finishNowActivity(arg_6_0, arg_6_1)
	arg_6_0.finishActivity[arg_6_1] = true

	arg_6_0:StopNowActivity(arg_6_1)

	return
end

function var_0_1.isActivityFinish(arg_7_0, arg_7_1)
	return arg_7_0.finishActivity[arg_7_1]
end

function var_0_1.IsActivityGroupByType(arg_8_0, arg_8_1, arg_8_2)
	return var_0_1.ACTIVITY_GROUP_RANGES[arg_8_2] and arg_8_1 >= var_3.min and arg_8_1 <= var_3.max
end

function var_0_1.GetActivityTypeById(arg_9_0, arg_9_1)
	pg = var_1_10002

	if not var_1_10002.activity_task_permanent[arg_9_1] then
		return nil
	end

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_0_1.ACTIVITY_GROUP_RANGES) do
		if arg_9_0:IsActivityGroupByType(var_2.activity_group, iter_9_0) then
			return iter_9_0
		end
	end

	return nil
end

function var_0_1.IsActivityIdByType(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:GetActivityTypeById(arg_10_1) == arg_10_2
end

function var_0_1.IsNormalActivityId(arg_11_0, arg_11_1)
	return arg_11_0:IsActivityIdByType(arg_11_1, var_0_1.TYPE_NORMAL_ACTIVITY)
end

function var_0_1.getActivityIdsByType(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or var_0_1.TYPE_NORMAL_ACTIVITY
	_ = var_1_10002

	local var_12_0 = var_1_10002.select

	pg = var_1_10003

	return var_12_0(var_1_10003.activity_task_permanent.all, function(arg_13_0)
		local var_13_0 = arg_12_0

		return var_1.IsActivityIdByType(var_13_0, arg_13_0, arg_12_1)
	end)
end

function var_0_1.getDoingActivityId(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or var_0_1.TYPE_NORMAL_ACTIVITY
	ipairs = var_1_10003

	local var_14_0

	if not arg_14_0.doingActivities then
		var_14_0 = {}
	end

	for iter_14_0, iter_14_1 in var_1_10003(var_14_0) do
		if (not arg_14_2 or arg_14_2 == iter_14_1) and arg_14_0:IsActivityIdByType(iter_14_1, arg_14_1) then
			return iter_14_1
		end
	end

	return nil
end

function var_0_1.getDoingActivityById(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0

	if arg_15_0.getDoingActivityId(var_15_0, arg_15_1, arg_15_2) then
		getProxy = var_15_0
		ActivityProxy = var_5

		local var_15_1 = var_15_0(var_5)
		local var_15_2

		if not var_4.getActivityById(var_15_1, var_3) then
			var_15_2 = nil
		end

		return var_15_2
	end
end

function var_0_1.getDoingActivity(arg_16_0, arg_16_1)
	if #arg_16_0.doingActivities == 0 then
		return nil
	end

	return arg_16_0:getDoingActivityById(arg_16_1)
end

return var_0_1
