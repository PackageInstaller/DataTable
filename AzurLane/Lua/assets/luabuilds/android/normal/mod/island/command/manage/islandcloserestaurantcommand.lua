class = var_0_10000

local var_0_0 = "IslandCloseRestaurantCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.CLOSE_RESTAURANT = "IslandCloseRestaurantCommand.CLOSE_RESTAURANT"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().restId
	local var_1_1 = var_2.isPost

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21420, {
		trade_id = var_1_0
	}, 21421, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			IslandProxy = var_2_10002

			local var_2_0 = var_2_3(var_2_10002)
			local var_2_1 = var_2_3.GetIsland(var_2_0)
			local var_2_2 = var_2_3.GetManageAgency(var_2_1)

			var_2_3 = var_2_3.GetRestaurant(var_2_2, var_1_0)
			var_2_10003 = arg_1_0

			local var_2_4 = var_2.WarpItemInfo(var_2_10003, var_2_3)

			if not arg_2_0.event_add then
				var_2_10003 = 0
			end

			local var_2_5 = var_2_3:GetEventInfo() ~= 0
			local var_2_6 = var_2_3:GetSellCommondities()
			local var_2_7 = var_2_3:GetRemainCommodities()
			local var_2_8 = var_2_3:GetSales()
			local var_2_9 = {}
			local var_2_10 = 0

			ipairs = var_2_10011

			for iter_2_0, iter_2_1 in var_2_10011(var_2_3:GetAssistants()) do
				var_2_10 = var_2_10 + 1

				if iter_2_1.shipId ~= 0 then
					table = var_16

					var_16.insert(var_2_9, iter_2_1.shipId)
				end
			end

			local var_2_11 = var_2_3:AddSales()

			var_2_3:SetCommodities({}, {})
			var_2_3:ClearAssistantShips()
			var_2_3:SetEndTime(0)

			pg = var_12

			local var_2_12 = var_12.GameTrackerMgr.GetInstance()
			local var_2_13 = var_12.Record

			GameTrackerBuilder = var_14

			var_2_13(var_2_12, var_14.BuildIslandCloseRest(var_1_1 and 1 or 0, arg_2_0.drop_list))

			IslandDropHelper = var_2_13

			local var_2_14 = var_2_13.AddItems(arg_2_0)
			local var_2_15 = arg_1_0
			local var_2_16 = var_13.sendNotification

			GAME = var_15

			var_2_16(var_2_15, var_15.ISLAND_CLOSE_RESTAURANT_DONE, {
				restId = var_1_0,
				saleList = var_2_6,
				remainList = var_2_7,
				isUpgrade = var_2_11,
				oldShipCnt = var_2_10,
				shipIds = var_2_9,
				oldSale = var_2_8,
				dropData = var_2_14,
				isSpEvent = var_2_5,
				spEventID = var_4,
				itemList = var_2_4,
				priceAdd = var_2_10003
			})
		else
			pg = var_2_3

			local var_2_17 = var_2_3.TipsMgr.GetInstance()
			local var_2_18 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_18(var_2_17, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.WarpItemInfo(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1, var_3_2 = arg_3_1:GetEventInfo()

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_3_3 = var_1_10005(var_1_10006)
	local var_3_4 = var_5.GetIsland(var_3_3)
	local var_3_5 = var_5.GetInventoryAgency(var_3_4)

	ipairs = var_3_4

	for iter_3_0, iter_3_1 in var_3_4(arg_3_1:getConfig("item_id")) do
		if var_3_5:GetItemById(iter_3_1[1]) and var_3_2[var_11.id] then
			table = var_12

			var_12.insert(var_3_0, var_11.id)
		end
	end

	return var_3_0
end

return var_0_1
