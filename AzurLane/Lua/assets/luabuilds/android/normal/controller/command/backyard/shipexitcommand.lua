class = var_0_10000

local var_0_0 = "ShipExitCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	DormProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_1_1.shipId

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_1_4 = var_1_10005(var_1_10006)
	local var_1_5 = var_5.getShipById(var_1_4, var_1_3)
	local var_1_6 = var_1_1.callback

	pg = var_8

	local var_1_7 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_7, 19004, {
		ship_id = var_1_3
	}, 19005, function(arg_2_0)
		local var_2_0 = 0

		if arg_2_0.result == 0 then
			local var_2_1 = var_1_2

			var_2_10004 = var_2.getRawData(var_2_1)

			var_2.DeleteShip(var_2_10004, var_1_3)

			var_2_10004 = var_1_2

			local var_2_2 = var_3.updateDrom
			local var_2_3 = var_2

			BackYardConst = var_2_10006

			var_2_2(var_2_10004, var_2_3, var_2_10006.DORM_UPDATE_TYPE_SHIP)

			var_2_10004 = arg_1_0

			local var_2_4 = var_3.sendNotification

			DormProxy = var_2_3

			var_2_4(var_2_10004, var_2_3.SHIP_EXIT, var_1_5)

			var_2_0 = arg_2_0.exp
			var_2_10004 = var_1_5

			var_3.addExp(var_2_10004, var_2_0)

			var_2_10004 = var_0

			var_3.updateShip(var_2_10004, var_1_5)

			var_2_10004 = arg_1_0

			local var_2_5 = var_3.sendNotification

			GAME = var_5

			var_2_5(var_2_10004, var_5.EXIT_SHIP_DONE, var_1_5)
		else
			pg = var_2

			local var_2_6 = var_2.TipsMgr.GetInstance()
			local var_2_7 = var_2.ShowTips

			errorTip = var_2_10004

			var_2_7(var_2_6, var_2_10004("backyard_shipExit", arg_2_0.result))
		end

		if var_1_6 ~= nil then
			var_1_6(var_2_0)
		end

		return
	end)

	return
end

return var_0_1
