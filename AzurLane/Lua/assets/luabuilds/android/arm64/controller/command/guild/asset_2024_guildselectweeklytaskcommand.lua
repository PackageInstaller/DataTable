class = var_0_10000

local var_0_0 = "GuildSelectWeeklyTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.num

	getProxy = var_1_10005
	GuildProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getRawData(var_1_2) then
		pg = var_1_10007

		local var_1_3 = var_1_10007.TipsMgr.GetInstance()
		local var_1_4 = var_7.ShowTips

		i18n = var_1_10010

		var_1_4(var_1_3, var_1_10010("guild_no_exist"))

		return
	end

	local var_1_5 = var_6
	local var_1_6 = var_6.getWeeklyTask(var_1_5)
	local var_1_7 = var_7.getState(var_1_6)

	GuildTask = var_1_5

	if var_1_7 ~= var_1_5.STATE_EMPTY then
		pg = var_1_7

		local var_1_8 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10011

		var_1_7(var_1_8, var_1_10011("guild_week_task_state_is_wrong"))

		return
	end

	GuildMember = var_1_7

	local var_1_9 = var_1_7.IsAdministrator
	local var_1_10 = var_6
	local var_1_12

	if not var_1_9(var_6.getSelfDuty(var_1_10)) then
		pg = var_1_12

		local var_1_11 = var_1_12.TipsMgr.GetInstance()

		var_1_12 = var_1_12.ShowTips
		i18n = var_1_10

		var_1_12(var_1_11, var_1_10("guild_commander_and_sub_op"))

		return
	end

	pg = var_1_12

	local var_1_13 = var_1_12.ConnectionMgr.GetInstance()

	var_9.Send(var_1_13, 62013, {
		id = var_1_0
	}, 62014, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.GUILD_SELECT_TASK_DONE)
		else
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
