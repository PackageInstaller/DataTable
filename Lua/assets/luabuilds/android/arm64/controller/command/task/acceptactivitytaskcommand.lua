local var_0_0 = class("AcceptActivityTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	print("accpet activity task...................")

	local var_1_0 = getProxy(ActivityProxy)

	_.each(var_1_0:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_TASK_LIST,
		ActivityConst.ACTIVITY_TYPE_TASK_RES
	}), function(arg_2_0)
		if not arg_2_0:isEnd() then
			updateActivityTaskStatus(arg_2_0)
		end

		return
	end)
	underscore.each(var_1_0:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_PT_CRUSING
	}), function(arg_3_0)
		if not arg_3_0:isEnd() then
			updateCrusingActivityTask(arg_3_0)
		end

		return
	end)

	return
end

return var_0_0
