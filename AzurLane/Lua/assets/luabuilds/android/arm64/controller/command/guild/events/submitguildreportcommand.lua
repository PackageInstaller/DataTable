class = var_0_10000

local var_0_0 = "SubmitGuildReportCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).ids

	getProxy = var_1_0
	GuildProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getRawData(var_1_2)

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_4 = var_1_10006(var_1_10008)
	local var_1_5 = var_6.getRawData(var_1_4).id
	local var_1_6 = var_1_3
	local var_1_7 = var_1_3.getMemberById(var_1_6, var_1_5)
	local var_1_9

	if var_7.IsRecruit(var_1_7) then
		pg = var_1_9

		local var_1_8 = var_1_9.TipsMgr.GetInstance()

		var_1_9 = var_1_9.ShowTips
		i18n = var_1_10011

		var_1_9(var_1_8, var_1_10011("guild_duty_is_too_low"))

		return
	end

	_ = var_1_9

	if var_1_9.any(var_1_1, function(arg_2_0)
		local var_2_0 = var_0
		local var_2_1 = var_1.GetReportById(var_2_0, arg_2_0)

		return not var_1.CanSubmit(var_2_1)
	end) then
		pg = var_8

		local var_1_10 = var_8.TipsMgr.GetInstance()
		local var_1_11 = var_8.ShowTips

		i18n = var_11

		var_1_11(var_1_10, var_11("guild_get_report_failed"))

		return
	end

	local var_1_12 = var_2.callback

	pg = var_1_6

	local var_1_13 = var_1_6.ConnectionMgr.GetInstance()

	var_9.Send(var_1_13, 61019, {
		ids = var_1_1
	}, 61020, function(arg_3_0)
		local var_3_0

		if arg_3_0.result == 0 then
			PlayerConst = var_3_0
			var_3_0 = var_3_0.addTranDrop(arg_3_0.drop_list)
			ipairs = var_2_10002

			for iter_3_0, iter_3_1 in var_2_10002(var_1_1) do
				local var_3_1 = var_0
				local var_3_2 = var_7.GetReportById(var_3_1, iter_3_1)

				var_7.Submit(var_3_2)
			end

			var_2_10004 = arg_1_0

			local var_3_3 = var_2.sendNotification

			GAME = iter_3_0

			var_3_3(var_2_10004, iter_3_0.SUBMIT_GUILD_REPORT_DONE, {
				awards = var_3_0,
				list = var_1_1,
				callback = var_1_12
			})
		else
			pg = var_3_0

			local var_3_4 = var_3_0.TipsMgr.GetInstance()
			local var_3_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_3_5(var_3_4, var_2_10004[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
