local GuildCancelTechCommand = class("GuildCancelTechCommand", pm.SimpleCommand)

function GuildCancelTechCommand:execute(arg_1_1)
	local var_1_0 = getProxy(GuildProxy):getData()

	if not var_1_0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))

		return
	end

	if not var_1_0:getActiveTechnologyGroup() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_activation_tech"))

		return
	end

	local var_1_1 = var_1_0:getTechnologyGroupById(arg_1_1:getBody().id)

	if not var_1_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_tech"))

		return
	end

	if not var_1_0:CanCancelTech() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_cancel_only_once_pre_day"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62026, {
		id = var_1_1.pid
	}, 62027, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.GUILD_CANCEL_TECH_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildCancelTechCommand
