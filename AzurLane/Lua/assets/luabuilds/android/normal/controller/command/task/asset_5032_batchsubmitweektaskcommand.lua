class = var_0_10000

local var_0_0 = "BatchSubmitWeekTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.dontSendMsg

	getProxy = var_1_10006
	TaskProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.GetWeekTaskProgressInfo(var_1_3)

	if #var_1_0 <= 0 then
		return
	end

	pg = var_8

	local var_1_5 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 20108, {
		id = var_1_0
	}, 20109, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			var_2_10003 = var_1_4

			local var_2_1 = var_2.GetSubTask(var_2_10003, var_1_0[1])

			var_2_10003 = var_2.GetAward(var_2_1)
			table = var_2_1

			local var_2_2 = var_2_1.insert
			local var_2_3 = var_2_0

			Drop = var_2_10006

			var_2_2(var_2_3, var_2_10006.New({
				type = var_2_10003[1],
				id = var_2_10003[2],
				count = arg_2_0.pt
			}))

			local var_2_4 = var_1_4

			var_4.RemoveSubTasks(var_2_4, var_1_0)

			local var_2_5 = var_1_4

			var_4.AddProgress(var_2_5, arg_2_0.pt)

			ipairs = var_4

			for iter_2_0, iter_2_1 in var_4(arg_2_0.next) do
				WeekPtTask = var_2_10009
				var_2_10009 = var_2_10009.New(iter_2_1)

				local var_2_6 = var_1_4

				var_10.AddSubTask(var_2_6, var_2_10009)
			end

			if not var_1_2 then
				local var_2_7 = arg_1_0
				local var_2_8 = var_4.sendNotification

				GAME = var_6

				var_2_8(var_2_7, var_6.BATCH_SUBMIT_WEEK_TASK_DONE, {
					awards = var_2_0,
					ids = var_1_0
				})
			end

			if var_1_1 then
				var_1_1(var_2_0)
			end
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_10(var_2_9, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
