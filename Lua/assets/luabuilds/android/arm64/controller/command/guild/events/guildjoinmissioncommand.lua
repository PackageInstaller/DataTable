local var_0_0 = class("GuildJoinMissionCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.shipIds

	if not var_1_0.id or #var_1_0.shipIds == 0 then
		return
	end

	if not arg_1_0:CanFormationMission(var_1_0.id) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(61007, {
		event_tid = var_1_0.id,
		ship_ids = var_1_0.shipIds
	}, 61008, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()
			local var_2_2 = var_2_1:GetActiveEvent():GetMissionById(var_1_1)

			var_2_2:UpdateFleet(var_2_2:GetCanFormationIndex(), var_1_2)
			var_2_2:UpdateFormationTime(pg.TimeMgr.GetInstance():GetServerTime())
			var_2_0:updateGuild(var_2_1)
			arg_1_0:sendNotification(GAME.GUILD_JOIN_MISSION_DONE, {
				id = var_1_1
			})
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildEvent")
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
