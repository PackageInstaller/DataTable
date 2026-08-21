local var_0_0 = class("IslandExchangeItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		table.insert({}, {
			make_id = iter_1_1.exchangeId,
			num = iter_1_1.num
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21066, {
		makes = {}
	}, 21067, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				var_2_0:RemoveItem(iter_2_1.itemId, iter_2_1.num)
			end

			arg_1_0:sendNotification(GAME.ISLAND_EXCHANGE_ITEM_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
