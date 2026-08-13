class = var_0_10000

local var_0_0 = "GuildImpeachCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getData(var_1_1)
	local var_1_4

	if var_4.inKickTime(var_1_2) then
		pg = var_1_4

		local var_1_3 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10008

		var_1_4(var_1_3, var_1_10008("guild_commder_in_impeach_time"))

		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 60016, {
		player_id = var_1_0
	}, 60017, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			pg = var_2_10003

			local var_2_1 = var_2_10003.TimeMgr.GetInstance()
			local var_2_2 = var_3.GetServerTime(var_2_1) + 0

			var_2_0:setkickLeaderTime(var_2_2)
			var_1:updateGuild(var_2_0)

			pg = var_2_10004

			local var_2_3 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_7

			var_2_10004(var_2_3, var_7("guild_impeach_sucess"))

			local var_2_4 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_4, var_7.GUILD_IMPEACH_DONE)
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("guild_impeach_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
