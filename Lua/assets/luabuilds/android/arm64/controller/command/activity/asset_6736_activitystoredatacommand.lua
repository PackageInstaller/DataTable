local ActivityStoreDataCommand = class("ActivityStoreDataCommand", pm.SimpleCommand)

function ActivityStoreDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_2 or var_1_2:isEnd() then
		return
	end

	local var_1_3 = var_1_0.intValue or 0
	local var_1_4 = var_1_0.strValue or ""

	pg.ConnectionMgr.GetInstance():Send(26160, {
		act_id = var_1_0.activity_id,
		int_value = var_1_3,
		str_value = var_1_4
	}, 26161, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2.data1 = var_1_3
			var_1_2.str_data1 = var_1_4

			getProxy(ActivityProxy):updateActivity(var_1_2)

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActivityStoreDataCommand
