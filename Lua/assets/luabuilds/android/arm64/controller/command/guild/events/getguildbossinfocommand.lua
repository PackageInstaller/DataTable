local var_0_0 = class("GetGuildBossInfoCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not arg_1_0:ExistActiveEvent() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(61027, {
		type = 0
	}, 61028, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:GetActiveEvent():GetBossMission():Flush(arg_2_0.boss_event)
			var_2_0:updateGuild(var_2_1)
			var_2_0:SetRefreshBossTime(pg.TimeMgr.GetInstance():GetServerTime())
			arg_1_0:sendNotification(GAME.GUILD_GET_BOSS_INFO_DONE)
		elseif arg_2_0.result == 20 then
			local var_2_2 = getProxy(GuildProxy):getData()
			local var_2_3 = var_2_2:GetActiveEvent()
			local var_2_4 = false

			if var_2_3 then
				var_2_3:Deactivate()

				var_2_4 = true
			end

			getProxy(GuildProxy):updateGuild(var_2_2)

			if var_2_4 then
				pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildEvent")
				pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildBossEvent")
			end

			arg_1_0:sendNotification(GAME.GUILD_END_BATTLE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
