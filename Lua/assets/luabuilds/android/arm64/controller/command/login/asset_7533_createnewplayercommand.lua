local CreateNewPlayerCommand = class("CreateNewPlayerCommand", pm.SimpleCommand)

function CreateNewPlayerCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId

	if var_1_0.nickname == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("login_createNewPlayer_error_nameNull"))
	end

	local var_1_2 = pg.ConnectionMgr.GetInstance()
	local var_1_3 = {
		nick_name = var_1_0.nickname,
		ship_id = var_1_0.shipId
	}

	var_1_3.device_id = pg.SdkMgr.GetInstance():GetDeviceId()

	var_1_2:Send(10024, var_1_3, 10025, function(arg_2_0)
		if arg_2_0.result == 0 then
			print("created new player: " .. arg_2_0.user_id)
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_ROLE_CREATE, nil, arg_2_0.user_id)
			getProxy(SettingsProxy):SetSelectedShipId(var_1_1)
			self:sendNotification(GAME.CREATE_NEW_PLAYER_DONE, arg_2_0.user_id)
			pg.TipsMgr.GetInstance():ShowTips(i18n("create_player_success"))
		elseif arg_2_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_createNewPlayer_full"))
		elseif arg_2_0.result == 18 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("system_database_busy"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result])
		end

		return
	end, false)

	return
end

return CreateNewPlayerCommand
