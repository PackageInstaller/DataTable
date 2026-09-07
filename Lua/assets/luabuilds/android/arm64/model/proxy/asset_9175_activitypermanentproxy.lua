local ActivityPermanentProxy = class("ActivityPermanentProxy", import(".NetProxy"))

ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY = 1
ActivityPermanentProxy.TYPE_REMASTER_ACTIVITY = 2
ActivityPermanentProxy.ACTIVITY_GROUP_RANGES = {
	[ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY] = {
		max = 1999,
		min = 1
	},
	[ActivityPermanentProxy.TYPE_REMASTER_ACTIVITY] = {
		max = 2999,
		min = 2000
	}
}

function ActivityPermanentProxy:register()
	self:on(11210, function(arg_2_0)
		self.finishActivity = {}
		self.doingActivities = {}

		underscore.each(arg_2_0.permanent_activity, function(arg_3_0)
			self.finishActivity[arg_3_0] = true

			return
		end)

		if type(arg_2_0.permanent_now) == "number" then
			table.insert(self.doingActivities, arg_2_0.permanent_now)
		else
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.permanent_now) do
				table.insert(self.doingActivities, iter_2_1)
			end
		end

		return
	end)

	return
end

function ActivityPermanentProxy:startSelectActivity(arg_4_1)
	local var_4_0 = self:GetActivityTypeById(arg_4_1)

	for iter_4_0 = #self.doingActivities, 1, -1 do
		if self.doingActivities[iter_4_0] == arg_4_1 or var_4_0 and self:GetActivityTypeById(self.doingActivities[iter_4_0]) == var_4_0 then
			table.remove(self.doingActivities, iter_4_0)
		end
	end

	table.insert(self.doingActivities, arg_4_1)

	return
end

function ActivityPermanentProxy:StopNowActivity(arg_5_1)
	if table.contains(self.doingActivities, arg_5_1) then
		table.removebyvalue(self.doingActivities, arg_5_1)
	end

	return
end

function ActivityPermanentProxy:finishNowActivity(arg_6_1)
	self.finishActivity[arg_6_1] = true

	self:StopNowActivity(arg_6_1)

	return
end

function ActivityPermanentProxy:isActivityFinish(arg_7_1)
	return self.finishActivity[arg_7_1]
end

function ActivityPermanentProxy:IsActivityGroupByType(arg_8_1, arg_8_2)
	return ActivityPermanentProxy.ACTIVITY_GROUP_RANGES[arg_8_2] and arg_8_1 >= ActivityPermanentProxy.ACTIVITY_GROUP_RANGES[arg_8_2].min and arg_8_1 <= ActivityPermanentProxy.ACTIVITY_GROUP_RANGES[arg_8_2].max
end

function ActivityPermanentProxy:GetActivityTypeById(arg_9_1)
	if not pg.activity_task_permanent[arg_9_1] then
		return nil
	end

	for iter_9_0, iter_9_1 in pairs(ActivityPermanentProxy.ACTIVITY_GROUP_RANGES) do
		if self:IsActivityGroupByType(pg.activity_task_permanent[arg_9_1].activity_group, iter_9_0) then
			return iter_9_0
		end
	end

	return nil
end

function ActivityPermanentProxy:IsActivityIdByType(arg_10_1, arg_10_2)
	return self:GetActivityTypeById(arg_10_1) == arg_10_2
end

function ActivityPermanentProxy:IsNormalActivityId(arg_11_1)
	return self:IsActivityIdByType(arg_11_1, ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY)
end

function ActivityPermanentProxy:getActivityIdsByType(arg_12_1)
	arg_12_1 = arg_12_1 or ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY

	return _.select(pg.activity_task_permanent.all, function(arg_13_0)
		return self:IsActivityIdByType(arg_13_0, arg_12_1)
	end)
end

function ActivityPermanentProxy:getDoingActivityId(arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY

	for iter_14_0, iter_14_1 in ipairs(self.doingActivities or {}) do
		if (not arg_14_2 or arg_14_2 == iter_14_1) and self:IsActivityIdByType(iter_14_1, arg_14_1) then
			return iter_14_1
		end
	end

	return nil
end

function ActivityPermanentProxy:getDoingActivityById(arg_15_1, arg_15_2)
	local var_15_0 = self:getDoingActivityId(arg_15_1, arg_15_2)

	return (var_15_0 or nil) and (getProxy(ActivityProxy):getActivityById(var_15_0) or nil)
end

function ActivityPermanentProxy:getDoingActivity(arg_16_1)
	if #self.doingActivities == 0 then
		return nil
	end

	return self:getDoingActivityById(arg_16_1)
end

return ActivityPermanentProxy
