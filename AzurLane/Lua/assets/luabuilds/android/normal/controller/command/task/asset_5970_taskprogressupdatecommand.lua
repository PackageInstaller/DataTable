class = var_0_10000

local var_0_0 = "TaskProgressUpdateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	arg_1_0:CheckAndSubmitVoteTask()

	return
end

function var_0_1.CheckAndSubmitVoteTask(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10004

	local var_2_2 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_VOTE)

	pairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_2) do
		if not iter_2_1:isEnd() then
			local var_2_3 = arg_2_0:GetCanSubmitVoteTaskList(iter_2_1)

			arg_2_0:SubmitTaskList(var_2_3)
		end
	end

	return
end

function var_0_1.GetCanSubmitVoteTaskList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getConfig(var_3_0, "config_id")

	pg = var_3_0

	local var_3_2 = var_3_0.activity_vote[var_3_1]

	assert = var_4

	var_4(var_3_2, arg_3_1.id .. "-" .. var_3_1)

	_ = var_4

	local var_3_3 = var_4.flatten(var_3_2.task_period)
	local var_3_4 = {}

	ipairs = var_6

	for iter_3_0, iter_3_1 in var_6(var_3_3) do
		getProxy = var_1_10011
		TaskProxy = var_1_10012
		var_1_10012 = var_1_10011(var_1_10012)

		if var_1_10011.getTaskById(var_1_10012, iter_3_1) and var_1_10011:isFinish() and not var_1_10011:isReceive() then
			table = var_1_10012

			var_1_10012.insert(var_3_4, var_1_10011)
		end
	end

	return var_3_4
end

function var_0_1.SubmitTaskList(arg_4_0, arg_4_1)
	if #arg_4_1 <= 0 then
		return
	end

	pairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_1) do
		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.sendNotification

		GAME = var_1_10009

		var_4_1(var_4_0, var_1_10009.SUBMIT_TASK, iter_4_1.id)
	end

	return
end

return var_0_1
