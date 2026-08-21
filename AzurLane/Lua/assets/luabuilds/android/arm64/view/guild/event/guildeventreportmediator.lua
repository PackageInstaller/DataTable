local var_0_0 = class("GuildEventReportMediator", import("...base.ContextMediator"))

var_0_0.ON_GET_REPORTS = "GuildEventReportMediator:ON_GET_REPORTS"
var_0_0.ON_SUBMIT_REPORTS = "GuildEventReportMediator:ON_SUBMIT_REPORTS"
var_0_0.GET_REPORT_RANK = "GuildEventReportMediator:GET_REPORT_RANK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GET_REPORT_RANK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GET_GUILD_REPORT_RANK, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_REPORTS, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_GUILD_REPORT, {
			ids = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_REPORTS, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GET_GUILD_REPORT, {
			callback = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_GUILD_REPORT_DONE,
		GAME.GET_GUILD_REPORT_RANK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.SUBMIT_GUILD_REPORT_DONE then
		arg_6_0.viewComponent:UpdateReports(var_6_1.list)
	elseif var_6_0 == GAME.GET_GUILD_REPORT_RANK_DONE then
		arg_6_0.viewComponent:OnGetReportRankList(var_6_1.ranks)
	end

	return
end

return var_0_0
