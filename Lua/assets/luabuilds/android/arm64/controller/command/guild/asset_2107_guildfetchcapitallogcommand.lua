local GuildFetchCapitalLogCommand = class("GuildFetchCapitalLogCommand", pm.SimpleCommand)

function GuildFetchCapitalLogCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)

	if not var_1_1:getData() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62011, {
		type = 0
	}, 62012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1:getData()
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.inclog) do
				table.insert(var_2_1, (GuildCapitalLog.New(iter_2_1)))
			end

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.declog) do
				table.insert(var_2_1, (GuildCapitalLog.New(iter_2_3)))
			end

			for iter_2_4, iter_2_5 in ipairs(arg_2_0.otherlog) do
				table.insert(var_2_1, (GuildCapitalLog.New(iter_2_5)))
			end

			if #var_2_1 > 0 then
				var_2_0:updateCapitalLogs(var_2_1)
				var_1_1:updateGuild(var_2_0)
			end

			self:sendNotification(GAME.GUILD_FETCH_CAPITAL_LOG_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildFetchCapitalLogCommand
