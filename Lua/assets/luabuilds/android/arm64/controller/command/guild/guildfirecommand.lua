local var_0_0 = class("GuildFireCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = getProxy(GuildProxy):getData()

	if var_1_2:getDutyByMemberId(getProxy(PlayerProxy):getData().id) >= var_1_2:getDutyByMemberId(var_1_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_fire_duty_limit"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(60014, {
		player_id = var_1_0
	}, 60015, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1:getData()
			local var_2_1 = var_1_1:getData()

			var_2_1:deleteMember(var_1_0)
			var_1_1:updateGuild(var_2_1)
			arg_1_0:sendNotification(GAME.GUILD_FIRE_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_fire_succeed"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_fire_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
