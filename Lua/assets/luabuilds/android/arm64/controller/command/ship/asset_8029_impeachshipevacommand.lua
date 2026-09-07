local ImpeachShipEvaCommand = class("ImpeachShipEvaCommand", pm.SimpleCommand)

function ImpeachShipEvaCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(17109, {
		ship_group_id = var_1_0.groupId,
		discuss_id = var_1_0.evaId,
		reason = var_1_0.reason
	}, 17110, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("report_sent_thank"))
		end

		return
	end)

	return
end

return ImpeachShipEvaCommand
