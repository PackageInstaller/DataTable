class = var_0_10000

local var_0_0 = "GuildDissolveCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getData(var_1_2) then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_10007

		var_1_2(var_1_3, var_1_10007("guild_no_exist"))

		return
	end

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 60010, {
		id = var_1_1
	}, 60011, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.exitGuild(var_2_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.GUILD_DISSOLVE_DONE)

			getProxy = var_2_2
			PlayerProxy = var_2_1
			var_2_10003 = var_2_2(var_2_1)

			local var_2_3 = var_2_2.getData(var_2_10003)

			var_2_10003 = var_2.setGuildWaitTime
			pg = var_2_10005

			local var_2_4 = var_2_10005.TimeMgr.GetInstance()

			var_2_10003(var_2_3, var_5.GetServerTime(var_2_4) + 0)
			var_2_2:updatePlayer(var_2)

			pg = var_2_10003

			local var_2_5 = var_2_10003.TipsMgr.GetInstance()

			var_2_10003 = var_2_10003.ShowTips
			i18n = var_5

			var_2_10003(var_2_5, var_5("guild_dissolve_sucess"))
		else
			pg = var_2_2

			local var_2_6 = var_2_2.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_7(var_2_6, var_2_10003("guild_dissolve_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
