local var_0_0 = class("InstagramFetchCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy)
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 6,
		activity_id = var_1_0.activity_id,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0 = 1, math.floor(#arg_2_0.number) do
				var_1_2.data1_list[iter_2_0] = arg_2_0.number[iter_2_0]
			end

			var_1_1:RegisterRequestTime(var_1_0.activity_id, pg.TimeMgr.GetInstance():GetServerTime())
			var_1_1:updateActivity(var_1_2)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
