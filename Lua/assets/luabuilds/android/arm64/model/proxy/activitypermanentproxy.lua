local var_0_0 = class("ActivityPermanentProxy", import(".NetProxy"))

var_0_0.TYPE_NORMAL_ACTIVITY = 1
var_0_0.TYPE_REMASTER_ACTIVITY = 2
var_0_0.ACTIVITY_GROUP_RANGES = {
	[var_0_0.TYPE_NORMAL_ACTIVITY] = {
		max = 1999,
		min = 1
	},
	[var_0_0.TYPE_REMASTER_ACTIVITY] = {
		max = 2999,
		min = 2000
	}
}

function var_0_0.register(arg_1_0)
	arg_1_0:on(11210, function(arg_2_0)
		arg_1_0.finishActivity = {}
		arg_1_0.doingActivities = {}

		underscore.each(arg_2_0.permanent_activity, function(arg_3_0)
			arg_1_0.finishActivity[arg_3_0] = true

			return
		end)

		if type(arg_2_0.permanent_now) == "number" then
			table.insert(arg_1_0.doingActivities, arg_2_0.permanent_now)
		else
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.permanent_now) do
				table.insert(arg_1_0.doingActivities, iter_2_1)
			end
		end

		return
	end)

	return
end

function var_0_0.startSelectActivity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetActivityTypeById(arg_4_1)

	for iter_4_0 = #arg_4_0.doingActivities, 1, -1 do
		if arg_4_0.doingActivities[iter_4_0] == arg_4_1 or var_4_0 and arg_4_0:GetActivityTypeById(arg_4_0.doingActivities[iter_4_0]) == var_4_0 then
			table.remove(arg_4_0.doingActivities, iter_4_0)
		end
	end

	table.insert(arg_4_0.doingActivities, arg_4_1)

	return
end

function var_0_0.StopNowActivity(arg_5_0, arg_5_1)
	if table.contains(arg_5_0.doingActivities, arg_5_1) then
		table.removebyvalue(arg_5_0.doingActivities, arg_5_1)
	end

	return
end

function var_0_0.finishNowActivity(arg_6_0, arg_6_1)
	arg_6_0.finishActivity[arg_6_1] = true

	arg_6_0:StopNowActivity(arg_6_1)

	return
end

function var_0_0.isActivityFinish(arg_7_0, arg_7_1)
	return arg_7_0.finishActivity[arg_7_1]
end

function var_0_0.IsActivityGroupByType(arg_8_0, arg_8_1, arg_8_2)
	return var_0_0.ACTIVITY_GROUP_RANGES[arg_8_2] and arg_8_1 >= var_0_0.ACTIVITY_GROUP_RANGES[arg_8_2].min and arg_8_1 <= var_0_0.ACTIVITY_GROUP_RANGES[arg_8_2].max
end

function var_0_0.GetActivityTypeById(arg_9_0, arg_9_1)
	if not pg.activity_task_permanent[arg_9_1] then
		return nil
	end

	for iter_9_0, iter_9_1 in pairs(var_0_0.ACTIVITY_GROUP_RANGES) do
		if arg_9_0:IsActivityGroupByType(pg.activity_task_permanent[arg_9_1].activity_group, iter_9_0) then
			return iter_9_0
		end
	end

	return nil
end

function var_0_0.IsActivityIdByType(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:GetActivityTypeById(arg_10_1) == arg_10_2
end

function var_0_0.IsNormalActivityId(arg_11_0, arg_11_1)
	return arg_11_0:IsActivityIdByType(arg_11_1, var_0_0.TYPE_NORMAL_ACTIVITY)
end

function var_0_0.getActivityIdsByType(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or var_0_0.TYPE_NORMAL_ACTIVITY

	return _.select(pg.activity_task_permanent.all, function(arg_13_0)
		return arg_12_0:IsActivityIdByType(arg_13_0, arg_12_1)
	end)
end

function var_0_0.getDoingActivityId(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or var_0_0.TYPE_NORMAL_ACTIVITY

	local var_14_1 = arg_14_0.doingActivities or {}

	for iter_14_0, iter_14_1 in var_14_0(var_14_1) do
		if (not arg_14_2 or arg_14_2 == iter_14_1) and arg_14_0:IsActivityIdByType(iter_14_1, arg_14_1) then
			return iter_14_1
		end
	end

	return nil
end

function var_0_0.getDoingActivityById(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getDoingActivityId(arg_15_1, arg_15_2)

	if var_15_0 then
		return getProxy(ActivityProxy):getActivityById(var_15_0) or nil
	end
end

function var_0_0.getDoingActivity(arg_16_0, arg_16_1)
	if #arg_16_0.doingActivities == 0 then
		return nil
	end

	return arg_16_0:getDoingActivityById(arg_16_1)
end

return var_0_0
