local var_0_0 = class("CheaterMarkCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(10994, {
		type = arg_1_1:getBody().reason
	}, 10995, function(arg_2_0)
		if var_0 ~= CC_TYPE_99 and var_0 ~= CC_TYPE_100 then
			pg.m02:sendNotification(GAME.LOGOUT, {
				code = 7
			})
		end

		return
	end)

	return
end

return var_0_0
