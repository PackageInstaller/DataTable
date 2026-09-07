local GuildFetchWeeklyTaskProgreeCommand = class("GuildFetchWeeklyTaskProgreeCommand", pm.SimpleCommand)

function GuildFetchWeeklyTaskProgreeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = var_1_1:getRawData()

	if not var_1_2 then
		return
	end

	local var_1_3 = var_1_2:getWeeklyTask()

	if not var_1_3 or var_1_3:getState() ~= GuildTask.STATE_ONGOING then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(62022, {
		type = 0
	}, 62023, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1:getRawData()

			var_1_3 = var_2_0:getWeeklyTask()

			var_1_3:updateProgress(arg_2_0.progress)
			var_1_1:updateGuild(var_2_0)
			var_2_0:setRefreshWeeklyTaskProgressTime()
			self:sendNotification(GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE)

			if var_1_3:getState() ~= var_1_3:getState() then
				self:sendNotification(GAME.GUILD_REFRESH_CAPITAL)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildFetchWeeklyTaskProgreeCommand
