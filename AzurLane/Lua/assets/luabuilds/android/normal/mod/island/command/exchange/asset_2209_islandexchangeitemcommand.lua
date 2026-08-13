class = var_0_10000

local var_0_0 = "IslandExchangeItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().list
	local var_1_1 = var_2.tempId
	local var_1_2 = var_2.tempCnt
	local var_1_3 = {}

	ipairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_0) do
		table = var_1_10012

		var_1_10012.insert(var_1_3, {
			make_id = iter_1_1.exchangeId,
			num = iter_1_1.num
		})
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21066, {
		makes = var_1_3
	}, 21067, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetInventoryAgency(var_2_1)
			ipairs = var_2_1

			for iter_2_0, iter_2_1 in var_2_1(var_1_0) do
				var_2_2:RemoveItem(iter_2_1.itemId, iter_2_1.num)
			end

			IslandDropHelper = var_2

			local var_2_3 = var_2.AddItems(arg_2_0)
			local var_2_4 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = iter_2_0

			var_2_10003(var_2_4, iter_2_0.ISLAND_EXCHANGE_ITEM_DONE, {
				dropData = var_2_3
			})
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
