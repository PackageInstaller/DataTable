local var_0_0 = class("SetSecondaryPasswordCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.UIMgr.GetInstance():LoadingOn()
	pg.ConnectionMgr.GetInstance():Send(11605, {
		password = var_1_0.pwd,
		notice = var_1_0.tip,
		system_list = var_1_0.settings
	}, 11606, function(arg_2_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_2_0.result == 0 then
			getProxy(SecondaryPWDProxy):OnFirstSet(var_1_0)
		end

		arg_1_0:sendNotification(GAME.SET_PASSWORD_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_0
