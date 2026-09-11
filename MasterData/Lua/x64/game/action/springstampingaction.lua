local var_0_0 = {}

manager.net:Bind(84303, function(arg_1_0)
	SpringStampingData:InitData(arg_1_0)
	var_0_0.InitRedPointKey(arg_1_0)
end)

function var_0_0.ConfirmStamp(arg_2_0)
	manager.net:SendWithLoadingNew(86026, {
		assignment_id = arg_2_0
	}, 86027, var_0_0.OnStampComplete)
end

function var_0_0:InitRedPointKey()
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SPRING_STAMPING, {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activity_id)
	})
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(self.activity_id) .. self.activity_id, {
		RedPointConst.ACTIVITY_SPRING_STAMPING
	})
	SpringStampingData:CheckTaskList()
end

return var_0_0
