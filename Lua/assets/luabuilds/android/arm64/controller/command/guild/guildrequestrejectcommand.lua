local var_0_0 = class("GuildRequestRejectCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getType()

	pg.ConnectionMgr.GetInstance():Send(60022, {
		player_id = arg_1_1:getBody()
	}, 60023, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GuildProxy):deleteRequest(var_0)
			arg_1_0:sendNotification(GAME.GUIDL_REQUEST_REJECT_DONE)

			if not var_1_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_rejecet_apply_sucess"))
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_reject_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
