local ChangeRandomFlagShipModeCommand = class("ChangeRandomFlagShipModeCommand", pm.SimpleCommand)

function ChangeRandomFlagShipModeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode

	pg.ConnectionMgr.GetInstance():Send(12206, {
		flag = var_1_0
	}, 12207, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PlayerProxy):getRawData():UpdateRandomFlagShipMode(var_1_0)
			self:sendNotification(GAME.CHANGE_RANDOM_SHIP_MODE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ChangeRandomFlagShipModeCommand
