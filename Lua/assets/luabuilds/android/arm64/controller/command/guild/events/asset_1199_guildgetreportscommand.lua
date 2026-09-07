local GuildGetReportsCommand = class("GuildGetReportsCommand", import(".GuildEventBaseCommand"))

function GuildGetReportsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(GuildProxy)

	if not var_1_1:ShouldRequestReport() then
		if var_1_0 then
			arg_1_1:getBody().callback((var_1_1:GetReports()))
		end

		return
	end

	local var_1_2 = getProxy(GuildProxy)

	pg.ConnectionMgr.GetInstance():Send(61017, {
		index = var_1_2:GetMaxReportId()
	}, 61018, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.reports) do
			var_1_1:AddReport(iter_2_1.event_type == GuildConst.REPORT_TYPE_BOSS and GuildBossReport.New(iter_2_1) or GuildReport.New(iter_2_1))
		end

		if var_1_0 then
			var_1_0((var_1_1:GetReports()))
		end

		self:sendNotification(GAME.GET_GUILD_REPORT_DONE)

		return
	end)

	return
end

return GuildGetReportsCommand
