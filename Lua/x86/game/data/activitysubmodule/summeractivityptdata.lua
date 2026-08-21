local var_0_0 = singletonClass("SummerActivityPtData")
local var_0_1 = {}

function var_0_0.Reset(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitWithServer(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not var_0_1[iter_2_0] then
			var_0_1[iter_2_1.id] = {}
		end

		var_0_1[iter_2_1.id].id = iter_2_1.id
		var_0_1[iter_2_1.id].clear_time = iter_2_1.clear_time
	end

	manager.notify:Invoke(SUMMER_ACTIVITY_PT_UPDATE, {})
end

function var_0_0.GetLevelChallengeCount(arg_3_0, arg_3_1)
	if not var_0_1 or not var_0_1[arg_3_1] then
		return 0
	end

	return var_0_1[arg_3_1].clear_time
end

return var_0_0
