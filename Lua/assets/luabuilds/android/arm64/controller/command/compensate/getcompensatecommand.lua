local var_0_0 = class("GetCompensateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg.ConnectionMgr.GetInstance():Send(30102, {
		type = 0
	}, 30103, function(arg_2_0)
		getProxy(CompensateProxy):RefreshRewardList((underscore.map(arg_2_0.time_reward_list, function(arg_3_0)
			return CompensateData.New(arg_3_0)
		end)))
		existCall(var_1_0)

		return
	end)

	return
end

return var_0_0
