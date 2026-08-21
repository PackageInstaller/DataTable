local var_0_0 = class("IslandAutomaticCollectionCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9001
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.gatherData
	local var_1_2 = getProxy(IslandProxy).GetIsland(var_1_9001)
	local var_1_3 = getProxy(IslandProxy).GetIsland(var_1_9001):GetBuildingAgency()
	local var_1_4 = getProxy(IslandProxy):GetIsland()
	local var_1_5 = var_1_4.GetInventoryAgency(var_1_9000)

	local function var_1_6(arg_2_0)
		local var_2_0 = var_1_1 or {}

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_1.id == arg_2_0 then
				return iter_2_1.pos
			end
		end

		return nil
	end

	pg.ConnectionMgr.GetInstance().Send(var_1_4, 21539, {
		type = var_1_0.type - 1,
		ship_list = var_1_0.ship_list
	}, 21540, function(arg_3_0)
		if arg_3_0.result == 0 then
			local var_3_0 = arg_3_0.ship_list or {}

			for iter_3_0, iter_3_1 in ipairs(var_3_0) do
				local var_3_1 = var_1_2:GetCharacterAgency():GetShipById(iter_3_1.ship_id)

				var_3_1:UpdateEnergy(iter_3_1.cur_power)
				var_3_1:UpdateEnergyBeginRecoverTime(iter_3_1.recover_time)
				var_3_1:AddExp(iter_3_1.add_exp)
			end

			local var_3_2 = arg_3_0.gather_list or {}

			for iter_3_2, iter_3_3 in ipairs(var_3_2) do
				local var_3_3 = var_1_6(iter_3_3)

				if var_3_3 then
					var_1_2:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
						unitId = var_3_3
					})
				end
			end

			local var_3_4 = arg_3_0.build_refresh or {}

			for iter_3_4, iter_3_5 in ipairs(var_3_4) do
				local var_3_5 = var_1_3:GetBuilding(iter_3_5.build_id)
				local var_3_6 = var_3_5:GetBuildingCollectData()

				var_3_6:SetAllTakeColelct()
				var_3_6:UpdateCollectRefreshtTime(iter_3_5.refresh_time)

				for iter_3_6, iter_3_7 in pairs(var_3_6:GetCollectSlotDatasDic()) do
					var_3_5:UpdateCollectDataBySlotId({
						id = iter_3_7.id
					}, 1)
				end
			end

			arg_1_0:sendNotification(GAME.ISLAND_TAKE_AUTO_COLLECTION_DONE, {
				dropData = IslandDropHelper.AddItems(arg_3_0),
				selectType = var_0
			})
			var_1_5:RemoveItem(1, arg_3_0.cost_gold)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_0
