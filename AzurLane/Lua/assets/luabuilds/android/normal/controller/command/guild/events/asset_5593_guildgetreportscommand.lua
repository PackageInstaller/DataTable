class = var_0_10000

local var_0_0 = "GuildGetReportsCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2

	if not var_4.ShouldRequestReport(var_1_1) then
		var_1_1 = var_4
		var_1_2 = var_4.GetReports(var_1_1)

		if var_1_0 then
			var_1_0(var_1_2)
		end

		return
	end

	getProxy = var_1_2
	GuildProxy = var_1_1

	local var_1_3 = var_1_2(var_1_1)
	local var_1_4 = var_5.GetMaxReportId(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 61017, {
		index = var_1_4
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

			var_2_10009 = var_0

			var_8.AddReport(var_2_10009, var_2_1)
		end

		if var_1_0 then
			local var_2_3 = var_0
			local var_2_4 = var_2.GetReports(var_2_3)

			var_1_0(var_2_4)
		end

		local var_2_5 = arg_1_0
		local var_2_6 = var_2.sendNotification

		GAME = var_4

		var_2_6(var_2_5, var_4.GET_GUILD_REPORT_DONE)

		return
	end)

	return
end

return var_0_1
