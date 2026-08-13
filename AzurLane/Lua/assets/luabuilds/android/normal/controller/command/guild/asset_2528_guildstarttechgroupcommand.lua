class = var_0_10000

local var_0_0 = "GuildStartTechGroupCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getData(var_1_1) then
		pg = var_1_1

		local var_1_2 = var_1_1.TipsMgr.GetInstance()
		local var_1_3 = var_6.ShowTips

		i18n = var_1_10008

		var_1_3(var_1_2, var_1_10008("guild_no_exist"))

		return
	end

	if not var_5:CanCancelTech() then
		pg = var_6

		local var_1_4 = var_6.TipsMgr.GetInstance()
		local var_1_5 = var_6.ShowTips

		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("guild_cancel_only_once_pre_day"))

		return
	end

	local var_1_6 = var_5

	if not var_5.getTechnologyGroupById(var_1_6, var_1_0) then
		pg = var_1_6

		local var_1_7 = var_1_6.TipsMgr.GetInstance()
		local var_1_8 = var_7.ShowTips

		i18n = var_1_10009

		var_1_8(var_1_7, var_1_10009("guild_not_exist_tech"))

		return
	end

	local var_1_10

	if var_6:isMaxLevel() then
		pg = var_1_10

		local var_1_9 = var_1_10.TipsMgr.GetInstance()

		var_1_10 = var_1_10.ShowTips
		i18n = var_1_10009

		var_1_10(var_1_9, var_1_10009("guild_tech_is_max_level"))

		return
	end

	pg = var_1_10

	local var_1_11 = var_1_10.ConnectionMgr.GetInstance()

	var_7.Send(var_1_11, 62020, {
		id = var_6.pid
	}, 62021, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.GUILD_START_TECH_TASK_DONE)
		else
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
