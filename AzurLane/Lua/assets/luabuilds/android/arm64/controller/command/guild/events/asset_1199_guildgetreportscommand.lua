class = var_0_10000

local var_0_0 = "GuildGetReportsCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	GuildProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3

	if not var_4.ShouldRequestReport(var_1_2) then
		var_1_2 = var_4
		var_1_3 = var_4.GetReports(var_1_2)

		if var_1_1 then
			var_1_1(var_1_3)
		end

		return
	end

	getProxy = var_1_3
	GuildProxy = var_1_2

	local var_1_4 = var_1_3(var_1_2)
	local var_1_5 = var_5.GetMaxReportId(var_1_4)

	pg = var_1_10006

	local var_1_6 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_6, 61017, {
		index = var_1_5
	}, 61018, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.reports) do
			local var_2_1
			local var_2_2 = iter_2_1.event_type

			GuildConst = var_2_10009

			if var_2_2 == var_2_10009.REPORT_TYPE_BOSS then
				GuildBossReport = var_2_2
				var_2_1 = var_2_2.New(iter_2_1)
			else
				GuildReport = var_2_2
				var_2_1 = var_2_2.New(iter_2_1)
			end

			local var_2_3 = var_0

			var_8.AddReport(var_2_3, var_2_1)
		end

		if var_1_1 then
			local var_2_4 = var_0
			local var_2_5 = var_2.GetReports(var_2_4)

			var_1_1(var_2_5)
		end

		local var_2_6 = arg_1_0
		local var_2_7 = var_2.sendNotification

		GAME = iter_2_0

		var_2_7(var_2_6, iter_2_0.GET_GUILD_REPORT_DONE)

		return
	end)

	return
end

return var_0_1
