local var_0_0 = class("EducateResetCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27029, {
		type = 1
	}, 27030, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):Reset(function()
				arg_1_0:sendNotification(GAME.EDUCATE_REFRESH_DONE)

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate reset error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
