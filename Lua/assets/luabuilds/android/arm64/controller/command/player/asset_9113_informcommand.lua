local InformCommand = class("InformCommand", pm.SimpleCommand)

function InformCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.playerId
	local var_1_2 = var_1_0.content

	if not var_1_0.playerId or not var_1_0.info or not var_1_0.content then
		return
	end

	if getProxy(PlayerProxy):getRawData().level < 20 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("inform_level_limit"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50111, {
		id = var_1_0.playerId,
		info = var_1_0.info,
		content = var_1_0.content
	}, 50112, function(arg_2_0)
		if arg_2_0.result == 0 then
			table.insert(getProxy(ChatProxy).informs, var_1_1 .. var_1_2)
			pg.TipsMgr.GetInstance():ShowTips(i18n("inform_sueecss"))
			self:sendNotification(GAME.INFORM_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("inform_failed"))
		end

		return
	end)

	return
end

return InformCommand
