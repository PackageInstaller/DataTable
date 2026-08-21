local var_0_0 = class("GetGuildBossRankCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg.ConnectionMgr.GetInstance():Send(61029, {
		type = 0
	}, 61030, function(arg_2_0)
		local var_2_0 = getProxy(GuildProxy)
		local var_2_1 = var_2_0:getRawData()

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.list) do
			local var_2_2 = var_2_1:getMemberById(iter_2_1.user_id)

			if var_2_2 then
				table.insert({}, {
					name = var_2_2.name,
					damage = iter_2_1.damage
				})
			end
		end

		var_2_0:UpdateBossRank({})
		var_2_0:UpdateBossRankRefreshTime(pg.TimeMgr.GetInstance():GetServerTime())

		if var_1_0 then
			var_1_0()
		end

		arg_1_0:sendNotification(GAME.GET_GUILD_BOSS_RANK_DONE)

		return
	end)

	return
end

return var_0_0
