local var_0_0 = class("GuildQuitCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(60018, {
		id = arg_1_1:getBody()
	}, 60019, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GuildProxy):exitGuild()
			arg_1_0:sendNotification(GAME.GUILD_QUIT_DONE)

			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:setGuildWaitTime(pg.TimeMgr.GetInstance():GetServerTime() + 0)
			var_2_0:updatePlayer(var_2_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_quit_sucess"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_quit_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
