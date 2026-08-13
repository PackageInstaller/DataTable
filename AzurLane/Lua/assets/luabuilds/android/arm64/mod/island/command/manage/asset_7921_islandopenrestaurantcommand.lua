class = var_0_10000

local var_0_0 = "IslandOpenRestaurantCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.OPEN_RESTAURANT = "IslandOpenRestaurantCommand.OPEN_RESTAURANT"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().restId
	local var_1_1 = {}

	pairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(var_2.ships) do
		table = var_1_10010

		var_1_10010.insert(var_1_1, {
			post_id = iter_1_0,
			ship_id = iter_1_1
		})
	end

	local var_1_2 = {}

	pairs = var_6

	for iter_1_2, iter_1_3 in var_6(var_2.commodities) do
		table = var_1_10011

		var_1_10011.insert(var_1_2, {
			food_id = iter_1_2,
			num = iter_1_3
		})
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21418, {
		trade_id = var_1_0,
		post_list = var_1_1,
		food_list = var_1_2,
		presell = var_2.estimateData
	}, 21419, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetInventoryAgency(var_2_10004)

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(var_1_2) do
				var_2_1:RemoveItem(iter_2_1.food_id, iter_2_1.num)
			end

			local var_2_2 = var_1:GetManageAgency()
			local var_2_3 = var_3.GetRestaurant(var_2_2, var_1_0)

			var_3.SetCommodities(var_2_3, arg_2_0.trade_data.sell_list, arg_2_0.trade_data.rest_list)

			local var_2_4 = var_3

			var_3.SetAssistants(var_2_4, arg_2_0.trade_data.post_list)

			var_2_10004 = arg_2_0.trade_data.end_time

			var_3:SetEndTime(var_2_10004)
			var_3:ReduceRemainCnt()
			var_3:InitEstimateData(var_0.estimateData)

			local var_2_5 = var_1:GetCharacterAgency()

			ipairs = var_2_4

			for iter_2_2, iter_2_3 in var_2_4(arg_2_0.ship_power) do
				local var_2_6 = var_2_5:GetShipById(iter_2_3.ship_id)

				var_11.UpdateEnergy(var_2_6, iter_2_3.power)
				var_11:UpdateEnergyBeginRecoverTime(var_2_10004)

				local var_2_7 = var_11
				local var_2_8 = var_11.UpdateState

				IslandShip = var_15

				var_2_8(var_2_7, var_15.STATE_RESTAURANT, var_1_0)
			end

			var_1:DispatchEvent(var_0_1.OPEN_RESTAURANT, {
				restId = var_1_0,
				postList = var_1_1
			})

			local var_2_9 = arg_1_0
			local var_2_10 = var_6.sendNotification

			GAME = var_9

			var_2_10(var_2_9, var_9.ISLAND_OPEN_RESTAURANT_DONE)
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_12(var_2_11, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
