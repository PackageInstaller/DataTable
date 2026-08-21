local var_0_0 = class("GuildRequestAcceptCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = getProxy(GuildProxy):getData()

	if var_1_2.memberCount >= var_1_2:getMaxMember() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_member_max_count"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(60020, {
		player_id = arg_1_1:getBody()
	}, 60021, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_new_member_join"))
			arg_1_0:sendNotification(GAME.GUIDL_REQUEST_ACCEPT_DONE)
		elseif arg_2_0.result == 4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_player_in_cd_time"))
		elseif arg_2_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_player_already_join"))
			arg_1_0:sendNotification(GAME.GUIDL_REQUEST_REJECT, var_1_0, true)
		elseif arg_2_0.result == 4305 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tip_grand_fleet_is_frozen"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_accept_erro", arg_2_0.result))
		end

		var_1_1:deleteRequest(var_1_0)

		return
	end)

	return
end

return var_0_0
