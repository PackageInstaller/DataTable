local var_0_0 = class("ActivityBeatMonsterNianCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_2 or var_1_2:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		activity_id = var_1_0.activity_id,
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2.data2 = var_1_2.data2 + 1
			var_1_2.data3 = arg_2_0.number[1]

			if var_1_2:GetDataConfig("hp") - var_1_2.data3 <= 0 then
				var_1_2.data1 = 1
			end

			getProxy(ActivityProxy):updateActivity(var_1_2)

			if var_1_1 then
				var_1_1((PlayerConst.addTranDrop(arg_2_0.award_list)))
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
