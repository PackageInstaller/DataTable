local GuildImpeachCommand = class("GuildImpeachCommand", pm.SimpleCommand)

function GuildImpeachCommand:execute(arg_1_1)
	if getProxy(GuildProxy):getData():inKickTime() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commder_in_impeach_time"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(60016, {
		player_id = arg_1_1:getBody()
	}, 60017, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:setkickLeaderTime(pg.TimeMgr.GetInstance():GetServerTime() + 0)
			var_2_0:updateGuild(var_2_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_impeach_sucess"))
			self:sendNotification(GAME.GUILD_IMPEACH_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_impeach_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return GuildImpeachCommand
