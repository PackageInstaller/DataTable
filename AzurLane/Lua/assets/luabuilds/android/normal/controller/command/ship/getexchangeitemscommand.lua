class = var_0_10000

local var_0_0 = "GetExchangeItemsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 16106, {
		type = 0
	}, 16107, function(arg_2_0)
		getProxy = var_2_10001
		BuildShipProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = {}

		ipairs = var_2_10003

		for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.item_shop_id_list) do
			table = var_2_10008

			var_2_10008.insert(var_2_1, {
				isFetched = false,
				id = iter_2_1
			})
		end

		ipairs = var_3

		for iter_2_2, iter_2_3 in var_3(arg_2_0.item_fetch_list) do
			pairs = var_2_10008

			for iter_2_4, iter_2_5 in var_2_10008(var_2_1) do
				if iter_2_5.id == iter_2_3 then
					var_2_1[iter_2_4].isFetched = true
				end
			end
		end

		var_2_0:updateExchangeItemList(arg_2_0.item_flash_time, var_2_1)

		if var_1_0 and var_1_0 == 1 then
			var_2_0:addExChangeItemTimer()
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_3.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.GET_EXCHANGE_ITEMS_DONE)

		return
	end)

	return
end

return var_0_1
