local TaskProgressUpdateCommand = class("TaskProgressUpdateCommand", pm.SimpleCommand)

function TaskProgressUpdateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	self:CheckAndSubmitVoteTask()

	return
end

function TaskProgressUpdateCommand:CheckAndSubmitVoteTask(arg_2_1)
	for iter_2_0, iter_2_1 in pairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if not iter_2_1:isEnd() then
			self:SubmitTaskList((self:GetCanSubmitVoteTaskList(iter_2_1)))
		end
	end

	return
end

function TaskProgressUpdateCommand:GetCanSubmitVoteTaskList(arg_3_1)
	local var_3_0 = arg_3_1:getConfig("config_id")

	assert(pg.activity_vote[var_3_0], arg_3_1.id .. "-" .. var_3_0)

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs((_.flatten(pg.activity_vote[var_3_0].task_period))) do
		local var_3_2 = getProxy(TaskProxy):getTaskById(iter_3_1)

		if var_3_2 and var_3_2:isFinish() and not var_3_2:isReceive() then
			table.insert(var_3_1, var_3_2)
		end
	end

	return var_3_1
end

function TaskProgressUpdateCommand:SubmitTaskList(arg_4_1)
	if #arg_4_1 <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		self:sendNotification(GAME.SUBMIT_TASK, iter_4_1.id)
	end

	return
end

return TaskProgressUpdateCommand
