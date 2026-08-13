class = var_0_10000

local var_0_0 = "GuildFetchCapitalCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 62024, {
		type = 0
	}, 62025, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			var_2.setRefreshCaptialTime(var_2_0)
			var_2:updateCapital(arg_2_0.capital)
			var_1:updateGuild(var_2)

			local var_2_1 = arg_1_0
			local var_2_2 = var_3.sendNotification

			GAME = var_6

			var_2_2(var_2_1, var_6.GUILD_REFRESH_CAPITAL_DONE)
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
