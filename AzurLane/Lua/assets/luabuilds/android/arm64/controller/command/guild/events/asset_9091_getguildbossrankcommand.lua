class = var_0_10000

local var_0_0 = "GetGuildBossRankCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 61029, {
		type = 0
	}, 61030, function(arg_2_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getRawData(var_2_0)
		local var_2_2 = {}

		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.list) do
			if var_2_1:getMemberById(iter_2_1.user_id) then
				table = var_2_10010

				var_2_10010.insert(var_2_2, {
					name = var_9.name,
					damage = iter_2_1.damage
				})
			end
		end

		var_1:UpdateBossRank(var_2_2)

		local var_2_3 = var_1
		local var_2_4 = var_1.UpdateBossRankRefreshTime

		pg = var_7

		local var_2_5 = var_7.TimeMgr.GetInstance()

		var_2_4(var_2_3, var_7.GetServerTime(var_2_5))

		if var_1_1 then
			var_1_1()
		end

		local var_2_6 = arg_1_0
		local var_2_7 = var_4.sendNotification

		GAME = var_7

		var_2_7(var_2_6, var_7.GET_GUILD_BOSS_RANK_DONE)

		return
	end)

	return
end

return var_0_1
