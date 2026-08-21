local var_0_0 = class("GuildRefreshMissionCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.callback

	if not arg_1_0:ExistMission(var_1_0.id) then
		return
	end

	local var_1_3 = arg_1_0:GetMissionById(var_1_0.id)

	if not var_1_3:ShouldRefresh() and not var_1_0.force then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(61023, {
		event_tid = var_1_0.id
	}, 61024, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()
			local var_2_2 = var_2_1:GetActiveEvent():GetMissionById(var_1_1)
			local var_2_3 = arg_2_0.event_info

			if not arg_2_0.event_info or var_2_3.event_id == 0 then
				var_2_3 = GuildMission.CompleteData2FullData(arg_2_0.completed_info)
			end

			var_2_2:Flush(var_2_3, GuildConst.REFRESH_MISSION_TIME)
			var_2_0:updateGuild(var_2_1)
			arg_1_0:sendNotification(GAME.GUILD_REFRESH_MISSION_DONE, {
				id = var_2_2.id
			})
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildEvent")

			if var_1_2 then
				var_1_2()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
