local var_0_0 = class("GuildJoinEventCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(61031, {
		type = 0
	}, 61032, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:GetActiveEvent():IncreaseJoinCnt()
			var_2_1:getMemberById(getProxy(PlayerProxy):getRawData().id):AddLiveness(pg.guildset.operation_event_guild_active.key_value)
			var_2_0:updateGuild(var_2_1)
			arg_1_0:sendNotification(GAME.ON_GUILD_JOIN_EVENT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
