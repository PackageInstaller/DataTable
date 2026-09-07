local Dorm3dRecordVisitCommand = class("Dorm3dRecordVisitCommand", pm.SimpleCommand)

function Dorm3dRecordVisitCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(28036, {
		ship_id = var_1_0
	}, 28037, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			var_2_0.visitTime = pg.TimeMgr.GetInstance():GetServerTime()

			getProxy(ApartmentProxy):ModifyApartment(var_1_0, var_2_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return Dorm3dRecordVisitCommand
