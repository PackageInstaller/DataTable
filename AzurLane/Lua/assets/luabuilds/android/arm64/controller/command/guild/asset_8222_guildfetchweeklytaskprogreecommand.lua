class = var_0_10000

local var_0_0 = "GuildFetchWeeklyTaskProgreeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getRawData(var_1_1) then
		return
	end

	local var_1_2 = var_4

	if var_4.getWeeklyTask(var_1_2) then
		var_1_1 = var_5:getState()
		GuildTask = var_1_2

		if var_1_1 ~= var_1_2.STATE_ONGOING then
			return
		end

		pg = var_1_1

		local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

		var_6.Send(var_1_3, 62022, {
			type = 0
		}, 62023, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_0

				var_2_10004 = var_1.getRawData(var_2_0)
				var_0 = var_1.getWeeklyTask(var_2_10004)
				var_2_10004 = var_0

				local var_2_1 = var_2.getState(var_2_10004)
				local var_2_2 = var_0

				var_3.updateProgress(var_2_2, arg_2_0.progress)

				local var_2_3 = var_0

				var_3.updateGuild(var_2_3, var_1)
				var_1:setRefreshWeeklyTaskProgressTime()

				local var_2_4 = arg_1_0
				local var_2_5 = var_3.sendNotification

				GAME = var_6

				var_2_5(var_2_4, var_6.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE)

				local var_2_6 = var_0

				if var_2_1 ~= var_3.getState(var_2_6) then
					local var_2_7 = arg_1_0

					var_2_10004 = var_2_10004.sendNotification
					GAME = var_2_10007

					var_2_10004(var_2_7, var_2_10007.GUILD_REFRESH_CAPITAL)
				end
			else
				pg = var_1

				local var_2_8 = var_1.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_9(var_2_8, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
