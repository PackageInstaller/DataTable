class = var_0_10000

local var_0_0 = "GuildJoinMissionCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.shipIds

	if not var_1_0 or #var_1_1 == 0 then
		return
	end

	if not arg_1_0:CanFormationMission(var_1_0) then
		return
	end

	pg = var_5

	local var_1_2 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 61007, {
		event_tid = var_1_0,
		ship_ids = var_1_1
	}, 61008, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)
			local var_2_1 = var_2.GetActiveEvent(var_2_0)
			local var_2_2 = var_3.GetMissionById(var_2_1, var_1_0)
			local var_2_3 = var_2_10004.GetCanFormationIndex(var_2_2)

			var_2_10004:UpdateFleet(var_2_3, var_1_1)

			local var_2_4 = var_2_10004
			local var_2_5 = var_2_10004.UpdateFormationTime

			pg = var_9

			local var_2_6 = var_9.TimeMgr.GetInstance()

			var_2_5(var_2_4, var_9.GetServerTime(var_2_6))
			var_1:updateGuild(var_2)

			local var_2_7 = arg_1_0
			local var_2_8 = var_6.sendNotification

			GAME = var_9

			var_2_8(var_2_7, var_9.GUILD_JOIN_MISSION_DONE, {
				id = var_1_0
			})

			pg = var_2_8

			local var_2_9 = var_2_8.ShipFlagMgr.GetInstance()

			var_6.UpdateFlagShips(var_2_9, "inGuildEvent")
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_11(var_2_10, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
