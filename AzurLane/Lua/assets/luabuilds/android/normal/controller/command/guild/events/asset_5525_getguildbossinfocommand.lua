class = var_0_10000

local var_0_0 = "GetGuildBossInfoCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not arg_1_0:ExistActiveEvent() then
		return
	end

	pg = var_3

	local var_1_1 = var_3.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 61027, {
		type = 0
	}, 61028, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)
			var_2_10004 = var_1.getData(var_2_10003)
			var_2_10005 = var_2_10002.GetActiveEvent(var_2_10004)

			local var_2_0 = var_2_10003.GetBossMission(var_2_10005)

			var_2_10004.Flush(var_2_0, arg_2_0.boss_event)
			var_1:updateGuild(var_2_10002)

			local var_2_1 = var_1

			var_2_10005 = var_1.SetRefreshBossTime
			pg = var_7

			local var_2_2 = var_7.TimeMgr.GetInstance()

			var_2_10005(var_2_1, var_7.GetServerTime(var_2_2))

			local var_2_3 = arg_1_0

			var_2_10005 = var_2_10005.sendNotification
			GAME = var_7

			var_2_10005(var_2_3, var_7.GUILD_GET_BOSS_INFO_DONE)
		elseif arg_2_0.result == 20 then
			getProxy = var_1
			GuildProxy = var_2_10002

			local var_2_4 = var_1(var_2_10002)

			var_2_10003 = var_1.getData(var_2_4)

			local var_2_5 = var_1.GetActiveEvent(var_2_10003)

			var_2_10003 = false

			if var_2_5 then
				var_2_10005 = var_2_5

				var_2_5.Deactivate(var_2_10005)

				var_2_10003 = true
			end

			getProxy = var_2_10004
			GuildProxy = var_2_10005

			local var_2_6 = var_2_10004(var_2_10005)

			var_4.updateGuild(var_2_6, var_1)

			if var_2_10003 then
				pg = var_4

				local var_2_7 = var_4.ShipFlagMgr.GetInstance()

				var_4.ClearShipsFlag(var_2_7, "inGuildEvent")

				pg = var_4

				local var_2_8 = var_4.ShipFlagMgr.GetInstance()

				var_4.ClearShipsFlag(var_2_8, "inGuildBossEvent")
			end

			local var_2_9 = arg_1_0
			local var_2_10 = var_4.sendNotification

			GAME = var_6

			var_2_10(var_2_9, var_6.GUILD_END_BATTLE)
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_12(var_2_11, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
