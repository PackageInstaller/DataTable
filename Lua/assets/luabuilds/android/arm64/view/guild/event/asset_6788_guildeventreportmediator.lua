local GuildEventReportMediator = class("GuildEventReportMediator", import("...base.ContextMediator"))

GuildEventReportMediator.ON_GET_REPORTS = "GuildEventReportMediator:ON_GET_REPORTS"
GuildEventReportMediator.ON_SUBMIT_REPORTS = "GuildEventReportMediator:ON_SUBMIT_REPORTS"
GuildEventReportMediator.GET_REPORT_RANK = "GuildEventReportMediator:GET_REPORT_RANK"

function GuildEventReportMediator:register()
	self:bind(GuildEventReportMediator.GET_REPORT_RANK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GET_GUILD_REPORT_RANK, {
			id = arg_2_1
		})

		return
	end)
	self:bind(GuildEventReportMediator.ON_SUBMIT_REPORTS, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_GUILD_REPORT, {
			ids = arg_3_1
		})

		return
	end)
	self:bind(GuildEventReportMediator.ON_GET_REPORTS, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GET_GUILD_REPORT, {
			callback = arg_4_1
		})

		return
	end)

	return
end

function GuildEventReportMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_GUILD_REPORT_DONE,
		GAME.GET_GUILD_REPORT_RANK_DONE
	}
end

function GuildEventReportMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.SUBMIT_GUILD_REPORT_DONE then
		self.viewComponent:UpdateReports(var_6_1.list)
	elseif var_6_0 == GAME.GET_GUILD_REPORT_RANK_DONE then
		self.viewComponent:OnGetReportRankList(var_6_1.ranks)
	end

	return
end

return GuildEventReportMediator
