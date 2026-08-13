class = var_0_10000

local var_0_0 = "CreateNewPlayerCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().nickname
	local var_1_1 = var_2.shipId

	if var_1_0 == "" then
		pg = var_1_10005

		local var_1_2 = var_1_10005.TipsMgr.GetInstance()

		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10008

		var_1_10005(var_1_2, var_1_10008("login_createNewPlayer_error_nameNull"))
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()
	local var_1_4 = var_5.Send
	local var_1_5 = 10024
	local var_1_6 = {
		nick_name = var_1_0,
		ship_id = var_1_1
	}

	pg = var_1_10010

	local var_1_7 = var_1_10010.SdkMgr.GetInstance()

	var_1_6.device_id = var_10.GetDeviceId(var_1_7)

	var_1_4(var_1_3, var_1_5, var_1_6, 10025, function(arg_2_0)
		if arg_2_0.result == 0 then
			print = var_1

			var_1("created new player: " .. arg_2_0.user_id)

			pg = var_1

			local var_2_0 = var_1.TrackerMgr.GetInstance()
			local var_2_1 = var_1.Tracking

			TRACKING_ROLE_CREATE = var_2_10004

			var_2_1(var_2_0, var_2_10004, nil, arg_2_0.user_id)

			getProxy = var_2_1
			SettingsProxy = var_2_0
			var_2_10004 = var_2_1(var_2_0)

			var_1.SetSelectedShipId(var_2_10004, var_1_1)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.CREATE_NEW_PLAYER_DONE, arg_2_0.user_id)

			pg = var_2_2
			var_2_10004 = var_2_2.TipsMgr.GetInstance()

			local var_2_3 = var_2.ShowTips

			i18n = var_5

			var_2_3(var_2_10004, var_5("create_player_success"))
		elseif arg_2_0.result == 6 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10004

			var_2_5(var_2_4, var_2_10004("login_createNewPlayer_full"))
		else
			local var_2_7

			if arg_2_0.result == 18 then
				pg = var_2_7

				local var_2_6 = var_2_7.TipsMgr.GetInstance()

				var_2_7 = var_2_7.ShowTips
				i18n = var_2_10004

				var_2_7(var_2_6, var_2_10004("system_database_busy"))
			else
				pg = var_2_7

				local var_2_8 = var_2_7.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_9(var_2_8, var_2_10004[arg_2_0.result])
			end
		end

		return
	end, false)

	return
end

return var_0_1
