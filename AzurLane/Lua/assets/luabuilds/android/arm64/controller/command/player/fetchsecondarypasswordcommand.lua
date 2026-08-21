local var_0_0 = class("FetchSecondaryPasswordCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.UIMgr.GetInstance():LoadingOn()
	pg.ConnectionMgr.GetInstance():Send(11603, {
		type = 1
	}, 11604, function(arg_2_0)
		pg.UIMgr.GetInstance():LoadingOff()
		getProxy(SecondaryPWDProxy):SetData(arg_2_0)
		arg_1_0:sendNotification(GAME.FETCH_PASSWORD_STATE_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_0
