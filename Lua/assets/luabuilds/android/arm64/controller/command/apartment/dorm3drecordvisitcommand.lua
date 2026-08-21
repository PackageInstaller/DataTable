local var_0_0 = class("Dorm3dRecordVisitCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(28036, {
		ship_id = arg_1_1:getBody()
	}, 28037, function(arg_2_0)
		if arg_2_0.result == 0 then
			({}).visitTime = pg.TimeMgr.GetInstance():GetServerTime()

			getProxy(ApartmentProxy):ModifyApartment(var_0, {})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
