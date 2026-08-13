class = var_0_10000

local var_0_0 = "GuildFetchCapitalLogCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getData(var_1_1) then
		pg = var_1_10005

		local var_1_2 = var_1_10005.TipsMgr.GetInstance()

		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10008

		var_1_10005(var_1_2, var_1_10008("guild_no_exist"))

		return
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 62011, {
		type = 0
	}, 62012, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getData(var_2_0)

			local var_2_2 = {}

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(arg_2_0.inclog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_1)
				table = var_2_10009

				var_2_10009.insert(var_2_2, var_2_10008)
			end

			ipairs = var_3

			for iter_2_2, iter_2_3 in var_3(arg_2_0.declog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_3)
				table = var_2_10009

				var_2_10009.insert(var_2_2, var_2_10008)
			end

			ipairs = var_3

			for iter_2_4, iter_2_5 in var_3(arg_2_0.otherlog) do
				GuildCapitalLog = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_5)
				table = var_2_10009

				var_2_10009.insert(var_2_2, var_2_10008)
			end

			local var_2_3 = #var_2_2

			if 0 < var_2_3 then
				var_2_1:updateCapitalLogs(var_2_2)

				local var_2_4 = var_0

				var_3.updateGuild(var_2_4, var_2_1)
			end

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = iter_2_4

			var_2_6(var_2_5, iter_2_4.GUILD_FETCH_CAPITAL_LOG_DONE)
		else
			pg = var_2_1

			local var_2_7 = var_2_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_8(var_2_7, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
