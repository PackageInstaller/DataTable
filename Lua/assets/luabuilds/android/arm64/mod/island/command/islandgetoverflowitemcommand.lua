local var_0_0 = class("IslandGetOverFlowItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21006, {
		type = 0
	}, 21007, function(arg_2_0)
		if arg_2_0.result == 0 then
			if #arg_2_0.item_list > 0 then
				local var_2_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

				for iter_2_0, iter_2_1 in ipairs(arg_2_0.item_list) do
					var_2_0:RemoveOverflowItem(iter_2_1.id, iter_2_1.num)
					table.insert({}, {
						type = DROP_TYPE_ISLAND_ITEM,
						id = iter_2_1.id,
						count = iter_2_1.num
					})
				end

				arg_1_0:sendNotification(GAME.ISLAND_GET_OVERFLOW_ITEM_DOME, {
					awards = IslandDropHelper.AddItems({
						drop_list = {}
					}).awards
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
