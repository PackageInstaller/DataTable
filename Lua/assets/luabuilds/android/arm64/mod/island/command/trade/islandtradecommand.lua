local var_0_0 = class("IslandTradeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.islandId
	local var_1_2 = var_1_0.op
	local var_1_3 = var_1_0.num
	local var_1_4 = var_1_0.price
	local var_1_5 = getProxy(IslandProxy):GetIsland()
	local var_1_6 = var_1_5:GetInventoryAgency()
	local var_1_7 = var_1_5:GetTradeAgency()

	if var_1_0.op == IslandConst.TRADE_PURCHASE then
		if not var_1_5:GetInventoryAgency():CanAddItem(IslandItem.PEARL_ID, var_1_3) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_bag_full_label"))

			return
		end
	elseif var_1_2 == IslandConst.TRADE_SELL and var_1_3 > var_1_5:GetTradeAgency():GetCanSellCnt(var_1_1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_sell_failed_label2"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21240, {
		island_id = var_1_1,
		type = var_1_2,
		num = var_1_3
	}, 21241, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = IslandDropHelper.AddItems(arg_2_0)
			local var_2_1 = {}

			if var_1_2 == IslandConst.TRADE_PURCHASE then
				table.insert(var_2_1, {
					id = IslandItem.GOLD_ID,
					count = var_1_3 * var_1_4
				})
				var_1_7:UpdateWeekNum(var_1_3)
			elseif var_1_2 == IslandConst.TRADE_SELL then
				if var_1_1 ~= var_1_5.id then
					var_1_7:UpdateSellLimit(var_1_1, var_1_3)
				end

				table.insert(var_2_1, {
					id = IslandItem.PEARL_ID,
					count = var_1_3
				})
			end

			for iter_2_0, iter_2_1 in ipairs(var_2_1) do
				var_1_6:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			arg_1_0:sendNotification(GAME.ISLAND_TRADE_DONE, {
				dropData = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
