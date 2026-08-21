local var_0_0 = class("IslandConvertSeasonPtCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21014, {
		type = var_1_0.type,
		item_list = var_1_0.list
	}, 21015, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
			local var_2_1 = 0
			local var_2_2 = pg.island_item_data_template

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				if var_0 == 2 then
					var_2_0:RemoveOverflowItem(iter_2_1.id, iter_2_1.num)
				elseif var_0 == 1 then
					var_2_0:RemoveItem(iter_2_1.id, iter_2_1.num)
				end

				if var_2_2[iter_2_1.id].convert == 1 then
					var_2_1 = var_2_1 + var_2_2[iter_2_1.id].pt_num * iter_2_1.num
				end
			end

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.item_list) do
				table.insert({}, {
					type = DROP_TYPE_ISLAND_ITEM,
					id = iter_2_3.id,
					count = iter_2_3.num
				})
			end

			table.insert({}, {
				id = 0,
				type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
				count = var_2_1
			})
			arg_1_0:sendNotification(GAME.ISLAND_CONVERT_SEASON_PT_DONE, {
				dropData = IslandDropHelper.AddItems({
					drop_list = {}
				})
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
