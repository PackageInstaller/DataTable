class = var_0_10000

local var_0_0 = "GuildRequestAcceptCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getData(var_1_1).memberCount
	local var_1_3 = var_4

	if var_1_2 >= var_4.getMaxMember(var_1_3) then
		pg = var_1_2

		local var_1_4 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_3

		var_1_2(var_1_4, var_1_3("guild_member_max_count"))

		return
	end

	pg = var_1_2

	local var_1_5 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 60020, {
		player_id = var_1_0
	}, 60021, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			i18n = var_2_10004

			var_2_1(var_2_0, var_2_10004("guild_new_member_join"))

			local var_2_2 = arg_1_0
			local var_2_3 = var_1.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.GUIDL_REQUEST_ACCEPT_DONE)
		elseif arg_2_0.result == 4 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10004

			var_2_5(var_2_4, var_2_10004("guild_player_in_cd_time"))
		elseif arg_2_0.result == 1 then
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10004

			var_2_7(var_2_6, var_2_10004("guild_player_already_join"))

			local var_2_8 = arg_1_0
			local var_2_9 = var_1.sendNotification

			GAME = var_2_10004

			var_2_9(var_2_8, var_2_10004.GUIDL_REQUEST_REJECT, var_1_0, true)
		else
			local var_2_11

			if arg_2_0.result == 4305 then
				pg = var_2_11

				local var_2_10 = var_2_11.TipsMgr.GetInstance()

				var_2_11 = var_2_11.ShowTips
				i18n = var_2_10004

				var_2_11(var_2_10, var_2_10004("guild_tip_grand_fleet_is_frozen"))
			else
				pg = var_2_11

				local var_2_12 = var_2_11.TipsMgr.GetInstance()
				local var_2_13 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_13(var_2_12, var_2_10004("guild_accept_erro", arg_2_0.result))
			end
		end

		local var_2_14 = var_0

		var_1.deleteRequest(var_2_14, var_1_0)

		return
	end)

	return
end

return var_0_1
