class = var_0_10000

local var_0_0 = "SubmitWeekTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	TaskProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetWeekTaskProgressInfo(var_1_1)

	if not var_5.GetSubTask(var_1_2, var_1_0) or not var_6:IsFinished() then
		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 20106, {
		id = var_1_0
	}, 20107, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			var_2_10003 = var_0

			local var_2_1 = var_2.GetAward(var_2_10003)

			table = var_2_10003
			var_2_10003 = var_2_10003.insert

			local var_2_2 = var_2_0

			Drop = var_2_10005

			var_2_10003(var_2_2, var_2_10005.Create(var_2_1))

			local var_2_3 = var_0

			var_2_10003.AddProgress(var_2_3, var_2_1[3])

			local var_2_4 = var_0

			var_2_10003.RemoveSubTask(var_2_4, var_1_0)

			local var_2_5

			if arg_2_0.next and arg_2_0.next.id ~= 0 then
				WeekPtTask = var_2_10003
				var_2_10003 = var_2_10003.New(arg_2_0.next)
				var_2_5 = var_0

				var_4.AddSubTask(var_2_5, var_2_10003)
			end

			local var_2_6 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_5

			var_2_10003(var_2_6, var_2_5.SUBMIT_WEEK_TASK_DONE, {
				awards = var_2_0,
				id = var_1_0
			})
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_8(var_2_7, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
