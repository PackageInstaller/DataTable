local var_0_0 = class("ActivityRandomDailyTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		activity_id = var_1_0.activity_id,
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg_list = {},
		kvargs1 = var_1_0.kvargs1
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_0.cmd == ActivityConst.RANDOM_DAILY_TASK_OP_RANDOM then
				var_1_1.data1 = pg.TimeMgr.GetInstance():GetServerTime()

				getProxy(ActivityProxy):updateActivity(var_1_1)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
