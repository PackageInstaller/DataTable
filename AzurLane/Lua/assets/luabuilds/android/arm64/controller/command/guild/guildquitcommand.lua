class = var_0_10000

local var_0_0 = "GuildQuitCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 60018, {
		id = var_1_0
	}, 60019, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.exitGuild(var_2_10004)

			var_2_10004 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_2_10005

			var_2_0(var_2_10004, var_2_10005.GUILD_QUIT_DONE)

			getProxy = var_2_0
			PlayerProxy = var_2_10004

			local var_2_1 = var_2_0(var_2_10004)
			local var_2_2 = var_2.getData(var_2_1)

			var_2_10004 = var_3.setGuildWaitTime
			pg = var_2_10007

			local var_2_3 = var_2_10007.TimeMgr.GetInstance()

			var_2_10004(var_2_2, var_7.GetServerTime(var_2_3) + 0)
			var_2:updatePlayer(var_3)

			pg = var_2_10004

			local var_2_4 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_7

			var_2_10004(var_2_4, var_7("guild_quit_sucess"))
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("guild_quit_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
