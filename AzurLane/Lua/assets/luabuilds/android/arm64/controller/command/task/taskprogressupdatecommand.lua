local var_0_0 = class("TaskProgressUpdateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	arg_1_0:CheckAndSubmitVoteTask()

	return
end

function var_0_0.CheckAndSubmitVoteTask(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if not iter_2_1:isEnd() then
			arg_2_0:SubmitTaskList((arg_2_0:GetCanSubmitVoteTaskList(iter_2_1)))
		end
	end

	return
end

function var_0_0.GetCanSubmitVoteTaskList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getConfig("config_id")

	assert(pg.activity_vote[var_3_0], arg_3_1.id .. "-" .. var_3_0)

	for iter_3_0, iter_3_1 in ipairs((_.flatten(pg.activity_vote[var_3_0].task_period))) do
		local var_3_1 = getProxy(TaskProxy):getTaskById(iter_3_1)

		if var_3_1 and var_3_1:isFinish() and not var_3_1:isReceive() then
			table.insert({}, var_3_1)
		end
	end

	return {}
end

function var_0_0.SubmitTaskList(arg_4_0, arg_4_1)
	if #arg_4_1 <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		arg_4_0:sendNotification(GAME.SUBMIT_TASK, iter_4_1.id)
	end

	return
end

return var_0_0
