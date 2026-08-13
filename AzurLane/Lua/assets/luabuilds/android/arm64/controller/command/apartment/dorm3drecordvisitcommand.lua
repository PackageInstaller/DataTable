class = var_0_10000

local var_0_0 = "Dorm3dRecordVisitCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 28036, {
		ship_id = var_1_0
	}, 28037, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			ApartmentProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1 = var_2_1.ModifyApartment
			var_2_10004 = var_1_0

			local var_2_2 = {}

			pg = var_2_10006

			local var_2_3 = var_2_10006.TimeMgr.GetInstance()

			var_2_2.visitTime = var_6.GetServerTime(var_2_3)

			var_2_1(var_2_0, var_2_10004, var_2_2)
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
