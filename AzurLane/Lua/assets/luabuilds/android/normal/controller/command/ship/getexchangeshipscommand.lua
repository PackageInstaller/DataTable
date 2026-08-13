class = var_0_10000

local var_0_0 = "GetExchangeShipsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().time

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 16100, {
		time = var_1_0
	}, 16101, function(arg_2_0)
		getProxy = var_2_10001
		BuildShipProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = {}

		ipairs = var_2_10003

		for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.ship_id_list) do
			table = var_2_10008

			var_2_10008.insert(var_2_1, {
				isFetched = false,
				id = iter_2_1
			})
		end

		ipairs = var_3

		for iter_2_2, iter_2_3 in var_3(arg_2_0.fetched_index_list) do
			var_2_1[iter_2_3].isFetched = true
		end

		var_2_0:updateExchangeList(arg_2_0.flag_ship_flash_time, arg_2_0.flash_time, var_2_1)

		local var_2_2 = arg_1_0
		local var_2_3 = var_3.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.GET_EXCHANGE_SHIPS_DONE)

		return
	end)

	return
end

return var_0_1
