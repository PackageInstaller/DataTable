class = var_0_10000

local var_0_0 = "GuildRefreshMissionCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.force

	if not arg_1_0:ExistMission(var_1_0) then
		return
	end

	local var_1_3 = arg_1_0:GetMissionById(var_1_0)

	if not var_6.ShouldRefresh(var_1_3) and not var_1_2 then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 61023, {
		event_tid = var_1_0
	}, 61024, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)
			local var_2_1 = var_2.GetActiveEvent(var_2_0)
			local var_2_2 = var_2_10003.GetMissionById(var_2_1, var_1_0)
			local var_2_3

			if not arg_2_0.event_info or var_2_3.event_id == 0 then
				GuildMission = var_6
				var_2_3 = var_6.CompleteData2FullData(arg_2_0.completed_info)
			end

			local var_2_4 = var_2_2
			local var_2_5 = var_2_2.Flush
			local var_2_6 = var_2_3

			GuildConst = var_2_10009

			var_2_5(var_2_4, var_2_6, var_2_10009.REFRESH_MISSION_TIME)
			var_1:updateGuild(var_2)

			local var_2_7 = arg_1_0
			local var_2_8 = var_6.sendNotification

			GAME = var_8

			var_2_8(var_2_7, var_8.GUILD_REFRESH_MISSION_DONE, {
				id = var_2_2.id
			})

			pg = var_2_8

			local var_2_9 = var_2_8.ShipFlagMgr.GetInstance()

			var_6.UpdateFlagShips(var_2_9, "inGuildEvent")

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_11(var_2_10, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
