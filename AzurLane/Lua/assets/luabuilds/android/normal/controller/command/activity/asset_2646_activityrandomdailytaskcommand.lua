class = var_0_10000

local var_0_0 = "ActivityRandomDailyTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getActivityById(var_1_2, var_1_1.activity_id) or var_3:isEnd() then
		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 11202, {
		activity_id = var_1_1.activity_id,
		cmd = var_1_1.cmd,
		arg1 = var_1_1.arg1,
		arg2 = var_1_1.arg2,
		arg_list = {},
		kvargs1 = var_1_1.kvargs1
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_1.cmd
			ActivityConst = var_2_10002

			if var_2_0 == var_2_10002.RANDOM_DAILY_TASK_OP_RANDOM then
				pg = var_2_0

				local var_2_1 = var_2_0.TimeMgr.GetInstance()

				var_2_0 = var_2_0.GetServerTime(var_2_1)

				local var_2_2 = var_0

				var_2_2.data1 = var_2_0
				getProxy = var_2_2
				ActivityProxy = var_2_10003
				var_2_10003 = var_2_2(var_2_10003)

				var_2.updateActivity(var_2_10003, var_0)
			end
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
