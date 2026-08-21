local var_0_0 = class("IslandGetCardDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21326, {
		user_id = var_1_0.userId
	}, 21327, function(arg_2_0)
		existCall(var_1_1, (IslandCard.New(var_0, arg_2_0)))

		return
	end)

	return
end

return var_0_0
