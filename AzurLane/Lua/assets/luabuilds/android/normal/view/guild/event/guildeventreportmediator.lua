class = var_0_10000

local var_0_0 = "GuildEventReportMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_GET_REPORTS = "GuildEventReportMediator:ON_GET_REPORTS"
var_0_1.ON_SUBMIT_REPORTS = "GuildEventReportMediator:ON_SUBMIT_REPORTS"
var_0_1.GET_REPORT_RANK = "GuildEventReportMediator:GET_REPORT_RANK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_REPORT_RANK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GET_GUILD_REPORT_RANK, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_REPORTS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_GUILD_REPORT, {
			ids = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_REPORTS, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.GET_GUILD_REPORT, {
			callback = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_GUILD_REPORT_DONE
	GAME = var_2
	var_5_0[2] = var_2.GET_GUILD_REPORT_RANK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 == var_6_1.SUBMIT_GUILD_REPORT_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.UpdateReports(var_6_3, var_6_2.list)
	else
		GAME = var_4

		if var_6_0 == var_4.GET_GUILD_REPORT_RANK_DONE then
			local var_6_4 = arg_6_0.viewComponent

			var_4.OnGetReportRankList(var_6_4, var_6_2.ranks)
		end
	end

	return
end

return var_0_1
