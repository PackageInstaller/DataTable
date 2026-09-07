local GuildSelectWeeklyTaskCommand = class("GuildSelectWeeklyTaskCommand", pm.SimpleCommand)

function GuildSelectWeeklyTaskCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(GuildProxy):getRawData()

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))

		return
	end

	if var_1_2:getWeeklyTask():getState() ~= GuildTask.STATE_EMPTY then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_week_task_state_is_wrong"))

		return
	end

	if not GuildMember.IsAdministrator(var_1_2:getSelfDuty()) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commander_and_sub_op"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62013, {
		id = var_1_0.taskId
	}, 62014, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.GUILD_SELECT_TASK_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildSelectWeeklyTaskCommand
