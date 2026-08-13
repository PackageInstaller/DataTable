class = var_0_10000

local var_0_0 = "SubmitWeekTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	TaskProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetWeekTaskProgressInfo(var_1_2)

	if not var_5.GetSubTask(var_1_3, var_1_1) or not var_6:IsFinished() then
		return
	end

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 20106, {
		id = var_1_1
	}, 20107, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			var_2_10004 = var_0

			local var_2_1 = var_2.GetAward(var_2_10004)

			table = var_2_10003

			local var_2_2 = var_2_10003.insert
			local var_2_3 = var_2_0

			Drop = var_2_10006

			var_2_2(var_2_3, var_2_10006.Create(var_2_1))

			local var_2_4 = var_0

			var_3.AddProgress(var_2_4, var_2_1[3])

			local var_2_5 = var_0

			var_3.RemoveSubTask(var_2_5, var_1_1)

			local var_2_7

			if arg_2_0.next and arg_2_0.next.id ~= 0 then
				WeekPtTask = var_3

				local var_2_6 = var_3.New(arg_2_0.next)

				var_2_7 = var_0

				var_2_10004.AddSubTask(var_2_7, var_2_6)
			end

			local var_2_8 = arg_1_0
			local var_2_9 = var_3.sendNotification

			GAME = var_2_7

			var_2_9(var_2_8, var_2_7.SUBMIT_WEEK_TASK_DONE, {
				awards = var_2_0,
				id = var_1_1
			})
		else
			pg = var_2_0

			local var_2_10 = var_2_0.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_11(var_2_10, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
