local IslandCloseRestaurantCommand = class("IslandCloseRestaurantCommand", pm.SimpleCommand)

IslandCloseRestaurantCommand.CLOSE_RESTAURANT = "IslandCloseRestaurantCommand.CLOSE_RESTAURANT"

function IslandCloseRestaurantCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.restId
	local var_1_2 = var_1_0.isPost

	pg.ConnectionMgr.GetInstance():Send(21420, {
		trade_id = var_1_0.restId
	}, 21421, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(var_1_1)
			local var_2_1 = self:WarpItemInfo(var_2_0)
			local var_2_2 = arg_2_0.event_add or 0
			local var_2_3 = var_2_0:GetEventInfo()
			local var_2_4 = var_2_3 ~= 0
			local var_2_5 = var_2_0:GetSellCommondities()
			local var_2_6 = var_2_0:GetRemainCommodities()
			local var_2_7 = var_2_0:GetSales()
			local var_2_8 = {}
			local var_2_9 = 0

			for iter_2_0, iter_2_1 in ipairs(var_2_0:GetAssistants()) do
				var_2_9 = var_2_9 + 1

				if iter_2_1.shipId ~= 0 then
					table.insert(var_2_8, iter_2_1.shipId)
				end
			end

			local var_2_10 = var_2_0:AddSales()

			var_2_0:SetCommodities({}, {})
			var_2_0:ClearAssistantShips()
			var_2_0:SetEndTime(0)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandCloseRest(var_1_2 and 1 or 0, arg_2_0.drop_list))
			self:sendNotification(GAME.ISLAND_CLOSE_RESTAURANT_DONE, {
				restId = var_1_1,
				saleList = var_2_5,
				remainList = var_2_6,
				isUpgrade = var_2_10,
				oldShipCnt = var_2_9,
				shipIds = var_2_8,
				oldSale = var_2_7,
				dropData = IslandDropHelper.AddItems(arg_2_0),
				isSpEvent = var_2_4,
				spEventID = var_2_3,
				itemList = var_2_1,
				priceAdd = var_2_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function IslandCloseRestaurantCommand:WarpItemInfo(arg_3_1)
	local var_3_0 = {}
	local var_3_1, var_3_2 = arg_3_1:GetEventInfo()
	local var_3_3 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1:getConfig("item_id")) do
		local var_3_4 = var_3_3:GetItemById(iter_3_1[1])

		if var_3_4 and var_3_2[var_3_4.id] then
			table.insert(var_3_0, var_3_4.id)
		end
	end

	return var_3_0
end

return IslandCloseRestaurantCommand
