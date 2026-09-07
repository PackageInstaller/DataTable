local GuildRequestRejectCommand = class("GuildRequestRejectCommand", pm.SimpleCommand)

function GuildRequestRejectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = arg_1_1:getType()

	pg.ConnectionMgr.GetInstance():Send(60022, {
		player_id = var_1_0
	}, 60023, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GuildProxy):deleteRequest(var_1_0)
			self:sendNotification(GAME.GUIDL_REQUEST_REJECT_DONE)

			if not var_1_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_rejecet_apply_sucess"))
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_reject_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return GuildRequestRejectCommand
