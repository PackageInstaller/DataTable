class = var_0_10000

local var_0_0 = "GuildFetchWeeklyTaskProgreeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getRawData(var_1_2) then
		return
	end

	local var_1_3 = var_4

	if var_4.getWeeklyTask(var_1_3) then
		local var_1_4 = var_5

		var_1_3 = var_5.getState(var_1_4)
		GuildTask = var_1_4

		if var_1_3 ~= var_1_4.STATE_ONGOING then
			return
		end

		pg = var_1_3

		local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

		var_6.Send(var_1_5, 62022, {
			type = 0
		}, 62023, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_0

				var_2_10003 = var_1.getRawData(var_2_0)
				var_0 = var_1.getWeeklyTask(var_2_10003)
				var_2_10003 = var_0

				local var_2_1 = var_2.getState(var_2_10003)
				local var_2_2 = var_0

				var_2_10003.updateProgress(var_2_2, arg_2_0.progress)

				local var_2_3 = var_0

				var_2_10003.updateGuild(var_2_3, var_1)
				var_1:setRefreshWeeklyTaskProgressTime()

				local var_2_4 = arg_1_0

				var_2_10003 = var_2_10003.sendNotification
				GAME = var_5

				var_2_10003(var_2_4, var_5.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE)

				local var_2_5 = var_0

				if var_2_1 ~= var_2_10003.getState(var_2_5) then
					local var_2_6 = arg_1_0
					local var_2_7 = var_4.sendNotification

					GAME = var_2_10006

					var_2_7(var_2_6, var_2_10006.GUILD_REFRESH_CAPITAL)
				end
			else
				pg = var_1

				local var_2_8 = var_1.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
