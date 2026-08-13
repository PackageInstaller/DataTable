class = var_0_10000

local var_0_0 = "IslandTradeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().islandId
	local var_1_1 = var_2.op
	local var_1_2 = var_2.num
	local var_1_3 = var_2.price

	getProxy = var_1_10007
	IslandProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = var_7.GetIsland(var_1_4)
	local var_1_6 = var_7.GetInventoryAgency(var_1_5)
	local var_1_7 = var_7:GetTradeAgency()

	IslandConst = var_1_5

	local var_1_9

	if var_1_1 == var_1_5.TRADE_PURCHASE then
		local var_1_8 = var_1_6

		var_1_9 = var_1_6.CanAddItem
		IslandItem = var_1_10013

		if not var_1_9(var_1_8, var_1_10013.PEARL_ID, var_1_2) then
			pg = var_1_9

			local var_1_10 = var_1_9.TipsMgr.GetInstance()

			var_1_9 = var_1_9.ShowTips
			i18n = var_13

			var_1_9(var_1_10, var_13("island_trade_bag_full_label"))

			return
		end
	else
		IslandConst = var_1_9

		if var_1_1 == var_1_9.TRADE_SELL and var_1_7:GetCanSellCnt(var_1_0) < var_1_2 then
			pg = var_1_9

			local var_1_11 = var_1_9.TipsMgr.GetInstance()

			var_1_9 = var_1_9.ShowTips
			i18n = var_13

			var_1_9(var_1_11, var_13("island_trade_sell_failed_label2"))

			return
		end
	end

	pg = var_1_9

	local var_1_12 = var_1_9.ConnectionMgr.GetInstance()

	var_10.Send(var_1_12, 21240, {
		island_id = var_1_0,
		type = var_1_1,
		num = var_1_2
	}, 21241, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			IslandDropHelper = var_2_0
			var_2_0 = var_2_0.AddItems(arg_2_0)

			local var_2_1 = {}
			local var_2_2 = var_1_1

			IslandConst = var_2_10004

			if var_2_2 == var_2_10004.TRADE_PURCHASE then
				table = var_2_2
				var_2_2 = var_2_2.insert

				local var_2_3 = var_2_1
				local var_2_4 = {}

				IslandItem = var_2_10007
				var_2_4.id = var_2_10007.GOLD_ID
				var_2_4.count = var_1_2 * var_1_3

				var_2_2(var_2_3, var_2_4)

				local var_2_5 = var_1_7

				var_2_2.UpdateWeekNum(var_2_5, var_1_2)
			else
				var_2_2 = var_1_1
				IslandConst = var_2_10004

				if var_2_2 == var_2_10004.TRADE_SELL then
					if var_1_0 ~= var_0.id then
						local var_2_6 = var_1_7

						var_2_2.UpdateSellLimit(var_2_6, var_1_0, var_1_2)
					end

					table = var_2_2
					var_2_2 = var_2_2.insert

					local var_2_7 = var_2_1
					local var_2_8 = {}

					IslandItem = var_2_10007
					var_2_8.id = var_2_10007.PEARL_ID
					var_2_8.count = var_1_2

					var_2_2(var_2_7, var_2_8)
				end
			end

			ipairs = var_2_2

			for iter_2_0, iter_2_1 in var_2_2(var_2_1) do
				local var_2_9 = var_1_6

				var_8.RemoveItem(var_2_9, iter_2_1.id, iter_2_1.count)
			end

			local var_2_10 = arg_1_0
			local var_2_11 = var_3.sendNotification

			GAME = iter_2_0

			var_2_11(var_2_10, iter_2_0.ISLAND_TRADE_DONE, {
				dropData = var_2_0
			})
		else
			pg = var_2_0

			local var_2_12 = var_2_0.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_13(var_2_12, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
