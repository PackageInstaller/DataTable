local var_0_0 = class("SkirmishProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:BuildSkirmishData()

	return
end

var_0_0.SkirmishMap = 1250022

function var_0_0.BuildSkirmishData(arg_2_0)
	local var_2_0 = SkirmishVO.bindConfigTable()

	for iter_2_0, iter_2_1 in pairs(var_2_0.all) do
		table.insert(arg_2_0.data, (SkirmishVO.New(var_2_0[iter_2_1].id)))
	end

	return
end

function var_0_0.TryFetchNewTask(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE)

	if var_3_0 and not var_3_0:isEnd() then
		return updateActivityTaskStatus(var_3_0)
	end

	return
end

function var_0_0.UpdateSkirmishProgress(arg_4_0)
	local var_4_0 = getProxy(TaskProxy)
	local var_4_1 = math.min(getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE):getDayIndex(), #arg_4_0.data)
	local var_4_2 = false

	for iter_4_0 = #arg_4_0.data, 1, -1 do
		local var_4_4 = var_4_0:getTaskVO((arg_4_0.data[iter_4_0]:getConfig("task_id")))
		local var_4_5

		if var_4_1 < iter_4_0 then
			var_4_5 = SkirmishVO.StateInactive
		elseif var_4_4 then
			if var_4_4:isReceive() then
				var_4_5 = SkirmishVO.StateClear
				var_4_2 = var_4_2 or iter_4_0 <= var_4_1
			elseif not var_4_4:isFinish() then
				var_4_5 = SkirmishVO.StateWorking
				var_4_2 = true
			else
				var_4_5 = SkirmishVO.StateWorking
				var_4_2 = true
			end
		else
			var_4_5 = var_4_2 and SkirmishVO.StateClear or SkirmishVO.StateActive
		end

		var_4_3:SetState(var_4_5)
	end

	return
end

return var_0_0
