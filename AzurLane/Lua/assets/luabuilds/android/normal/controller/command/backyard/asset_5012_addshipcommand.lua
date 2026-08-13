class = var_0_10000

local var_0_0 = "AddShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.type
	local var_1_2 = var_2.callBack

	getProxy = var_1_10006
	DormProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	getProxy = var_1_10007
	BayProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)
	local var_1_5 = var_7.getShipById(var_1_4, var_1_0)
	local var_1_6 = var_1_3
	local var_1_7 = var_1_3.getRawData(var_1_6)

	pg = var_1_6

	local var_1_8 = var_1_6.ConnectionMgr.GetInstance()

	var_10.Send(var_1_8, 19002, {
		ship_id = var_1_0,
		type = var_1_1
	}, 19003, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7

			var_2_2.AddShip(var_2_0, var_1_5.id, var_1_1)

			local var_2_1 = var_1_3

			var_2_2 = var_2_2.updateDrom
			var_2_10003 = var_1_7
			BackYardConst = var_4

			var_2_2(var_2_1, var_2_10003, var_4.DORM_UPDATE_TYPE_SHIP)

			local var_2_3 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_3, var_2_10003.ADD_SHIP_DONE, {
				id = var_1_0,
				type = var_1_1
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("backyard_addShip", arg_2_0.result))
		end

		if var_1_2 then
			var_1_2()
		end

		return
	end)

	return
end

return var_0_1
