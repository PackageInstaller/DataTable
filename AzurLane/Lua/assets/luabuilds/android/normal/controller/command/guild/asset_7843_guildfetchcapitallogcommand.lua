class = var_0_10000

local var_0_0 = "GuildFetchCapitalLogCommand"

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

	var_5.Send(var_1_4, 62011, {
		type = 0
	}, 62012, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getData(var_2_0)

			local var_2_2 = {}

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.inclog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_1)
				table = var_9

				var_9.insert(var_2_2, var_2_10008)
			end

			ipairs = var_2_10003

			for iter_2_2, iter_2_3 in var_2_10003(arg_2_0.declog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_3)
				table = var_9

				var_9.insert(var_2_2, var_2_10008)
			end

			ipairs = var_2_10003

			for iter_2_4, iter_2_5 in var_2_10003(arg_2_0.otherlog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_5)
				table = var_9

				var_9.insert(var_2_2, var_2_10008)
			end

			if #var_2_2 > 0 then
				var_2_1:updateCapitalLogs(var_2_2)

				local var_2_3 = var_0

				var_2_10003.updateGuild(var_2_3, var_2_1)
			end

			local var_2_4 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_4, var_5.GUILD_FETCH_CAPITAL_LOG_DONE)
		else
			pg = var_2_1

			local var_2_5 = var_2_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
