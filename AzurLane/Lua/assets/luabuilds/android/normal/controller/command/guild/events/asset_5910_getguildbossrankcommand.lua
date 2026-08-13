class = var_0_10000

local var_0_0 = "GetGuildBossRankCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 61029, {
		type = 0
	}, 61030, function(arg_2_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = var_1.getRawData(var_2_0)
		local var_2_2 = {}

		ipairs = var_2_10004

		for iter_2_0, iter_2_1 in var_2_10004(arg_2_0.list) do
			local var_2_3 = var_2_1

			if var_2_1.getMemberById(var_2_3, iter_2_1.user_id) then
				table = var_2_3

				var_2_3.insert(var_2_2, {
					name = var_9.name,
					damage = iter_2_1.damage
				})
			end
		end

		var_1:UpdateBossRank(var_2_2)

		local var_2_4 = var_1
		local var_2_5 = var_1.UpdateBossRankRefreshTime

		pg = var_6

		local var_2_6 = var_6.TimeMgr.GetInstance()

		var_2_5(var_2_4, var_6.GetServerTime(var_2_6))

		if var_1_0 then
			var_1_0()
		end

		local var_2_7 = arg_1_0
		local var_2_8 = var_4.sendNotification

		GAME = var_6

		var_2_8(var_2_7, var_6.GET_GUILD_BOSS_RANK_DONE)

		return
	end)

	return
end

return var_0_1
