local var_0_0 = class("SetSecondaryPasswordSettingsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.UIMgr.GetInstance():LoadingOn()
	pg.ConnectionMgr.GetInstance():Send(11607, {
		password = var_1_0.pwd,
		system_list = var_1_0.settings
	}, 11608, function(arg_2_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_2_0.result == 0 then
			getProxy(SecondaryPWDProxy):OnSettingsChange(var_1_0)
		end

		arg_1_0:sendNotification(GAME.SET_PASSWORD_SETTINGS_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_0
