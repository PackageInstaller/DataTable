class = var_0_10000

local var_0_0 = "GuildQuitCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 60018, {
		id = var_1_1
	}, 60019, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			var_1.exitGuild(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_2_10004

			var_2_0(var_2_10003, var_2_10004.GUILD_QUIT_DONE)

			getProxy = var_2_0
			PlayerProxy = var_2_10003

			local var_2_1 = var_2_0(var_2_10003)
			local var_2_2 = var_2.getData(var_2_1)
			local var_2_3 = var_2_10003.setGuildWaitTime

			pg = var_2_10006

			local var_2_4 = var_2_10006.TimeMgr.GetInstance()

			var_2_3(var_2_2, var_6.GetServerTime(var_2_4) + 0)
			var_2:updatePlayer(var_2_10003)

			pg = var_4

			local var_2_5 = var_4.TipsMgr.GetInstance()
			local var_2_6 = var_4.ShowTips

			i18n = var_6

			var_2_6(var_2_5, var_6("guild_quit_sucess"))
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_8(var_2_7, var_2_10003("guild_quit_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
