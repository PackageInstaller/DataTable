local var_0_0 = class("SubmitGuildReportCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ids
	local var_1_2 = getProxy(GuildProxy)

	if getProxy(GuildProxy):getRawData():getMemberById(getProxy(PlayerProxy):getRawData().id):IsRecruit() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_duty_is_too_low"))

		return
	end

	if _.any(var_1_0.ids, function(arg_2_0)
		return not var_1_2:GetReportById(arg_2_0):CanSubmit()
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_get_report_failed"))

		return
	end

	local var_1_3 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(61019, {
		ids = var_1_0.ids
	}, 61020, function(arg_3_0)
		if arg_3_0.result == 0 then
			for iter_3_0, iter_3_1 in ipairs(var_1_1) do
				var_1_2:GetReportById(iter_3_1):Submit()
			end

			arg_1_0:sendNotification(GAME.SUBMIT_GUILD_REPORT_DONE, {
				awards = PlayerConst.addTranDrop(arg_3_0.drop_list),
				list = var_1_1,
				callback = var_1_3
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_0
