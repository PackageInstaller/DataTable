local var_0_0 = singletonClass("GMData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityActiveList_ = {}
end

function var_0_0.EnabledActivity(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		table.insert(arg_2_0.activityActiveList_, arg_2_1)
	else
		table.removebyvalue(arg_2_0.activityActiveList_, arg_2_1)
	end
end

function var_0_0.ResetActivityList(arg_3_0)
	arg_3_0.activityActiveList_ = {}
end

function var_0_0.SetActivityList(arg_4_0, arg_4_1)
	arg_4_0.activityActiveList_ = arg_4_1
end

function var_0_0.GetActivityList(arg_5_0)
	return arg_5_0.activityActiveList_
end

return var_0_0
