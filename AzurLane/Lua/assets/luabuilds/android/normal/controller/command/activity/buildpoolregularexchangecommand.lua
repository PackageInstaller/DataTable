class = var_0_10000

local var_0_0 = "BuildPoolRegularExchangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	BuildShipProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getRegularExchangeCount(var_1_1)

	pg = var_1_1

	local var_1_3 = var_1_1.ship_data_create_exchange

	REGULAR_BUILD_POOL_EXCHANGE_ID = var_1_10006

	if var_1_2 < var_1_3[var_1_10006].exchange_request then
		pg = var_1_2

		local var_1_4 = var_1_2.TipsMgr.GetInstance()

		var_1_2.ShowTips(var_1_4, "unenough")

		return
	end

	pg = var_1_2

	local var_1_5 = var_1_2.ConnectionMgr.GetInstance()

	var_4.Send(var_1_5, 12047, {
		ship_tid = var_1_0
	}, 12048, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			BuildShipProxy = var_2_10002

			local var_2_0 = var_2_1(var_2_10002)

			var_2_1 = var_2_1.changeRegularExchangeCount
			pg = var_2_10003
			var_2_10003 = var_2_10003.ship_data_create_exchange
			REGULAR_BUILD_POOL_EXCHANGE_ID = var_2_10004

			var_2_1(var_2_0, -var_2_10003[var_2_10004].exchange_request)

			PlayerConst = var_2_1
			var_2_1 = var_2_1.addTranDrop(arg_2_0.drop_list)
			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10004

			var_2_2(var_2_10003, var_2_10004.REGULAR_BUILD_POOL_EXCHANGE_DONE, {
				awards = var_2_1
			})
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
