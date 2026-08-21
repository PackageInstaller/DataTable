local var_0_0 = class("SelectDorm3dEnterCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(28017, {
		type = 0
	}, 28018, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.m02:sendNotification(GAME.SELECT_DORM_ENTER_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
