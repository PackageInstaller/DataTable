class = var_0_10000

local var_0_0 = "GetGuildBossInfoCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

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
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			var_2_10006 = var_2.GetActiveEvent(var_2_0)

			local var_2_1 = var_2_10003.GetBossMission(var_2_10006)

			var_2_10004.Flush(var_2_1, arg_2_0.boss_event)
			var_1:updateGuild(var_2)

			local var_2_2 = var_1
			local var_2_3 = var_1.SetRefreshBossTime

			pg = var_8

			local var_2_4 = var_8.TimeMgr.GetInstance()

			var_2_3(var_2_2, var_8.GetServerTime(var_2_4))

			local var_2_5 = arg_1_0
			local var_2_6 = var_5.sendNotification

			GAME = var_8

			var_2_6(var_2_5, var_8.GUILD_GET_BOSS_INFO_DONE)
		elseif arg_2_0.result == 20 then
			getProxy = var_1
			GuildProxy = var_2_10003

			local var_2_7 = var_1(var_2_10003)

			var_2_10004 = var_1.getData(var_2_7)

			local var_2_8 = var_1.GetActiveEvent(var_2_10004)
			local var_2_9 = false

			if var_2_8 then
				var_2_10006 = var_2_8

				var_2_8.Deactivate(var_2_10006)

				var_2_9 = true
			end

			getProxy = var_2_10004
			GuildProxy = var_2_10006

			local var_2_10 = var_2_10004(var_2_10006)

			var_2_10004.updateGuild(var_2_10, var_1)

			if var_2_9 then
				pg = var_2_10004

				local var_2_11 = var_2_10004.ShipFlagMgr.GetInstance()

				var_2_10004.ClearShipsFlag(var_2_11, "inGuildEvent")

				pg = var_2_10004

				local var_2_12 = var_2_10004.ShipFlagMgr.GetInstance()

				var_2_10004.ClearShipsFlag(var_2_12, "inGuildBossEvent")
			end

			local var_2_13 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_13, var_7.GUILD_END_BATTLE)
		else
			pg = var_1

			local var_2_14 = var_1.TipsMgr.GetInstance()
			local var_2_15 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_15(var_2_14, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
