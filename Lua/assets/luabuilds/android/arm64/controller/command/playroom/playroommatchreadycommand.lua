local var_0_0 = class("PlayRoomMatchReadyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().arg

	getProxy(PlayRoomProxy):SetExitMatchFlag(var_1_0)
	pg.ConnectionMgr.GetInstance():Send(23019, {
		ready = var_1_0
	}, 23020, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0
