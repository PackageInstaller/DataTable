local IslandOpenRestaurantCommand = class("IslandOpenRestaurantCommand", pm.SimpleCommand)

IslandOpenRestaurantCommand.OPEN_RESTAURANT = "IslandOpenRestaurantCommand.OPEN_RESTAURANT"

function IslandOpenRestaurantCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.restId
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.ships) do
		table.insert(var_1_2, {
			post_id = iter_1_0,
			ship_id = iter_1_1
		})
	end

	local var_1_3 = {}

	for iter_1_2, iter_1_3 in pairs(var_1_0.commodities) do
		table.insert(var_1_3, {
			food_id = iter_1_2,
			num = iter_1_3
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21418, {
		trade_id = var_1_0.restId,
		post_list = var_1_2,
		food_list = var_1_3,
		presell = var_1_0.estimateData
	}, 21419, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland()
			local var_2_1 = var_2_0:GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs(var_1_3) do
				var_2_1:RemoveItem(iter_2_1.food_id, iter_2_1.num)
			end

			local var_2_2 = var_2_0:GetManageAgency():GetRestaurant(var_1_1)

			var_2_2:SetCommodities(arg_2_0.trade_data.sell_list, arg_2_0.trade_data.rest_list)
			var_2_2:SetAssistants(arg_2_0.trade_data.post_list)
			var_2_2:SetEndTime(arg_2_0.trade_data.end_time)
			var_2_2:ReduceRemainCnt()
			var_2_2:InitEstimateData(var_1_0.estimateData)

			local var_2_3 = var_2_0:GetCharacterAgency()

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.ship_power) do
				local var_2_4 = var_2_3:GetShipById(iter_2_3.ship_id)

				var_2_4:UpdateEnergy(iter_2_3.power)
				var_2_4:UpdateEnergyBeginRecoverTime(arg_2_0.trade_data.end_time)
				var_2_4:UpdateState(IslandShip.STATE_RESTAURANT, var_1_1)
			end

			var_2_0:DispatchEvent(IslandOpenRestaurantCommand.OPEN_RESTAURANT, {
				restId = var_1_1,
				postList = var_1_2
			})
			self:sendNotification(GAME.ISLAND_OPEN_RESTAURANT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandOpenRestaurantCommand
