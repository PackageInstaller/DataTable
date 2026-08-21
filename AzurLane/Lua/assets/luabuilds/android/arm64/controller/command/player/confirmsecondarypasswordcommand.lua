local var_0_0 = class("ConfirmSecondaryPasswordCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.UIMgr.GetInstance():LoadingOn()
	pg.ConnectionMgr.GetInstance():Send(11609, {
		password = arg_1_1:getBody().pwd
	}, 11610, function(arg_2_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(SecondaryPWDProxy):getRawData()

			var_2_0.state = 2
			var_2_0.fail_cd = nil
			var_2_0.fail_count = 0
		end

		arg_1_0:sendNotification(GAME.CONFIRM_PASSWORD_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_0
